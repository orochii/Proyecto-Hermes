<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    ¡Bienvenido a Hermes!
    <br><br>
    <form action="login" method="post">
        <input type="text" name="user" placeholder="Introduzca usuario">
        <br><br>
        <input type="password" name="pass" placeholder="Introduzca contraseña">
        <br><br>
        <input type="submit">
    </form>
</t:basicpage>