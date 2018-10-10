<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div id="comments">
                <h2>Add Food</h2>
                <form action="ManageCart" method="post">
                    <div class="one_third first">
                        <label for="name">Menu Name <span>*</span></label>
                        <input type="text" name="menu_name" id="name" value="" required>
                    </div>
                    <div class="one_third first">
                        <label for="name">Menu type <span>*</span></label><br>
                        <div class="s_ing" style="text-align: center">
                            Appetizer <input type="radio" name="menu_type" value="appetizer" required/>
                            Drink <input type="radio" name="menu_type" value="drink" required/>
                            Food <input type="radio" name="menu_type" value="food" required/>
                        </div>
                    </div>
                    <div class="one_third first">
                        <label for="name">Food type <span>*</span></label><br>
                        <div class="s_ing" style="text-align: center">
                            Salad <input type="radio" name="food_type" value="salad" required/>
                            Grill <input type="radio" name="food_type" value="grill" required/>
                        </div>
                    </div>
                    <div class="one_third">
                        <label for="name">Detail <span>*</span></label>
                        <input type="text" name="detail" id="name" value="" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Price<span>*</span></label>
                        <input type="text" name="price" id="name" value="" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Sauce</label>
                        <input type="text" name="sauce" id="name" value="1" >
                    </div>
                    <div class="one_third">
                        <label for="name">Ingredients</label>
                        <input type="text" name="ingd" id="name" value="1" >
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