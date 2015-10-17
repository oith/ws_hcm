package oith.ws.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan
@SpringBootApplication
public class Application implements CommandLineRunner {

   // @Autowired
   // private UserRepository repository;

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

        System.out.println("java ws");
//        repository.deleteAll();
//
//        // save a couple of users
//        repository.save(new User("mac", "123", User.Gender.MALE, "Manik", new Date()));
//        repository.save(new User("anis", "123", User.Gender.MALE, "Anis", new Date()));
//
//        // fetch all users
//        System.out.println("-------------------------------");
//        for (User user : repository.findAll()) {
//            System.out.println(user);
//        }
//        System.out.println();
//
//        // fetch an individual user
//        System.out.println("--------------------------------");
//        System.out.println(repository.findByUsername("mac"));
//
//        System.out.println("--------------------------------");
//        for (User user : repository.findAll()) {
//            System.out.println(user);
//        }

    }

}
