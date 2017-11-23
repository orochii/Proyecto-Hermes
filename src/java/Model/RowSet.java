/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Lord of Nightmares
 */
public class RowSet {

    private ArrayList<HashMap<String, Object>> structure;
    private boolean success;

    public RowSet(ResultSet set) {
        structure = new ArrayList<>();
        if (set != null) {
            createFromResultSet(set);
        }
    }

    private void createFromResultSet(ResultSet set) {
        try {
            // Get the resultset metadata
            ResultSetMetaData meta = set.getMetaData();
            // Get the column count
            int colCount = meta.getColumnCount();
            // Do an array with all columns.
            ArrayList<String> cols = new ArrayList<>();
            for (int index = 1; index <= colCount; index++) {
                cols.add(meta.getColumnName(index));
            }
            // Construct each row in the structure
            while (set.next()) {
                HashMap<String, Object> row = new HashMap<>();
                for (String colName : cols) {
                    Object val = set.getObject(colName);
                    row.put(colName, val);
                }
                structure.add(row);
            }
            success = true;
        } catch (SQLException ex) {
            Logger.getLogger(RowSet.class.getName()).log(Level.SEVERE, null, ex);
            success = (set != null);
        }
    }

    public int rows() {
        return structure.size();
    }
    
    public HashMap<String, Object> row(int index) {
        return structure.get(index);
    }
    
    public String getString(String column) {
        if(structure.isEmpty()) return null;
        Object data = row(0).get(column);
        if(data instanceof BigDecimal) data = TypeParser.bDecToString((BigDecimal)data);
        if(data instanceof Timestamp) data = TypeParser.tStampToString((Timestamp)data);
        return (String) data;
    }
    
    public boolean success() {
        return success;
    }
    
    
}
