package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import org.springframework.data.mongodb.core.mapping.DBRef;

@Document(collection = "Job")
public class Job extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @NotNull
    @DBRef
    private Desg desg;

    @NotNull
    @DBRef
    private Grade grade;

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public Grade getGrade() {
        return grade;
    }

    public void setGrade(Grade grade) {
        this.grade = grade;
    }

    public Desg getDesg() {
        return desg;
    }

    public void setDesg(Desg desg) {
        this.desg = desg;
    }

}
