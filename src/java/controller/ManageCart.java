package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;

public class ManageCart extends HttpServlet {

    private Cart cart;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        cart = (Cart) session.getAttribute("cart");
        if (session.getAttribute("cart") == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        try {
            // Get the values of all request's parameters
            Enumeration enumParaName = request.getParameterNames();
            while (enumParaName.hasMoreElements()) {
                String paraName = (String) enumParaName.nextElement();
                // Check the button
                if (paraName.equals("add")) { // add menu to cart from the menu-catalog page
                    int mid = Integer.parseInt(request.getParameter("add"));
                    String menu_type = request.getParameter("menu_type");
                    float ori_price = Float.parseFloat(request.getParameter("price"));
                    float adj_price = ori_price;
                    // LOGGED-IN FOR DISCOUNT
                    if (session.getAttribute("uid") != null) {
                        Connection conn = (Connection) getServletContext().getAttribute("connection");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM promotions");
                        while (rs.next()) {
                            if (rs.getInt("menu_id") == mid) {
                                if (rs.getString("discount_type").equals("direct_cut")) {
                                    adj_price -= rs.getFloat("discount_unit");
                                } else if (rs.getString("discount_type").equals("percent")) {
                                    adj_price = rs.getFloat("discount_unit") / 100 * adj_price;
                                } else if (rs.getString("discount_type").equals("set")) {
                                    adj_price = rs.getFloat("discount_unit");
                                }
                            }
                        }
                    }
                    // CHECK MENU TYPE
                    if (menu_type.equals("food")) {
                        String sauce = "";
                        String ingd = "";
                        String[] sauceList = request.getParameterValues("sauce");
                        String[] ingdList = request.getParameterValues("ingd");
                        if (sauceList != null) {
                            int sCount = sauceList.length;
                            for (String s : request.getParameterValues("sauce")) {
                                sauce = sauce + s;
                                if (sCount > 1) {
                                    sauce += ",";
                                    sCount--;
                                }
                            }
                        }
                        if (ingdList != null) {
                            int iCount = ingdList.length;
                            for (String s : request.getParameterValues("ingd")) {
                                ingd += s;
                                if (iCount > 1) {
                                    ingd += ",";
                                    iCount--;
                                }
                            }
                        }
                        cart.addFood(mid, request.getParameter("name"), ori_price, adj_price,
                                request.getParameter("food_type"),
                                request.getParameter("meat"), sauce, ingd);
                    } else if (menu_type.equals("drink")) {
                        cart.addDrink(mid, request.getParameter("name"), ori_price, adj_price);
                    } else if (menu_type.equals("appetizer")) {
                        cart.addAppetizer(mid, request.getParameter("name"), ori_price, adj_price);
                    }
                    response.sendRedirect("cart.jsp");
                } else if (paraName.equals("view")) { // menu-catalog to menu-datail page
                    session.setAttribute("menu_id", Integer.parseInt(request.getParameter("view")));
                    response.sendRedirect("menu.jsp");
                } else if (paraName.equals("cancel")) { // remove one item from cart
                    int fIndex = Integer.parseInt(request.getParameter("cancel"));
                    cart.removeItem(fIndex);
                    response.sendRedirect("cart.jsp");
                } else if (paraName.equals("addmenu")) { // add menu to cart from the menu-detail page
                    int mid = 0;
                    if (session.getAttribute("menu_id") instanceof String) {
                        mid = Integer.parseInt((String) session.getAttribute("menu_id"));
                    } else {
                        mid = (int) session.getAttribute("menu_id");
                    }
                    float ori_price = Float.parseFloat(request.getParameter("price"));
                    float adj_price = ori_price;
                    String menu_type = request.getParameter("menu_type");
                    // LOGGED-IN FOR DISCOUNT
                    if (session.getAttribute("uid") != null) {
                        Connection conn = (Connection) getServletContext().getAttribute("connection");
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery("SELECT * FROM promotions");
                        while (rs.next()) {
                            if (rs.getInt("menu_id") == mid) {
                                System.out.println(mid + " : " +rs.getString("discount_type") + " : " + rs.getFloat("discount_unit"));
                                if (rs.getString("discount_type").equals("direct_cut")) {
                                        adj_price = adj_price - rs.getFloat("discount_unit");
                                        break;
                                } else if (rs.getString("discount_type").equals("percent")) {
                                        adj_price = rs.getFloat("discount_unit") / 100 * adj_price;
                                        break;
                                } else if (rs.getString("discount_type").equals("set")) {
                                    adj_price = rs.getFloat("discount_unit");
                                    break;
                                }
                            }
                        }
                    }
                    if (menu_type.equals("food")) {
                        String sauce = "";
                        String ingd = "";
                        String[] sauceList = request.getParameterValues("sauce");
                        String[] ingdList = request.getParameterValues("ingd");
                        if (sauceList != null) {
                            int sCount = sauceList.length;
                            for (String s : request.getParameterValues("sauce")) {
                                sauce = sauce + s;
                                if (sCount > 1) {
                                    sauce += ",";
                                    sCount--;
                                }
                            }
                        }
                        if (ingdList != null) {
                            int iCount = ingdList.length;
                            for (String s : request.getParameterValues("ingd")) {
                                ingd += s;
                                if (iCount > 1) {
                                    ingd += ",";
                                    iCount--;
                                }
                            }
                        }
                        cart.addFood((int) session.getAttribute("menu_id"),
                                request.getParameter("name"), ori_price, adj_price,
                                request.getParameter("food_type"),
                                request.getParameter("meat"), sauce, ingd);
                    } else if (menu_type.equals("appetizer")) {
                        cart.addAppetizer((int) session.getAttribute("menu_id"),
                                request.getParameter("name"), ori_price, adj_price);
                    } else if (menu_type.equals("drink")) {
                        cart.addDrink((int) session.getAttribute("menu_id"),
                                request.getParameter("name"), ori_price, adj_price);
                    }
                    response.sendRedirect("cart.jsp");
                } else if (paraName.equals("back")) {
                    switch (request.getParameter("menu_type")) {
                        case "food":
                            response.sendRedirect("food.jsp");
                            break;
                        case "appetizer":
                            response.sendRedirect("appetizer.jsp");
                            break;
                        case "drink":
                            response.sendRedirect("drink.jsp");
                            break;
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageCart.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
