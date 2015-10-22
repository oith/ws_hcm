package oith.ws.service;

import oith.ws.dom.hcm.pmis.Emp;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.EmpNotFoundException;
import java.util.List;

public interface EmpService {

    public Emp findByCode(String code);

    public Emp findById(String id);

    public Emp create(Emp emp);

    public Emp update(Emp emp) throws EmpNotFoundException;

    public Emp update(Emp emp, String cols) throws EmpNotFoundException;

    public Emp delete(String id) throws EmpNotFoundException;

    public List<Emp> search(_SearchDTO pageable);

    public List<Emp> findAll(_SearchDTO pageable);

    public Iterable<Emp> findAll();
}
