package oith.ws.dom.hcm.prl;

import oith.ws.dom.hcm.core.AbstEmpApp;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "LoanApp")
public class LoanApp extends AbstEmpApp {

    public enum LoanType {

        HOUSE,
        CAR,
        STUDY,
        HOUSE_HOLD,
        OTHER
    }

    public enum LoanStatus {

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
