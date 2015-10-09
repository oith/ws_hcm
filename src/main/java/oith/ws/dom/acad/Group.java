package oith.ws.dom.acad;

import java.io.Serializable;
import java.util.Set;

public class Group implements Serializable{

    private ClassName className;
    private String name;//general, science, arts, commerce
    private Set<Subject> subjects;

    public ClassName getClassName() {
        return className;
    }

    public void setClassName(ClassName className) {
        this.className = className;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Subject> getSubjects() {
        return subjects;
    }

    public void setSubjects(Set<Subject> subjects) {
        this.subjects = subjects;
    }

}
