package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class ManageMenu extends HttpServlet {

    private Connection conn;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        response.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String name = request.getParameter("name");
            String desc = request.getParameter("desc");
            String cal = request.getParameter("calories");
            String price = request.getParameter("price");
            String menu_type = request.getParameter("menu_type");
            String food_type = request.getParameter("food_type");
            String ingd = request.getParameter("ingd");
            String sauce = request.getParameter("sauce");

            String rootPath = getServletContext().getRealPath("/");
            String destPath = rootPath + "assets" + File.separator + "images";
            conn = (Connection) getServletContext().getAttribute("connection");
            int uid = (int) request.getSession().getAttribute("uid");
            Part img = request.getPart("image");
            String img_name = Paths.get(img.getSubmittedFileName()).getFileName().toString();
            String img_link;
            switch (menu_type) {
                case "appetizer":
                    destPath += File.separator + "appetizer";
                    img_link = "assets/images/appetizer/" + img_name;
                    break;
                case "drink":
                    destPath += File.separator + "drink";
                    img_link = "assets/images/drink/" + img_name;
                    break;
                default:
                    destPath += File.separator + "food";
                    img_link = "assets/images/food/" + img_name;
                    break;
            }
            String meSql = "INSERT INTO menus (name,description,total_calories,price,menu_type,picture_link) "
                    + "VALUES ('" + name + "','" + desc + "'," + cal + "," + price + ",'" + menu_type + "','"
                    + img_link + "')";
            String mefSql = "INSERT INTO menus "
                    + "(name,description,total_calories,price,menu_type,picture_link,food_type) "
                    + "VALUES ('" + name + "','" + desc + "'," + cal + "," + price + ",'" + menu_type + "','"
                    + img_link + "','" + food_type + "')";

            Statement stmt = conn.createStatement();
            switch (request.getParameter("submit")) {
                case "Add":
                    // Add image file
                    InputStream imgFile = img.getInputStream();
                    File file = new File(destPath, img_name);
                    Files.copy(imgFile, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    // Add DB record
                    int mid = addMenu(meSql, mefSql, food_type, uid);
                    ResultSet ingdTab = stmt.executeQuery("SELECT * FROM ingredients");
                    if (ingd != null && !ingd.isEmpty()) {
                        addIngredient(ingd, ingdTab, "ingredient", mid);
                    }
                    if (sauce != null && !sauce.isEmpty()) {
                        addIngredient(sauce, ingdTab, "sauce", mid);
                    }
                    break;
                case "Remove":
                    // remove menu
                    break;
            }
            //successfully added
            switch (menu_type) {
                case "appetizer":
                    response.sendRedirect("appetizer.jsp");
                    break;
                case "drink":
                    response.sendRedirect("drink.jsp");
                    break;
                case "food":
                    response.sendRedirect("food.jsp");
                    break;
            }
        } catch (ServletException | SQLException e) {
            response.sendRedirect("addmenu.jsp");
            Logger.getLogger(ManageMenu.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    /**
     * Add a menu to menus table in cleanfooddb.
     *
     * @param wofSql sql query for menu without food_type
     * @param foodSql sql query for menu with food_type
     * @param food_type null if menu contains no food_type
     * @param uid user id of user that add this menu
     * @return menu_id - if menu is successfully added to the table
     * @throws java.sql.SQLException
     */
    public int addMenu(String wofSql, String foodSql, String food_type, int uid) throws SQLException {
        String sql;
        // Add to menus table
        if (food_type == null || food_type.isEmpty()) {
            sql = wofSql;
        } else {
            sql = foodSql;
        }
        PreparedStatement mePs = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
        mePs.executeUpdate();
        ResultSet meRs = mePs.getGeneratedKeys();
        int mid = 0;
        if (meRs.next()) {
            mid = meRs.getInt(1);
        }
        // Add to admin_menu table
        String meusSql = "INSERT INTO admin_menu VALUES (" + uid + "," + mid + ")";
        Statement stmt = conn.createStatement();
        stmt.executeUpdate(meusSql);
        return mid;
    }

    /**
     * Add item into table. Only item that not present in table will be add.
     *
     * @param list String list with comma separates each items name in String
     * @param table for item matches check
     * @param type type of list item
     * @param menuID menu_id for item to refers
     * @return list of added item
     * @throws java.sql.SQLException
     */
    public ArrayList<String> addIngredient(String list, ResultSet table, String type, int menuID)
            throws SQLException {
        List<String> items = Arrays.asList(list.split("\\s*,\\s*"));
        ArrayList<String> itemList = new ArrayList(items);
        ArrayList<String> nmList = new ArrayList();

        for (String s : itemList) {
            boolean matched = false;
            while (table.next()) {
                if (table.getString("name").equals(s)) {
                    matched = true;
                    break;
                }
            }
            if (!matched) {
                nmList.add(s);
            }
        }
        Statement stmt = conn.createStatement();
        for (int i = 0; i < nmList.size(); i++) {
            String sql = "INSERT INTO ingredients (name,type) VALUES ('" + nmList.get(i) + "','" + type + "')";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int iid = 0;
            if (rs.next()) {
                iid = rs.getInt(1);
            }
            String sql2 = "IMSERT INTO menu_ingredient VALUES (" + menuID + "," + iid + ")";
            stmt.executeUpdate(sql2);
        }
        return nmList;
    }
}
