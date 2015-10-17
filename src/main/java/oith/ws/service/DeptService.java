package oith.ws.service;

import oith.ws.dom.hcm.pmis.Org;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.DeptNotFoundException;
import java.util.List;

public interface DeptService {

    public Org findById(String id);

    public Org create(Org org);

    public Org update(Org org) throws DeptNotFoundException;

    public Org delete(String id) throws DeptNotFoundException;

    public List<Org> search(_SearchDTO pageable);

    public List<Org> findAll(_SearchDTO pageable);

    public Iterable<Org> findAll();
}
