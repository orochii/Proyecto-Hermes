<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="selectClient" method="post" target="_blank">
        <p>Ingrese el Cliente que busca</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>                
                <td><b>Ingrese tipo de identificación</b></td>
                <td><input type="text" name="tipoIdent" placeholder="Tipo Ident..." maxlength="3" required></td>
            </tr>
             <tr>                
                <td><b>Ingrese Número de identificación</b></td>
                <td><input type="text" name="numeroIdent" placeholder="Número Ident..." maxlength="8" required></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>