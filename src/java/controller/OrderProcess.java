package controller;

import crypto.Caesar;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;

public class OrderProcess extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        response.setStatus(HttpServletResponse.SC_EXPECTATION_FAILED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (session.getAttribute("cart") == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        switch (request.getParameter("submit")) {
            case "Confirm":
                session.setAttribute("op_totalprice", cart.getTotalPrice());
                session.setAttribute("op_paytype", request.getParameter("paytype"));
                session.setAttribute("op_firstname", request.getParameter("firstname"));
                session.setAttribute("op_lastname", request.getParameter("lastname"));
                session.setAttribute("op_email", request.getParameter("email"));
                session.setAttribute("op_phone", request.getParameter("phone"));
                session.setAttribute("op_address", request.getParameter("address"));

                if (cart.getItems().isEmpty()) {
                    response.sendRedirect("cart.jsp");
                } else {
                    request.getRequestDispatcher("card.jsp").forward(request, response);
                }
                break;
            case "Check Out":
                try {
                    addOrder(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(OrderProcess.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;
            default:
                response.sendRedirect("cart.jsp");
                break;
        }
    }

    protected void addOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        float totalprice = (float) session.getAttribute("op_totalprice");
        String paytype = (String) session.getAttribute("op_paytype");
        String firstname = (String) session.getAttribute("op_firstname");
        String lastname = (String) session.getAttribute("op_lastname");
        String email = (String) session.getAttribute("op_email");
        String phone = (String) session.getAttribute("op_phone");
        String address = (String) session.getAttribute("op_address");

        String cardnum = request.getParameter("cardnum");
        String cvv = request.getParameter("cvv");
        String expm = request.getParameter("expm");
        String expd = request.getParameter("expd");
        String exp = expm + "/" + expd;
        String fname = request.getParameter("cardfname");
        String lname = request.getParameter("cardlname");
        String fullname = fname + " " + lname;

        Connection conn = (Connection) getServletContext().getAttribute("connection");
        Statement stmt = conn.createStatement(); //Update customers

        if (session.getAttribute("user") == null) {
            String sql = "INSERT INTO customers (first_name,last_name,email,phone,address) "
                    + "VALUES ('" + firstname + "','" + lastname + "','" + email + "','"
                    + phone + "','" + address + "')";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int cid = 0;
            if (rs.next()) {
                cid = rs.getInt(1);
            }
            session.setAttribute("cid", cid);
        } else {
            int cid = (int) session.getAttribute("cid");
            stmt.executeUpdate("UPDATE customers SET phone = '" + phone + "', "
                    + "address = '" + address + "' WHERE id = " + cid);
        }
        int cid = (int) session.getAttribute("cid");
        String sql = "";
        if (paytype.equals("Card")) {
            sql = "INSERT INTO orders (total_price,pay_type,status,order_date,address,cus_id,"
                    + "card_number,card_cvv,card_expire,card_name) VALUES (" + totalprice + ",'" 
                    + paytype + "','pending',NOW(),'" + address + "'," + cid + ",'" + Caesar.encrypt(cardnum) + "','"
                    + cvv + "','" + exp + "','" + fullname + "')";
        } else {
            sql = "INSERT INTO orders (total_price,pay_type,status,order_date,address,cus_id) "
                    + "VALUES (" + totalprice + ",'" + paytype + "','pending',NOW(),'" + address + "'," + cid + ")";
        }
        PreparedStatement ps2 = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps2.executeUpdate();
        ResultSet rs2 = ps2.getGeneratedKeys();
        int oid = 0;
        if (rs2.next()) {
            oid = rs2.getInt(1);
        }
        session.setAttribute("oid", oid);

        Statement stmt2 = conn.createStatement();
        for (CartItem i : cart.getItems()) {
            // Check for meat, ingredient, and sauce.
            if (i.getMeat() != null && !i.getMeat().isEmpty()) {
                if (i.getIngredient() != null && !i.getIngredient().isEmpty()) {
                    if (i.getSauce() != null && !i.getSauce().isEmpty()) {
                        // meat, ingredient, sauce
                        stmt2.executeUpdate("INSERT INTO order_menu VALUES (" + oid + ","
                                + i.getId() + ",'" + i.getMeat() + "','" + i.getIngredient()
                                + "','" + i.getSauce() + "'," + i.getPrice() + ")");
                    } else {
                        // meat, ingredient
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,meat,ingredient,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getMeat() + "','"
                                + i.getIngredient() + "'," + i.getPrice() + ")");
                    }
                } else {
                    if (i.getSauce() != null && !i.getSauce().isEmpty()) {
                        // meat, sauce
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,meat,sauce,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getMeat() + "','"
                                + i.getSauce() + "'," + i.getPrice() + ")");
                    } else {
                        // meat
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,meat,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getMeat()
                                + "'," + i.getPrice() + ")");
                    }
                }
            } else {
                if (i.getIngredient() != null && !i.getIngredient().isEmpty()) {
                    if (i.getSauce() != null && !i.getSauce().isEmpty()) {
                        // ingredient, sauce
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,ingredient,sauce,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getIngredient() + "','"
                                + i.getSauce() + "'," + i.getPrice() + ")");
                    } else {
                        // ingredient
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,ingredient,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getIngredient()
                                + "'," + i.getPrice() + ")");
                    }
                } else {
                    if (i.getSauce() != null && !i.getSauce().isEmpty()) {
                        // sauce
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,sauce,price) "
                                + "VALUES (" + oid + "," + i.getId() + ",'" + i.getSauce()
                                + "'," + i.getPrice() + ")");
                    } else {
                        // no meat, no ingredient, non sauce
                        stmt2.executeUpdate("INSERT INTO order_menu (order_id,menu_id,price) "
                                + "VALUES (" + oid + "," + i.getId() + "," + i.getPrice() + ")");
                    }
                }
            }
        }
        /*
        response.setHeader("Refresh", "3;url=order.jsp");
        response.sendRedirect("success.html");
         */
        cart.clearCart();
        response.sendRedirect("order.jsp");
    }
}
