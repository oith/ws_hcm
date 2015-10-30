package oith.ws.dom.hcm.fd;

import oith.ws.dom.hcm.core.AbstEmpAttach;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.IPeriodical;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "AssignmentFd")
public class AssignmentFd extends AbstEmpAttach implements IPeriodical {

    @NotNull
    @DBRef
    private Mess mess;
    @NotNull
    private Date startDate;
    private Date endDate;

    public AssignmentFd(User user, Emp emp) {
        super(user, emp);
    }

    @Override
    public Date getStartDate() {
        return startDate;
    }

    @Override
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public Date getEndDate() {
        return endDate;
    }

    @Override
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Mess getMess() {
        return mess;
    }

    public void setMess(Mess mess) {
        this.mess = mess;
    }

}
