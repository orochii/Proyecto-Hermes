<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<t:basicpage title="Hermes - Comunicación">
    <form action="insertClient" method="post">
        <p>Insertar Cliente</p>
        <p style="color: red">${message}</p>
        <hr>
        <table>
            <tr>                
                <td><b>Tipo Identificacion</b></td>
                <td><input type="text" name="tipoIdent" placeholder="Tipo Ident..." maxlength="3" required></td>
            </tr>
            <tr>
                <td><b>Numero Identificacion</b></td>
                <td><input type="text" name="numeroIdent" placeholder="Numero Ident..." maxlength="10"></td>
            </tr>
            <tr>
                <td><b>Codigo Postal</b></td>
                <td><input type="text" name="codigoPostal" placeholder="Codigo Post..." maxlength="6"></td>
            </tr>
            <tr>
                <td><b>Nombre</b></td>
                <td><input type="text" name="nombre" placeholder="Nombre..." maxlength="50" required></td>
            </tr>
            <tr>
                <td><b>Estado Civil</b></td>
                <td><input type="text" name="estadoCivil" placeholder="Estado Civil..." maxlength="50"></td>
            </tr>
            <tr>
                <td><b>Email</b></td>
                <td><input type="text" name="email" placeholder="123@ejemplo.com" maxlength="50"></td>
            </tr>
            <tr>
                <td><b>Fecha de Nacimiento</b></td>
                <td><input type="text" name="fechaNac" placeholder="DD/MM/YYYY" maxlength="10"></td>
            </tr>
            <tr>
                <td><b>Sexo</b></td>
                <td><input type="text" name="sexo" placeholder="F/M" maxlength="1"></td>
            </tr>
            <tr>
                <td><b>Nacionalidad</b></td>
                <td><input type="text" name="nacionalidad" placeholder="Nacionalidad..." maxlength="50"></td>
            </tr>
            <tr>
                <td><b>Tiempo de residencia</b></td>
                <td><input type="text" name="tiempoRec" placeholder="TiempoReciden..." maxlength="10"></td>
            </tr>
            <tr>
                <td><b>Numero Dependientes</b></td>
                <td><input type="text" name="numeroDep" placeholder="Numero depen...." maxlength="10"></td>
            </tr>
              <tr>
                <td><b>Vencimiento Identificacion</b></td>
                <td><input type="text" name="vencimientoIdent" placeholder="DD/MM/YYYY" maxlength="10"></td>
            </tr>
        </table>
        <input type="submit">
    </form>
    <hr>
    <a href="/Proyecto-Hermes">Regresar</a>
    
</t:basicpage>