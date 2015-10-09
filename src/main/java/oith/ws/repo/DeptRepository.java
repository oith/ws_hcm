package oith.ws.repo;

import oith.ws.dom.hcm.pmis.Dept;
import org.springframework.data.repository.CrudRepository;

public interface DeptRepository extends CrudRepository<Dept, String> {

    public Dept findByCode(String code);
}
