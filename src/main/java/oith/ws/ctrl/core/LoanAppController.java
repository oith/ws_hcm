package oith.ws.ctrl.core;

import oith.ws.dom.hcm.prl.LoanApp;
import oith.ws.exception.LoanAppNotFoundException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.validation.Valid;
import oith.ws.dom.core.Client;
import oith.ws.dom.hcm.def.os.HcmObject;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.InAppropriateClientException;
import oith.ws.exception.NotLoggedInException;
import oith.ws.exception.UserNotFoundException;
import oith.ws.service.MacUtils;
import oith.ws.util.StringToHcmObjectConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.support.GenericConversionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/loanApp")
public class LoanAppController extends _OithClientAuditController {

    public static final String MODEL_ATTIRUTE = "loanApp";
    public static final String MODEL_ATTRIBUTES = MODEL_ATTIRUTE + "s";
    public static final String ADD_FORM_VIEW = MODEL_ATTIRUTE + "/create";
    public static final String EDIT_FORM_VIEW = MODEL_ATTIRUTE + "/edit";
    public static final String COPY_FORM_VIEW = MODEL_ATTIRUTE + "/copy";
    public static final String SHOW_FORM_VIEW = MODEL_ATTIRUTE + "/show";
    public static final String LIST_VIEW = MODEL_ATTIRUTE + "/index";

    @Autowired
    private oith.ws.service.LoanAppService loanAppService;

    @Autowired
    private oith.ws.service.HcmObjectService hcmObjectService;

    @InitBinder
    void registerConverters(WebDataBinder binder) {
        if (binder.getConversionService() instanceof GenericConversionService) {
            GenericConversionService conversionService = (GenericConversionService) binder.getConversionService();

            //conversionService.addConverter(new StringToAccountHeadFmConverter(accountHeadFmService));
            conversionService.addConverter(new StringToHcmObjectConverter(hcmObjectService));
        }
    }

    private void allComboSetup(ModelMap model) {
        Client client = null;
        try {
            client = super.getLoggedClient();
        } catch (NotLoggedInException e) {
        }

        //model.addAttribute("signs", Arrays.asList(TrnscFm.Sign.values()));
        List emps = new LinkedList();
        for (HcmObject col : hcmObjectService.findAllByClient(client)) {
            emps.add(col);
        }
        model.addAttribute("emps", emps);

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

        model.addAttribute(MODEL_ATTIRUTE, new LoanApp(client));
        allComboSetup(model);
        return ADD_FORM_VIEW;
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String save(
            @ModelAttribute(MODEL_ATTIRUTE) @Valid LoanApp currObject,
            BindingResult bindingResult,
            ModelMap model,
            RedirectAttributes attributes) {

        try {
            super.save(currObject, attributes);
        } catch (NotLoggedInException e) {
            return REDIRECT_TO_LOGIN;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(LoanAppController.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (bindingResult.hasErrors()) {
            allComboSetup(model);
            return ADD_FORM_VIEW;
        }

        LoanApp currObjectLocal = loanAppService.create(currObject);
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
            LoanApp currObjectLocal = loanAppService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return EDIT_FORM_VIEW;
        } catch (LoanAppNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.POST)
    public String update(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid LoanApp currObject,
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
            LoanApp currObjectLocal = loanAppService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (LoanAppNotFoundException ex) {
            return NOT_FOUND;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(LoanAppController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            //loanApp = loanAppService.update(currObject);
            LoanApp currObjectLocal = loanAppService.update(currObject, "auditor,emp,code,appDate,remarks,approval,appliedAmount,sanctionAmount,installmentAmount,interestPct,remainingAmount,lastInstallmentAmount,lastInterestAmount,lastTouchPayrollPeriod,sanctionDate,loanType,loanStatus,reasonForLoan");
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
            LoanApp currObjectLocal = loanAppService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            allComboSetup(model);
            return COPY_FORM_VIEW;
        } catch (LoanAppNotFoundException ex) {
            return NOT_FOUND;
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
    }

    @RequestMapping(value = "/copy/{id}", method = RequestMethod.POST)
    public String copied(
            @PathVariable("id") String id,
            @ModelAttribute(MODEL_ATTIRUTE) @Valid LoanApp currObject,
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

        try {
            LoanApp currObjectLocal = loanAppService.findById(id, client);
            currObject.setAuditor(currObjectLocal.getAuditor());
            super.update(currObject);
        } catch (NotLoggedInException | InAppropriateClientException e) {
            return REDIRECT_TO_LOGIN;
        } catch (LoanAppNotFoundException ex) {
            return NOT_FOUND;
        } catch (UserNotFoundException ex) {
            Logger.getLogger(LoanAppController.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            LoanApp currObjectLocal = new LoanApp(client);
            MacUtils.copyProperties(currObjectLocal, currObject, "auditor,emp,code,appDate,remarks,approval,appliedAmount,sanctionAmount,installmentAmount,interestPct,remainingAmount,lastInstallmentAmount,lastInterestAmount,lastTouchPayrollPeriod,sanctionDate,loanType,loanStatus,reasonForLoan");
            currObjectLocal = loanAppService.create(currObjectLocal);
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
        List<LoanApp> loanApps;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            loanApps = loanAppService.search(searchCriteria, client);
        } else {
            loanApps = loanAppService.findAllByClient(searchCriteria, client);
        }
        model.addAttribute(MODEL_ATTRIBUTES, loanApps);
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

        List<LoanApp> loanApps = loanAppService.findAllByClient(searchCriteria, client);

        model.addAttribute(MODEL_ATTRIBUTES, loanApps);
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
            LoanApp currObjectLocal = loanAppService.findById(id, client);
            model.addAttribute(MODEL_ATTIRUTE, currObjectLocal);
            return SHOW_FORM_VIEW;
        } catch (LoanAppNotFoundException ex) {
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
            LoanApp deleted = loanAppService.delete(id, client);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DELETED, deleted.getId());
        } catch (LoanAppNotFoundException e) {
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND);
        } catch (InAppropriateClientException ex) {
            return REDIRECT_TO_LOGIN;
        }
        return REDIRECT + "/" + LIST_VIEW;
    }
}
