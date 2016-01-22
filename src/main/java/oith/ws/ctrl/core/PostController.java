package oith.ws.ctrl.core;

import oith.ws.dom.core.Post;
import oith.ws.dom.core.Comment;

import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import javax.validation.Valid;
import oith.ws.ctrl.core._OithClientAuditController;
import oith.ws.dom.core.Auditor;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IEmbdDetail;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.PostNotFoundException;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.ReportNotFoundException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
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

@Controller
@RequestMapping(value = "/post")
public class PostController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "post";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private oith.ws.service.PostService postService;

    private void allComboSetup(ModelMap model) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

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

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new Post(client));
        allComboSetup(model);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject,
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

        Post currObjectLocal = postService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model) {

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
        } catch (PostNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            //post = postService.update(currObject);
            Post currObjectLocal = postService.update(currObject, "auditor,subject,content,comments");
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
            return COPY_FORM_VIEW;
        }

        Post currObjectReal;
        try {
            currObjectReal = postService.findById(id, client);
        } catch (InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            Post currObjectLocal = new Post(client);
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,subject,content,comments");
            currObjectLocal = postService.create(currObjectLocal);
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
    public String show(@PathVariable("id") String id, ModelMap model) {

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

    @RequestMapping(value = "/comments/edit/{id}", method = RequestMethod.POST)
    public String commentsModal(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Comment currObject,
            RedirectAttributes attributes) {

        Post objOrignal;
        try {
            objOrignal = postService.findById(id);
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            if (objOrignal.getComments() == null) {
                objOrignal.setComments(new LinkedHashSet<Comment>());
            }

            if (currObject.getEmbdId() == null) {//new detail

                int mx = -1;
                for (Comment col : objOrignal.getComments()) {
                    mx = Math.max(col.getEmbdId(), mx);
                }

                currObject.setEmbdId(mx + 1);
                currObject.setAuditor(new Auditor(null, new Date()));
                objOrignal.getComments().add(currObject);

            } else {//update

                for (Comment col : objOrignal.getComments()) {
                    if (col.getEmbdId().equals(currObject.getEmbdId())) {

                        if (currObject.getAuditor() == null) {
                            currObject.setAuditor(new Auditor(null, new Date()));
                        }
                        currObject.getAuditor().setUpdateDate(new Date());

                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            postService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getEmbdId());
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = "/det/del/{dets}", method = RequestMethod.GET)
    public String submitDelDtl(@PathVariable("dets") String dets, RedirectAttributes attributes) {

        String aaa[] = dets.split("~");

        String field = aaa[0];
        String dtsMstId = aaa[1];
        Integer id = Integer.parseInt(aaa[2]);

        Post currMst;
        try {
            currMst = postService.findById(dtsMstId);
        } catch (PostNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            PropertyDescriptor pd = new PropertyDescriptor(field, Post.class);
            Method getter = pd.getReadMethod();
            Set<IEmbdDetail> jjj = (Set<IEmbdDetail>) getter.invoke(currMst);

            for (IEmbdDetail col : jjj) {
                if (col.getEmbdId().equals(id)) {
                    jjj.remove(col);
                    break;
                }
            }
            postService.update(currMst);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, dtsMstId);
        } catch (IntrospectionException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + dtsMstId;
    }

}
