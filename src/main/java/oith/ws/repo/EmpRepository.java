package oith.ws.repo;

import oith.ws.dom.core.hrm.om.Emp;
import org.springframework.data.repository.CrudRepository;

public interface EmpRepository extends CrudRepository<Emp, String> {

    public Emp findByCode(String code);
}
