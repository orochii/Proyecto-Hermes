/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Lord of Nightmares
 */
public class TypeParser {
    public static int parseInt(String value) {
        try{
            int number = Integer.parseInt(value);
            return number;
        } catch(NumberFormatException e) {
            return 0;
        }
    }
}
