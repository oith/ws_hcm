package oith.ws.ctrl.core;

import oith.ws.dom.hcm.def.os.HcmObject;
import java.beans.IntrospectionException;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.IEmbdDetail;
import oith.ws.dom.hcm.def.os.ICompanyCode;
import oith.ws.dom.hcm.def.os.IHcmObject;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.HcmObjectNotFoundException;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
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
@RequestMapping(value = "/hcmObject")
public class HcmObjectController extends oith.ws.ctrl.core._OithClientAuditController {

    protected static final String MODEL_ATTIRUTE = "hcmObject";
    protected static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    protected static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    protected static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    protected static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    protected static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    protected static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private org.springframework.context.MessageSource messageSource;

    @Autowired
    private oith.ws.service.HcmObjectService hcmObjectService;

    //@Autowired
    //private oith.ws.service.CompanyCodeService companyCodeService;

    //@Autowired
    //private oith.ws.service.CoaService coaService;
    //@Autowired
    //private oith.ws.service.FiscalYearVariantService fiscalYearVariantService;
    @Autowired
    private oith.ws.service.ProfileService profileService;

    private void allComboSetup(ModelMap model, Locale locale) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        //Map<AllEnum.Gender, String> genders = new EnumMap(AllEnum.Gender.class);
        //for (AllEnum.Gender col : AllEnum.Gender.values()) {
        //    genders.put(col, messageSource.getMessage("label.gender." + col.name(), null, locale));
        //}
        //model.addAttribute("genders", genders);
        //
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
    public String create(ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        model.addAttribute(MODEL_ATTIRUTE, new HcmObject(client));
        allComboSetup(model, locale);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            return NOT_FOUND;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return ADD_FORM_VIEW;
        }

