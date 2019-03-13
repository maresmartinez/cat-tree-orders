<%-- 
    Document   : error404
    Created on : 5-Oct-2018, 4:27:35 PM
    Author     : Mariel Martinez (marmarie)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Error 404</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/css/main.css">
    </head>
    <body>
        <header>
            <h1>Error 404</h1>
        </header>
        <main class="container">
            <h2>Oh no!</h2>
            <p>Page not found.</p>
        </main>
        <footer>
            2018 &copy; Mariel Martinez
        </footer>
    </body>
</html>
