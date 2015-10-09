package oith.ws.service;

import oith.ws.dom.hcm.pmis.Dept;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.DeptNotFoundException;
import java.util.List;

public interface DeptService {

    public Dept findById(String id);

    public Dept create(Dept org);

    public Dept update(Dept org) throws DeptNotFoundException;

    public Dept delete(String id) throws DeptNotFoundException;

    public List<Dept> search(_SearchDTO pageable);

    public List<Dept> findAll(_SearchDTO pageable);

    public Iterable<Dept> findAll();
}
