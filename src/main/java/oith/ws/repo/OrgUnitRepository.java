package oith.ws.repo;

import oith.ws.dom.hcm.pmis.OrgStruct;
import org.springframework.data.repository.CrudRepository;

public interface OrgUnitRepository extends CrudRepository<OrgStruct, String> {

    public OrgStruct findByCode(String code);
}
