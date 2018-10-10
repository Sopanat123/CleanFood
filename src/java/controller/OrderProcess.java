package controller;

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
import model.Item;

public class OrderProcess extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("cart");
            int cid = (int) session.getAttribute("cid");

            float totalprice = Float.parseFloat(request.getParameter("totalprice"));
            String paytype = request.getParameter("paytype");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Connection conn = (Connection) getServletContext().getAttribute("connection");
            Statement stmt = conn.createStatement(); //Update customers

            if (session.getAttribute("user") == null) {
                stmt.executeUpdate("INSERT INTO customers (first_name,last_name,email,phone,address) "
                        + "VALUES ('" + firstname + "','" + lastname + "','" + email + "','"
                        + phone + "','" + address + "')");
            } else {
                stmt.executeUpdate("UPDATE customers SET phone = '" + phone + "', "
                        + "address = '" + address + "' WHERE id = " + cid);
            }

            String sql = "INSERT INTO orders (total_price,pay_type,status,order_date,cus_id) "
                    + "VALUES (" + totalprice + ",'" + paytype + "','pending',NOW()," + cid + ")";
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int oid = 0;
            if (rs.next()) {
                oid = rs.getInt(1);
                session.setAttribute("oid", oid);
                System.out.println("controller.OrderProcess.doPost()" + oid);
            }

            Statement stmt2 = conn.createStatement();
            for (Item i : cart.getItems()) {
                stmt2.executeUpdate("INSERT INTO order_menu VALUES (" + oid + ","
                        + i.getId() + ",'" + i.getMeat() + "','" + i.getIngredient()
                        + "','" + i.getSauce() + "')");
            }

            response.sendRedirect("orderlist.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(OrderProcess.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
