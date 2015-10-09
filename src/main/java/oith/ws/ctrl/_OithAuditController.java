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

    private User getCurrUser() throws UserNotFoundException {
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
        currObject.setInsertDate(new Date());
        currObject.setInsertByUser(getCurrUser());
    }

    protected void doAuditUpdate(AbstDocAudit currObject) throws UserNotFoundException {
        currObject.setUpdateDate(new Date());
        currObject.setUpdateByUser(getCurrUser());
    }
}
