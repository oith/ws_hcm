package oith.ws.dom.hcm.prl;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;

@Document(collection = "Element")
public class Element extends AbstDocAudit implements ICodable {

    public static enum ElementPole {

        EARNING,
        DEDUCTION
    }

    @NotNull
    @Indexed(unique = true)
    private String code;

    @NotNull
    @Indexed
    private String name;

    private String description;
    ElementPole elementPole;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
