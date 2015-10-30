package oith.ws.dom.hcm.fm;

import java.util.Date;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "TrnscFm")
public class TrnscFm extends AbstDocAudit implements ICodable {

    public TrnscFm() {
    }

    public TrnscFm(User user) {
        super(user);
    }

    @NotNull
    private String code;
    @NotNull
    private Date transDate;
    @NotNull
    @DBRef
    private AccountHeadFm accountHeadFm;

    @NotNull
    private Sign sign;
    @NotNull
    @Min(1)
    @Max(100000)
    private Double amount;
    @DBRef
    private AccountHeadFm accountHeadFmOpposite;
    @DBRef
    private Emp emp;
    private String narration;

    @Override
    public String getCode() {
        return code;
    }

    @Override
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

    public AccountHeadFm getAccountHeadFmOpposite() {
        return accountHeadFmOpposite;
    }

    public void setAccountHeadFmOpposite(AccountHeadFm accountHeadFmOpposite) {
        this.accountHeadFmOpposite = accountHeadFmOpposite;
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

    public static enum Sign {

        DR,
        CR
    }
}
