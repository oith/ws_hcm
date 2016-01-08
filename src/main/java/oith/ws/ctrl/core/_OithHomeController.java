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

        System.out.println("finding getCodableDTO: code: " + code);

        try {
//            GridFSDBFile gridFsFile = gridFsTemplate.findOne(new Query().addCriteria(Criteria.where("_id").is(code)));
//
//            //GridFSDBFile gridFsFile = gridFsTemplate.findOne(new Query().addCriteria(Criteria.where("metadata.size").is("small").and("metadata.parent").is(code)));
//            final HttpHeaders headers = new HttpHeaders();
//            headers.setContentType(MediaType.IMAGE_JPEG);

            Menu menu = menuService.findByCode(code);
//            if (code.equals("0000")) {
//                return "/oith_ws_hcm/client";
//            } else if (code.equals("0001")) {
//                return "/oith_ws_hcm/post";
//            }

            return menu.getAddress();

        } catch (Exception e) {
            System.out.println("eeeeeeeey get photo " + e);
            return null;
        }

    }

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

                    //list.add(urlPattern);
                }

                if (!(urlPattern.endsWith("/"))) {
//                if (!(urlPattern.contains("{") || urlPattern.endsWith("/"))) {
                    list.add(urlPattern);
                }
                //Collections.sort(list);
            }
        }
    }
}
