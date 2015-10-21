package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "OrgUnit")
public class OrgUnit extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;
    @NotNull
    @Indexed
    private String name;
    @NotNull
    private OrgType orgType;

    @NotNull
    @Indexed
    private CostCenter costCenter;

    private String description;

    public OrgUnit(User user) {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public OrgType getOrgType() {
        return orgType;
    }

    public void setOrgType(OrgType orgType) {
        this.orgType = orgType;
    }

    public enum OrgType {

        COMPANY_CODE, PERSONNEL_AREA, PERSONNEL_SUBAREA
        //BUSINESS_UNIT, OPERATING_UNIT, PLANT, DEPARTMENT, SUB_DEPARTMENT
    }
}
