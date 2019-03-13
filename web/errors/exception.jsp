<%-- 
    Document   : exception
    Created on : 28-Sep-2018, 4:56:41 PM
    Author     : Mariel Martinez (marmarie)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" 
              href="${pageContext.request.contextPath}/css/a2.css">
        <title>Error</title>
    </head>
    <body>
        <header>
            <h1>Custom Cat Tree - Errors</h1>
        </header>
        <main class="container">

            <p>There were some problems with your order:</p>
            <p class="errors">${pageContext.exception.message}</p>

            <p>
                <a href="${pageContext.request.contextPath}/index.jsp">
                    Back to Order Form
                </a>
            </p>
        </main>
    </body>
</html>
