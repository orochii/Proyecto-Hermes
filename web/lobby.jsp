<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <b>Bienvenido ${username}.</b>
    <hr>
    <p>Control de sesión</p>
    <a href="changePassword">Cambiar contraseña</a><br>
    <a href="logoff">Cerrar sesión</a>
    <hr>
    <c:if test="${accessLevel > -1}">
        <p>Zona de Usuario</p>
        <hr>
    </c:if>
    <c:if test="${accessLevel > 0}">
        <p>Zona de Operador</p>
        <a href="createUser">Crear usuario</a>
        <hr>
    </c:if>
    <c:if test="${accessLevel > 1}">
        <p>Zona de Administrador</p>

        <hr>
    </c:if>
    <c:if test="${accessLevel > 5}">
        <p>Zona de Superusuario</p>
        <a href="insertBillingCycle">Insertar ciclo facturable</a><br>
        <a href="insertClient.jsp">Insertar Cliente</a><br>
        <a href="insertCampania.jsp">Insertar Campaña</a><br>
        <a href="updateCampania.jsp">Update Campaña</a><br>
        <a href="deleteCampania.jsp">Delete Campaña</a><br>
        <a href="uploadDirections">Subir direcciones</a><br>
        <a href="selectClient.jsp">Buscar Cliente</a><br>
        <hr>
    </c:if>
</t:basicpage>
