package oith.ws.ctrl.core;

import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeSet;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import oith.ws.dom.core.Menu;
import oith.ws.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@Controller
public class _OithHomeController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private RequestMappingHandlerMapping requestMappingHandlerMapping;

    private final SortedSet<String> list = new TreeSet<>();

    @RequestMapping(value = "/menu/{code}", method = RequestMethod.GET)
    public @ResponseBody
    String getCodableDTOSmall(@PathVariable("code") String code) {

        System.out.println("finding getCodableDTOSmall: code: " + code);

        try {
            Menu menu = menuService.findByCode(code);
            return menu.getAddress();
        } catch (Exception e) {
            System.out.println("eeeeeeeey get photo " + e);
            return null;
        }
    }

    @RequestMapping(value = "/menuTest", method = RequestMethod.GET)
    public String menuTest(ModelMap model, HttpServletRequest request) {
        return "menu";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(ModelMap model) {
        return "index";
    }

    @RequestMapping(value = "/accessdenied")
    public String loginerror(ModelMap model) {
        model.addAttribute("error", "true");
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request) {
        //model.addAttribute("loginUrl", "");
        model.addAttribute("lists", list);
        return "index";
    }

//    @RequestMapping(value = {"/", ""}, method = RequestMethod.POST)
//    public String indexPost(ModelMap model, HttpServletRequest request) {
//        model.addAttribute("loginUrl", "index");
//        model.addAttribute("lists", list);
//        return "index";
//    }
    @PostConstruct
    public void init() {

        Map<RequestMappingInfo, HandlerMethod> handlerMethods
                = this.requestMappingHandlerMapping.getHandlerMethods();

        for (Entry<RequestMappingInfo, HandlerMethod> item : handlerMethods.entrySet()) {
            RequestMappingInfo mapping = item.getKey();
            HandlerMethod method = item.getValue();

            for (String urlPattern : mapping.getPatternsCondition().getPatterns()) {
                //System.out.println(method.getBeanType().getName() + "#" + method.getMethod().getName()+ " <-- " + urlPattern);

                if (urlPattern.contains("index") //|| urlPattern.endsWith("queryRunner")
                        ) {
                    System.out.println(method.getBeanType().getName() + "#" + method.getMethod().getName() + " <-- " + urlPattern);

                    //list.add(urlPattern);
                }

                if (urlPattern.contains("index")) {
//                if (!(urlPattern.endsWith("/"))) {
                    list.add(urlPattern);
                }
            }
        }
    }
}
