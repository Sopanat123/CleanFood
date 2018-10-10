package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.NoSuchProviderException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import crypto.CryptoText;

public class Register extends HttpServlet {

    protected void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, NoSuchAlgorithmException, NoSuchProviderException {
        response.setContentType("text/html;charset=UTF-8");

        // WEB PARA 
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");
        String inputFirstname = request.getParameter("firstname");
        String inputLastname = request.getParameter("lastname");
        String inputEmail = request.getParameter("email");
        String inputPhone = request.getParameter("phone");

        String ePassword = CryptoText.getSecurePassword(inputPassword);

        // CONNECT TO DATABASE
        ServletContext slct = getServletContext();
        Connection conn = (Connection) slct.getAttribute("connection");
        Statement stmt = conn.createStatement();
        ResultSet userDetailTable = stmt.executeQuery("SELECT * FROM users AS u "
                + "JOIN customers AS c ON u.cus_id = c.id");

        // ERROR FLAG
        boolean unameErrFlag = false;
        boolean emailErrFlag = false;
        // USERNAME CHECK
        while (userDetailTable.next()) {
            if (userDetailTable.getString("username").equals(inputUsername)) {
                unameErrFlag = true;
                break;
            } else if (userDetailTable.getString("email").equals(inputEmail)) {
                emailErrFlag = true;
                break;
            }
        }

        // ERROR CHECK
        if (unameErrFlag || emailErrFlag) {
            response.sendRedirect("sign_up.jsp");
        } else {
            // Generate record in users and customers
            Statement stmt2 = conn.createStatement();
            stmt2.executeUpdate("INSERT INTO customers (first_name,last_name,email,phone) "
                    + "VALUES ('" + inputFirstname + "','" + inputLastname + "','" + inputEmail + "','" + inputPhone + "')");

            Statement stmt3 = conn.createStatement();
            ResultSet cid_table = stmt3.executeQuery("SELECT * FROM customers");
            int cid = 0;
            while (cid_table.next()) {
                if (cid_table.getString("email").equals(inputEmail)) {
                    cid = cid_table.getInt("id");
                    break;
                }
            }

            Statement stmt4 = conn.createStatement();
            stmt4.executeUpdate("INSERT INTO users (username,password,privilege,cus_id) "
                    + "VALUES ('" + inputUsername + "','" + ePassword + "','member'," + cid + ")");

            response.sendRedirect("sign_in.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            addUser(request, response);
        } catch (SQLException | NoSuchAlgorithmException | NoSuchProviderException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sign_up.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            addUser(request, response);
        } catch (SQLException | NoSuchAlgorithmException | NoSuchProviderException ex) {
            Logger.getLogger(Register.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sign_up.jsp");
        }
    }

}
