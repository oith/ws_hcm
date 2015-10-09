package oith.ws.dom.acad;

import oith.ws.dom.core.Profile;
import oith.ws.dom.core.AbstDoc;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Student")
public class Student extends AbstDoc {

    @DBRef
    @NotNull
    private final Profile profile;

    //link for org + student, org can be acad org
    //@Indexed(unique = true)
    //private String roll;
    @DBRef
    private Guardian guardian;
    @DBRef
    private Guardian guardianLocal;
    @DBRef
    private Guardian guardianRemote;

    Student(Profile profile) {
        this.profile = profile;
    }

    public Profile getProfile() {
        return profile;
    }

    public Guardian getGuardian() {
        return guardian;
    }

    public void setGuardian(Guardian guardian) {
        this.guardian = guardian;
    }

    public Guardian getGuardianLocal() {
        return guardianLocal;
    }

    public void setGuardianLocal(Guardian guardianLocal) {
        this.guardianLocal = guardianLocal;
    }

    public Guardian getGuardianRemote() {
        return guardianRemote;
    }

    public void setGuardianRemote(Guardian guardianRemote) {
        this.guardianRemote = guardianRemote;
    }

    @Override
    public String toString() {
        return "Student{" + "profile=" + profile + ", guardian=" + guardian + ", guardianLocal=" + guardianLocal + ", guardianRemote=" + guardianRemote + '}';
    }


}
