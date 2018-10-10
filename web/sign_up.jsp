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
            <h1><a href="index.html">Clean Food</a></h1>
            <p>For Healthy Living Style</p>
        </header>

        <nav id="header2">
            <ul class="clear">
                <li><a href="promotion.jsp">Promotion</a></li>
                <li><a href="food.jsp">Food</a></li>
                <li><a href="drink.jsp">Drink</a></li>
                <li><a href="appetizer.jsp">Appetizer</a></li>
                <li><a href="cart.jsp">Cart</a></li>
                <li><a href="sign_in.jsp">Sign In</a></li>
            </ul>
        </nav>

        <!--content-->
        <div class="container">
            <div id="body">
                <div class="header">
                    <div>
                        <h1>Sign Up</h1>
                    </div>
                </div>
            </div>
            <form class="login-register" action="reg.do" method="POST">
                <input type="text" placeholder="Username" name="username" required/>
                <input type="password" placeholder="Password" name="password" required/>
                <input type="text" placeholder="First Name" name="firstname" required/>
                <input type="text" placeholder="Last Name" name="lastname" required/>
                <input type="text" placeholder="Email" name="email" required/>
                <input type="text" placeholder="Phone No." name="phone" required/>
                <button id="log-reg-butt" type="submit" name="comman" value="sign_up">Create</button>
                <p class="message">Already registered? <a href="sign_in.jsp">Sign In</a></p>
            </form>
        </div>
        <!--footer-->

        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
    </body>
</html>
