package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CryptoText;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    protected void doLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        String signInUsername = request.getParameter("username");
        String signInPassword = request.getParameter("password");

        HttpSession session = request.getSession(true);
        session.setAttribute("cid", 0);
        session.setAttribute("uid", 0);
        session.setAttribute("user", "");

        Connection conn = (Connection) getServletContext().getAttribute("connection");
        Statement stmt = conn.createStatement();
        ResultSet users_table = stmt.executeQuery("SELECT * FROM users;");

        while (users_table.next()) {
            if (users_table.getString("username").equals(signInUsername) && 
                    CryptoText.decrypt(users_table.getString("password")).equals(signInPassword)) {
                session.setAttribute("cid", users_table.getInt("cus_id"));
                session.setAttribute("uid", users_table.getInt("id"));
                session.setAttribute("user", users_table.getString("privilege"));
                break;
            }
        }

        if ((int) session.getAttribute("cid") == 0 || session.getAttribute("cid") == null) {
            response.sendRedirect("sign_in.jsp");
        } else {
            response.sendRedirect("promotion.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            doLogin(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sign_in.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            doLogin(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("sign_in.jsp");
        }
    }

}
