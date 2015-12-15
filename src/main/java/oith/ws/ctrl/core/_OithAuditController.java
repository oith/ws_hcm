package oith.ws.ctrl.core;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import oith.ws.dom.core.AbstDoc;
import oith.ws.dom.core.Auditor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.IAuditable;
import oith.ws.dom.core.Param;
import oith.ws.dom.core.User;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.MacUserDetail;
import oith.ws.service.UserService;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithAuditController extends _OithController {

    @Autowired
    private UserService userService;

    public MacUserDetail getLoggedPrincipal() throws NotLoggedInException {

        Object authUserObj = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (authUserObj instanceof MacUserDetail) {
            return (MacUserDetail) authUserObj;
        }

        throw new NotLoggedInException();
    }

    protected User getLoggedUser() throws NotLoggedInException {
        MacUserDetail authUser = getLoggedPrincipal();
        User user = userService.findById(authUser.getUserId());
        return user;
    }

//    protected void doAuditInsert(IAuditable currObject) throws NotLoggedInException, UserNotFoundException {
//        Auditor auditor = currObject.getAuditor();
//        if (auditor == null) {
//            currObject.setAuditor(new Auditor(getLoggedUser(), new Date()));
//        }
//    }
    public UserService getUserService() {
        return userService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    protected MacUserDetail save(IAuditable currObject, RedirectAttributes attributes) throws NotLoggedInException {

        MacUserDetail authUser = getLoggedPrincipal();
        Auditor auditor = currObject.getAuditor();
        if (auditor == null) {
            User user = userService.findById(authUser.getUserId());
            currObject.setAuditor(new Auditor(user, new Date()));
        }
        return authUser;
    }

    protected void update(IAuditable currObject) throws NotLoggedInException {
        Auditor auditor = currObject.getAuditor();

        MacUserDetail authUser = getLoggedPrincipal();
        User user = userService.findById(authUser.getUserId());

        if (auditor == null) {
            currObject.setAuditor(new Auditor(user, new Date()));
        }

        currObject.getAuditor().setUpdateByUser(user);
        currObject.getAuditor().setUpdateDate(new Date());

    }

    protected void setUserParam(AbstDoc abstDoc, String action, ModelMap refs) {

        try {
            Class kkk = abstDoc.getClass();
            MacUserDetail authUser = getLoggedPrincipal();

            for (Param col : authUser.getParams()) {
                if (col.getController().equals(kkk.getSimpleName())
                        && col.getAction().equals(action) //create
                        ) {
                    //col.getKey().equals("narration")

                    Param.ValueType valueType = col.getValueType();
                    String ret = col.getValue();

                    try {
                        String coll = col.getKey();

                        if (valueType == Param.ValueType.NUMBER) {
                            Method method = kkk.getDeclaredMethod("set" + coll, Double.class);
                            method.invoke(abstDoc, new Double(ret));
                        } else if (valueType == Param.ValueType.DATE) {

                            if (ret.equalsIgnoreCase("SYSDATE")) {
                                Date now = new Date();
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                ret = sdf.format(now);

                                Method method = kkk.getDeclaredMethod("set" + coll, Date.class);
                                method.invoke(abstDoc, sdf.parse(ret));
                            } else {
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                Method method = kkk.getDeclaredMethod("set" + coll, Date.class);
                                method.invoke(abstDoc, sdf.parse(ret));
                            }

                        } else if (valueType == Param.ValueType.REF) {
                            //refs.put(coll, ret);

                            refs.addAttribute(coll, ret);
                            // Method method = kkk.getDeclaredMethod("set" + coll, AbstDoc.class);
                            // method.invoke(abstDoc, accountHeadFmService.findById(ret));
                        } else {
                            Method method = kkk.getDeclaredMethod("set" + coll, String.class);
                            method.invoke(abstDoc, ret);
                        }

                    } catch (Exception e) {
                        System.out.println(" set parma mac err: " + e);
                    }
                }
            }
        } catch (NotLoggedInException ex) {
            Logger.getLogger(_OithAuditController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
