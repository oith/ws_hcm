package oith.ws.repo;

import oith.ws.dom.hcm.fm.AccountHeadFm;
import org.springframework.data.repository.CrudRepository;

public interface AccountHeadFmRepository extends CrudRepository<AccountHeadFm, String> {

    public AccountHeadFm findByCode(String code);
}
