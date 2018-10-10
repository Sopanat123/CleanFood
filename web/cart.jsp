<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <c:if test="${sessionScope.user != 'cook' && sessionScope.user != 'receptionist' 
                              && sessionScope.user != 'transporter'}">
                          ${applicationScope['menubarCustomer']}
                      </c:if>
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
                            <h1>Cart</h1>
                        </div>
                    </div>
                    <div id="comments">
                        <form action="managecart.do" method="POST">
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
                                    <c:forEach var="menu" items="${cart.items}" varStatus="loop">
                                        <c:if test="${not empty menu}">
                                            <tr>
                                                <td><button class="btn" name="cancel" type="submit" value="${loop.index}"><i class="fa fa-trash" aria-hidden="true"></i></button> ${loop.index + 1}</td>
                                                <td><c:if test="${not empty menu.meat}">[${menu.meat}]</c:if> ${menu.name}</td>
                                                <td>${menu.ingredient}</td>
                                                <td>${menu.sauce}</td>
                                                <td>${menu.price}</td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </form>
                        <form action="orderprocess.do" method="post">
                            <c:if test="${not empty sessionScope.user}">
                                <h3>No Discount Price : ${cart.totalOriPrice}</h3>
                                <h3>Saving : ${cart.totalOriPrice - cart.totalPrice}</h3>
                            </c:if>
                            <h2>Net Price : ${cart.totalPrice} Thai Baht</h2>
                            <h3>Select Payment type</h3>
                            <br>
                            <ul>
                                <li>
                                    <input type="radio" name="paytype" value="Pay on delivery" required/><p> Pay on delivery </p>
                                </li>
                                <li>
                                    <input type="radio" name="paytype" value="Card" required/><p> Card </p>
                                </li>
                            </ul>
                            <c:choose>
                                <c:when test="${not empty sessionScope.user}">
                                    <sql:setDataSource var="cfDB"
                                                       driver="com.mysql.jdbc.Driver"
                                                       url="${applicationScope.dburl}"
                                                       user="${applicationScope.dbusername}"
                                                       password="${applicationScope.dbpassword}"/>
                                    <sql:query var="customers" dataSource="${cfDB}">
                                        SELECT * FROM customers WHERE id = ${sessionScope.cid}
                                    </sql:query>
                                    <c:forEach var="customer" items="${customers.rows}">
                                        <div class="block clear">
                                            <label for="comment">First Name</label>
                                            <input type="text" name="firstname" value="${customer.first_name}" readonly /> <br>
                                            <label for="comment">Last Name</label>
                                            <input type="text" name="lastname" value="${customer.last_name}" readonly/> <br>
                                            <label for="comment">Email</label>
                                            <input type="text" name="email" value="${customer.email}" readonly/> <br>
                                            <label for="comment">Phone no.</label>
                                            <input type="text" name="phone" value="${customer.phone}" required/> <br>
                                            <label for="comment">Address</label>
                                            <textarea name="address" id="comment" cols="25" rows="10" required>${customer.address}</textarea>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="block clear">
                                        <label for="comment">First Name</label>
                                        <input type="text" name="firstname" value="" required/> <br>
                                        <label for="comment">Last Name</label>
                                        <input type="text" name="lastname" value="" required/> <br>
                                        <label for="comment">Email</label>
                                        <input type="text" name="email" value="" required/> <br>
                                        <label for="comment">Phone no.</label>
                                        <input type="text" name="phone" value="" required/> <br>
                                        <label for="comment">Address</label>
                                        <textarea name="address" id="comment" cols="25" rows="10" required></textarea>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <input class="load" type="submit" name="submit" value="Confirm"/> <br>
                        </form>
                    </div>
                </div>
                <br><br><br>
            </div>
            <script src="assets/js/datatable.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
            <script src="assets/js/jquery-1.12.4.js"></script>
            <script src="assets/js/jquery.dataTables.min.js"></script>
        </body>
    </html>
