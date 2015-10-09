import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;//BCryptPasswordEncoder;

class EncDec {

    public static void main(String[] args) {

        BCryptPasswordEncoder hheh = new BCryptPasswordEncoder();

        String hhh = hheh.encode("123");
        System.out.println("hhh: " + hhh);
    }
}
