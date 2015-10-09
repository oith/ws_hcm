package oith.ws.dom.acad;

import oith.ws.dom.acad.Student;
import oith.ws.dom.core.AbstDoc;
import oith.ws.dom.hcm.pmis.Emp;
import java.util.Date;
import javax.validation.constraints.NotNull;

public abstract class Payment extends AbstDoc {

    public enum PayFor {

        UNDEFINED, ADMISSION, FEE, FINE, LAB, OTHER
    }

    @NotNull
    private Student student;
    @NotNull
    private Emp emp;
    @NotNull
    private Double amount;
    @NotNull
    private Date date;
    @NotNull
    private PayFor payFor;
    private String remarks;

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public Emp getEmp() {
        return emp;
    }

    public void setEmp(Emp emp) {
        this.emp = emp;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public PayFor getPayFor() {
        return payFor;
    }

    public void setPayFor(PayFor payFor) {
        this.payFor = payFor;
    }

}
