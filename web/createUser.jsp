<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="createUser" method="post">
        <p>Crear usuario</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
             <tr>
                <td><b>Usuario</b></td>
                <td><input type="text" name="newUser" placeholder="Nombre usuario..." maxlength="6"></td>
            </tr>
            <tr>
                <td><b>Contraseña</b></td>
                <td><input type="password" name="newPass" placeholder="Contraseña..." maxlength="50" required></td>
            </tr>
            <tr>                
                <td><b>Tipo Identificacion</b></td>
                <td><input type="text" name="tipoIdent" placeholder="Tipo Ident..." maxlength="3" required></td>
            </tr>
            <tr>
                <td><b>Numero Identificacion</b></td>
                <td><input type="text" name="numIdent" placeholder="Numero Ident..." maxlength="10"></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>