
package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManageOrder extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");
        
        Connection conn = (Connection) getServletContext().getAttribute("connection");
        
        try {
            Enumeration enumAttr = request.getParameterNames();
            while (enumAttr.hasMoreElements()) {
                String paraName = (String) enumAttr.nextElement();
                // Check button name
                if (paraName.equals("approved")) {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate("UPDATE orders SET status = 'approved' "
                            + "WHERE id = " + request.getParameter("approved"));
                    response.sendRedirect("reception.jsp");
                } else if (paraName.equals("cooking")) {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate("UPDATE orders SET status = 'cooking' "
                            + "WHERE id = " + request.getParameter("cooking"));
                    response.sendRedirect("cook.jsp");
                } else if (paraName.equals("disapproved")) {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate("UPDATE orders SET status = 'disapproved' "
                            + "WHERE id = " + request.getParameter("disapproved"));
                    response.sendRedirect("reception.jsp");
                } else if (paraName.equals("finished")) {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate("UPDATE orders SET status = 'finished' "
                            + "WHERE id = " + request.getParameter("finished"));
                    response.sendRedirect("transport.jsp");
                } else if (paraName.equals("transit")) {
                    Statement stmt = conn.createStatement();
                    stmt.executeUpdate("UPDATE orders SET status = 'in-transit' "
                            + "WHERE id = " + request.getParameter("transit"));
                    response.sendRedirect("transport.jsp");
                } else if (paraName.equals("view")) {
                    request.getSession().setAttribute("oid", request.getParameter("view"));
                    response.sendRedirect("order.jsp");
                }
            }
        } catch (IOException | SQLException ex) {
            Logger.getLogger(ManageOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
