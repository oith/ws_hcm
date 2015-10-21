package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "EnterpriseStruct")
public class EnterpriseStruct extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @NotNull
    @Indexed
    private OrgUnit companyCode;

    //This level represents an independent accounting unit within a client. Each company code has its own balance sheet and its own profit and loss statement.
    //Example: a subsidiary company, member of a corporate group
    @NotNull
    @Indexed
    private OrgUnit personnelArea;//companyCode, factory, Operational unit within a company code. ie: production facility, branch office.

    @NotNull
    @Indexed
    private OrgUnit personnelSubarea;//Department

//     @NotNull
//    @Indexed
//    private Org plant;//factory, Operational unit within a company code. ie: production facility, branch office.
//
//    @Indexed
//    private Org subDepartment;
    public EnterpriseStruct(User user) {
        super(user);
    }

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public OrgUnit getCompanyCode() {
        return companyCode;
    }

    public void setCompanyCode(OrgUnit companyCode) {
        this.companyCode = companyCode;
    }

    public OrgUnit getPersonnelArea() {
        return personnelArea;
    }

    public void setPersonnelArea(OrgUnit personnelArea) {
        this.personnelArea = personnelArea;
    }

    public OrgUnit getPersonnelSubarea() {
        return personnelSubarea;
    }

    public void setPersonnelSubarea(OrgUnit personnelSubarea) {
        this.personnelSubarea = personnelSubarea;
    }

}
