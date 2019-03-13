<%-- 
    Document   : displayCatTreeOrder
    Created on : 15-Oct-2018, 2:13:20 PM
    Author     : Mariel Martinez (marmarie)
--%>

<%@tag description="Displays a CustomOrder object" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- The list of normal or fragment attributes can be specified here: --%>
<%@attribute name="customOrder" required="true" rtexprvalue="true"
    type="ca.sheridancollege.java3.a1.CustomOrder"%>

<%-- Tags to display the CustomOrder information --%>

<%-- Customer details --%>
<div>
    <div class="header">
        Customer Contact
    </div>
    <div>
        ${order.customer.email}
    </div>
</div>

<%-- Tree Base Details --%>
<div>
    <div class="header">
        Tree Base:
    </div>
    <div>
        <ul>
            <li>Fabric: ${order.fabric.name}</li>
            <li>${order.levels} levels</li>
        </ul>
    </div>
    <div class="header">
        Base Total: 
        <fmt:formatNumber value="${order.levelTotal}" type="currency" />
    </div>
</div>

<%-- Options Details, only present if options are selected --%>
<c:if test="${order.options != null}">
    <div>
        <div class="header">
            Options:
        </div>
        <div>
            <ul>
                <c:forEach var="option" items="${order.options}">
                    <li>${option.name}</li>
                 </c:forEach>
            </ul>
        </div>
        <div class="header">
            Options Total: 
            <fmt:formatNumber type="currency" 
                value="${order.getOptionsTotal()}" />
        </div>
    </div>
</c:if>

<div class="header">
    Order Total: 
    <fmt:formatNumber type="currency" value="${order.getTotalCost()}" />
</div>