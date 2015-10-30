package oith.ws.dom.hcm.core;

import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;

public abstract class AbstEmpAttach extends AbstDocAudit {
    
    @DBRef
    @NotNull
    private Emp emp;
    
    public AbstEmpAttach(User user, Emp emp) {
        super(user);
        this.emp = emp;
    }
    
    public Emp getEmp() {
        return emp;
    }
    
    public void setEmp(Emp emp) {
        this.emp = emp;
    }
    
}
