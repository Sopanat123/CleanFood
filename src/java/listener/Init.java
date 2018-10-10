package listener;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.sql.DataSource;

public class Init implements ServletContextListener {

    /**Connection to database. For create statement and stuffs */
    private Connection conn;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // for ALL web users
        String menu1 = " <li><a href=\"promotion.jsp\">Promotion</a></li>\n"
                + " <li><a href=\"food.jsp\">Food</a></li>\n"
                + " <li><a href=\"drink.jsp\">Drink</a></li>\n"
                + " <li><a href=\"appetizer.jsp\">Appetizer</a></li>\n"
                + " <li><a href=\"cart.jsp\">Cart</a></li>\n";
        // for logged-in users
        String menu2 = " <li><a href=\"manageuser.jsp\">Manage User</a></li>\n"
                + " <li><a href=\"orderlist.jsp\">Order List</a></li>\n";
        // for logged-in admin users
        String menu3 = " <li><a href=\"prepare.jsp\">Prepare order</a></li>\n"
                + " <li><a href=\"addpromotion.jsp\">Add Promotion</a></li>\n"
                + " <li><a href=\"addmenu.jsp\">Add Menu</a></li>\n";
        // for ALL web user, except for those who logged-in
        String menu4 = " <li><a href=\"sign_in.jsp\">Login</a></li>";
        // for logged-in users
        String menu5 = " <li><a href=\"logout.do\">Logout</a></li>";

        try {
            conn = getCfDB().getConnection();
            sce.getServletContext().setAttribute("connection", conn);
            sce.getServletContext().setAttribute("menubarCustomer", menu1);
            sce.getServletContext().setAttribute("menubarUser", menu2);
            sce.getServletContext().setAttribute("menubarAdmin", menu3);
            sce.getServletContext().setAttribute("menuLogin", menu4);
            sce.getServletContext().setAttribute("menuLogout", menu5);
        } catch (NamingException | SQLException ex) {
            Logger.getLogger(Init.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Init.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private DataSource getCfDB() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/cfDB");
    }

}
