package oith.ws.repo;

import oith.ws.dom.hcm.pmis.Org;
import org.springframework.data.repository.CrudRepository;

public interface OrgRepository extends CrudRepository<Org, String> {

    public Org findByCode(String code);
}
