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
            <div id="comments">
                <form action="orderprocess.do" method="post">
                    <c:if test="${sessionScope.op_paytype == 'Card'}">
                        <h2>Card Information</h2>
                        <div class="one_third first">
                            <label for="name">Card Number <span>*</span></label>
                            <input type="text" name="cardnum" id="name" value="" size="16" required>
                        </div>
                        <div class="one_third">
                            <label for="name">CVV <span>*</span></label>
                            <input type="text" name="cvv" id="name" value="" size="4" required>
                        </div>
                        <div class="one_third">
                            <label for="name">Expiry Month<span>*</span></label>
                            <input type="text" name="expm" id="name" value="" required>
                        </div>
                        <div class="one_third">
                            <label for="name">Expiry Day<span>*</span></label>
                            <input type="text" name="expd" id="name" value="" required>
                        </div>
                        <div class="one_third">
                            <label for="name">First Name<span>*</span></label>
                            <input type="text" name="cardfname" id="name" value="" size="100" required>
                        </div>
                        <div class="one_third">
                            <label for="name">Last Name<span>*</span></label>
                            <input type="text" name="cardlname" id="name" value="" size="100" required>
                        </div>
                        <br>
                    </c:if>
                    <h2>Order Cost : ${sessionScope.op_totalprice}</h2>
                    <h3>Proceed?</h3>
                    <input class="load" type="submit" name="submit" value="Check Out"/>
                    &nbsp;
                    <input class="load" type="submit" name="submit" value="Back" formaction="cart.jsp" formnovalidate/>
                    <br><br><br>
                </form>
            </div>
        </div>

        <script src="assets/js/datatable.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-1.12.4.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
    </body>
</html>
