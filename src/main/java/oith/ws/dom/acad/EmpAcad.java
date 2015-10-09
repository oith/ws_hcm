package oith.ws.dom.acad;

import oith.ws.dom.hcm.pmis.Emp;
import java.util.Set;

public class EmpAcad extends Emp {

    private Set<ClassName> classNames;

    public Set<ClassName> getClassNames() {
        return classNames;
    }

    public void setClassNames(Set<ClassName> classNames) {
        this.classNames = classNames;
    }

}
