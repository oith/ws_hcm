package oith.ws.dom.hcm.fm;

import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AccountHeadFm")
public class AccountHeadFm extends AbstDocAudit implements ICodable {

    @NotNull
    private String code;
    @NotNull
    private String title;
    @NotNull
    private String accNo;
    private Boolean active;
    private Integer slNo;
    private Boolean empRequired;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAccNo() {
        return accNo;
    }

    public void setAccNo(String accNo) {
        this.accNo = accNo;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getSlNo() {
        return slNo;
    }

    public void setSlNo(Integer slNo) {
        this.slNo = slNo;
    }

    public Boolean getEmpRequired() {
        return empRequired;
    }

    public void setEmpRequired(Boolean empRequired) {
        this.empRequired = empRequired;
    }

}
