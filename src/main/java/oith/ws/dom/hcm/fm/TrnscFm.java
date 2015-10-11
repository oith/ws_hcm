package oith.ws.dom.hcm.fm;

import java.util.Date;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.hcm.pmis.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "TrnscFm")
public class TrnscFm extends AbstDocAudit implements ICodable {

    public static enum Sign {

        DR,
        CR
    }

    @NotNull
    private String code;
    @NotNull
    private Date transDate;
    @NotNull
    @DBRef
    private AccountHeadFm accountHeadFm;
    @DBRef
    private AccountHeadFm accountHeadFmOppos;
    @NotNull
    private Sign sign;
    @NotNull
    private Double amount;

    @DBRef
    private Emp emp;
    private String narration;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTransDate() {
        return transDate;
    }

    public void setTransDate(Date transDate) {
        this.transDate = transDate;
    }

    public AccountHeadFm getAccountHeadFm() {
        return accountHeadFm;
    }

    public void setAccountHeadFm(AccountHeadFm accountHeadFm) {
        this.accountHeadFm = accountHeadFm;
    }

    public AccountHeadFm getAccountHeadFmOppos() {
        return accountHeadFmOppos;
    }

    public void setAccountHeadFmOppos(AccountHeadFm accountHeadFmOppos) {
        this.accountHeadFmOppos = accountHeadFmOppos;
    }

    public Sign getSign() {
        return sign;
    }

    public void setSign(Sign sign) {
        this.sign = sign;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Emp getEmp() {
        return emp;
    }

    public void setEmp(Emp emp) {
        this.emp = emp;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }

}
