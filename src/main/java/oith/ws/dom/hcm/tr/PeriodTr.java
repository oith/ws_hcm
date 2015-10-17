package oith.ws.dom.hcm.tr;

import java.util.Date;
import javax.validation.constraints.NotNull;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.ICodable;
import oith.ws.dom.core.IPeriodical;

@Document(collection = "Period")
public class PeriodTr extends AbstDocAudit implements ICodable, IPeriodical {

    @NotNull
    @Indexed
    private String code;
    @NotNull
    @Indexed
    private String name;

    private String description;

    @NotNull
    private Date startDate;
    @NotNull
    private Date endDate;

    @Override
    public String getCode() {
        return code;
    }

    @Override
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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

}
