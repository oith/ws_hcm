package oith.ws.dom.hcm.pmis;

import oith.ws.dom.hcm.pmis.*;
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
    @Indexed
    private String name;

    private String description;

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

}
