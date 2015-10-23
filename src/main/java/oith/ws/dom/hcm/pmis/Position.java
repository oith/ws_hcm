package oith.ws.dom.hcm.pmis;

import oith.ws.dom.core.OrgStruct;
import oith.ws.dom.core.PersonnelStruct;
import oith.ws.dom.core.CostCenter;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import org.springframework.data.mongodb.core.mapping.DBRef;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "Position")
public class Position extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @DBRef
    @NotNull
    private CostCenter costCenter;

    @DBRef
    @NotNull
    private OrgStruct orgStruct;

//    @DBRef
//    @NotNull
//    private EnterpriseStruct enterpriseStruct;

    @DBRef
    @NotNull
    private PersonnelStruct personnelStruct;

    @DBRef
    @NotNull
    private Job job;

    public Position(User user) {
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

    @Override
    public String toString() {
        return job + " of " + orgStruct;
    }

    public OrgStruct getOrgStruct() {
        return orgStruct;
    }

    public void setOrgStruct(OrgStruct orgStruct) {
        this.orgStruct = orgStruct;
    }

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

    public CostCenter getCostCenter() {
        return costCenter;
    }

    public void setCostCenter(CostCenter costCenter) {
        this.costCenter = costCenter;
    }

//    public EnterpriseStruct getEnterpriseStruct() {
//        return enterpriseStruct;
//    }
//
//    public void setEnterpriseStruct(EnterpriseStruct enterpriseStruct) {
//        this.enterpriseStruct = enterpriseStruct;
//    }

    public PersonnelStruct getPersonnelStruct() {
        return personnelStruct;
    }

    public void setPersonnelStruct(PersonnelStruct personnelStruct) {
        this.personnelStruct = personnelStruct;
    }

}
