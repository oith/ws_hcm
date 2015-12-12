package oith.ws.ctrl;

import java.util.Date;
import static oith.ws.ctrl._OithController.ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND;
import oith.ws.dom.core.AbstDocClientAudit;
import oith.ws.dom.core.Auditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.IAuditable;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUserDetail;
import oith.ws.service.ProfileService;
import oith.ws.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithAuditController extends _OithController {

    @Autowired
    private UserService userService;


    public MacUserDetail getLoggedPrincipal() throws NotLoggedInException {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            return (MacUserDetail) authUserObj;
        }

        throw new NotLoggedInException();
    }

    protected User getLoggedUser() throws NotLoggedInException {
        MacUserDetail authUser = getLoggedPrincipal();
        User user = userService.findById(authUser.getUserId());
        return user;
    }

//    protected void doAuditInsert(IAuditable currObject) throws NotLoggedInException, UserNotFoundException {
//        Auditor auditor = currObject.getAuditor();
//        if (auditor == null) {
//            currObject.setAuditor(new Auditor(getLoggedUser(), new Date()));
//        }
//    }
    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }


    protected MacUserDetail save(IAuditable currObject, RedirectAttributes attributes) throws NotLoggedInException {

        MacUserDetail authUser = getLoggedPrincipal();
        Auditor auditor = currObject.getAuditor();
        if (auditor == null) {
            User user = userService.findById(authUser.getUserId());
            currObject.setAuditor(new Auditor(user, new Date()));
        }
        return authUser;
    }

    protected void update(IAuditable currObject) throws NotLoggedInException {
        Auditor auditor = currObject.getAuditor();

        MacUserDetail authUser = getLoggedPrincipal();
        User user = userService.findById(authUser.getUserId());

        if (auditor == null) {
            currObject.setAuditor(new Auditor(user, new Date()));
        }

        currObject.getAuditor().setUpdateByUser(user);
        currObject.getAuditor().setUpdateDate(new Date());

    }
}
