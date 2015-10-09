package oith.ws.dom.acad;

import oith.ws.dom.hcm.pmis.EmpContactPerson;
import oith.ws.dom.core.AbstDoc;
import java.util.Date;
import org.springframework.data.mongodb.core.index.Indexed;

public class Owner extends AbstDoc {

    @Indexed(unique = true)
    private String code;
    private Date doj;
    private Double pct;
    private EmpContactPerson contactPerson;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDoj() {
        return doj;
    }

    public void setDoj(Date doj) {
        this.doj = doj;
    }

    public Double getPct() {
        return pct;
    }

    public void setPct(Double pct) {
        this.pct = pct;
    }

    public EmpContactPerson getContactPerson() {
        return contactPerson;
    }

    public void setContactPerson(EmpContactPerson contactPerson) {
        this.contactPerson = contactPerson;
    }


}
