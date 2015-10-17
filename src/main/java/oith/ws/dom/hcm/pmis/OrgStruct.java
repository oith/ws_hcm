package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;

@Document(collection = "OrgStruct")
public class OrgStruct extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @NotNull
    @Indexed
    private Org businessUnit;

    //This level represents an independent accounting unit within a client. Each company code has its own balance sheet and its own profit and loss statement.
    //Example: a subsidiary company, member of a corporate group
    @NotNull
    @Indexed
    private Org operatingUnit;//companyCode, factory, Operational unit within a company code. ie: production facility, branch office.

    @NotNull
    @Indexed
    private Org plant;//factory, Operational unit within a company code. ie: production facility, branch office.

    @NotNull
    @Indexed
    private Org department;

    @Indexed
    private Org subDepartment;

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public Org getBusinessUnit() {
        return businessUnit;
    }

    public void setBusinessUnit(Org businessUnit) {
        this.businessUnit = businessUnit;
    }

    public Org getOperatingUnit() {
        return operatingUnit;
    }

    public void setOperatingUnit(Org operatingUnit) {
        this.operatingUnit = operatingUnit;
    }

    public Org getPlant() {
        return plant;
    }

    public void setPlant(Org plant) {
        this.plant = plant;
    }

    public Org getDepartment() {
        return department;
    }

    public void setDepartment(Org department) {
        this.department = department;
    }

    public Org getSubDepartment() {
        return subDepartment;
    }

    public void setSubDepartment(Org subDepartment) {
        this.subDepartment = subDepartment;
    }

}
