
package oith.ws.ctrl;

import org.springframework.stereotype.Controller;

@Controller
public class _OithCommon extends _OithController {

    /*@Autowired
    private ProfileService profileService;

    @RequestMapping(value = "/comdtl/del", method = RequestMethod.POST)
    public String submitDelDtl(@ModelAttribute("dets") String dets, BindingResult bindingResult, ModelMap model, RedirectAttributes attributes, MultipartHttpServletRequest request) {

        String profileId = "";
        Integer id = 2;
        Profile profile = profileService.findById(profileId);

        UserDetailsMac authUser = (UserDetailsMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String profileIdCurr = authUser.getProfileId();

        try {

            for (ProfileEduDtl col : profile.getProfileEduDtls()) {
                if (col.getId().equals(id)) {
                    profile.getProfileEduDtls().remove(col);
                    break;
                }
            }

            profileService.update(profile);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_EDITED, profileId);
        } catch (ProfileNotFoundException e) {
            System.out.println("No profile was found err: " + e);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND);
        }

        if (profileIdCurr.equals(profileId)) {
            return "redirect:/profile/show";
        } else {
            return "redirect:/admin/profile/admin_show/" + profileId;
        }
    }*/
}
