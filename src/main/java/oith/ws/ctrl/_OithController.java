package oith.ws.ctrl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

public abstract class _OithController {

    protected static final String ERROR_MESSAGE_KEY_DELETED_WAS_NOT_FOUND = "error.message.deleted.not.found";
    protected static final String ERROR_MESSAGE_KEY_EDITED_WAS_NOT_FOUND = "error.message.edited.not.found";

    protected static final String FEEDBACK_MESSAGE_KEY_CREATED = "feedback.message.created";
    protected static final String FEEDBACK_MESSAGE_KEY_DELETED = "feedback.message.deleted";
    protected static final String FEEDBACK_MESSAGE_KEY_EDITED = "feedback.message.edited";

    protected static final String REQUEST_MAPPING_LIST = "index";
    protected static final String MODEL_ATTRIBUTE_SEARCH_CRITERIA = "searchCriteria";

    private static final String FLASH_ERROR_MESSAGE = "errorMessage";
    private static final String FLASH_FEEDBACK_MESSAGE = "feedbackMessage";
    private static final String VIEW_REDIRECT_PREFIX = "redirect:";

    @Resource
    private MessageSource messageSource;

    @InitBinder
    public void initBinder(WebDataBinder webDataBinder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        dateFormat.setLenient(false);
        webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * Adds a new error message
     *
     * @param model A model which stores the the error message.
     * @param code A message code which is used to fetch the correct message
     * from the message source.
     * @param params The parameters attached to the actual error message.
     */
    protected void addErrorMessage(RedirectAttributes model, String code, Object... params) {
        Locale current = LocaleContextHolder.getLocale();
        String localizedErrorMessage = messageSource.getMessage(code, params, current);
        model.addFlashAttribute(FLASH_ERROR_MESSAGE, localizedErrorMessage);
    }

    /**
     * Adds a new feedback message.
     *
     * @param model A model which stores the feedback message.
     * @param code A message code which is used to fetch the actual message from
     * the message source.
     * @param params The parameters which are attached to the actual feedback
     * message.
     */
    protected void addFeedbackMessage(RedirectAttributes model, String code, Object... params) {
        Locale current = LocaleContextHolder.getLocale();
        String localizedFeedbackMessage = messageSource.getMessage(code, params, current);
        model.addFlashAttribute(FLASH_FEEDBACK_MESSAGE, localizedFeedbackMessage);
    }

    protected String multipartFileHandlerx(MultipartHttpServletRequest request, String col) {
        return "";
    }

    protected String multipartImageFileHandlerx(MultipartHttpServletRequest request, String col) {
        return "";
    }

    /**
     * Creates a redirect view path for a specific controller action
     *
     * @param path The path processed by the controller method.
     * @return A redirect view path to the given controller method.
     */
    protected String createRedirectViewPath(String path) {
        StringBuilder builder = new StringBuilder();
        builder.append(VIEW_REDIRECT_PREFIX);
        builder.append(path);
        return builder.toString();
    }

}
