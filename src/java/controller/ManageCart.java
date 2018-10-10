package controller;

import java.io.IOException;
import java.util.Enumeration;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Cart;

public class ManageCart extends HttpServlet {

    /**A model for hold an item from each request. */
    Cart cart;

    /**Process the request.
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession(true);
        cart = (Cart) session.getAttribute("cart");
        if (session.getAttribute("cart") == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }

        // Get the values of all request parameters
        Enumeration enumParaName = request.getParameterNames();
        while (enumParaName.hasMoreElements()) {
            String paraName = (String) enumParaName.nextElement();
            // CHECK BUTTON TYPE
            switch (paraName) {
                case "add":
                    // CHECK MENU TYPE
                    switch (request.getParameter("menu_type")) {
                        case "food":
                            String sauce = "";
                            String ingd = "";
                            String[] sauceList = request.getParameterValues("sauce");
                            String[] ingdList = request.getParameterValues("ingd");
                            if (sauceList != null) {
                                int sCount = sauceList.length;
                                for (String s : request.getParameterValues("sauce")) {
                                    sauce = sauce + s;
                                    if (sCount > 1) {
                                        sauce += ",";
                                        sCount--;
                                    }
                                }
                            }
                            if (ingdList != null) {
                                int iCount = ingdList.length;
                                for (String s : request.getParameterValues("ingd")) {
                                    ingd += s;
                                    if (iCount > 1) {
                                        ingd += ",";
                                        iCount--;
                                    }
                                }
                            }
                            cart.addFood(Integer.parseInt(request.getParameter("add")),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")),
                                    request.getParameter("food_type"),
                                    request.getParameter("meat"),
                                    sauce,
                                    ingd);
                            break;
                        case "drink":
                            cart.addDrink(Integer.parseInt(request.getParameter("add")),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")));
                            break;
                        case "appetizer":
                            cart.addAppetizer(Integer.parseInt(request.getParameter("add")),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")));
                            break;
                        default:
                            response.sendRedirect("wrongmenutype.jsp");
                            break;
                    }
                    response.sendRedirect("cart.jsp");
                    break;
                case "view":
                    session.setAttribute("menu_id", Integer.parseInt(request.getParameter("view")));
                    response.sendRedirect("menu.jsp");
                    break;
                case "cancel":
                    int fIndex = Integer.parseInt(request.getParameter("cancel"));
                    cart.removeItem(fIndex);
                    response.sendRedirect("cart.jsp");
                    break;
                case "addmenu":
                    switch (request.getParameter("menu_type")) {
                        case "food":
                            String sauce = "";
                            String ingd = "";
                            String[] sauceList = request.getParameterValues("sauce");
                            String[] ingdList = request.getParameterValues("ingd");
                            if (sauceList != null) {
                                int sCount = sauceList.length;
                                for (String s : request.getParameterValues("sauce")) {
                                    sauce = sauce + s;
                                    if (sCount > 1) {
                                        sauce += ",";
                                        sCount--;
                                    }
                                }
                            }
                            if (ingdList != null) {
                                int iCount = ingdList.length;
                                for (String s : request.getParameterValues("ingd")) {
                                    ingd += s;
                                    if (iCount > 1) {
                                        ingd += ",";
                                        iCount--;
                                    }
                                }
                            }
                            cart.addFood((int) session.getAttribute("menu_id"),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")),
                                    request.getParameter("food_type"),
                                    request.getParameter("meat"),
                                    sauce, ingd);
                            break;
                        case "appetizer":
                            cart.addAppetizer((int) session.getAttribute("menu_id"),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")));
                            break;
                        case "drink":
                            cart.addDrink((int) session.getAttribute("menu_id"),
                                    request.getParameter("name"),
                                    Float.parseFloat(request.getParameter("price")));
                            break;
                            
                    }
                    response.sendRedirect("cart.jsp");
                    break;
                case "back":
                    switch (request.getParameter("menu_type")) {
                        case "food":
                            response.sendRedirect("food.jsp");
                            break;
                        case "appetizer":
                            response.sendRedirect("appetizer.jsp");
                            break;
                        case "drink":
                            response.sendRedirect("drink.jsp");
                            break;
                    }
                    break;
            }
        }
    }
}
