package oith.ws.dom.hcm.pmis;

import java.util.Set;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import org.springframework.data.mongodb.core.mapping.DBRef;
import oith.ws.dom.core.ICodable;

@Document(collection = "Grade")
public class Grade extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;
    @NotNull
    @Indexed
    private String name;

    private String description;

    @DBRef
    private Set<Job> jobs;

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
