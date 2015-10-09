package oith.ws.dom.acad;

import java.io.Serializable;

public class Subject implements Serializable {

    private String name;
    private String supportReader;

    private int mark;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    public String getSupportReader() {
        return supportReader;
    }

    public void setSupportReader(String supportReader) {
        this.supportReader = supportReader;
    }

}
