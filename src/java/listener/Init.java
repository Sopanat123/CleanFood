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

    /**
     * Connection to database. For create statement and stuffs
     */
    private Connection conn;
    private final String alt_db_url = "jdbc:mysql://tomcat.it.kmitl.ac.th:3306/"
            + "webpro_00_dev?zeroDateTimeBehavior=convertToNull&autoReconnect=true&"
            + "useEncoding=true&characterEncoding=UTF-8";
    private final String alt_db_username = "webpro-08";
    private final String alt_db_password = "Jib_Music_10";
    private final String db_url = "jdbc:mysql:///cleanfoodDB";
    private final String db_username = "root";
    private final String db_password = "";

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
        // for cook users
        String menu3 = " <li><a href=\"cook.jsp\">Cooking</a></li>\n";
        // for logged-in admin users
        String menu4 = " <li><a href=\"manageadvertise.jsp\">Manage Ads</a></li>\n"
                + " <li><a href=\"addadvertise.jsp\">Add Ads</a></li>\n"
                + " <li><a href=\"addpromotion.jsp\">Add Promotion</a></li>\n"
                + " <li><a href=\"addmenu.jsp\">Add Menu</a></li>\n";
        // for ALL web user, except for those who logged-in
        String menu5 =  " <li><a href=\"sign_in.jsp\">Login</a></li>";
        // for logged-in users
        String menu6 = " <li><a href=\"logout.do\">Logout</a></li>";

        try {
            sce.getServletContext().setAttribute("dburl", db_url);
            sce.getServletContext().setAttribute("dbusername", db_username);
            sce.getServletContext().setAttribute("dbpassword", db_password);
            conn = getCfDB().getConnection();
            sce.getServletContext().setAttribute("connection", conn);
            sce.getServletContext().setAttribute("menubarCustomer", menu1);
            sce.getServletContext().setAttribute("menubarUser", menu2);
            sce.getServletContext().setAttribute("menuCook", menu3);
            sce.getServletContext().setAttribute("menubarAdmin", menu4);
            sce.getServletContext().setAttribute("menuLogin", menu5);
            sce.getServletContext().setAttribute("menuLogout", menu6);
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
