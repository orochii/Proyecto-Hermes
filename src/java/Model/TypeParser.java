/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author Lord of Nightmares
 */
public class TypeParser {

    public static int parseInt(String value) {
        try {
            int number = Integer.parseInt(value);
            return number;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public static String bDecToString(BigDecimal bDec) {
        return bDec.toString();
    }

    public static Object tStampToString(Timestamp timestamp) {
        return timestamp.toString();
    }
}
