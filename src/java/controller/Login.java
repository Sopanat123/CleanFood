package controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import crypto.CryptoText;

public class Login extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
        } catch (IOException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String uname = request.getParameter("username");
            String pword = request.getParameter("password");

            request.getSession().invalidate();
            HttpSession session = request.getSession(true);

            Connection conn = (Connection) getServletContext().getAttribute("connection");
            Statement stmt = conn.createStatement();
            ResultSet users_table = stmt.executeQuery("SELECT * FROM users;");

            while (users_table.next()) {
                if (users_table.getString("username").equals(uname)
                        && users_table.getString("password").equals(CryptoText.getSecurePassword(pword))) {
                    session.setAttribute("cid", users_table.getInt("cus_id"));
                    session.setAttribute("uid", users_table.getInt("id"));
                    session.setAttribute("user", users_table.getString("privilege"));
                    break;
                }
            }

            if (session.getAttribute("cid") == null) {
                response.sendRedirect("sign_in.jsp");
            } else if (session.getAttribute("user").equals("cook")) {
                response.sendRedirect("cook.jsp");
            } else if (session.getAttribute("user").equals("receptionist")){
                response.sendRedirect("reception.jsp");
            } else if (session.getAttribute("user").equals("transporter")) {
                response.sendRedirect("transport.jsp");
            } else {
                response.sendRedirect("promotion.jsp");
            }
        } catch (SQLException | NoSuchAlgorithmException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sign_in.jsp");
        }
    }

}
