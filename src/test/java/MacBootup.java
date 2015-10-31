
import oith.ws.dom.core.hrm.Client;
import oith.ws.repo.ClientRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MacBootup implements CommandLineRunner {

    @Autowired
    private ClientRepository clientRepository;

    public static void main(String[] args) {
        //MacBootup mm = new MacBootup();
        SpringApplication.run(MacBootup.class, args);
    }

    @Override
    public void run(String... args) throws Exception {

//        repository.save(new User("mac", "123", User.Gender.MALE, "Manik", new Date()));
//        repository.save(new User("anis", "123", User.Gender.MALE, "Anis", new Date()));
        clientRepository.deleteAll();

        Client c1 = new Client();
        c1.setId("55cef88a27b665569010f650");
        c1.setCode("0002");
        c1.setName("IBCS Group");
        c1.setDomain("ibcs-primax");
        c1.setUserCreateUrl("ibc");
        c1.setLoginUrl("xbc");
        c1.setActive(true);
        c1.setSlNo(1);
        c1.setRemarks("n/a man.");
        c1.setClientCategory(Client.ClientCategory.DEMO);

        Client c2 = new Client();
        c2.setId("55cef88a27b665569010f651");
        c2.setCode("0001");
        c2.setName("Oith Group");
        c2.setDomain("oith");
        c2.setUserCreateUrl("oc");
        c2.setLoginUrl("obc");
        c2.setActive(true);
        c2.setSlNo(1);
        c2.setRemarks("n/agv");
        c2.setClientCategory(Client.ClientCategory.OITH);

        Client c3 = new Client();
        c3.setId("55cef88a27b665569010f652");
        c3.setCode("0000");
        c3.setName("Anonimous");
        c3.setDomain("anonimous");
        c3.setLoginUrl("abc3");
        c3.setUserCreateUrl("acx2");
        c3.setActive(true);
        c3.setSlNo(1);
        c3.setRemarks("n/a man.m hib");
        c3.setClientCategory(Client.ClientCategory.DEMO);

        Client c4 = new Client();
        c4.setId("55cef88a27b665569010f658");
        c4.setCode("0003");
        c4.setName("Biman Group");
        c4.setUserCreateUrl("bgc");
        c4.setLoginUrl("kbc");
        c4.setDomain("bdbiman");
        c4.setActive(true);
        c4.setSlNo(2);
        c4.setRemarks("n/a.");
        c4.setClientCategory(Client.ClientCategory.CORPORATE);

        clientRepository.save(c1);
        clientRepository.save(c2);
        clientRepository.save(c3);
        clientRepository.save(c4);
    }

}
