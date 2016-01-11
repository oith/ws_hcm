package oith.ws.ctrl.core;

import oith.ws.dom.core.Menu;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.MenuNotFoundException;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
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
@RequestMapping(value = "/menu")
public class MenuController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "menu";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private oith.ws.service.MenuService menuService;

    private void allComboSetup(ModelMap model) {

        //model.addAttribute("signs", Arrays.asList(TrnscFm.Sign.values()));
        //List emps = new LinkedList();
        //for (Emp col : empService.findAllByClient(client)) {
        //    emps.add(col);
        //}
        //model.addAttribute("emps", emps);
        //List accountHeadFms = new LinkedList();
        //for (AccountHeadFm col : accountHeadFmService.findAllByClient(client)) {
        //    accountHeadFms.add(col);
        //}
        //model.addAttribute("accountHeadFms", accountHeadFms);
        //model.addAttribute("accountHeadFmOpposites", accountHeadFms);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model) {

        model.addAttribute(MODEL_ATTIRUTE, new Menu());
        allComboSetup(model);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Menu currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return ADD_FORM_VIEW;
        }

        Menu currObjectLocal = menuService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model) {

        try {
            Menu currObjectLocal = menuService.findById(id);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        } catch (MenuNotFoundException ex) {
            return NOT_FOUND;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Menu currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        }

        try {
            Menu currObjectLocal = menuService.findById(id);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (MenuNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            //menu = menuService.update(currObject);
            Menu currObjectLocal = menuService.update(currObject, "auditor,code,menuType,text,address");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.GET)
    public String copy(@PathVariable("id") String id, ModelMap model) {

        try {
            Menu currObjectLocal = menuService.findById(id);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return COPY_FORM_VIEW;
        } catch (MenuNotFoundException ex) {
            return NOT_FOUND;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Menu currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return COPY_FORM_VIEW;
        }

        Menu currObjectReal;
        try {
            currObjectReal = menuService.findById(id);
        } catch (MenuNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            Menu currObjectLocal = new Menu();
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,code,menuType,text,address");
            currObjectLocal = menuService.create(currObjectLocal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_COPIED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model);
            return COPY_FORM_VIEW;
        }
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Menu> menus;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            menus = menuService.search(searchCriteria);
        } else {
            menus = menuService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, menus);
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

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Menu> menus = menuService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, menus);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model) {

        try {
            Menu currObjectLocal = menuService.findById(id);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (MenuNotFoundException ex) {
            return NOT_FOUND;
        }
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Menu deleted = menuService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (MenuNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

}
