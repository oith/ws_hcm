package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.OrgUnitNotFoundException;
import java.util.List;
import oith.ws.dom.hcm.pmis.OrgStruct;

public interface OrgUnitService {

    public OrgStruct findById(String id);

    public OrgStruct create(OrgStruct orgUnit);

    public OrgStruct update(OrgStruct orgUnit) throws OrgUnitNotFoundException;

    public OrgStruct delete(String id) throws OrgUnitNotFoundException;

    public List<OrgStruct> search(_SearchDTO pageable);

    public List<OrgStruct> findAll(_SearchDTO pageable);

    public Iterable<OrgStruct> findAll();
}
