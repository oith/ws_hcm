package oith.ws.ctrl;

import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.AbstDocAudit;
import oith.ws.dom.core.User;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.UserDetailsMac;
import oith.ws.service.UserService;

public abstract class _OithAuditController extends _OithController {

    @Autowired
    private UserService userService;

    protected User getCurrUser() throws UserNotFoundException {
        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();

        if (userId == null) {
            throw new UserNotFoundException();
        }

        User user = userService.findById(userId);

        if (user == null) {
            throw new UserNotFoundException();
        }
        return user;
    }

    protected void doAuditInsert(AbstDocAudit currObject) throws UserNotFoundException {
        User user = getCurrUser();
//        currObject.setClient(user.getClient());
        currObject.setInsertByUser(user);
        currObject.setInsertDate(new Date());
    }

    protected void doAuditUpdate(AbstDocAudit currObject) throws UserNotFoundException {
        currObject.setUpdateByUser(getCurrUser());
        currObject.setUpdateDate(new Date());
    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    
    
}
