package oith.ws.dom.hcm.pmis;

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
    private OrgUnit orgStruct;
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

    public OrgUnit getOrgStruct() {
        return orgStruct;
    }

    public void setOrgStruct(OrgUnit orgStruct) {
        this.orgStruct = orgStruct;
    }

    public Job getJob() {
        return job;
    }

    public void setJob(Job job) {
        this.job = job;
    }

}
