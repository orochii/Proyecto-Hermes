<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="insertCampania" method="post">
        <p>Insertar Campaña</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>
                <td><b>Código de Campaña</b></td>
                <td><input type="text" name="codigoCamp" placeholder="Código..." maxlength="20" required></td>
            </tr>
            <tr>
                <td><b>Descripción</b></td>
                <td><input type="text" name="descripcionCamp" placeholder="Descripción..." maxlength="150" required></td>
            </tr>
            <tr>
                <td><b>Estado</b></td>
                <td><input type="text" name="estadoCamp" placeholder="Estado..." maxlength="50" required></td>
            </tr>
            <tr>
                <td><b>Propósito</b></td>
                <td><input type="text" name="propositoCamp" placeholder="Propósito..." maxlength="50" required></td>
            </tr>
            <tr>
                <td><b>Nombre de Campaña</b></td>
                <td><input type="text" name="nombreCamp" placeholder="Nombre..." maxlength="50" required></td>
            </tr>
            <tr>
                <td><b>Tipo de campaña</b></td>
                <td><input type="text" name="tipoCamp" placeholder="Tipo..." maxlength="50" required></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>