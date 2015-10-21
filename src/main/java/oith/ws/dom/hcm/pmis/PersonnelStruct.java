package oith.ws.dom.hcm.pmis;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "PersonnelStruct")
public class PersonnelStruct extends AbstDocAudit implements ICodable {

    @NotNull
    @Indexed
    private String code;

    @NotNull
    @Indexed
    private EmployeeGroup employeeGroup;

    @NotNull
    @Indexed
    private EmployeeSubgroup employeeSubgroup;

    @NotNull
    @Indexed
    private PayrollArea payrollArea;

    public PersonnelStruct(User user) {
        super(user);
    }

    @Override
    public String getCode() {
        return code;
    }

    @Override
    public void setCode(String code) {
        this.code = code;
    }

    public EmployeeGroup getEmployeeGroup() {
        return employeeGroup;
    }

    public void setEmployeeGroup(EmployeeGroup employeeGroup) {
        this.employeeGroup = employeeGroup;
    }

    public EmployeeSubgroup getEmployeeSubgroup() {
        return employeeSubgroup;
    }

    public void setEmployeeSubgroup(EmployeeSubgroup employeeSubgroup) {
        this.employeeSubgroup = employeeSubgroup;
    }

    public PayrollArea getPayrollArea() {
        return payrollArea;
    }

    public void setPayrollArea(PayrollArea payrollArea) {
        this.payrollArea = payrollArea;
    }

    public enum EmployeeGroup {

        EXTERNAL,
        PENSIONER,
        ACTIVE
    }

    public enum EmployeeSubgroup {

        NON_PAY_SCALE,
        HOURLY_WAGE,
        SALARIED,
        TRAINEE
    }

    public enum PayrollArea {

        MONTHLY,
        BI_WEEKLY,
        WEEKLY
    }

}
