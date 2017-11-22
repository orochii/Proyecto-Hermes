/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Lord of Nightmares
 */
public class MD5Generator {
    public static String GetMD5(String original) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.reset();
            md.update(original.getBytes());
            byte[] digest = md.digest();
            BigInteger bigInt = new BigInteger(1,digest);
            String result = bigInt.toString(16);
            while(result.length() < 32 ){
              result = "0"+result;
            }
            return result;
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(MD5Generator.class.getName()).log(Level.SEVERE, null, ex);
        }
        return "00000000000000000000000000000000";
    }
    
    public static String GetFalseMD5() {
        return "00000000000000000000000000000000";
    }
}
