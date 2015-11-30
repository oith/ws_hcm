package oith.ws.ctrl;

import java.util.ArrayList;
import oith.ws.dom.core.User;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.UserService;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.AllEnum;
import oith.ws.dom.core.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import oith.ws.dom.core.Role;
import oith.ws.dto._SearchDTO;
import oith.ws.service.ClientService;
import oith.ws.service.RoleService;
import oith.ws.service.MacUserDetail;
import oith.ws.util.StringToRoleConverter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

@Controller
@RequestMapping(value = "/user")
public class UserController extends _OithController {

    protected static final String MODEL_ATTIRUTE = "user";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";
    //
    protected static final String ADD_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_create";
    protected static final String EDIT_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_edit";
    protected static final String SHOW_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_show";

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private ClientService clientService;

    @InitBinder
    void registerConverters(WebDataBinder binder) {
        if (binder.getConversionService() instanceof GenericConversionService) {
            GenericConversionService conversionService = (GenericConversionService) binder.getConversionService();

            conversionService.addConverter(new StringToRoleConverter(roleService));
        }
    }

    private List<Client> getClients() {

        List<Client> clients = new ArrayList();

        for (Client col : clientService.findAll()) {
            clients.add(col);
        }
        return clients;
    }

    private List<Role> getAuthorities() {

        List<Role> roles = new ArrayList();

        for (Role col : roleService.findAll()) {
            roles.add(col);
        }
        return roles;
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model) {

        //Client client = new Client();
        User user = new User();
        model.addAttribute("genders",  AllEnum.Gender.values());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("genders", AllEnum.Gender.values());
            return ADD_FORM_VIEW;
        }

        currObject.setAccountNonExpired(true);
        currObject.setAccountNonLocked(true);
        currObject.setCredentialsNonExpired(true);
        currObject.setEnabled(true);

        User user = userService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, user.getId());
        return "redirect:/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String showEditForm(ModelMap model, RedirectAttributes attributes) {

        Object authUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = null;

        if (authUser instanceof MacUserDetail) {
            String userId = ((MacUserDetail) authUser).getUserId();
            user = userService.findById(userId);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute("genders",  AllEnum.Gender.values());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String userId = null;
        MacUserDetail authUser = null;
        if (authUserObj instanceof MacUserDetail) {
            userId = ((MacUserDetail) authUserObj).getUserId();
            authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        }

        if (authUser == null) {
            return "noLoginState";
        }

        currObject.setId(userId);

        if (bindingResult.hasErrors()) {
            model.addAttribute("genders",  AllEnum.Gender.values());
            return EDIT_FORM_VIEW;
        }

        try {//user name cant be update but admin can do
            User user = userService.update(currObject, "fullName,gender,dob,password,openInNewPage,lang");//username
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());

            //session.setAttribute("userId", user.getId());
            //session.setAttribute("fullName", user.getDisplayName());
            authUser.setUserId(user.getId());
            authUser.setFullName(user.getFullName());
            authUser.setOpenInNewPage(user.getOpenInNewPage());
            authUser.setLang(user.getLang());

            return "redirect:/" + SHOW_FORM_VIEW;
        } catch (UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String showForm(ModelMap model, RedirectAttributes attributes) {
        Object authUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        User user = null;

        if (authUser instanceof MacUserDetail) {
            String userId = ((MacUserDetail) authUser).getUserId();
            user = userService.findById(userId);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin_create", method = RequestMethod.GET)
    public String showAdminCreateForm(ModelMap model) {

        Object authUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Client client = null;

        if (authUser instanceof MacUserDetail) {
            String clientId = ((MacUserDetail) authUser).getClientId();//UserId();
            client = clientService.findById(clientId);
        }

        User user = new User(client);
        //Set<Role> roles = getCommonRoles();
        //user.setAuthorities(roles);
        model.addAttribute("clients", getClients());
        model.addAttribute("genders",  AllEnum.Gender.values());
        model.addAttribute("authorities", getAuthorities());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return ADD_FORM_VIEW_ADMIN;
    }

//    private Set<Role> getCommonRolesx() {
//        Set<Role> roles = new HashSet();
//        // roles.add(new Role(null, "55cef88a27b665569010fccc"));
//        //roles.add(new Role());
//        // roles.add("ROLE_USER");
//        return roles;
//    }
    @RequestMapping(value = "/admin_create", method = RequestMethod.POST)
    public String submitAdminCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("clients", getClients());
            model.addAttribute("genders",  AllEnum.Gender.values());
            model.addAttribute("authorities", getAuthorities());
            return ADD_FORM_VIEW_ADMIN;
        }

        //Set<Role> roles = getCommonRoles();
        //currObject.setAuthorities(roles);
        User user = userService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, user.getId());
        return "redirect:/" + SHOW_FORM_VIEW_ADMIN + "/" + user.getId();
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.GET)
    public String showAdminEditForm(
            @PathVariable("id") String id,
            ModelMap model,
            RedirectAttributes attributes) {

        User user = userService.findById(id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute("clients", getClients());
        model.addAttribute("genders",  AllEnum.Gender.values());
        model.addAttribute("authorities", getAuthorities());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.POST)
    public String submitAdminEditForm(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("clients", getClients());
            model.addAttribute("genders",  AllEnum.Gender.values());
            model.addAttribute("authorities", getAuthorities());
            return EDIT_FORM_VIEW_ADMIN;
        }

        try {
            User user = userService.update(currObject, "client,fullName,gender,dob,username,password,authorities");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());
        } catch (UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW_ADMIN + "/" + id;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<User> users;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            users = userService.search(searchCriteria);
        } else {
            users = userService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, users);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String showList(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<User> users = userService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, users);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/admin_show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
        User user = userService.findById(id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute("genders",  AllEnum.Gender.values());
        model.addAttribute("authorities", getAuthorities());
        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            User deleted = userService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + "" + LIST_VIEW;
    }
}
