<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="insertBillingCycle" method="post">
        <p>Insertar ciclo de facturación</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>
                <td><b>Código Ciclo</b></td>
                <td><input type="text" name="codCiclo" placeholder="Código ciclo..." maxlength="20" required></td>
            </tr>
            <tr>
                <td><b>Nombre Ciclo</b></td>
                <td><input type="text" name="nombre" placeholder="Nombre ciclo..." maxlength="20"></td>
            </tr>
            <tr>
                <td><b>Tiempo Ciclo</b></td>
                <td><input type="text" name="tiempoCiclo" placeholder="Tiempo ciclo..." maxlength="10"></td>
            </tr>
            <tr>
                <td><b>Descripción Ciclo</b></td>
                <td><input type="text" name="descCiclo" placeholder="Descripción ciclo..." maxlength="150" required></td>
            </tr>
            <tr>
                <td><b>Descripción Estado</b></td>
                <td><input type="text" name="descStatus" placeholder="Descripción estado..." maxlength="150" required></td>
            </tr>
            <tr>
                <td><b>Código Estado</b></td>
                <td><input type="text" name="codStatus" placeholder="Código estado..." maxlength="20"></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>