/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package oith.ws.dom.hcm.pmis;

import java.util.Date;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import oith.ws.dom.hcm.core.AbstEmpApp;

/**
 *
 * @author mbadiuzzaman
 */
public abstract class AbstAssignmentAltApp extends AbstEmpApp {

    private Date effectDate;
    private Date prlEffectDate;
    private String refNo;
    //AltType altType;

    public AbstAssignmentAltApp(User user, Emp emp) {
        super(user, emp);
    }

    public Date getEffectDate() {
        return effectDate;
    }

    public void setEffectDate(Date effectDate) {
        this.effectDate = effectDate;
    }

    public Date getPrlEffectDate() {
        return prlEffectDate;
    }

    public void setPrlEffectDate(Date prlEffectDate) {
        this.prlEffectDate = prlEffectDate;
    }

    public String getRefNo() {
        return refNo;
    }

    public void setRefNo(String refNo) {
        this.refNo = refNo;
    }
    
    
}
