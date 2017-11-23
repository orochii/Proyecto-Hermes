<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="changePassword" method="post">
        <p>Cambiar contraseña</p>
        <p style="color: red">${message}</p>
        <hr>
        <input type="password" name="oldPass" placeholder="Contraseña actual">
        <input type="password" name="newPass" placeholder="Contraseña nueva">
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>