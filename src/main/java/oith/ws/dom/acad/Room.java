package oith.ws.dom.acad;

import java.io.Serializable;

public class Room implements Serializable {

    private String name;//102,204 etc
    private String description;
    private Org institute;

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

    public Org getInstitute() {
        return institute;
    }

    public void setInstitute(Org institute) {
        this.institute = institute;
    }

}
