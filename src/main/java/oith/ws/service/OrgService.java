package oith.ws.service;

import oith.ws.dom.hcm.pmis.Org;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.OrgNotFoundException;
import java.util.List;

public interface OrgService {

    public Org findById(String id);

    public Org create(Org org);

    public Org update(Org org) throws OrgNotFoundException;

    public Org delete(String id) throws OrgNotFoundException;

    public List<Org> search(_SearchDTO pageable);

    public List<Org> findAll(_SearchDTO pageable);

    public Iterable<Org> findAll();
}
