package crypto;

public class Caesar {

    public static int shift = 15;
    
    public static String shiftMessage(String msg, int shift) {
        String s = "";
        for (int x = 0; x < msg.length(); x++) {
            char c = (char) (msg.charAt(x) + shift);
            if (c > 'z') {
                s += (char) (msg.charAt(x) - (26 - shift));
            } else {
                s += (char) (msg.charAt(x) + shift);
            }
        }
        return  s;
    }

    public static String encrypt(String plaintext) {
        return shiftMessage(plaintext, shift);
    }
    
    public static String decrypt(String message) {
        return shiftMessage(message, -shift);
    }
}
