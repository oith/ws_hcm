/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package oith.ws.dom.hcm.pmis;

import oith.ws.dom.core.User;
import org.springframework.data.mongodb.core.mapping.Document;

/**
 *
 * @author mbadiuzzaman
 */
@Document(collection = "AppFire")
public class AppFire extends AbstAssignmentAltApp{

    public AppFire(User user, Emp emp) {
        super(user, emp);
    }
    
}
