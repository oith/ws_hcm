package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.OrgUnitNotFoundException;
import java.util.List;
import oith.ws.dom.hcm.pmis.OrgUnit;

public interface OrgUnitService {

    public OrgUnit findById(String id);

    public OrgUnit create(OrgUnit orgUnit);

    public OrgUnit update(OrgUnit orgUnit) throws OrgUnitNotFoundException;

    public OrgUnit delete(String id) throws OrgUnitNotFoundException;

    public List<OrgUnit> search(_SearchDTO pageable);

    public List<OrgUnit> findAll(_SearchDTO pageable);

    public Iterable<OrgUnit> findAll();
}
