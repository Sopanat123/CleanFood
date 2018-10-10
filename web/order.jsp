<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="keywords" content="HTML"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Clean Food</title>
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="assets/css/fonts/font-awesome.min.css">
        <script src="assets/js/jquery.min.js"></script>
        <link rel="stylesheet" href="assets/css/jquery.dataTables.min.css">
    </head>
    <body>
        <header id="header">
            <h1><a href="promotion.jsp">Clean Food</a></h1>
            <p>For Healthy Living Style</p>
        </header>
        <nav id="header2">
            <ul class="clear">
                <c:choose>
                    <c:when test="${sessionScope.user == 'cook'}">
                        <li><a href="cook.jsp">To Cook List</a></li>
                        <li><a href="logout.do">Logout</a></li>
                        </c:when>
                        <c:when test="${sessionScope.user == 'receptionist'}">
                        <li><a href="receptiom.jsp">Pending List</a></li>
                        <li><a href="logout.do">Logout</a></li>
                        </c:when>
                        <c:when test="${sessionScope.user == 'transporter'}">
                        <li><a href="transport.jsp">Back to Order List</a></li>
                        <li><a href="logout.do">Logout</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${sessionScope.user != 'cook' && sessionScope.user != 'receptionist' && sessionScope.user != 'transporter'}">
                                ${applicationScope['menubarCustomer']}
                                <c:if test="${not empty sessionScope.user}">
                                    ${applicationScope['menubarUser']}
                                </c:if>
                                <c:if test="${sessionScope.user == 'admin'}">
                                    ${applicationScope['menubarAdmin']}
                                </c:if>
                                <c:if test="${empty sessionScope.user}">
                                    ${applicationScope['menuLogin']}
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">
                                    ${applicationScope['menuLogout']}
                                </c:if>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
            </ul>
        </nav>

        <div class="container">
            <div id="body">
                <sql:setDataSource var="cfDB"
                                   driver="com.mysql.jdbc.Driver"
                                   url="${applicationScope.dburl}"
                                   user="${applicationScope.dbusername}"
                                   password="${applicationScope.dbpassword}"/>
                <c:set var="oid" value=""/>
                <c:choose>
                    <c:when test="${not empty param.submit}">
                        <c:set var="oid" value="${param.submit}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="oid" value="${sessionScope.oid}"/>
                    </c:otherwise>
                </c:choose>
                <sql:query var="orders" dataSource="${cfDB}">
                    SELECT o.total_price AS total_price, o.pay_type AS pay_type, o.address AS address, c.phone AS phone 
                    FROM orders AS o
                    JOIN customers AS c 
                    ON o.cus_id = c.id 
                    WHERE o.id = ${oid}
                </sql:query>
                <sql:query var="menus" dataSource="${cfDB}">
                    SELECT m.name AS name, x.meat AS meat, x.ingredient AS ingredient, 
                    x.sauce AS sauce, x.price AS price  
                    FROM order_menu AS x 
                    JOIN menus AS m 
                    ON x.menu_id = m.id 
                    WHERE x.order_id = ${oid}
                </sql:query>
                <div class="header">
                    <div>
                        <h1>Order no. ${oid}</h1>
                    </div>
                </div>
                <div id="comments">
                    <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Menu</th>
                                <th>Ingredients</th>
                                <th>Sauce</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="menu" items="${menus.rows}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td><c:if test="${not empty menu.meat}">[${menu.meat}] </c:if>${menu.name}</td>
                                    <td>${menu.ingredient}</td>
                                    <td>${menu.sauce}</td>
                                    <td>${menu.price}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:forEach var="order" items="${orders.rows}">
                        <h2>Net Price : ${order.total_price} Thai Baht</h2>
                        <h2>Payment type is ${order.pay_type}</h2>
                        <h2>Phone no. ${order.phone}</h2>
                        <h2>Address</h2>
                        <p>${order.address}</p>
                        <br>
                    </c:forEach>
                    <c:if test="${not empty sessionScope.user && sessionScope.user != 'admin' && sessionScope.user != 'user'}">
                        <form action="manageorder.do" method="POST">
                            <c:choose>
                                <c:when test="${sessionScope.user == 'cook'}">
                                    <button type="submit" name="cooking" value="${oid}">Cooking</button>
                                </c:when>
                                <c:when test="${sessionScope.user == 'receptionist'}">
                                    <button type="submit" name="approved" value="${oid}">Approve</button>
                                    <button type="submit" name="disapproved" value="${oid}">Disapprove</button>
                                </c:when>
                                <c:when test="${sessionScope.user == 'transporter'}">
                                    <button type="submit" name="transit" value="${oid}">In Transit</button>
                                    <button type="submit" name="finished" value="${oid}">Finished</button>
                                </c:when>
                            </c:choose>
                        </form>
                        <br><br><br>
                    </c:if>
                </div>
            </div>
        </div>


        <script src="assets/js/datatable.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-1.12.4.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
    </body>
</html>

