<%-- 
    Document   : sending
    Created on : Apr 29, 2018, 11:58:35 PM
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
                <li><a href="sending.jsp">Sending</a></li>
                <li><a href="delivered.jsp">Delivered</a></li>
                <li><a href="sign_in.jsp">Sign In</a></li>
            </ul>
        </nav>
        
         <div class="container">
            <div id="body">
                <div class="header">
                    <div>
                        <h1>Sending</h1>
                    </div>
                </div>
                <div id="comments">
                    <form action="#" method="POST">
                    <table id="dataCom" class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Order No.</th>
                            <th>By</th>
                            <th>Time</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>55555</td>
                            <td>GG</td>
                            <td>1996 Mar 21</td>
                            <td><button class="btn" name="submit" type="submit" value="#"><i class="fa fa-send" aria-hidden="true"></i></button></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>58000</td>
                            <td>EZ</td>
                            <td>1997 Mar 21</td>
                            <td><button class="btn" name="submit" type="submit" value="#"><i class="fa fa-send" aria-hidden="true"></i></button></td>
                        </tr>
                    </tbody>
                    </table>
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

