package oith.ws.ctrl;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import oith.ws.dom.core.ContactInfo;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.service.ProfileService;
import oith.ws.service.UserService;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSFile;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.gridfs.GridFsOperations;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import static oith.ws.ctrl._OithController.FEEDBACK_MESSAGE_KEY_EDITED;
import oith.ws.dom.core.IEmbdDetail;
import oith.ws.dom.core.ProfileEduDtl;
import oith.ws.dom.core.ProfileJobDtl;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.UserDetailsMac;

@Controller
//@RequestMapping(value = "/")
//@RequestMapping(value = "/profile")
//@SessionAttributes("profile")
public class ProfileController extends _OithAuditController {

    protected static final String MODEL_ATTIRUTE = "profile";
    protected static final String MODEL_ATTRIBUTES = "profiles";
    protected static final String ADD_FORM_VIEW = "profile/create";
    protected static final String EDIT_FORM_VIEW = "profile/edit";
    protected static final String EDIT_FORM_VIEW_ADMIN = "profile/admin_edit";
    protected static final String SHOW_FORM_VIEW = "profile/show";
    protected static final String LIST_VIEW = "profile/index";
    protected static final String SHOW_FORM_VIEW_ADMIN = "profile/admin_show";
    protected static final String SHOW_FORM_VIEW_OPERATOR = "profile/operator_show";

    @Autowired
    private ProfileService profileService;

    @Autowired
    private GridFsOperations gridFsTemplate;

    @Autowired
    private UserService userService;

