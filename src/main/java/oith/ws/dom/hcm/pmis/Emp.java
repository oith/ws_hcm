package oith.ws.dom.hcm.pmis;

import java.util.Date;
import java.util.Set;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAttach;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;

@Document(collection = "Emp")
public class Emp extends AbstDocAttach implements ICodable {

    @NotNull
    @Indexed(unique = true)
    private String code;
    @NotNull
    private Date doj;//date of join
    @NotNull
    private Date doe;//date of expired

    private Set<EmpContactPerson> empContactPersons;

    public Emp(User user, Profile profile) {
        super(user, profile);
    }

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public Date getDoj() {
        return doj;
    }

    public void setDoj(Date doj) {
        this.doj = doj;
    }

    public Set<EmpContactPerson> getEmpContactPersons() {
        return empContactPersons;
    }

    public void setEmpContactPersons(Set<EmpContactPerson> empContactPersons) {
        this.empContactPersons = empContactPersons;
    }

    public Date getDoe() {
        return doe;
    }

    public void setDoe(Date doe) {
        this.doe = doe;
    }

}
