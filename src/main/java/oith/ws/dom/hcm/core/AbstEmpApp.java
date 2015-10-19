package oith.ws.dom.hcm.core;

//import com.oith.annotation.MacSearchable;
import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.pmis.Emp;

public abstract class AbstEmpApp extends AbstEmpAttach implements ICodable{

    @NotNull
    private Date appDate;
    //@MacSearchable
    private String code;
    private String remarks;

    public AbstEmpApp(User user, Emp emp) {
        super(user, emp);
    }

    public Date getAppDate() {
        return appDate;
    }

    public void setAppDate(Date appDate) {
        this.appDate = appDate;
    }

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

}
