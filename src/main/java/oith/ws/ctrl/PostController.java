package oith.ws.ctrl;

import oith.ws.dom.core.Post;
import oith.ws.dom.core.User;
import oith.ws.exception.PostNotFoundException;
import oith.ws.service.PostService;
import oith.ws.service.UserService;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import oith.ws.dto._SearchDTO;
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
import oith.ws.service.UserDetailsMac;

@Controller
//@RequestMapping(value = "/")
//@RequestMapping(value = "/post")
//@SessionAttributes("post")
public class PostController extends _OithController {

    protected static final String MODEL_ATTIRUTE = "post";
    protected static final String MODEL_ATTRIBUTES = "posts";
    protected static final String ADD_FORM_VIEW = "post/create";
    protected static final String EDIT_FORM_VIEW = "post/edit";
    protected static final String SHOW_FORM_VIEW = "post/show";
    protected static final String LIST_VIEW = "post/index";

    @Autowired
    private PostService postService;

    @Autowired
    private UserService userService;

    //  public String showEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
    @RequestMapping(value = "/post/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model, RedirectAttributes attributes) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();

        if (userId == null) {
            System.out.println("No user found with id: " + userId);
            attributes.addFlashAttribute("flashMessage", "Please login to post, man!");
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        User user = userService.findById(userId);

        if (user == null) {
            System.out.println("No user found with obj id: " + userId);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, new Post(user));

        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/post/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }
        Post post = postService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, post.getId());
        return "redirect:/" + SHOW_FORM_VIEW + "/" + post.getId();
    }

    @RequestMapping(value = "/post/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Post post = postService.findById(id);

        if (post == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, post);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/post/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Post currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

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

    @RequestMapping(value = {"/post", "/post/index"}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {

        String searchTerm = searchCriteria.getSearchTerm();
        List<Post> posts;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            posts = postService.search(searchCriteria);
        } else {
            posts = postService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, posts);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/post", "/post/index"}, method = RequestMethod.GET)
    public String showList(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Post> posts = postService.findAll(searchCriteria);

        model.addAttribute(MODEL_ATTRIBUTES, posts);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/post/show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Post post = postService.findById(id);

        if (post == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, post);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/post/delete/{id}", method = RequestMethod.GET)
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
