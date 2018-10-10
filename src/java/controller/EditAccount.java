package controller;

import java.io.IOException;
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
import model.CryptoText;

/**Change some information of the user account */
public class EditAccount extends HttpServlet {

    protected void doRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
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
                + "last_name = '" + lname + "', phone_no = '" + phone + "' WHERE id = " + cus_id + "; "
                + "UPDATE users SET password = '" + CryptoText.encrypt(password) + "' WHERE id = "
                + user_id + ";");
        response.sendRedirect("manageuser.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            doRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            doRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditAccount.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
