package oith.ws.repo;

import oith.ws.dom.hcm.fm.TrnscFm;
import org.springframework.data.repository.CrudRepository;

public interface TrnscFmRepository extends CrudRepository<TrnscFm, String> {

    public TrnscFm findByCode(String code);
}
