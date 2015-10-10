package oith.ws.dom.hcm.prl;

import java.util.Date;
import oith.ws.dom.hcm.core.AbstEmpApp;
import javax.validation.constraints.NotNull;
import oith.ws.dom.hcm.core.Period;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "LoanApp")
public class LoanApp extends AbstEmpApp {

    public static enum LoanType {

        HOUSE,
        CAR,
        STUDY,
        HOUSE_HOLD,
        OTHER
    }

    public static enum LoanStatus {

        OPEN,
        CLOSE
    }

    @NotNull
    private Double appliedAmount;
    private Double sanctionAmount;
    private Double installmentAmount;
    private Float interestPct;
    private Double remainingAmount;

    private Double lastInstallmentAmount;
    private Double lastInterestAmount;
    @DBRef
    private Period lastTouchPeriod;

    private Date sanctionDate;

    @NotNull
    private LoanType loanType;
    @NotNull
    private LoanStatus loanStatus;
    private String reasonForLoan;

    public Double getAppliedAmount() {
        return appliedAmount;
    }

    public void setAppliedAmount(Double appliedAmount) {
        this.appliedAmount = appliedAmount;
    }

    public Double getInstallmentAmount() {
        return installmentAmount;
    }

    public void setInstallmentAmount(Double installmentAmount) {
        this.installmentAmount = installmentAmount;
    }

    public Double getRemainingAmount() {
        return remainingAmount;
    }

    public void setRemainingAmount(Double remainingAmount) {
        this.remainingAmount = remainingAmount;
    }

    public LoanType getLoanType() {
        return loanType;
    }

    public void setLoanType(LoanType loanType) {
        this.loanType = loanType;
    }

    public LoanStatus getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(LoanStatus loanStatus) {
        this.loanStatus = loanStatus;
    }

    public Double getSanctionAmount() {
        return sanctionAmount;
    }

    public void setSanctionAmount(Double sanctionAmount) {
        this.sanctionAmount = sanctionAmount;
    }

    public Float getInterestPct() {
        return interestPct;
    }

    public void setInterestPct(Float interestPct) {
        this.interestPct = interestPct;
    }

    public Double getLastInstallmentAmount() {
        return lastInstallmentAmount;
    }

    public void setLastInstallmentAmount(Double lastInstallmentAmount) {
        this.lastInstallmentAmount = lastInstallmentAmount;
    }

    public Double getLastInterestAmount() {
        return lastInterestAmount;
    }

    public void setLastInterestAmount(Double lastInterestAmount) {
        this.lastInterestAmount = lastInterestAmount;
    }

    public Period getLastTouchPeriod() {
        return lastTouchPeriod;
    }

    public void setLastTouchPeriod(Period lastTouchPeriod) {
        this.lastTouchPeriod = lastTouchPeriod;
    }

    public Date getSanctionDate() {
        return sanctionDate;
    }

    public void setSanctionDate(Date sanctionDate) {
        this.sanctionDate = sanctionDate;
    }

    public String getReasonForLoan() {
        return reasonForLoan;
    }

    public void setReasonForLoan(String reasonForLoan) {
        this.reasonForLoan = reasonForLoan;
    }
}
