package oith.ws.ctrl.core;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.User;
import oith.ws.exception.ProfileNotFoundException;
import oith.ws.service.ProfileService;
import com.mongodb.gridfs.GridFSDBFile;
import com.mongodb.gridfs.GridFSFile;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.beans.PropertyDescriptor;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
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
import static oith.ws.ctrl.core._OithController.FEEDBACK_MESSAGE_KEY_EDITED;
import static oith.ws.ctrl.core._OithController.REDIRECT_TO_LOGIN;
import oith.ws.dom.core.AllEnum;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IEmbdDetail;
import oith.ws.dom.core.ProfileEduDtl;
import oith.ws.dom.core.ProfileJobDtl;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUserDetail;

@Controller
@RequestMapping(value = "/profile")
public class ProfileController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "profile";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    public static final String EDIT_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_edit";
    public static final String SHOW_FORM_VIEW_ADMIN = MODEL_ATTIRUTE + "/admin_show";
    public static final String SHOW_FORM_VIEW_OPERATOR = MODEL_ATTIRUTE + "/operator_show";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private ProfileService profileService;

    @Autowired
    private GridFsOperations gridFsTemplate;

    private void allComboSetup(ModelMap model, Locale locale) {

        Map<AllEnum.BloodGroup, String> bloodGroups = new EnumMap(AllEnum.BloodGroup.class);
        for (AllEnum.BloodGroup col : AllEnum.BloodGroup.values()) {
            bloodGroups.put(col, messageSource.getMessage("label.allEnum.bloodGroup." + col.name(), null, locale));
        }
        model.addAttribute("bloodGroups", bloodGroups);

        Map<AllEnum.Religion, String> religions = new EnumMap(AllEnum.Religion.class);
        for (AllEnum.Religion col : AllEnum.Religion.values()) {
            religions.put(col, messageSource.getMessage("label.allEnum.religion." + col.name(), null, locale));
        }
        model.addAttribute("religions", religions);

        Map<AllEnum.MaritalSts, String> maritalStss = new EnumMap(AllEnum.MaritalSts.class);
        for (AllEnum.MaritalSts col : AllEnum.MaritalSts.values()) {
            maritalStss.put(col, messageSource.getMessage("label.allEnum.maritalSts." + col.name(), null, locale));
        }
        model.addAttribute("maritalStss", maritalStss);
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String showCreateForm(ModelMap model, RedirectAttributes attributes, Locale locale) {

        User user = null;
        try {
            user = super.getLoggedUser();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        Profile profile = profileService.findByUser(user);
        if (profile == null) {
            profile = new Profile();
            profile.setUser(user);
            model.addAttribute(MODEL_ATTIRUTE, profile);
            allComboSetup(model, locale);

            return ADD_FORM_VIEW;
        } else {
            return "redirect:/" + SHOW_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String submitCreateForm(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request,
            Locale locale) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return ADD_FORM_VIEW;
        }

        int code = new Random().nextInt(999999);
        currObject.setCode(String.format("%06d", code));

        Profile currObjectLocal = profileService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        authUser.setProfileId(currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String showEditForm(ModelMap model, RedirectAttributes attributes, Locale locale) {

        Profile profile = null;
        try {
            profile = super.getLoggedProfile();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (ProfileNotFoundException ex) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, profile);
        allComboSetup(model, locale);
        return EDIT_FORM_VIEW;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String submitEditForm(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request,
            Locale locale) {

        Profile profile = null;
        try {
            profile = super.getLoggedProfile();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (ProfileNotFoundException ex) {
            return REDIRECT_TO_LOGIN;
        }

        currObject.setId(profile.getId());

        imageHandle(request, currObject);

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }

        try {
            Profile currObjectLocal = profileService.update(currObject, "title,firstName,middleName,lastName,nickName,nid,profilePicFile,chestSize,height,weight,bloodGroup,maritalSts,religion,marriageDate,noOfChild");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
        } catch (ProfileNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin_show_4m_user/{id}", method = RequestMethod.GET)
    public String showShowFormAUser(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {

        User user = null;
        try {
            user = super.getUserService().findById(id);
        } catch (UserNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        Profile profile = profileService.findByUser(user);
        if (profile == null) {
            profile = new Profile(null);//c pore
            model.addAttribute("userId", id);
            model.addAttribute(MODEL_ATTIRUTE, profile);

            return "profile/admin_create";
        } else {
            return "redirect:/" + "" + SHOW_FORM_VIEW_ADMIN + "/" + profile.getId();
        }
    }

    @RequestMapping(value = "/admin_create", method = RequestMethod.POST)
    public String submitCreateForm4mUser(@ModelAttribute("userId") String userId, @ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        User user = null;
        try {
            user = super.getUserService().findById(userId);
        } catch (UserNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }
        currObject.setUser(user);

        if (bindingResult.hasErrors()) {
            return "profile/admin_create";
        }

        Profile profile = profileService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, profile.getId());

        return "redirect:/" + "" + SHOW_FORM_VIEW_ADMIN + "/" + profile.getId();
    }

    @RequestMapping(value = "/profileEduDtls/edit", method = RequestMethod.POST)
    public String submitEditDetailEduForm(@ModelAttribute("profileId") String profileId, @ModelAttribute(MODEL_ATTIRUTE) @Valid ProfileEduDtl currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        Profile profile = null;
        try {
            profile = profileService.findById(profileId);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
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

            profileService.update(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | ProfileNotFoundException e) {
            System.out.println("No profile was found err: " + e);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/" + SHOW_FORM_VIEW;
        } else {
            return "redirect:/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/profileJobDtls/edit", method = RequestMethod.POST)
    public String submitEditDetailJobForm(@ModelAttribute("profileId") String profileId, @ModelAttribute(MODEL_ATTIRUTE) @Valid ProfileJobDtl currObject, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes) {

        Profile profile = null;
        try {
            profile = profileService.findById(profileId);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
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
            return "redirect:/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/admin_delete/{id}", method = RequestMethod.GET)
    public String delete(@PathVariable("id") String id, RedirectAttributes attributes) {

        try {
            Profile deleted = profileService.delete(id);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (ProfileNotFoundException e) {
            System.out.println("No profile found with id: " + id);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        }
        return "redirect:/profile/index";
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.GET)
    public String showAdminEditForm(
            @PathVariable("id") String id,
            ModelMap model,
            RedirectAttributes attributes) {

        Profile user = null;
        try {
            user = profileService.findById(id);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }
        model.addAttribute(MODEL_ATTIRUTE, user);

        return EDIT_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/admin_edit/{id}", method = RequestMethod.POST)
    public String submitAdminEditFormDD(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid Profile currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            MultipartHttpServletRequest request) {

        if (bindingResult.hasErrors()) {
            return EDIT_FORM_VIEW_ADMIN;
        }
        imageHandle(request, currObject);
//        try {
//            doAuditUpdate(currObject);
//        } catch (UserNotFoundException ex) {
//            System.out.println("No user object found with id: " + ex);
//            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
//            return ADD_FORM_VIEW;
//        } catch (NotLoggedInException ex) {
//            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
//        }
        try {
            Profile user = profileService.update(currObject, "title,firstName,middleName,lastName,nickName,profilePicFile,updateDate,updateByUser");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, user.getId());
            return "redirect:/" + "" + SHOW_FORM_VIEW_ADMIN + "/" + user.getId();

        } catch (ProfileNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            return null;
        }
    }

    @RequestMapping(value = {"", "/index"}, method = RequestMethod.POST)
    public String search(@ModelAttribute(SEARCH_CRITERIA) _SearchDTO searchCriteria, ModelMap model) {
        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        String searchTerm = searchCriteria.getSearchTerm();
        List<Profile> profiles;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            profiles = profileService.search(searchCriteria, client);
        } else {
            profiles = profileService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, profiles);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = {"", "/index"}, method = RequestMethod.GET)
    public String showList(ModelMap model) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        _SearchDTO searchCriteria = new _SearchDTO();
        searchCriteria.setPage(0);
        searchCriteria.setPageSize(10);

        List<Profile> profiles = profileService.findAllByClient(searchCriteria, client);

        System.out.println("showList:" + profiles);

        model.addAttribute(MODEL_ATTRIBUTES, profiles);
        model.addAttribute(SEARCH_CRITERIA, searchCriteria);

        List<Integer> pages = new ArrayList<>();
        for (int i = 0; i < searchCriteria.getTotalPages(); i++) {
            pages.add(i);
        }
        model.addAttribute("pages", pages);
        return LIST_VIEW;
    }

    @RequestMapping(value = "/show", method = RequestMethod.GET)
    public String showForm(ModelMap model, RedirectAttributes attributes) {
        //String profileId = (String) session.getAttribute("profileId");

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileId = authUser.getProfileId();
        Profile profile = null;
        try {
            profile = profileService.findById(profileId);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (profile == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        model.addAttribute(MODEL_ATTIRUTE, profile);
        return SHOW_FORM_VIEW;
    }

    @RequestMapping(value = "/admin_show/{id}", method = RequestMethod.GET)
    public String showForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
        Profile user = null;
        try {
            user = profileService.findById(id);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW_ADMIN;
    }

    @RequestMapping(value = "/operator_show/{id}", method = RequestMethod.GET)
    public String showOperForm(@PathVariable("id") String id, ModelMap model, RedirectAttributes attributes) {
        Profile user = null;
        try {
            user = profileService.findById(id);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (user == null) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
            //return createRedirectViewPath(REQUEST_MAPPING_LIST);
        }

        model.addAttribute(MODEL_ATTIRUTE, user);
        return SHOW_FORM_VIEW_OPERATOR;
    }

    @RequestMapping(value = "/getPhoto/{code}", method = RequestMethod.GET)
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

    @RequestMapping(value = "/det/del/{dets}", method = RequestMethod.GET)
    public String submitDelDtl(@PathVariable("dets") String dets, RedirectAttributes attributes) {

        String aaa[] = dets.split("~");

        String field = aaa[0];
        String profileId = aaa[1];
        Integer id = Integer.parseInt(aaa[2]);

        Profile profile = null;
        try {
            profile = profileService.findById(profileId);
        } catch (ProfileNotFoundException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
        }

        MacUserDetail authUser = (MacUserDetail) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileIdCurr = authUser.getProfileId();

        try {
            PropertyDescriptor pd = new PropertyDescriptor(field, Profile.class);
            Method getter = pd.getReadMethod();//Profile.class.getDeclaredMethod(method);
            Set<IEmbdDetail> jjj = (Set<IEmbdDetail>) getter.invoke(profile);

            for (IEmbdDetail col : jjj) {
                if (col.getEmbdId().equals(id)) {
                    jjj.remove(col);
                    break;
                }
            }
            profileService.update(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (Exception e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/profile/show";
        } else {
            return "redirect:/profile/admin_show/" + profileId;
        }
    }

    @RequestMapping(value = "/getPhoto/small/{code}", method = RequestMethod.GET)
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
