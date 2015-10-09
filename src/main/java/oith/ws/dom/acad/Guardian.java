package oith.ws.dom.acad;

import oith.ws.dom.core.Profile;
import oith.ws.dom.core.AbstDoc;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.DBRef;

public class Guardian extends AbstDoc {

    @DBRef
    @NotNull
    private Profile profile;

}
