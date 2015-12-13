package oith.ws.ctrl;

import oith.ws.dom.core.Post;
import oith.ws.exception.PostNotFoundException;
import oith.ws.service.PostService;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.Valid;
import oith.ws.dom.core.User;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/post")
public class PostController extends _OithClientAuditController {

    protected static final String MODEL_ATTIRUTE = "post";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private PostService postService;

    //  public String showEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap model, RedirectAttributes attributes) throws UserNotFoundException, NotLoggedInException {

        User user = super.getLoggedUser();

        if (user == null) {
            attributes.addFlashAttribute("flashMessage", "Please login to post, man!");
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(INDEX);
        }

        model.addAttribute(MODEL_ATTIRUTE, new Post());

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(@ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        Post post = postService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, post.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + post.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        try {
            Post post = postService.findById(id, null);

            if (post == null) {
                addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
                return createRedirectViewPath(INDEX);
            }
            model.addAttribute(MODEL_ATTIRUTE, post);
        } catch (PostNotFoundException ex) {
            Logger.getLogger(PostController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return EDIT_FORM_VIEW;

    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String edit(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject,
            BindingResult bindingResult, ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW;
        }

        Post post = null;

        try {
            //currObject.setUser(userService.findByUsername("mac"));
            post = postService.update(currObject);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, post.getId());
        } catch (PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW + "/" + post.getId();
    }

    @RequestMapping(value = {"/", "/index", ""}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Post> posts;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            posts = postService.search(searchCriteria, null);
        } else {
            posts = postService.findAllByClient(searchCriteria, null);
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
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Post> posts = postService.findAllByClient(searchCriteria, null);

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

        Post post;
        try {
            post = postService.findById(id, null);

            if (post == null) {
                addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
                return createRedirectViewPath(INDEX);
            }
            model.addAttribute(MODEL_ATTIRUTE, post);
        } catch (PostNotFoundException ex) {
            Logger.getLogger(PostController.class.getName()).log(Level.SEVERE, null, ex);
        }

        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Post deleted = postService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (PostNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/" + LIST_VIEW;
    }
}
