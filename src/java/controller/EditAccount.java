package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import crypto.CryptoText;

/**
 * Change some information of the user account
 */
public class EditAccount extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        } catch (IOException ex) {
            Logger.getLogger(EditAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.setContentType("text/html;charset=UTF-8");

            String fname = request.getParameter("firstname");
            String lname = request.getParameter("lastname");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");

            HttpSession session = request.getSession();
            int cus_id = (int) session.getAttribute("cid");
            int user_id = (int) session.getAttribute("uid");
            Connection conn = (Connection) getServletContext().getAttribute("connection");
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("UPDATE customers SET first_name = '" + fname + "', "
                    + "last_name = '" + lname + "', phone = '" + phone + "' WHERE id = " + cus_id);
            Statement stmt2 = conn.createStatement();
            stmt2.executeUpdate("UPDATE users SET password = '" + CryptoText.getSecurePassword(password)
                    + "' WHERE id = " + user_id);
            response.sendRedirect("logout.do");
        } catch (SQLException | NoSuchAlgorithmException | IOException ex) {
            Logger.getLogger(EditAccount.class.getName()).log(Level.SEVERE, null, ex);
            try {
                request.getRequestDispatcher("manageuser.jsp").forward(request, response);
            } catch (ServletException | IOException ex1) {
                Logger.getLogger(EditAccount.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }
    }

}
