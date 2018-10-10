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
            <h1><a href="transport.jsp">Clean Food</a></h1>
            <p>For Healthy Living Style</p>
        </header>
        <nav id="header2">
            <ul class="clear">
                <li><a href="manageuser.jsp">Manage User</a></li>
                <li><a href="logout.do">Logout</a></li>
            </ul>
        </nav>

        <div class="container">
            <div id="body">
                <div class="header">
                    <div>
                        <h1>Prepare</h1>
                    </div>
                </div>
                <div id="comments">
                    <sql:setDataSource var="cfDB"
                                       driver="com.mysql.jdbc.Driver"
                                       url="${applicationScope.dburl}"
                                       user="${applicationScope.dbusername}"
                                       password="${applicationScope.dbpassword}"/>
                    <sql:query var="orders" dataSource="${cfDB}">
                        SELECT CONCAT(c.first_name," ",c.last_name) AS name, 
                        o.id AS id, total_price, status, order_date, o.address AS address 
                        FROM orders AS o
                        JOIN customers AS c ON o.cus_id = c.id 
                        WHERE status = 'cooking' 
                        OR status = 'in-transit'
                    </sql:query>
                    <form action="manageorder.do" method="POST">
                        <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Change Status</th>
                                    <th>Order No.</th>
                                    <th>By</th>
                                    <th>Status</th>
                                    <th>Time</th>
                                    <th>Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders.rows}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            <button type="submit" name="finished" value="${order.id}">F</button>
                                            <button type="submit" name="transit" value="${order.id}">T</button>
                                        </td>
                                        <td>${order.id}</td>
                                        <td>${order.name}</td>
                                        <td>${order.status}</td>
                                        <td>${order.order_date}</td>
                                        <td><button class="btn" name="view" type="submit" value="${order.id}">
                                                <i class="fa fa-book" aria-hidden="true"></i></button></td>
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

