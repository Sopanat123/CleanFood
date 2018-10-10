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
                <h2>Add Promotion</h2>
                <form action="#" method="post">
                    <div class="one_third first">
                        <label for="name">Product id <span>*</span></label>
                        <br>
                        <select name="menutid">
                            <option>1</option>
                            <option>2</option>
                        </select>
                    </div>
                    <div class="one_third">
                        <label for="name">Detail <span>*</span></label>
                        <input type="text" name="detail" id="name" value="" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Price<span>*</span></label>
                        <input type="text" name="discount" id="name" value="" required>
                    </div>
                    <div class="one_third">
                        <label for="name">Image<span>*</span></label>
                        <input type="file" name="image" id="name" value="" required>
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