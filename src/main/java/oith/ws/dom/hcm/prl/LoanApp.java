package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.core.AbstEmpApp;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "LoanApp")
public class LoanApp extends AbstEmpApp {

    public Double getAppliedAmount() {
        return appliedAmount;
    }

    public void setAppliedAmount(Double appliedAmount) {
        this.appliedAmount = appliedAmount;
    }

    public Double getSanctionedAmount() {
        return sanctionedAmount;
    }

    public void setSanctionedAmount(Double sanctionedAmount) {
        this.sanctionedAmount = sanctionedAmount;
    }

    public Double getInstallmentAmount() {
        return installmentAmount;
    }

    public void setInstallmentAmount(Double installmentAmount) {
        this.installmentAmount = installmentAmount;
    }

    public Double getLastAmount() {
        return lastAmount;
    }

    public void setLastAmount(Double lastAmount) {
        this.lastAmount = lastAmount;
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
    private Double sanctionedAmount;
    private Double installmentAmount;
    private Double lastAmount;
    private Double remainingAmount;

    @NotNull
    private LoanType loanType;
    @NotNull
    private LoanStatus loanStatus;

}
