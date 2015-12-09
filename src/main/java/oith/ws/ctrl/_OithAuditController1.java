package oith.ws.ctrl;

import java.util.Date;
import static oith.ws.ctrl._OithController.ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND;
import oith.ws.dom.core.AbstDocClientAudit;
import oith.ws.dom.core.Auditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IAuditable;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.ClientService;
import oith.ws.service.MacUserDetail;
import oith.ws.service.ProfileService;
import oith.ws.service.UserService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithAuditController1 extends _OithController {

    @Autowired
    private UserService userService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private ProfileService profileService;

    public void checkLoggedPrincipal() throws NotLoggedInException {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (!(authUserObj instanceof MacUserDetail) || authUserObj == null) {
            throw new NotLoggedInException();
        }

    }

    public MacUserDetail getLoggedPrincipal() throws NotLoggedInException {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            return (MacUserDetail) authUserObj;
        }

        throw new NotLoggedInException();
    }

    public Client getLoggedClient() throws NotLoggedInException {
        MacUserDetail authUser = getLoggedPrincipal();
        Client client = clientService.findById(authUser.getClientId());
        return client;
    }

    protected User getLoggedUser() throws NotLoggedInException {
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

    void create(RedirectAttributes attributes) {
        try {
            checkLoggedPrincipal();
        } catch (NotLoggedInException e) {
            attributes.addFlashAttribute("flashMessage", "Please login, man!");
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            // return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

    }

    void save(AbstDocClientAudit currObject, RedirectAttributes attributes) throws NotLoggedInException {

        MacUserDetail authUser = getLoggedPrincipal();
        Client client = clientService.findById(authUser.getClientId());
        currObject.setClient(client);

            //doAuditInsert(currObject);
        Auditor auditor = currObject.getAuditor();
        if (auditor == null) {
            User user = userService.findById(authUser.getUserId());
            currObject.setAuditor(new Auditor(user, new Date()));
        }
    }

}
