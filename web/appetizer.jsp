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


    </head>

    <body>
        <!--Navbar-->
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
                            <h1>Menu</h1>
                        </div>
                    </div>
                    <div>
                        <sql:setDataSource var="cfDB"
                                           driver="com.mysql.jdbc.Driver"
                                           url="${applicationScope.dburl}"
                                           user="${applicationScope.dbusername}"
                                           password="${applicationScope.dbpassword}"/>
                        <sql:query var="appts" dataSource="${cfDB}">
                            SELECT * FROM menus WHERE menu_type = 'appetizer'
                        </sql:query>
                        <c:if test="${not empty appts}">
                            <ul>
                                <c:forEach var="apptRow" items="${appts.rows}">
                                    <li>
                                        <form action="managecart.do" method="POST">
                                            <input type="hidden" name="name" value="${apptRow.name}"/>
                                            <input type="hidden" name="price" value="${apptRow.price}"/>
                                            <input type="hidden" name="menu_type" value="appetizer">
                                            <img class="img-food" src="${apptRow.picture_link}" alt="">
                                            <h2><button class="btn" type="submit" name="view" value="${apptRow.id}">${apptRow.name}</button> 
                                                <button class="btn" type="submit" name="add" value="${apptRow.id}">
                                                    <i class="fa fa-cart-plus" aria-hidden="true"></i>
                                                </button>
                                            </h2>
                                        </form>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:if>
                    </div>
                </div>
            </div>

            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
        </body>
    </html>