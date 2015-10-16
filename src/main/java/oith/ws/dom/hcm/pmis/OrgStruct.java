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
    private Dept dept;

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

 

}
