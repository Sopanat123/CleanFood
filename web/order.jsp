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
                <li><a href="orderlist.jsp">Order List</a></li>
                <li><a href="approved.jsp">Approved</a></li>
                <li><a href="disapproved.jsp">Disapproved</a></li>
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
                        <h2>Net Price : 1200.0 Thai Baht</h2>
                        <h2>Payment type is Card</h2>
                        <h2>Address</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec interdum neque arcu, vel pellentesque orci lacinia eget. Donec in eros et quam ullamcorper efficitur. Morbi dolor nibh, consequat sed faucibus non, efficitur vel magna. Nulla porttitor elit eget mauris pulvinar, eget laoreet risus tempus. Aliquam vel tortor nec eros vehicula lobortis. Vivamus vestibulum, elit eget finibus facilisis, augue neque pharetra libero, nec feugiat mauris massa in nibh. Ut venenatis libero nec ipsum vehicula, id eleifend est condimentum.

Mauris tincidunt lacinia dui, ac tristique diam condimentum ut. Sed a molestie ligula. Cras egestas urna nec aliquet accumsan. Pellentesque rhoncus eleifend auctor. Sed ac consequat risus. Donec in ornare sem, at hendrerit dui. Integer eleifend vel ipsum at porta. In sed mi nec libero ornare vulputate. Donec non neque eros. Ut pretium nisi et dignissim eleifend. Nunc ut mi tortor. Nullam et urna eu felis dictum imperdiet.</p>
                        <input class="load" type="submit" name="submit" value="Accept"/>
                        <input class="load" type="submit" name="submit" value="Decline"/>
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

