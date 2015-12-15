package oith.ws.ctrl.core;

import oith.ws.dom.core.AbstDocClientAudit;
import org.springframework.beans.factory.annotation.Autowired;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.Profile;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.service.ClientService;
import oith.ws.service.MacUserDetail;
import oith.ws.service.ProfileService;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithClientAuditController extends _OithAuditController {

    @Autowired
    private ClientService clientService;
    @Autowired
    private ProfileService profileService;

    public Client getLoggedClient() throws NotLoggedInException {
        MacUserDetail authUser = getLoggedPrincipal();
        Client client = clientService.findById(authUser.getClientId());
        return client;
    }

    protected Profile getLoggedProfile() throws NotLoggedInException, ProfileNotFoundException {
        MacUserDetail authUser = getLoggedPrincipal();
        Profile profile = profileService.findById(authUser.getProfileId());
        return profile;
    }

    void save(AbstDocClientAudit currObject, RedirectAttributes attributes) throws NotLoggedInException {

        MacUserDetail authUser = super.save(currObject, attributes);
        Client client = clientService.findById(authUser.getClientId());
        currObject.setClient(client);
    }

}
