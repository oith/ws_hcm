package oith.ws.ctrl;

import oith.ws.exception.ClientNotFoundException;
import oith.ws.service.ClientService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dto._SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/client")
public class ClientController extends _OithController {

    protected static final String MODEL_ATTIRUTE = "client";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private ClientService clientService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        // UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        // String userId = authUser.getUserId();
        // User user = super.getUserService().findById(userId);
        model.addAttribute("clientCategorys", Client.ClientCategory.values());
        model.addAttribute(MODEL_ATTIRUTE, new Client());
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid Client currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("clientCategorys", Client.ClientCategory.values());
            return ADD_FORM_VIEW;
        }

        Client org = clientService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, org.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + org.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client = clientService.findById(id);

        if (client == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, client);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Client currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("clientCategorys", Client.ClientCategory.values());
            return EDIT_FORM_VIEW;
        }

        try {
            Client client = clientService.update(currObject, "code,name,active,slNo,remarks,clientCategory,domain,loginUrl,userCreateUrl");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, id);
        } catch (Exception e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Client> orgs;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            orgs = clientService.search(searchCriteria);
        } else {
            orgs = clientService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, orgs);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String list(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(5);

        List<Client> orgs = clientService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, orgs);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client = clientService.findById(id);

        if (client == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, client);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Client deleted = clientService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (ClientNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
