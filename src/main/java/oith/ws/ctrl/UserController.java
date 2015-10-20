package oith.ws.ctrl;

import java.util.ArrayList;
import java.util.HashMap;
import oith.ws.dom.core.User;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.UserService;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.validation.Valid;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import oith.ws.dom.core.Role;
import oith.ws.dto._SearchDTO;
import oith.ws.service.ClientService;
import oith.ws.service.RoleService;
import oith.ws.service.UserDetailsMac;

@Controller
@RequestMapping(value = "/user")
public class UserController extends _OithController {

    protected static final String MODEL_ATTIRUTE = "user";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    protected static final String ADD_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_create";
    protected static final String EDIT_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_edit";
    protected static final String SHOW_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_show";

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private ClientService clientService;

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model) {

        Client client = new Client();
        User user = new User(client);
        //Set<Role> roles = getCommonRoles();
        //user.setAuthorities(roles);
        model.addAttribute(MODEL_ATTIRUTE, user);

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        //Set<Role> roles = getCommonRoles();
        //currObject.setAuthorities(roles);
        currObject.setAccountNonExpired(true);
        currObject.setAccountNonLocked(true);
        currObject.setCredentialsNonExpired(true);
        currObject.setEnabled(true);

        User user = userService.create(currObject);

        //session.getSessionContext().getSession(LIST_VIEW)
        //session.setAttribute("userId", user.getId());
        //session.setAttribute("fullName", user.getDisplayName());
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, user.getId());
        return "redirect:/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String showEditForm(ModelMap model, RedirectAttributes attributes) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = userService.findById(userId);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();

        currObject.setId(userId);

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        try {//user name cant be update admin can do
            User user = userService.update(currObject, "fullName,gender,dob,password");//username
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());

            //session.setAttribute("userId", user.getId());
            //session.setAttribute("fullName", user.getDisplayName());
            authUser.setUserId(user.getId());
            authUser.setFullName(user.getFullName());

            return "redirect:/" + SHOW_FORM_VIEW;
        } catch (UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String showForm(ModelMap model, RedirectAttributes attributes) {
        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();

        User user = userService.findById(userId);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin_create", method = RequestMethod.GET)
    public String showAdminCreateForm(ModelMap model) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String clientId = authUser.getClientId();
        Client client = clientService.findById(clientId);

        User user = new User(client);
        //Set<Role> roles = getCommonRoles();
        //user.setAuthorities(roles);
        model.addAttribute("authorities", getAuthorities());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return ADD_FORM_VIEW_ADMIN;
    }

    private Set<Role> getCommonRolesx() {
        Set<Role> roles = new HashSet();
        // roles.add(new Role(null, "55cef88a27b665569010fccc"));
        //roles.add(new Role());
        // roles.add("ROLE_USER");
        return roles;
    }

    @RequestMapping(value = "/admin_create", method = RequestMethod.POST)
    public String submitAdminCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("authorities", getAuthorities());
            return ADD_FORM_VIEW_ADMIN;
        }

        //Set<Role> roles = getCommonRoles();
        //currObject.setAuthorities(roles);
        User user = userService.create(currObject);

        //session.getSessionContext().getSession(LIST_VIEW)
        //session.setAttribute("userId", user.getId());
        //session.setAttribute("fullName", user.getDisplayName());
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, user.getId());
        return "redirect:/" + "admin/" + SHOW_FORM_VIEW_ADMIN + "/" + user.getId();
    }

    private Map<String, String> getAuthorities() {

        Map<String, String> phones = new HashMap();

        for (Role col : roleService.findAll()) {
            phones.put(col.getId(), col.getCode() + "-" + col.getName());
        }
//        phones.put("samsung", "SAMSUNG");
//        phones.put("nokia", "NOKIA");
//        phones.put("iphone", "IPHONE");
//        phones.put("bberry", "BLACKBERRY");
//        phones.put("htc", "HTC");

        return phones;
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.GET)
    public String showAdminEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        User user = userService.findById(id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute("authorities", getAuthorities());
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/admin_edit", method = RequestMethod.POST)
    public String submitAdminEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("authorities", getAuthorities());
            return EDIT_FORM_VIEW_ADMIN;
        }

        try {
            User user = userService.update(currObject, "fullName,gender,dob,username,password,authorities");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());
            return "redirect:/" + "admin/" + SHOW_FORM_VIEW_ADMIN + "/" + user.getId();
        } catch (UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return null;
        }
    }

    @RequestMapping(value = {"", "/index"}, method = RequestMethod.POST)
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

    @RequestMapping(value = {"", "/index"}, method = RequestMethod.GET)
    public String showList(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<User> users = userService.findAll(searchCriteria);

        System.out.println("showList:" + users);

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
        System.out.println("showForm: " + user + " userId: " + id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        List<Role> kk = new ArrayList<>();
//        kk.add(new Role("55cef88a27b665569010fcce", "*", "Permit All"));
//        kk.add(new Role("55cef88a27b665569010fccc", "USER", "User"));
//        kk.add(new Role("55cef88a27b665569010fccd", "ADMIN", "Administrator"));

        for (Role kk1 : roleService.findAll()) {
            kk.add(kk1);
        }

        model.addAttribute("allAuthorities", kk);
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
        return "redirect:/" + "admin/" + LIST_VIEW;
    }
}
