package oith.ws.dom.hcm.tl;

import oith.ws.dom.hcm.core.AbstEmpApp;
import java.util.Date;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.IRanger;
import oith.ws.dom.core.User;
import oith.ws.dom.hcm.pmis.Emp;

@Document(collection = "LeaveApp")
public class LeaveApp extends AbstEmpApp implements IRanger {

    public LeaveApp(User user, Emp emp) {
        super(user, emp);
    }

    public static enum LeaveType {

        ACCIDENT,
        CASUAL,
        DEFERRED,
        JOINING,
        LWOP,
        LWP,
        MATERNITY,
        PRIVILEGE,
        QUARANTINE,
        SICK,
        SPECIAL_WOP,
        SPECIAL_WP,
        STUDY,
        SUSPENSION
    }

    @NotNull
    private Date fromDate;
    @NotNull
    private Date toDate;
    @NotNull
    private LeaveType leaveType;
    private String addressDuringLeave;
    private String contactNo;
    private String reasonForLeave;

    public LeaveType getLeaveType() {
        return leaveType;
    }

    public void setLeaveType(LeaveType leaveType) {
        this.leaveType = leaveType;
    }

    public String getAddressDuringLeave() {
        return addressDuringLeave;
    }

    public void setAddressDuringLeave(String addressDuringLeave) {
        this.addressDuringLeave = addressDuringLeave;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getReasonForLeave() {
        return reasonForLeave;
    }

    public void setReasonForLeave(String reasonForLeave) {
        this.reasonForLeave = reasonForLeave;
    }

    @Override
    public Date getFromDate() {
        return fromDate;
    }

    @Override
    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    @Override
    public Date getToDate() {
        return toDate;
    }

    @Override
    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }
}