        IHcmObject currObjectLocal = hcmObjectService.create(currObject);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_CREATED, currObjectLocal.getId());

        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(@PathVariable("id") String id, ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (HcmObjectNotFoundException | UserNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            //hcmObject = hcmObjectService.update(currObject);
            HcmObject currObjectLocal = hcmObjectService.update(currObject, "auditor,code,hcmObjectType,name,salesOffice,companyCode,currency,divisions,salesOrg,responsibleEmp,companyCodes,coa,fiscalYearVariant,controllingArea,profile,doj,isHeadOfPosition,costCenter,orgUnitType,orgUnitAccAssignment,storageLocations,purchasingOrg,nameSecondary,interval,description");
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
            return EDIT_FORM_VIEW;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.GET)
    public String copy(@PathVariable("id") String id, ModelMap model, Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        try {
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes,
            Locale locale) {

        Client client;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model, locale);
            return COPY_FORM_VIEW;
        }

        HcmObject currObjectReal;
        try {
            currObjectReal = hcmObjectService.findById(id, client);
        } catch (InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            IHcmObject currObjectLocal = new HcmObject(client);
            MacUtils.copyProperties(currObjectLocal, currObject, currObjectReal, "auditor,code,hcmObjectType,name,salesOffice,companyCode,currency,divisions,salesOrg,responsibleEmp,companyCodes,coa,fiscalYearVariant,controllingArea,profile,doj,isHeadOfPosition,costCenter,orgUnitType,orgUnitAccAssignment,storageLocations,purchasingOrg,nameSecondary,interval,description");
            currObjectLocal = hcmObjectService.create(currObjectLocal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_COPIED, currObjectLocal.getId());
            return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + currObjectLocal.getId();
        } catch (Exception e) {
            errorHandler(bindingResult, e);
            allComboSetup(model, locale);
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
        List<HcmObject> hcmObjects;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            hcmObjects = hcmObjectService.search(searchCriteria, client);
        } else {
            hcmObjects = hcmObjectService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, hcmObjects);
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

        List<HcmObject> hcmObjects = hcmObjectService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, hcmObjects);
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
            HcmObject currObjectLocal = hcmObjectService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (HcmObjectNotFoundException ex) {
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
            HcmObject deleted = hcmObjectService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (HcmObjectNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }

    @RequestMapping(value = "/divisions/edit/{id}", method = RequestMethod.POST)

    public String divisionsModal(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            RedirectAttributes attributes) {

        HcmObject objOrignal;
        try {
            objOrignal = hcmObjectService.findById(id);
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            if (objOrignal.getDivisions() == null) {
                objOrignal.setDivisions(new LinkedHashSet<HcmObject>());
            }

            if (currObject.getId() == null) {//new detail

//                int mx = -1;
//                for (HcmObject col : objOrignal.getDivisions()) {
//                    mx = Math.max(col.getId(), mx);
//                }
                currObject.setId(ObjectId.get().toString());
                objOrignal.getDivisions().add(currObject);

            } else {//update

                for (HcmObject col : objOrignal.getDivisions()) {
                    if (col.getId().equals(currObject.getId())) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            hcmObjectService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getId());
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | HcmObjectNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = "/companyCodes/edit/{id}", method = RequestMethod.POST)

    public String companyCodesModal(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid ICompanyCode currObject,
            RedirectAttributes attributes) {

        HcmObject objOrignal;
        try {
            objOrignal = hcmObjectService.findById(id);
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            if (objOrignal.getCompanyCodes() == null) {
                objOrignal.setCompanyCodes(new LinkedHashSet<ICompanyCode>());
            }

            if (currObject.getId() == null) {//new detail

//                int mx = -1;
//                for (CompanyCode col : objOrignal.getCompanyCodes()) {
//                    mx = Math.max(col.getId(), mx);
//                }
                currObject.setId(ObjectId.get().toString());
                objOrignal.getCompanyCodes().add(currObject);

            } else {//update

                for (ICompanyCode col : objOrignal.getCompanyCodes()) {
                    if (col.getId().equals(currObject.getId())) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            hcmObjectService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getId());
        } catch (Exception e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + id;
    }

    @RequestMapping(value = "/storageLocations/edit/{id}", method = RequestMethod.POST)

    public String storageLocationsModal(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid HcmObject currObject,
            RedirectAttributes attributes) {

        HcmObject objOrignal;
        try {
            objOrignal = hcmObjectService.findById(id);
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            if (objOrignal.getStorageLocations() == null) {
                objOrignal.setStorageLocations(new LinkedHashSet<HcmObject>());
            }

            if (currObject.getId() == null) {//new detail

//                int mx = -1;
//                for (HcmObject col : objOrignal.getStorageLocations()) {
//                    mx = Math.max(col.getId(), mx);
//                }
                currObject.setId(ObjectId.get().toString());
                objOrignal.getStorageLocations().add(currObject);

            } else {//update

                for (HcmObject col : objOrignal.getStorageLocations()) {
                    if (col.getId().equals(currObject.getId())) {
                        PropertyUtils.copyProperties(col, currObject);
                        break;
                    }
                }
            }

            hcmObjectService.update(objOrignal);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, currObject.getId());
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | HcmObjectNotFoundException e) {
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

        HcmObject currMst;
        try {
            currMst = hcmObjectService.findById(dtsMstId);
        } catch (HcmObjectNotFoundException ex) {
            return NOT_FOUND;
        }

        try {
            PropertyDescriptor pd = new PropertyDescriptor(field, HcmObject.class);
            Method getter = pd.getReadMethod();
            Set<IEmbdDetail> jjj = (Set<IEmbdDetail>) getter.invoke(currMst);

            for (IEmbdDetail col : jjj) {
                if (col.getEmbdId().equals(id)) {
                    jjj.remove(col);
                    break;
                }
            }
            hcmObjectService.update(currMst);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, dtsMstId);
        } catch (IntrospectionException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | HcmObjectNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }
        return REDIRECT + "/" + SHOW_FORM_VIEW + "/" + dtsMstId;
    }

}
