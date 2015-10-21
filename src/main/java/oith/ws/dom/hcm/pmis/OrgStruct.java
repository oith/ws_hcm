package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "OrgStruct")
public class OrgStruct extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @NotNull
    @Indexed
    private CostCenter costCenter;

    @NotNull
    @Indexed
    private OrgUnit plant;//factory, Operational unit within a company code. ie: production facility, branch office.

    @NotNull
    @Indexed
    private OrgUnit storageLocation;//warehouse 1,2,3

    public OrgStruct(User user) {
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

    public OrgUnit getPlant() {
        return plant;
    }

    public void setPlant(OrgUnit plant) {
        this.plant = plant;
    }

}
