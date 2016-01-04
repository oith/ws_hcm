package oith.ws.ctrl.core;

import oith.ws.dom.core.Post;
import oith.ws.exception.PostNotFoundException;
import oith.ws.service.PostService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import org.apache.commons.beanutils.PropertyUtils;
import org.bson.types.ObjectId;
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
@RequestMapping(value = "/post")
public class PostController extends _OithClientAuditController {

    protected static final String MODEL_ATTIRUTE = "post";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private PostService postService;

    private void allComboSetup(ModelMap model) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        //List signs = Arrays.asList(TrnscFm.Sign.values());
        //List emps = new LinkedList();
        //for (Emp col : empService.findAll()) {
        //    emps.add(col);
        //}
        //List accountHeadFms = new LinkedList();
        //for (AccountHeadFm col : accountHeadFmService.findAllByClient(client)) {
        //    accountHeadFms.add(col);
        //}
        //model.addAttribute("signs", signs);
        //model.addAttribute("emps", emps);
        //model.addAttribute("accountHeadFmOpposites", accountHeadFms);
        //model.addAttribute("accountHeadFms", accountHeadFms);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new Post());
        allComboSetup(model);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return ADD_FORM_VIEW;
        }

        Post currObjectLocal = postService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Post currObjectLocal = postService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        }

        try {
            Post currObjectLocal = postService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            //post = postService.update(currObject);
            Post currObjectLocal = postService.update(currObject, "auditor,subject,content,comments");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.GET)
    public String copy(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Post currObjectLocal = postService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return COPY_FORM_VIEW;
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return COPY_FORM_VIEW+"ggggggg";
        }

//        try {
//            Post currObjectLocal = postService.findById(id, client);
//            currObject.setAuditor(currObjectLocal.getAuditor());
//            super.update(currObject);
//        } catch (NotLoggedInException | InAppropriateClientException e) {
//            return REDIRECT_TO_LOGIN;
//        } catch (PostNotFoundException ex) {
//            return NOT_FOUND;
//        }
        // String idx = ObjectId.get().toString();
        //currObject.setId(idx);
        //System.out.println("uuuuuuuuuuuuuuuu kkkkkkk 1044: " + idx + " currObject: " + currObject+" id: "+id);
        try {
            //post = postService.update(currObject);
            Post gg = new Post();
         //   PropertyUtils.copyProperties(currObject,gg);
           // String idx = ObjectId.get().toString();
            //gg.setId(idx);

            Post currObjectLocal = postService.create(gg);

            //System.out.println("uuuuuuuuuuuuuuuu yyyyyyy 1044: " + idx + " currObject: " + currObject + " ggg " + currObjectLocal);
            //Post currObjectLocal = postService.update(currObject, "auditor,subject,content,comments");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_COPIED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return COPY_FORM_VIEW+"oooooo"+e;
        }
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        String searchTerm = searchCriteria.getSearchTerm();
        List<Post> posts;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            posts = postService.search(searchCriteria, client);
        } else {
            posts = postService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, posts);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;

    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.GET)
    public String list(ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Post> posts = postService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, posts);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Post currObjectLocal = postService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            Post deleted = postService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

}
