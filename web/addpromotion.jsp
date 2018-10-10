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
            <div id="comments">
                <sql:setDataSource var="cfDB"
                                   driver="com.mysql.jdbc.Driver"
                                   url="${applicationScope.dburl}"
                                   user="${applicationScope.dbusername}"
                                   password="${applicationScope.dbpassword}"/>
                <sql:query var="menus" dataSource="${cfDB}">
                    SELECT * FROM menus
                </sql:query>
                <h2>Add Promotion</h2>
                <form action="managepromotion.do" method="post" enctype="multipart/form-data">
                    <div class="one_third first">
                        <label for="name">Product id <span>*</span></label>
                        <br>
                        <select name="menu_id">
                            <c:forEach var="menu" items="${menus.rows}">
                                <option value="${menu.id}">${menu.id} : ${menu.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="one_third">
                        <label for="name">Discount type<span>*</span></label>
                        <br>
                        <select name="discount_type">
                            <option value="direct_cut" selected>Direct Cut</option>
                            <option value="percent">Percent</option>
                            <option value="set">Overide Set</option>
                        </select>
                    </div>
                    <div class="one_third">
                        <label for="name">Discount unit*</label>
                        <input type="text" name="discount_unit" id="name" placeholder="10" value="" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Start Date* (2018-04-01)</label>
                        <input type="text" name="start_date" id="name" placeholder="yyyy-mm-dd" required>
                    </div>
                    <div class="one_third">
                        <label for="name">End Date* (2018-04-01)</label>
                        <input type="text" name="end_date" id="name" placeholder="yyyy-mm-dd" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Image<span>*</span></label>
                        <input type="file" name="image" accept="image/*" id="name" required>
                    </div>
                    <div>
                        <input class="load" type="submit" name="submit" value="Add">
                    </div>
                </form>
            </div>
        </div>

        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>