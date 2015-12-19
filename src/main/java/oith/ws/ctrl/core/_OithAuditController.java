package oith.ws.ctrl.core;

import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import oith.ws.dom.core.AbstDoc;
import oith.ws.dom.core.Auditor;
import oith.ws.dom.core.Client;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import oith.ws.dom.core.IAuditable;
import oith.ws.dom.core.Lookup;
import oith.ws.dom.core.Param;
import oith.ws.dom.core.User;
import oith.ws.exception.NotLoggedInException;
import oith.ws.service.MacUserDetail;
import oith.ws.service.UserService;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithAuditController extends _OithController {

    private SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

    @Autowired
    private UserService userService;

    @Autowired
    private MongoOperations mongoTemplate;

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

    protected void setUserParam(AbstDoc abstDoc, String action) {

        
 
        try {
            Class kkk = abstDoc.getClass();
            MacUserDetail authUser = getLoggedPrincipal();

            for (Param col : authUser.getParams()) {
                if (col.getController().equals(kkk.getSimpleName())
                        && col.getAction().equals(action) //create
                        ) {
                    try {
                        Param.ValueType paramValueType = col.getValueType();
                        String paramValue = col.getValue();
                        String paramProperty = col.getProperty();

                        Object val = null;
                        Method method;

                        if (paramValueType == Param.ValueType.NUMBER) {
                            method = kkk.getDeclaredMethod("set" + paramProperty, Double.class);
                            val = new Double(paramValue);
                        } else if (paramValueType == Param.ValueType.DATE) {

                            if (paramValue.equalsIgnoreCase("SYSDATE")) {
                                Date now = new Date();
                                paramValue = sdf.format(now);
                            }

                            method = kkk.getDeclaredMethod("set" + paramProperty, Date.class);
                            val = sdf.parse(paramValue);
                        } else if (paramValueType == Param.ValueType.REF) {

                            //Class iiii = Class.forName("oith.ws.dom.hcm.fm.AccountHeadFm");
                            Class iiii = Class.forName(col.getClassName());
                            method = kkk.getDeclaredMethod("set" + paramProperty, iiii);
                            val = mongoTemplate.findById(paramValue, iiii);

                        } else if (paramValueType == Param.ValueType.ENUM) {

                            //Class iiii = Class.forName("oith.ws.dom.hcm.fm.TrnscFm$Sign");
                            Class iiii = Class.forName(col.getClassName());

                            for (Object col1 : iiii.getEnumConstants()) {
                                if (col1.toString().equals(paramValue)) {
                                    val = col1;
                                    break;
                                }
                            }

                            method = kkk.getDeclaredMethod("set" + paramProperty, iiii);

                        } else {
                            method = kkk.getDeclaredMethod("set" + paramProperty, String.class);
                            val = paramValue;
                        }

                        method.invoke(abstDoc, val);
                    } catch (Exception e) {
                        System.out.println("set param loop mac err: " + e);
                    }
                }
            }
        } catch (Exception ex) {
            System.out.println("set param mac err: " + ex);
        }
    }
}
