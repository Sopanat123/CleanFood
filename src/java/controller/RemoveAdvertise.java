
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RemoveAdvertise extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            int aid = Integer.parseInt(request.getParameter("button"));
            
            Connection conn = (Connection) getServletContext().getAttribute("connection");
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("DELETE FROM admin_advertise WHERE advertise_id = " + aid);
            stmt.executeUpdate("DELETE FROM advertises WHERE id = " + aid);
            response.sendRedirect("manageadvertise.jsp");
        } catch (IOException | NumberFormatException | SQLException ex) {
            Logger.getLogger(RemoveAdvertise.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
