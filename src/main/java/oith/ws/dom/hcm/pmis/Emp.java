package oith.ws.dom.hcm.pmis;

import java.util.Set;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.Person;

@Document(collection = "Emp")
public class Emp extends Person {

    private Set<EmpContactPerson> empContactPersons;

    public Emp() {
    }

    public Emp(User user, Profile profile) {
        super(user, profile);
    }

    public Set<EmpContactPerson> getEmpContactPersons() {
        return empContactPersons;
    }

    public void setEmpContactPersons(Set<EmpContactPerson> empContactPersons) {
        this.empContactPersons = empContactPersons;
    }

}