    //profile/det/del/ProfileEduDtls~55cef88a27b665569010f85c~4
    @RequestMapping(value = "profile/det/del/{dets}", method = RequestMethod.GET)
    public String submitDelDtl(@PathVariable("dets") String dets, RedirectAttributes attributes) {

        String aaa[] = dets.split("~");

        String method = "get" + aaa[0];
        String profileId = aaa[1];
        Integer id = Integer.parseInt(aaa[2]);

        Profile profile = profileService.findById(profileId);

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileIdCurr = authUser.getProfileId();

        try {

            Method mm = Profile.class.getDeclaredMethod(method);
            Set<IEmbdDetail> jjj = (Set<IEmbdDetail>) mm.invoke(profile);

            for (IEmbdDetail col : jjj) {
                if (col.getEmbdId().equals(id)) {
                    jjj.remove(col);
                    break;
                }
            }

            doAuditUpdate(profile);

            profileService.update(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | UserNotFoundException | ProfileNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/profile/show";
        } else {
            return "redirect:/admin/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/profile/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model, RedirectAttributes attributes) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = userService.findById(userId);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        Profile profile = profileService.findByUser(user);
        if (profile == null) {
            profile = new Profile(user);
            model.addAttribute(MODEL_ATTIRUTE, profile);

            return ADD_FORM_VIEW;
        } else {
            return "redirect:/" + SHOW_FORM_VIEW;
        }
    }

    @RequestMapping(value = "admin/profile/admin_show_4m_user/{id}", method = RequestMethod.GET)
    public String showShowFormAUser(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        User user = userService.findById(id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        Profile profile = profileService.findByUser(user);
        if (profile == null) {
            profile = new Profile();
            model.addAttribute("userId", id);
            model.addAttribute(MODEL_ATTIRUTE, profile);

            return "profile/admin_create";
        } else {
            return "redirect:/" + "admin/" + SHOW_FORM_VIEW_ADMIN + "/" + profile.getId();
        }
    }

    @RequestMapping(value = "admin/profile/admin_create", method = RequestMethod.POST)
    public String submitCreateForm4mUser(@ModelAttribute("userId") String userId, @ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        User user = userService.findById(userId);
        currObject.setUser(user);

        if (bindingResult.hasErrors()) {
            return "profile/admin_create";
        }

        try {
            doAuditInsert(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return "profile/admin_create";
        }

        Profile profile = profileService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, profile.getId());

        return "redirect:/" + "admin/" + SHOW_FORM_VIEW_ADMIN + "/" + profile.getId();
    }

    @RequestMapping(value = "/profile/create", method = RequestMethod.POST)
    public String submitCreateForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userId = authUser.getUserId();
        User user = userService.findById(userId);

        currObject.setUser(user);

        if (bindingResult.hasErrors()) {
            return ADD_FORM_VIEW;
        }

        try {
            doAuditInsert(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return ADD_FORM_VIEW;
        }

        Profile profile = profileService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, profile.getId());
        authUser.setProfileId(profile.getId());

        return "redirect:/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/profile/edit", method = RequestMethod.GET)
    public String showEditForm(ModelMap model, RedirectAttributes attributes) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileId = authUser.getProfileId();

        //String profileId = (String) session.getAttribute("profileId");
        System.out.println("Rendering edit profile form for profile with id: " + profileId);

        Profile profile = profileService.findById(profileId);

        if (profile == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, profile);

        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/profileEduDtl/edit", method = RequestMethod.POST)
    public String submitEditDetailEduForm(@ModelAttribute("profileId") String profileId, @ModelAttribute(MODEL_ATTIRUTE) @Valid ProfileEduDtl currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        Profile profile = profileService.findById(profileId);

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileIdCurr = authUser.getProfileId();

        try {

            Integer id = currObject.getEmbdId();

            if (profile.getProfileEduDtls() == null) {
                profile.setProfileEduDtls(new LinkedHashSet<ProfileEduDtl>());
            }

            if (id == null) {//new detail

                int mx = -1;
                for (ProfileEduDtl col : profile.getProfileEduDtls()) {
                    mx = Math.max(col.getEmbdId(), mx);
                }

                //currObject.setId(profile.getProfileEduDtls().size());
                currObject.setEmbdId(mx + 1);
                profile.getProfileEduDtls().add(currObject);
            } else {//update

                for (ProfileEduDtl col : profile.getProfileEduDtls()) {
                    if (col.getEmbdId().equals(id)) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            try {
                doAuditUpdate(profile);
            } catch (UserNotFoundException ex) {
                System.out.println("No user object found with id: " + ex);
                addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
                return ADD_FORM_VIEW;
            }
            profileService.update(profile);
            //profile = profileService.update(profile, "profileEduDtls");
            //profile = profileRepository.save(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | ProfileNotFoundException e) {
            System.out.println("No profile was found err: " + e);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/" + SHOW_FORM_VIEW;
        } else {
            return "redirect:/admin/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/profileJobDtl/edit", method = RequestMethod.POST)
    public String submitEditDetailJobForm(@ModelAttribute("profileId") String profileId, @ModelAttribute(MODEL_ATTIRUTE) @Valid ProfileJobDtl currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        Profile profile = profileService.findById(profileId);

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileIdCurr = authUser.getProfileId();

        try {

            Integer id = currObject.getEmbdId();

            if (profile.getProfileJobDtls() == null) {
                profile.setProfileJobDtls(new LinkedHashSet<ProfileJobDtl>());
            }

            if (id == null) {//new detail

                int mx = -1;
                for (ProfileJobDtl col : profile.getProfileJobDtls()) {
                    mx = Math.max(col.getEmbdId(), mx);
                }

                //currObject.setId(profile.getProfileEduDtls().size());
                currObject.setEmbdId(mx + 1);
                profile.getProfileJobDtls().add(currObject);
            } else {//update

                for (ProfileJobDtl col : profile.getProfileJobDtls()) {
                    if (col.getEmbdId().equals(id)) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            try {
                doAuditUpdate(profile);
            } catch (UserNotFoundException ex) {
                System.out.println("No user object found with id: " + ex);
                addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
                return ADD_FORM_VIEW;
            }

            profileService.update(profile);
            //profile = profileService.update(profile, "profileEduDtls");
            //profile = profileRepository.save(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | ProfileNotFoundException e) {
            System.out.println("No profile was found err: " + e);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/" + SHOW_FORM_VIEW;
        } else {
            return "redirect:/admin/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/admin/profile/admin_delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Profile deleted = profileService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (ProfileNotFoundException e) {
            System.out.println("No profile found with id: " + id);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/admin/profile/index";
    }

    @RequestMapping(value = "/admin/profile/admin_edit/{id}", method = RequestMethod.GET)
    public String showAdminEditForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        Profile user = profileService.findById(id);

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/admin/profile/admin_edit", method = RequestMethod.POST)
    public String submitAdminEditFormDD(@ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW_ADMIN;
        }
        imageHandle(request, currObject);
        try {
            doAuditUpdate(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return ADD_FORM_VIEW;
        }
        try {
            Profile user = profileService.update(currObject, "firstName,middleName,lastName,nickName,profilePicFile,updateDate,updateByUser");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());
            return "redirect:/" + "admin/" + SHOW_FORM_VIEW_ADMIN + "/" + user.getId();

        } catch (ProfileNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return null;
        }

    }

    @RequestMapping(value = "/profile/edit", method = RequestMethod.POST)
    public String submitEditForm(@ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileId = authUser.getProfileId();

        currObject.setId(profileId);

        ContactInfo contactInfo = new ContactInfo();
        contactInfo.setWeb("www.oith.org");
        contactInfo.setMobile("036128763");
        contactInfo.setPhone("9666676");
        contactInfo.setEmail("anis.php@gmail.com");
        currObject.setContactInfo(contactInfo);

        imageHandle(request, currObject);

        if (bindingResult.hasErrors()) {
            System.out.println("Edit profile form contains validation errors. Rendering form view." + bindingResult.getFieldError());
            return EDIT_FORM_VIEW;
        }

        try {
            doAuditUpdate(currObject);
        } catch (UserNotFoundException ex) {
            System.out.println("No user object found with id: " + ex);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return ADD_FORM_VIEW;
        }

        try {
            Profile profile = profileService.update(currObject, "permanentAddress,presentAddress,contactInfo,org,firstName,lastName,middleName,nickName,profilePicFile,user,updateDate,updateByUser");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (ProfileNotFoundException e) {
            System.out.println("No profile was found with id: " + profileId);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return "redirect:/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = {"/admin/profile", "/admin/profile/index"}, method = RequestMethod.POST)
    public String search(@ModelAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {
        System.out.println("Searching profiles with search criteria: " + searchCriteria);

        String searchTerm = searchCriteria.getSearchTerm();
        List<Profile> profiles;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            profiles = profileService.search(searchCriteria);
        } else {
            profiles = profileService.findAll(searchCriteria);
        }
        model.addAttribute(MODEL_ATTRIBUTES, profiles);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"/admin/profile", "/admin/profile/index"}, method = RequestMethod.GET)
    public String showList(ModelMap model) {
        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Profile> profiles = profileService.findAll(searchCriteria);

        System.out.println("showList:" + profiles);

        model.addAttribute(MODEL_ATTRIBUTES, profiles);
        model.addAttribute(MODEL_ATTRIBUTE_SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/profile/show", method = RequestMethod.GET)
    public String showForm(ModelMap model, RedirectAttributes attributes, HttpServletResponse resp) {
        //String profileId = (String) session.getAttribute("profileId");

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileId = authUser.getProfileId();
        Profile profile = profileService.findById(profileId);

        System.out.println("showForm:" + profile);

        if (profile == null) {
            System.out.println("No profile found with id: " + profileId);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        model.addAttribute(MODEL_ATTIRUTE, profile);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin/profile/admin_show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
        Profile user = profileService.findById(id);
        System.out.println("showForm: " + user + " userId: " + id);

        if (user == null) {

            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW_ADMIN;
    }

     @RequestMapping(value = "/operator/profile/operator_show/{id}", method = RequestMethod.GET)
    public String showOperForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
        Profile user = profileService.findById(id);
        System.out.println("showForm: " + user + " userId: " + id);

        if (user == null) {

            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW_OPERATOR;
    }
    
    
            
            
            
    @RequestMapping(value = "/profile/getPhoto/{code}", method = RequestMethod.GET)
    public @ResponseBody
    ResponseEntity<byte[]> getCodableDTO(@PathVariable("code") String code) {

        System.out.println("finding getCodableDTO: code: " + code);

        try {

            //List<GridFSDBFile> result = gridFsTemplate.find(new Query().addCriteria(Criteria.where("filename").is(code)));
            GridFSDBFile gridFsFile = gridFsTemplate.findOne(new Query().addCriteria(Criteria.where("_id").is(code)));

            final HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_JPEG);
            return new ResponseEntity<>(IOUtils.toByteArray(gridFsFile.getInputStream()), headers, HttpStatus.CREATED);

        } catch (Exception e) {
            System.out.println("eeeeeeeey get photo " + e);
            return null;
        }

    }

    @RequestMapping(value = "/profile/getPhoto/small/{code}", method = RequestMethod.GET)
    public @ResponseBody
    ResponseEntity<byte[]> getCodableDTOSmall(@PathVariable("code") String code) {

        System.out.println("finding getCodableDTO: code: " + code);

        try {
            GridFSDBFile gridFsFile = gridFsTemplate.findOne(new Query().addCriteria(Criteria.where("_id").is(code)));

            //GridFSDBFile gridFsFile = gridFsTemplate.findOne(new Query().addCriteria(Criteria.where("metadata.size").is("small").and("metadata.parent").is(code)));
            final HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_JPEG);
            return new ResponseEntity<>(IOUtils.toByteArray(gridFsFile.getInputStream()), headers, HttpStatus.CREATED);

        } catch (Exception e) {
            System.out.println("eeeeeeeey get photo " + e);
            return null;
        }

    }

    private void imageHandle(MultipartHttpServletRequest request, Profile currObject) {
        MultipartFile multipartFile = request.getFile("profilePicFile" + "OBJ");
        long sss;
        if ((multipartFile != null && (sss = multipartFile.getSize()) > 0)) {

            InputStream inputStream = null;
            try {
                inputStream = multipartFile.getInputStream();
            } catch (Exception e) {
                System.out.println("err in image:" + e);
            }

            DBObject metaData = new BasicDBObject();
            metaData.put("status", "active");
            metaData.put("size", "big");

            byte[] bbb = new byte[(int) sss];

            if (inputStream != null) {
                try {
                    inputStream.read(bbb);
                } catch (Exception e) {
                }
            }

            GridFSFile trt = gridFsTemplate.store(new ByteArrayInputStream(bbb), multipartFile.getOriginalFilename(), multipartFile.getContentType(), metaData);
            currObject.setProfilePicFile(trt.getId().toString());

            try {
                BufferedImage bsrc = ImageIO.read(new ByteArrayInputStream(bbb));//  new File(data));
                BufferedImage bdest = new BufferedImage(45, 55, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = bdest.createGraphics();
                AffineTransform at = AffineTransform.getScaleInstance((double) 45 / bsrc.getWidth(),
                        (double) 55 / bsrc.getHeight());
                g.drawRenderedImage(bsrc, at);

                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bdest, "png", baos);
                InputStream is = new ByteArrayInputStream(baos.toByteArray());

                metaData = new BasicDBObject();
                metaData.put("parent", trt.getId());
                metaData.put("status", "active");
                metaData.put("size", "small");
                GridFSFile trtx = gridFsTemplate.store(is, multipartFile.getOriginalFilename(), multipartFile.getContentType(), metaData);

                currObject.setProfilePicFile(trt.getId().toString());
                System.out.println("done small image id: " + trtx.getId().toString());
                //ImageIO.write(bdest, "jpg", filet);
            } catch (Exception e) {
                System.out.println("eeeeeeeee" + e);
            }

        }
    }
}
