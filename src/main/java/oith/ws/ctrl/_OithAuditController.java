package oith.ws.ctrl;

import java.util.Date;
import oith.ws.dom.core.Auditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IAuditable;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.exception.ClientNotFoundException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.ClientService;
import oith.ws.service.MacUserDetail;
import oith.ws.service.ProfileService;
import oith.ws.service.UserService;

public abstract class _OithAuditController extends _OithController {

    @Autowired
    private UserService userService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private ProfileService profileService;

    public MacUserDetail getLoggedPrincipal() throws NotLoggedInException {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            return (MacUserDetail) authUserObj;
        }

        throw new NotLoggedInException();
    }

    public Client getLoggedClient() throws NotLoggedInException, ClientNotFoundException {
        MacUserDetail authUser = getLoggedPrincipal();
        Client client = clientService.findById(authUser.getClientId());
        return client;
    }

    protected User getLoggedUser() throws NotLoggedInException, UserNotFoundException {
        MacUserDetail authUser = getLoggedPrincipal();
        User user = userService.findById(authUser.getUserId());
        return user;
    }

    protected Profile getLoggedProfile() throws NotLoggedInException, ProfileNotFoundException {
        MacUserDetail authUser = getLoggedPrincipal();
        Profile profile = profileService.findById(authUser.getProfileId());
        return profile;
    }

    protected void doAuditInsert(IAuditable currObject) throws NotLoggedInException, UserNotFoundException {
        //User user = getCurrUser();
        //currObject.setClient(user.getClient());
        Auditor auditor = currObject.getAuditor();

        if (auditor == null) {
            currObject.setAuditor(new Auditor(getLoggedUser(), new Date()));
        }
    }

    protected void doAuditUpdate(IAuditable currObject) throws NotLoggedInException, UserNotFoundException {
        Auditor auditor = currObject.getAuditor();

        if (auditor == null) {
            currObject.setAuditor(new Auditor(getLoggedUser(), new Date()));
        }

        currObject.getAuditor().setUpdateByUser(getLoggedUser());
        currObject.getAuditor().setUpdateDate(new Date());

    }

    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

}
