/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Lord of Nightmares
 */
public class DirectionReader {

    HashMap<String, HashMap<String, HashMap<String, String>>> directionsContainer;

    public void readString(String dataString) {
        directionsContainer = new HashMap<>();
        String[] dataLines = dataString.split("\\r?\\n");
        for (String line : dataLines) {
            String[] values = line.trim().split(",");
            // 0:zip 1:provincia 2:canton 3:distrito
            if (values.length > 3) {
                values[3] = values[3].trim();
                if (!directionsContainer.containsKey(values[1])) {
                    directionsContainer.put(values[1], new HashMap<String, HashMap<String, String>>());
                }
                HashMap<String, HashMap<String, String>> provList = directionsContainer.get(values[1]);
                if (!provList.containsKey(values[2])) {
                    provList.put(values[2], new HashMap<String, String>());
                }
                HashMap<String, String> cantList = provList.get(values[2]);//canton
                if (!cantList.containsKey(values[3])) {
                    cantList.put(values[3], values[0]);
                }
            }
        }
    }

    public QueryResultEnum uploadDirNames() throws SQLException {
        // Si no hay direcciones por agregar, sale del método.
        if (directionsContainer == null) {
            return QueryResultEnum.NODATA;
        }
        // 
        QueryResultEnum result = QueryResultEnum.SUCCESS;
        QueryResultEnum chk = result;
        // Abre conexión con el servidor.
        SQLConnection con = new SQLConnection();
        // Itera entre los objetos en las direcciones.
        // Añade todos los miembros provincia, cantón, distrito y finalmente direcciones.
        int provN = 0;
        int cantN = 0;
        int distN = 0;
        for (String province : directionsContainer.keySet()) {
            provN++;
            chk = con.queryInsertProvince(provN, province);
            if(chk != result && chk != QueryResultEnum.SUCCESS) result = chk;
            for (String canton : directionsContainer.get(province).keySet()) {
                cantN++;
                chk = con.queryInsertCanton(cantN, canton);
                if(chk != result && chk != QueryResultEnum.SUCCESS) result = chk;
                for (String district : directionsContainer.get(province).get(canton).keySet()) {
                    distN++;
                    String zipcode = directionsContainer.get(province).get(canton).get(district);
                    chk = con.queryInsertDistrict(distN, district);
                    if(chk != result && chk != QueryResultEnum.SUCCESS) result = chk;
                    chk = con.queryInsertDirection(zipcode, provN, cantN, distN);
                    if(chk != result && chk != QueryResultEnum.SUCCESS) result = chk;
                }
            }
        }
        // Finalmente, cierra la conexión con la base de datos.
        con.close();
        return result;
    }
}
