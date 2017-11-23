<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>

<t:basicpage title="Hermes - Comunicación">
    <form action="selectClient" method="post" target="_blank">
        <table>
            <tr>
                <td>Tipo de identificación</td>
                <td>${tipoIdent}</td>
            </tr>
            <tr>
                <td>Número de identificación</td>
                <td>${numIdent}</td>
            </tr>
            <tr>
                <td>Nombre de cliente</td>
                <td>${nomClient}</td>
            </tr>
            <tr>
                <td>Correo electrónico</td>
                <td>${email}</td>
            </tr>
            <tr>
                <td>Fecha de nacimiento</td>
                <td>${fechaNac}</td>
            </tr>
            <tr>
                <td>Sexo</td>
                <td>${sexo}</td>
            </tr>
            <tr>
                <td>Nacionalidad</td>
                <td>${nacional}</td>
            </tr>
            <tr>
                <td>Código postal</td>
                <td>${codPostal}</td>
            </tr>
            <tr>
                <td>Estado civil</td>
                <td>${estCivil}</td>
            </tr>
            <tr>
                <td>Tiempo residencia</td>
                <td>${tResidDom}</td>
            </tr>
            <tr>
                <td>Número dependientes</td>
                <td>${numDepend}</td>
            </tr>
            <tr>
                <td>Vencimiento identificación</td>
                <td>${vencIdent}</td>
            </tr>
            
        </table>
    </form>
    <hr>
    <a onclick="self.close()">Cerrar</a>
    
</t:basicpage>