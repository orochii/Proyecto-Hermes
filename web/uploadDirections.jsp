<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <c:if test="${accessLevel > 5}">
        <form action="uploadDirections" method="post">
            <p>Subir Direcciones</p>
            <p style="color: red">${message}</p>
            <hr>
            <textarea name="directions" rows="24" cols="100" wrap="off"></textarea>
            <input type="submit">
        </form>
        
        <hr>
    </c:if>
    <c:if test="${accessLevel < 9}">
        <meta http-equiv="refresh" content="3;url=/Proyecto-Hermes" />
        <p>No tienes permisos para estar en esta sección.</p>
    </c:if>
</t:basicpage>