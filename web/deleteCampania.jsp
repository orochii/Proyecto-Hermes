<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="deleteCampania" method="post">
        <p>Borrar Campaña</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>
                <td><b>Código de Campaña</b></td>
                <td><input type="text" name="codigoCamp" placeholder="Código..." maxlength="20" required></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>