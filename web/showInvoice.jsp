<%-- 
    Assignment: A2_marmarie (Assignment 2)
    Program: Computer Programmer
    Course: PROG 32758
    Document   : showInvoice
    Created on : 13-Oct-2018, 7:54:05 PM
    Author     : Mariel Martinez (marmarie)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="ca.sheridancollege.java3.a1.CustomOrder"%>
<%@page import="ca.sheridancollege.java3.a1.Customer"%>
<%@page import="ca.sheridancollege.java3.a1.Fabric"%>
<%@page import="ca.sheridancollege.java3.a1.FabricType"%>
<%@page import="ca.sheridancollege.java3.a1.Options"%>

<%@taglib prefix="mcm" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Invoice</title>
        <link rel="stylesheet" type="text/css" href="css/a2.css">
    </head>
    <body>
        <header>
            <h1>Your Custom Cat Tree Order</h1>
        </header>
        <main class="container">
            <mcm:displayCustomOrder customOrder="${requestScope.order}" />
            <p>
                <a href="${pageContext.request.contextPath}/index.jsp">
                    Create New Order
                </a>
            </p>
        </main>
    </body>
</html>
