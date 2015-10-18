package oith.ws.repo;

import oith.ws.dom.hcm.pmis.OrgUnit;
import org.springframework.data.repository.CrudRepository;

public interface OrgUnitRepository extends CrudRepository<OrgUnit, String> {

    public OrgUnit findByCode(String code);
}
