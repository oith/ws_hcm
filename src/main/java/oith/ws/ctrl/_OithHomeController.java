package oith.ws.ctrl;

import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeSet;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@Controller
public class _OithHomeController {

    @Autowired
    private RequestMappingHandlerMapping requestMappingHandlerMapping;

    private final SortedSet<String> list = new TreeSet<>();

    @RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public String index(ModelMap model, HttpServletRequest request) {
        model.addAttribute("lists", list);
        return "index";
    }

    @RequestMapping(value = {"/indexSecure"}, method = RequestMethod.GET)
    public String indexSecure(ModelMap model, HttpServletRequest request) {
        model.addAttribute("lists", list);
        return "indexSecure";
    }

    @PostConstruct
    public void init() {

        Map<RequestMappingInfo, HandlerMethod> handlerMethods
                = this.requestMappingHandlerMapping.getHandlerMethods();

        for (Entry<RequestMappingInfo, HandlerMethod> item : handlerMethods.entrySet()) {
            RequestMappingInfo mapping = item.getKey();
            HandlerMethod method = item.getValue();

            for (String urlPattern : mapping.getPatternsCondition().getPatterns()) {
                //System.out.println(method.getBeanType().getName() + "#" + method.getMethod().getName()+ " <-- " + urlPattern);

                if (urlPattern.endsWith("index") || urlPattern.endsWith("indexSecure") //                        || urlPattern.endsWith("reportRunner")
                        //                        || urlPattern.endsWith("procRunner")
                        //                        || urlPattern.endsWith("queryRunner")
                        ) {
                    System.out.println(method.getBeanType().getName() + "#" + method.getMethod().getName() + " <-- " + urlPattern);

                    list.add(urlPattern);
                }
            }
        }
    }
}
