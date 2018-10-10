<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="keywords" content="HTML"/>
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Clean Food</title>

        <link href="assets/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/css/sty.css" rel="stylesheet" />
        <link href="assets/css/style.css" rel="stylesheet">
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

            <!--content-->
            <div class="container">
                <div id="body">
                    <div class="header">
                        <div>
                            <h1>Manage User</h1>
                        </div>
                    </div>
                    <c:if test="${empty sessionScope.user}">
                        <c:redirect url="sign_in.jsp"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <form action="account.edit" method="POST">
                            <sql:setDataSource var="cfDB"
                                               driver="com.mysql.jdbc.Driver"
                                               url="${applicationScope.dburl}"
                                               user="${applicationScope.dbusername}"
                                               password="${applicationScope.dbpassword}"/>
                            <sql:query var="cus" dataSource="${cfDB}">
                                SELECT * FROM customers WHERE id = ${sessionScope.cid}
                            </sql:query>
                            <sql:query var="user" dataSource="${cfDB}">
                                SELECT * FROM users WHERE id = ${sessionScope.uid}
                            </sql:query>
                            <c:forEach var="cusRow" items="${cus.rows}">
                                <c:forEach var="userRow" items="${user.rows}">
                                    Username : ${userRow.username} <br>
                                    Email : ${cusRow.email} <br>
                                    Firstname : <input type="text" name="firstname" value="${cusRow.first_name}" /> <br>
                                    Lastname : <input type="text" name="lastname" value="${cusRow.last_name}" /> <br>
                                    Phone no. : <input type="text" name="phone" value="${cusRow.phone}" /> <br>
                                    Password : <input type="password" name="password" value="" /> <br>
                                    <input type="submit" value="Submit" /> 
                                </c:forEach>
                            </c:forEach> 
                        </form>
                    </c:if>
                </div>
            </div>
            <!--footer-->

            <script src="assets/js/jquery.min.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
        </body>
    </html>
