<%-- 
    Assignment: A2_marmarie (Assignment 2)
    Program: Computer Programmer
    Course: PROG 32758
    Document   : index.jsp
    Created on : 13-Oct-2018, 7:47:51 PM
    Author     : Wendi Jollymore
    Modified by: Mariel Martinez (marmarie)
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="ca.sheridancollege.java3.a1.Fabric"%>
<%@page import="ca.sheridancollege.java3.a1.FabricType"%>
<%@page import="ca.sheridancollege.java3.a1.Options"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sydney's Custom Cat Trees</title>
    <link type="text/css" rel="stylesheet" href="css/a1.css">
</head>
<body>

<h1>Sydney's Custom Cat Trees</h1>

<!--  OrderCustomTree servlet processes the form data  -->
<form method="get" action="OrderCustomTree">

    <!--  customer information -->
    <p>
        <label for="custId">
            Customer ID:
            <input type="text" id="custId" name="custId" 
                   value="${sessionScope.id}">
        </label>
        <br>
        <label for="custEmail">Customer Email:<input type="text" 
            id="custEmail" name="custEmail"
            value="${sessionScope.email}"></label>
    </p>

    <!--  Fabric selection -->
    <select name="lstFabric" id="lstFabric">
        <option value="">** Choose a Fabric **</option>
        <c:forEach var="fabricType" items="${FabricType.values()}">
            <optgroup label="${fabricType.toString()}">
                <c:forEach var="fabric" 
                           items="${Fabric.getFabricsByType(fabricType)}">
                    <option value="${fabric}" 
                            <%-- if fabric was selected in form before error,
                                    add selected attribute to option --%>
                            ${(sessionScope.selFabric == fabric) 
                                ? "selected"
                                : ""}
                            >${fabric.name}</option>
                </c:forEach>
            </optgroup>
        </c:forEach>
    </select>

    <div>
        <!--  number of levels on cat tree -->
        <div style="display: inline-block">
            <fieldset>
                <legend>Number of Levels:</legend>
                <c:forEach var="level" begin="1" end="4">
                    <label for="optL${level}">
                        <input type="radio" id="optL${level}"
                               name="optLevels" value="${level}"
                               
                               <%-- if level was selected in form before error,
                                    add selected attribut to input --%>
                               ${(level == sessionScope.selLevels) 
                                    ? "checked" 
                                    : ""
                               }>
                        
                        ${level}
                    </label>
                    <br>
                </c:forEach>
            </fieldset>
        </div>

        <!--  extras to add to cat tree -->
        <div style="display: inline-block; vertical-align: top;">
            <fieldset>
                <legend>Select Options:</legend>

                <c:forEach var="option" items="${Options.values()}">
                    <label for="chk${option}">
                    <input type="checkbox" id="chk${option}"
                           name="chkExtras[]" value="${option}"

                           <%-- loop through array of selected options from 
                                session, and if it matches box, add checked 
                                attribute to input box --%>
                           <c:forEach var="selOption" 
                                      items="${sessionScope.selOptions}">
                               ${(option == selOption) ? "checked" : ""}
                           </c:forEach> 

                           > ${option.toString()}
                    </label>
                    <br>
                </c:forEach>

            </fieldset>
        </div>

    </div>

    <!--  buttons to process form -->
    <p>
        <button type="submit" id="btnCalc">Calculate</button>
        <button type="reset" id="btnReset">Reset</button>
    </p>
    
</form>
        
<script>
// Adds event listener to reset button of form, which clears all fields
document.getElementById("btnReset")
        .addEventListener("click", function(){
    
    // Remove input box selections
    var inputBoxes = document.getElementsByTagName("input");
    for (i = 0; i < inputBoxes.length; i++) {
        
        // Remove values from textboxes
        if (inputBoxes[i].getAttribute("type") === "text") {
            inputBoxes[i].removeAttribute("value");
        }
        
        // Uncheck radio buttons and checkboxes
        if (inputBoxes[i].getAttribute("type") === "radio" ||
                inputBoxes[i].getAttribute("type") === "checkbox") {
            inputBoxes[i].removeAttribute("checked");
        }
    }
    
    // Remove Fabric selection
    var optionBoxes = document.getElementsByTagName("option");
    for(i = 0; i < optionBoxes.length; i++) {
        optionBoxes[i].removeAttribute("selected");
    }
    
    // Clear session variables
    sessionStorage.clear();
});
</script>
</body>
</html>