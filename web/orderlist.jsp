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
            <h1><a href="index.html">Clean Food</a></h1>
            <p>For Healthy Living Style</p>
        </header>
        <nav id="header2">
            <ul class="clear">
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
            </ul>
        </nav>

        <div class="container">
            <div id="body">
                <div class="header">
                    <div>
                        <h1>Order List</h1>
                    </div>
                </div>
                <div id="comments">
                    <sql:setDataSource var="cfDB"
                                       driver="com.mysql.jdbc.Driver"
                                       url="jdbc:mysql:///cleanfoodDB"
                                       user="root" password="root" />
                    <sql:query var="orders" dataSource="${cfDB}">
                        SELECT * FROM orders
                    </sql:query>
                    <form action="order.jsp" method="POST">
                        <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Order No.</th>
                                    <th>By</th>
                                    <th>Time</th>
                                    <th>Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders.rows}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${order.id}</td>
                                        <td>${order.cus_id} customer name</td>
                                        <td>${order.order_date}</td>
                                        <td><button class="btn" name="submit" type="submit" value="#"><i class="fa fa-book" aria-hidden="true"></i></button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>


        <script src="assets/js/datatable.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-1.12.4.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
    </body>
</html>

