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
                            <h1>Food</h1>
                        </div>
                    </div>
                    <sql:setDataSource var="cfDB"
                                       driver="com.mysql.jdbc.Driver"
                                       url="${applicationScope.dburl}"
                                       user="${applicationScope.dbusername}"
                                       password="${applicationScope.dbpassword}"/>
                    <sql:query var="foods" dataSource="${cfDB}">
                        SELECT * FROM menus WHERE menu_type = 'food'
                    </sql:query>
                    <c:if test="${not empty foods}">
                        <c:forEach var="food" items="${foods.rows}">
                            <form class="food" action="managecart.do" method="POST">
                                <input type="hidden" name="name" value="${food.name}"/>
                                <input type="hidden" name="price" value="${food.price}"/>
                                <input type="hidden" name="menu_type" value="food">
                                <h2>${food.name}</h2>
                                <img class="img-food-food" src="${food.picture_link}" alt="">
                                <c:choose>
                                    <c:when test="${food.food_type == 'Salad'}">
                                        <br><br><br>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="s_meat"><h3>Select Meat</h3>
                                            Beef <input type="radio" name="meat" value="beef" required/>
                                            Pork <input type="radio" name="meat" value="pork" required/>
                                            Chicken <input type="radio" name="meat" value="chicken" checked required/>
                                            Fish <input type="radio" name="meat" value="fish" required/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                                <sql:query var="ingd" dataSource="${cfDB}">
                                    SELECT i.name 
                                    FROM ingredients AS i 
                                    JOIN menu_ingredient AS x 
                                    ON i.id = x.ingredient_id 
                                    JOIN menus AS m 
                                    ON m.id = x.menu_id 
                                    WHERE x.menu_id = ${food.id} 
                                    AND type = 'ingredient'
                                </sql:query>
                                <c:choose>
                                    <c:when test="${not empty ingd.rows}">
                                        <div class="s_ing"><h3>Select Ingredients</h3>
                                            <c:set var="ingdCount" value="1"/>
                                            <c:forEach var="ingdRow" items="${ingd.rows}">
                                                <c:if test="${ingdCount > 3}">
                                                    <br>
                                                    <c:set var="ingdCount" value="1"/>
                                                </c:if>
                                                ${ingdRow.name} <input type="checkbox" name="ingd" value="${ingdRow.name}" />
                                                <c:set var="ingdCount" value="${ingdCount + 1}"/>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <br><br>
                                    </c:otherwise>
                                </c:choose>
                                <sql:query var="sauces" dataSource="${cfDB}">
                                    SELECT i.name 
                                    FROM ingredients AS i 
                                    JOIN menu_ingredient AS x 
                                    ON i.id = x.ingredient_id 
                                    JOIN menus AS m 
                                    ON m.id = x.menu_id 
                                    WHERE x.menu_id = ${food.id} 
                                    AND type = 'sauce'
                                </sql:query>
                                <c:choose>
                                    <c:when test="${not empty sauces.rows}">
                                        <div class="s_sau"><h3>Select Sauce</h3>

                                            <c:set var="sauceCount" value="1"/>
                                            <c:forEach var="sauceRow" items="${sauces.rows}">
                                                <c:if test="${sauceCount > 3}">
                                                    <br>
                                                    <c:set var="sauceCount" value="1"/>
                                                </c:if>
                                                ${sauceRow.name} <input type="checkbox" name="sauce" value="${sauceRow.name}" />
                                                <c:set var="sauceCount" value="${sauceCount + 1}"/>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <br><br>
                                    </c:otherwise>
                                </c:choose>
                                <br>
                                <br>
                                <div class="but">
                                    <button class="btn" type="submit" name="add" value="${food.id}">Add</button>
                                    <button class="btn" type="submit" name="view" value="${food.id}">Detail</button>
                                </div>
                                <br><br><br>
                            </form>
                        </c:forEach>
                    </c:if>
                </div>
            </div>


            <script src="assets/js/datatable.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
            <script src="assets/js/jquery-1.12.4.js"></script>
            <script src="assets/js/jquery.dataTables.min.js"></script>
        </body>
    </html>

