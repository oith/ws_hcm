package oith.ws.dom.acad;

import oith.ws.dom.core.Profile;
import java.util.Date;
import java.util.Set;

public class Comity {

    private String name;
    private String description;
    private Date orientationDate;
    private Org institute;
    private Set<Profile> persons;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getOrientationDate() {
        return orientationDate;
    }

    public void setOrientationDate(Date orientationDate) {
        this.orientationDate = orientationDate;
    }

    public Org getInstitute() {
        return institute;
    }

    public void setInstitute(Org institute) {
        this.institute = institute;
    }

    public Set<Profile> getPersons() {
        return persons;
    }

    public void setPersons(Set<Profile> persons) {
        this.persons = persons;
    }

}
