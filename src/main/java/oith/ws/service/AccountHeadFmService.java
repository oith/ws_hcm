package oith.ws.service;


import oith.ws.dto._SearchDTO;
import oith.ws.exception.AccountHeadFmNotFoundException;
import java.util.List;
import oith.ws.dom.hcm.fm.AccountHeadFm;

public interface AccountHeadFmService {

    public AccountHeadFm findById(String id);

    public AccountHeadFm create(AccountHeadFm org);

    public AccountHeadFm update(AccountHeadFm org) throws AccountHeadFmNotFoundException;

    public AccountHeadFm delete(String id) throws AccountHeadFmNotFoundException;

    public List<AccountHeadFm> search(_SearchDTO pageable);

    public List<AccountHeadFm> findAll(_SearchDTO pageable);

    public Iterable<AccountHeadFm> findAll();
}
