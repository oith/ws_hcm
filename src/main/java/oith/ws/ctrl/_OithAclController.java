package oith.ws.ctrl;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import javax.servlet.http.HttpServletRequest;

@Controller
public class _OithAclController {

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(ModelMap model, HttpServletRequest request) {
        return "login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(ModelMap model) {
        return "logout";
    }

    @RequestMapping(value = "/accessdenied")
    public String loginerror(ModelMap model) {
        model.addAttribute("error", "true");
        return "denied";
    }

    @RequestMapping(value = "/menu", method = RequestMethod.GET)
    public String menu(ModelMap map) {

        return "menu";
    }
}
