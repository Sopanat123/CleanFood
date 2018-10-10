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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class ManagePromotion extends HttpServlet {

    private Connection conn;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        response.setStatus(HttpServletResponse.SC_EXPECTATION_FAILED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int menu_id = Integer.parseInt(request.getParameter("menu_id"));
            String dist = request.getParameter("discount_type");
            float disu = Float.parseFloat(request.getParameter("discount_unit"));
            String sd = request.getParameter("start_date");
            String ed = request.getParameter("end_date");

            String rootPath = getServletContext().getRealPath("/");
            String destPath = rootPath + "assets" + File.separator + "images" + File.separator + "promotion";
            conn = (Connection) getServletContext().getAttribute("connection");
            int uid = (int) request.getSession().getAttribute("uid");
            Part img = request.getPart("image");
            String img_name = Paths.get(img.getSubmittedFileName()).getFileName().toString();
            String img_link = "assets/images/promotion/" + img_name;

            // Add image file
            InputStream imgFile = img.getInputStream();
            File file = new File(destPath, img_name);
            Files.copy(imgFile, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            // Add promotion to DB
            String sql = "INSERT INTO promotions (menu_id,discount_type,discount_unit,picture_link,"
                    + "start_date,end_date) VALUES (" + menu_id + ",'" + dist + "'," + disu + ",'"
                    + img_link + "','" + sd + "','" + ed + "')";
            PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int pid = 0;
            if (rs.next()) {
                pid = rs.getInt(1);
            }
            // Add admin_promo
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO admin_promotion VALUES (" + uid + "," + pid + ")");
            response.sendRedirect("promotion.jsp");
        } catch (NumberFormatException | ServletException | SQLException ex) {
            response.sendRedirect("addpromotion.jsp");
            Logger.getLogger(ManageMenu.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
