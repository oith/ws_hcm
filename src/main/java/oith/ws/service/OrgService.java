package oith.ws.service;

import oith.ws.dom.hcm.pmis.OrgUnit;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.OrgNotFoundException;
import java.util.List;

public interface OrgService {

    public OrgUnit findById(String id);

    public OrgUnit create(OrgUnit org);

    public OrgUnit update(OrgUnit org) throws OrgNotFoundException;

    public OrgUnit delete(String id) throws OrgNotFoundException;

    public List<OrgUnit> search(_SearchDTO pageable);

    public List<OrgUnit> findAll(_SearchDTO pageable);

    public Iterable<OrgUnit> findAll();
}
