package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.TrnscFmNotFoundException;
import java.util.List;
import oith.ws.dom.hcm.fm.TrnscFm;

public interface TrnscFmService {

    public TrnscFm findById(String id);

    public TrnscFm create(TrnscFm org);

    public TrnscFm update(TrnscFm org, String cols) throws TrnscFmNotFoundException;

    public TrnscFm update(TrnscFm org) throws TrnscFmNotFoundException;

    public TrnscFm delete(String id) throws TrnscFmNotFoundException;

    public List<TrnscFm> search(_SearchDTO pageable);

    public List<TrnscFm> findAll(_SearchDTO pageable);

    public Iterable<TrnscFm> findAll();
}
