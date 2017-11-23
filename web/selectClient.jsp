<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="selectClient" method="post">
        <p>Ingrese el Cliente que buca</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>                
                <td><b>Ingrese tipo de identificacion</b></td>
                <td><input type="text" name="tipoIdent" placeholder="Tipo Ident..." maxlength="3" required></td>
            </tr>
                        <tr>                
                <td><b>Ingrese Numero de identificacion</b></td>
                <td><input type="text" name="numero" placeholder="Numero Ident..." maxlength="8" required></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>