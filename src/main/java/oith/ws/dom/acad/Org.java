package oith.ws.dom.acad;

import oith.ws.dom.core.Address;
import oith.ws.dom.core.ContactInfo;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.AbstDoc;
import java.util.Date;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "Org")
public class Org extends AbstDoc {

    public enum OrgType {

        SCHOOL, COLLEGE
    }

    public enum OrgCat {

        GOVT, PRIVATE
    }

    @NotNull
    private String code;
    @NotNull
    @Indexed
    private String name;
    private String remarks;
    private Address address;
    private ContactInfo contactInfo;
    private OrgCat orgCat;
    private OrgType orgType;
    private Date initDate;
    private boolean active;

    @DBRef
    private Profile profile;

    public Profile getProfile() {
        return profile;
    }

    public void setProfile(Profile profile) {
        this.profile = profile;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public OrgCat getOrgCat() {
        return orgCat;
    }

    public void setOrgCat(OrgCat orgCat) {
        this.orgCat = orgCat;
    }

    public OrgType getOrgType() {
        return orgType;
    }

    public void setOrgType(OrgType orgType) {
        this.orgType = orgType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public ContactInfo getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(ContactInfo contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Date getInitDate() {
        return initDate;
    }

    public void setInitDate(Date initDate) {
        this.initDate = initDate;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    @Override
    public String toString() {
        return name;
    }

}
