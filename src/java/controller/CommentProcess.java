package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CommentProcess extends HttpServlet {

    /**Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            Connection conn = (Connection) getServletContext().getAttribute("connection");
            Statement stmt = conn.createStatement();
            Statement stmt2 = conn.createStatement();

            HttpSession session = request.getSession();
            int uid = (int) session.getAttribute("uid");
            int mid = (int) session.getAttribute("menu_id");

            ResultSet rs = stmt.executeQuery("SELECT * FROM comments "
                    + "WHERE user_id = " + uid + " AND menu_id = " + mid);

            // Get the values of all request parameters
            Enumeration enumParaName = request.getParameterNames();
            while (enumParaName.hasMoreElements()) {
                String paraName = (String) enumParaName.nextElement();
                switch (paraName) {
                    case "rate":
                        int rating = Integer.parseInt(request.getParameter("rating"));

                        if (!rs.first()) {
                            stmt2.executeUpdate("INSERT INTO comments (rating,date,user_id,menu_id) "
                                    + "VALUES (" + rating + ",NOW()," + uid + "," + mid + ")");
                        } else {
                            stmt2.executeUpdate("UPDATE comments SET rating = " + rating
                                    + " WHERE user_id = " + uid + " AND menu_id = " + mid);
                        }
                        break;
                    case "submit":
                        String msg = request.getParameter("comment");
                        if (!rs.first()) {
                            stmt2.executeUpdate("INSERT INTO comments (message,date,user_id,menu_id) "
                                    + "VALUES ('" + msg + "',NOW()," + uid + "," + mid + ")");
                        } else {
                            stmt2.executeUpdate("UPDATE comments SET message = '" + msg
                                    + "' WHERE user_id = " + uid + " AND menu_id = " + mid);
                        }
                        break;
                }
            }
            response.sendRedirect("menu.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(CommentProcess.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("menu.jsp");
        }
    }
}
