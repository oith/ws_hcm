package oith.ws.dom.acad;

import java.util.Set;

public class ClassRoom extends Room {

    private int noOfSeat;

    private Set<ClassName> classNames;

    public int getNoOfSeat() {
        return noOfSeat;
    }

    public void setNoOfSeat(int noOfSeat) {
        this.noOfSeat = noOfSeat;
    }

    public Set<ClassName> getClassNames() {
        return classNames;
    }

    public void setClassNames(Set<ClassName> classNames) {
        this.classNames = classNames;
    }

}
