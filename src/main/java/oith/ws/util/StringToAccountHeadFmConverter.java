
package oith.ws.util;

import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.service.AccountHeadFmService;
import org.apache.commons.lang.StringUtils;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

/**
 *
 * @author mbadiuzzaman
 */
public class StringToAccountHeadFmConverter implements Converter<String, AccountHeadFm> {

    private final AccountHeadFmService accountHeadFmService;

    public StringToAccountHeadFmConverter(AccountHeadFmService accountHeadFmService) {
        this.accountHeadFmService = accountHeadFmService;
    }

    @Override
    public AccountHeadFm convert(String id) {
        if (id == null || StringUtils.isBlank(id)) {
            return null;
        }
        return accountHeadFmService.findById(id);
    }
}
