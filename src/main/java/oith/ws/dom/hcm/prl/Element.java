package oith.ws.dom.hcm.prl;

import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;

@Document(collection = "Element")
public class Element extends AbstDocAudit implements ICodable {

    public Element(User user) {
        super(user);
    }

    public static enum ElementPole {

        EARNING,
        DEDUCTION
    }

    @NotNull
    @Indexed(unique = true)
    private String code;

    @NotNull
    @Indexed
    private String name;

    private String description;
    private String accNo;
    private ElementPole elementPole;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

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

    public String getAccNo() {
        return accNo;
    }

    public void setAccNo(String accNo) {
        this.accNo = accNo;
    }

    public ElementPole getElementPole() {
        return elementPole;
    }

    public void setElementPole(ElementPole elementPole) {
        this.elementPole = elementPole;
    }

}
