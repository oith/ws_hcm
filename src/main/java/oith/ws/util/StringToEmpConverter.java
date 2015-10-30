/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package oith.ws.util;

import oith.ws.dom.core.hrm.om.Emp;
import oith.ws.service.EmpService;
import org.apache.commons.lang.StringUtils;
import org.springframework.core.convert.converter.Converter;

/**
 *
 * @author mbadiuzzaman
 */

public class StringToEmpConverter implements Converter<String, Emp> {
    
    private final EmpService empService;

    public StringToEmpConverter(EmpService empService) {
        this.empService = empService;
    }

    @Override
    public Emp convert(String id) {
        if (id == null || StringUtils.isBlank(id)) {
            return null;
        }
        return empService.findByCode(id);
    }
}
