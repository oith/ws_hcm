package oith.ws.dom.hcm.fd;

import oith.ws.dom.hcm.pmis.Grade;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.hcm.core.Period;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Cost")
public class Cost extends AbstDocAudit {

    @NotNull
    private Mess mess;
    @NotNull
    private Period period;
    @NotNull
    private Double cost;

}
