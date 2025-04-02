package com.schooltrip.util;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordHashUtil {
    public static String hashPassword(String password) throws Exception {
        // Generate salt
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);

        // Hash password with salt
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        byte[] hashedPassword = md.digest(password.getBytes());

        // Combine salt and hashed password
        byte[] combinedBytes = new byte[salt.length + hashedPassword.length];
        System.arraycopy(salt, 0, combinedBytes, 0, salt.length);
        System.arraycopy(hashedPassword, 0, combinedBytes, salt.length, hashedPassword.length);

        // Encode to Base64
        return Base64.getEncoder().encodeToString(combinedBytes);
    }

    public static boolean verifyPassword(String inputPassword, String storedHash) throws Exception {
        // Decode the stored hash
        byte[] combinedBytes = Base64.getDecoder().decode(storedHash);

        // Extract salt
        byte[] salt = new byte[16];
        System.arraycopy(combinedBytes, 0, salt, 0, 16);

        // Hash input password with extracted salt
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        md.update(salt);
        byte[] hashedInput = md.digest(inputPassword.getBytes());

        // Compare hashed input with stored hash
        byte[] storedPasswordBytes = new byte[combinedBytes.length - 16];
        System.arraycopy(combinedBytes, 16, storedPasswordBytes, 0, storedPasswordBytes.length);

        return MessageDigest.isEqual(hashedInput, storedPasswordBytes);
    }
}
