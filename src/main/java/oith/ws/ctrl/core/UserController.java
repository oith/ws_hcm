package oith.ws.ctrl.core;

import oith.ws.service.UserService;
import oith.ws.dom.core.AllEnum;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.User;
import oith.ws.dom.core.Role;
import oith.ws.dom.core.ShortCut;
import oith.ws.dom.core.Param;
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IEmbdDetail;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.UserNotFoundException;
import oith.ws.exception.NotLoggedInException;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import oith.ws.service.ClientService;
import oith.ws.service.RoleService;
import oith.ws.service.MacUserDetail;
import oith.ws.util.StringToRoleConverter;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

@Controller
@RequestMapping(value = "/user")
public class UserController extends _OithClientAuditController {

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
    private org.springframework.context.MessageSource messageSource;
    
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

    private void allComboSetup(ModelMap model, Locale locale) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        //model.addAttribute("signs", Arrays.asList(TrnscFm.Sign.values()));
        Map<AllEnum.Gender, String> genders = new EnumMap(AllEnum.Gender.class);
        for (AllEnum.Gender col : AllEnum.Gender.values()) {
            genders.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        }
        model.addAttribute("genders", genders);

        List authorities = new LinkedList();
        for (Role col : roleService.findAllByClient(client)) {
            authorities.add(col);
        }
        model.addAttribute("authorities", authorities);

        List clients = new LinkedList();
        for (Client col : clientService.findAll()) {
            clients.add(col);
        }
        model.addAttribute("clients", clients);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model, Locale locale) {

        //Client client = new Client();
        User user = new User();

        model.addAttribute(MODEL_ATTIRUTE, user);
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, Locale locale) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
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
    public String showEditForm(ModelMap model, RedirectAttributes attributes, Locale locale) {

        Object authUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = null;

        if (authUser instanceof MacUserDetail) {
            String userId = ((MacUserDetail) authUser).getUserId();
            try {
                user = userService.findById(userId);
            } catch (UserNotFoundException ex) {
                Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        allComboSetup(model, locale);
        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, Locale locale) {

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
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }

        try {//user name cant be update but admin can do
            User user = userService.update(currObject, "fullName,gender,dob,password,envs");//username
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());

            //session.setAttribute("userId", user.getId());
            //session.setAttribute("fullName", user.getDisplayName());
            authUser.setUserId(user.getId());
            authUser.setFullName(user.getFullName());

            authUser.setEnvs(user.getEnvs());

            //authUser.setOpenInNewPage(user.getOpenInNewPage());
            //authUser.setLang(user.getLang());
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
            try {
                user = userService.findById(userId);
            } catch (UserNotFoundException ex) {
                Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin_create", method = RequestMethod.GET)
    public String showAdminCreateForm(ModelMap model, Locale locale) {

        Object authUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        Client client = null;

        if (authUser instanceof MacUserDetail) {
            String clientId = ((MacUserDetail) authUser).getClientId();//UserId();
            client = clientService.findById(clientId);
        }

        User user = new User(client);
        allComboSetup(model, locale);
        model.addAttribute(MODEL_ATTIRUTE, user);

        return ADD_FORM_VIEW_ADMIN;
    }

//    private Set<Role> getCommonRolesx() {
//        Set<Role> roles = new LinkedHashSet();
//        // roles.add(new Role(null, "55cef88a27b665569010fccc"));
//        //roles.add(new Role());
//        // roles.add("ROLE_USER");
//        return roles;
//    }
    @RequestMapping(value = "/admin_create", method = RequestMethod.POST)
    public String submitAdminCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, Locale locale) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
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
            RedirectAttributes attributes,
            Locale locale) {

        User user = null;
        try {
            user = userService.findById(id);
        } catch (UserNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        allComboSetup(model, locale);
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.POST)
    public String submitAdminEditForm(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid User currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
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
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        String searchTerm = searchCriteria.getSearchTerm();
        List<User> users;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            users = userService.search(searchCriteria, client);
        } else {
            users = userService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, users);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String list(ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<User> users = userService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, users);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/admin_show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes, Locale locale) {
        User user = null;
        try {
            user = userService.findById(id);
        } catch (UserNotFoundException ex) {
            Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        allComboSetup(model, locale);
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

    @RequestMapping(value = "/favorites/edit/{id}", method = RequestMethod.POST)
    public String favoritesModal(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid ShortCut currObject,
            RedirectAttributes attributes) {

        User objOrignal;
        try {
            objOrignal = userService.findById(id);
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            if (objOrignal.getFavorites() == null) {
                objOrignal.setFavorites(new LinkedHashSet<ShortCut>());
            }

            if (currObject.getEmbdId() == null) {//new detail

                int mx = -1;
                for (ShortCut col : objOrignal.getFavorites()) {
                    mx = Math.max(col.getEmbdId(), mx);
                }

                currObject.setEmbdId(mx + 1);
                objOrignal.getFavorites().add(currObject);

            } else {//update

                for (ShortCut col : objOrignal.getFavorites()) {
                    if (col.getEmbdId().equals(currObject.getEmbdId())) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            userService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getEmbdId());
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = "/params/edit", method = RequestMethod.POST)
    public String paramsModal(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Param currObject,
            RedirectAttributes attributes) {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String userId = null;
        if (authUserObj instanceof MacUserDetail) {
            userId = ((MacUserDetail) authUserObj).getUserId();
        }

        User objOrignal;
        try {
            objOrignal = userService.findById(userId);
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        //currObject.setId(userId);
        try {
            if (objOrignal.getParams() == null) {
                objOrignal.setParams(new LinkedHashSet<Param>());
            }

            if (currObject.getEmbdId() == null) {//new detail

                int mx = -1;
                for (Param col : objOrignal.getParams()) {
                    mx = Math.max(col.getEmbdId(), mx);
                }

                currObject.setEmbdId(mx + 1);
                objOrignal.getParams().add(currObject);

            } else {//update

                for (Param col : objOrignal.getParams()) {
                    if (col.getEmbdId().equals(currObject.getEmbdId())) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            userService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getEmbdId());
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/det/del/{dets}", method = RequestMethod.GET)
    public String submitDelDtl(@PathVariable("dets") String dets, RedirectAttributes attributes) {

        String aaa[] = dets.split("~");

        String field = aaa[0];
        String dtsMstId = aaa[1];
        Integer id = Integer.parseInt(aaa[2]);

        User currMst;
        try {
            currMst = userService.findById(dtsMstId);
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            PropertyDescriptor pd = new PropertyDescriptor(field, User.class);
            Method getter = pd.getReadMethod();
            Set<IEmbdDetail> jjj = (Set<IEmbdDetail>) getter.invoke(currMst);

            for (IEmbdDetail col : jjj) {
                if (col.getEmbdId().equals(id)) {
                    jjj.remove(col);
                    break;
                }
            }
            userService.update(currMst);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, dtsMstId);
        } catch (IntrospectionException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | UserNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + dtsMstId;
    }
}
