<%-- 
    Document   : Preparing
    Created on : Apr 29, 2018, 11:41:37 PM
    Author     : Tinnawat
--%>

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
            <h1><a href="index.html">Clean Food</a></h1>
            <p>For Healthy Living Style</p>
        </header>
        <nav id="header2">
            <ul class="clear">
                <li><a href="prepare.jsp">Prepare</a></li>
                <li><a href="prepared.jsp">Prepared</a></li>
                <li><a href="sign_in.jsp">Sign In</a></li>
            </ul>
        </nav>
        
        <div class="container">
            <div id="body">
                <div class="header">
                    <div>
                        <h1>Order No. 55555</h1>
                    </div>
                </div>
                <div id="comments">
                    <form action="#" method="POST">
                    <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Menu</th>
                            <th>Ingredients</th>
                            <th>Sauce</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Salad</td>
                            <td>Cat,Dog,Fish,Grass</td>
                            <td>Lemon,Blood</td>
                            <td>120.0</td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Salad</td>
                            <td>Cat,Dog,Fish,Grass</td>
                            <td>Lemon</td>
                            <td>110.0</td>
                        </tr>
                    </tbody>
                    </table>
                        <input class="load" type="submit" name="submit" value="Prepared"/>
                    </form>
                </div>
            </div>
        </div>
        
        
        <script src="assets/js/datatable.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery-1.12.4.js"></script>
        <script src="assets/js/jquery.dataTables.min.js"></script>
    </body>
</html>

