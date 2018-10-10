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
        <script src="assets/js/jquery.min.js"></script>
        <link rel="stylesheet" href="assets/css/jquery.dataTables.min.css">


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
                    <div class="singlepost">
                        <div class="featured">
                            <sql:setDataSource var="cfDB"
                                               driver="com.mysql.jdbc.Driver"
                                               url="${applicationScope.dburl}"
                                               user="${applicationScope.dbusername}"
                                               password="${applicationScope.dbpassword}"/>
                            <c:set var="menuID" value="${param.menuID}"/>
                            <c:if test="${empty menuID}">
                                <c:set var="menuID" value="${sessionScope.menu_id}"/>
                            </c:if>
                            <sql:query var="menus" dataSource="${cfDB}" scope="request">
                                SELECT * FROM menus WHERE id = ${menuID}
                            </sql:query>
                            <c:if test="${not empty menus}">
                                <c:forEach var="menu" items="${menus.rows}">
                                    <c:set var="menu_id" value="${menu.id}" scope="session"/>
                                    <form action="managecart.do" method="post">
                                        <input type="hidden" name="name" value="${menu.name}"/>
                                        <input type="hidden" name="price" value="${menu.price}"/>
                                        <input type="hidden" name="menu_type" value="${menu.menu_type}"/>
                                        <input type="hidden" name="food_type" value="${menu.food_type}"/>
                                        <sql:query var="rating" dataSource="${cfDB}">
                                            SELECT rating FROM comments WHERE menu_id = ${menu.id}
                                        </sql:query>
                                        <c:set var="sumrate" value="0"/>
                                        <c:set var="countrate" value="0"/>
                                        <c:forEach var="eachrate" items="${rating.rows}">
                                            <c:set var="sumrate" value="${sumrate + eachrate.rating}"/>
                                            <c:set var="countrate" value="${countrate + 1}"/>
                                        </c:forEach>
                                        <c:set var="avgrate" value="0"/>
                                        <c:if test="${countrate > 0}">
                                            <c:set var="avgrate" value="${sumrate / countrate}"/>
                                        </c:if>
                                        <img class="img-food" src="${menu.picture_link}" alt="">
                                        <h1>${menu.name}</h1>
                                        Rate : <fmt:formatNumber value="${avgrate}" maxFractionDigits="2"/> Star <br>
                                        <c:out value="${menu.description}"/>
                                        <br>
                                        Price : <c:out value="${menu.price}"/>
                                        <br>
                                        Calories : <c:out value="${menu.total_calories}"/>
                                        <br>
                                        <c:if test="${menu.menu_type == 'food'}">
                                            <br>
                                            <c:if test="${menu.food_type != 'Salad'}">
                                                <h5>Select Meat : </h5>
                                                Beef <input type="radio" name="meat" value="beef" required/> 
                                                Pork <input type="radio" name="meat" value="pork" required/> 
                                                Chicken <input type="radio" name="meat" value="chicken" checked required/> 
                                                Fish <input type="radio" name="meat" value="fish" required/> 
                                                <br>
                                            </c:if>
                                            <sql:query var="ingd" dataSource="${cfDB}">
                                                SELECT i.name 
                                                FROM ingredients AS i 
                                                JOIN menu_ingredient AS x 
                                                ON i.id = x.ingredient_id 
                                                JOIN menus AS m 
                                                ON m.id = x.menu_id 
                                                WHERE x.menu_id = ${menu.id} 
                                                AND type = 'ingredient'
                                            </sql:query>
                                            <c:if test="${not empty ingd.rows}">
                                                <h5>Select Ingredients : </h5>
                                                <c:set var="ingdCount" value="1"/>
                                                <c:forEach var="ingdRow" items="${ingd.rows}">
                                                    <c:if test="${ingdCount > 5}">
                                                        <br>
                                                        <c:set var="ingdCount" value="1"/>
                                                    </c:if>
                                                    ${ingdRow.name} <input type="checkbox" name="ingd" value="${ingdRow.name}" /> 
                                                    <c:set var="ingdCount" value="${ingdCount + 1}"/>
                                                </c:forEach>
                                                <br>
                                            </c:if>
                                            <sql:query var="sauces" dataSource="${cfDB}">
                                                SELECT i.name 
                                                FROM ingredients AS i 
                                                JOIN menu_ingredient AS x 
                                                ON i.id = x.ingredient_id 
                                                JOIN menus AS m 
                                                ON m.id = x.menu_id 
                                                WHERE x.menu_id = ${menu.id} 
                                                AND type = 'sauce'
                                            </sql:query>
                                            <c:if test="${not empty sauces.rows}">
                                                <h5>Select Sauce : </h5>
                                                <c:set var="sauceCount" value="1"/>
                                                <c:forEach var="sauceRow" items="${sauces.rows}">
                                                    <c:if test="${sauceCount > 5}">
                                                        <br>
                                                        <c:set var="sauceCount" value="1"/>
                                                    </c:if>
                                                    ${sauceRow.name} <input type="checkbox" name="sauce" value="${sauceRow.name}" />
                                                </c:forEach>
                                            </c:if>
                                        </c:if>
                                        <br>
                                        <input class="load" type="submit" name="addmenu" value="Add">
                                        &nbsp;
                                        <input class="load" type="submit" name="back" value="Back">
                                    </form>
                                </c:forEach>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div id="comments">
                    <c:if test="${not empty sessionScope.user}">
                        <h2>Rate this menu</h2>
                        <form action="processcomment.do" method="post">
                            <fieldset class="rating">
                                <input type="radio" id="star5" name="rating" value="5" /><label class = "full" for="star5" title="Awesome - 5 stars"></label>
                                <input type="radio" id="star4" name="rating" value="4" /><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
                                <input type="radio" id="star3" name="rating" value="3" /><label class = "full" for="star3" title="Meh - 3 stars"></label>
                                <input type="radio" id="star2" name="rating" value="2" /><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
                                <input type="radio" id="star1" name="rating" value="1" /><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
                                <input class="load" type="submit" name="rate" value="Rate">
                            </fieldset>
                        </form>
                        <br><br><br><br><br>
                    </c:if>

                    <h2>Comments</h2>
                    <br>
                    <sql:query var="comments" dataSource="${cfDB}">
                        SELECT c.id, message, username
                        FROM comments AS c 
                        JOIN users AS u 
                        ON c.user_id = u.id 
                        JOIN menus AS m
                        ON c.menu_id = m.id
                        WHERE m.id = ${menuID}
                    </sql:query>
                    <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th>By</th>
                                <th>Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="comment" items="${comments.rows}">
                                <c:if test="${not empty comment.message}">
                                    <tr>
                                        <td>${comment.username}</td>
                                        <td>${comment.message}</td>
                                    </tr>
                                </c:if>

                            </c:forEach>
                        </tbody>
                    </table>

                    <c:if test="${not empty sessionScope.user}">
                        <form action="processcomment.do" method="post">
                            <div class="block clear">
                                <label for="comment">Your Comment</label>
                                <textarea name="comment" id="comment" cols="25" rows="10" required></textarea>
                            </div>
                            <div>
                                <input class="load" type="submit" name="submit" value="Submit">
                                &nbsp;
                                <input class="load" type="reset" name="reset" value="Reset">
                            </div>
                        </form>
                    </c:if>
                    <br><br>
                </div>
            </div>
            <script src="assets/js/datatable.js"></script>
            <script src="assets/js/bootstrap.min.js"></script>
            <script src="assets/js/jquery-1.12.4.js"></script>
            <script src="assets/js/jquery.dataTables.min.js"></script>
        </body>
    </html>
