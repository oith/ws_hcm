package oith.ws.dom.acad;

import oith.ws.dom.hcm.pmis.Emp;
import java.io.Serializable;
import java.util.Date;
import javax.validation.constraints.NotNull;

public class Admission implements Serializable {

    public enum AdmitType {

        NEW, PROMOTE
    }

    @NotNull
    private Student student;
    @NotNull
    private ClassName className;
    private Section section;
    @NotNull
    private Date admissionDate;
    @NotNull
    private Emp emp;
    private AdmitType admitType;
    private String fromInstitute;
    private String result;

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public ClassName getClassName() {
        return className;
    }

    public void setClassName(ClassName className) {
        this.className = className;
    }

    public Section getSection() {
        return section;
    }

    public void setSection(Section section) {
        this.section = section;
    }

    public Date getAdmissionDate() {
        return admissionDate;
    }

    public void setAdmissionDate(Date admissionDate) {
        this.admissionDate = admissionDate;
    }

    public Emp getEmp() {
        return emp;
    }

    public void setEmp(Emp emp) {
        this.emp = emp;
    }

    public AdmitType getAdmitType() {
        return admitType;
    }

    public void setAdmitType(AdmitType admitType) {
        this.admitType = admitType;
    }

    public String getFromInstitute() {
        return fromInstitute;
    }

    public void setFromInstitute(String fromInstitute) {
        this.fromInstitute = fromInstitute;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

}
