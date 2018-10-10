<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                            <h1>Promotion</h1>
                        </div>
                    </div>
                    <sql:setDataSource var="cfDB"
                                       driver="com.mysql.jdbc.Driver"
                                       url="${applicationScope.dburl}"
                                       user="${applicationScope.dbusername}"
                                       password="${applicationScope.dbpassword}"/>
                    <sql:query var="advers" dataSource="${cfDB}">
                        SELECT * FROM advertises
                    </sql:query>
                    <c:if test="${not empty advers}">
                        <c:forEach var="adver" items="${advers.rows}">
                            <div>
                                <img class="img-pro" src="${adver.picture_link}" alt="${adver.detail}"/>
                            </div>
                        </c:forEach>
                    </c:if>
                    <sql:query var="promos" dataSource="${cfDB}">
                        SELECT * FROM promotions 
                        WHERE start_date <= NOW() 
                        AND end_date >= NOW()
                    </sql:query>
                    <c:if test="${not empty promos}">
                        <c:forEach var="promo" items="${promos.rows}">
                            <div>
                                <a href="menu.jsp?menuID=${promo.menu_id}">
                                    <img class="img-pro" src="${promo.picture_link}" alt=""/>
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <br><br><br>
            </div>

            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
        </body>
    </html>