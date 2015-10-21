package oith.ws.repo;

import oith.ws.dom.hcm.pmis.OrgUnit;
import org.springframework.data.repository.CrudRepository;

public interface OrgRepository extends CrudRepository<OrgUnit, String> {

    public OrgUnit findByCode(String code);
}
