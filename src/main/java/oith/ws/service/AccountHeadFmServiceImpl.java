package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.AccountHeadFmNotFoundException;
import oith.ws.repo.AccountHeadFmRepository;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import org.apache.commons.beanutils.PropertyUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("accountHeadFmService")
@Transactional(readOnly = true)
public class AccountHeadFmServiceImpl implements AccountHeadFmService {

    @Autowired
    private AccountHeadFmRepository accountHeadFmRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Transactional
    @Override
    public AccountHeadFm create(AccountHeadFm accountHeadFm) {
        //ObjectId objectId = new ObjectId();
         //accountHeadFm.setId(objectId.toString());
        AccountHeadFm userSaved = accountHeadFmRepository.save(accountHeadFm);
        return userSaved;
    }

    @Override
    @Transactional
    public AccountHeadFm findById(String id) {
        AccountHeadFm user = (AccountHeadFm) accountHeadFmRepository.findOne(id);

        return user;
    }

    @Override
    @Transactional(rollbackFor = AccountHeadFmNotFoundException.class)
    public AccountHeadFm delete(String userId) throws AccountHeadFmNotFoundException {

        AccountHeadFm user = (AccountHeadFm) accountHeadFmRepository.findOne(userId);

        if (user == null) {
            throw new AccountHeadFmNotFoundException();
        }

        accountHeadFmRepository.delete(user);
        return user;
    }

    @Override
    @Transactional
    public Iterable<AccountHeadFm> findAll() {
        Iterable<AccountHeadFm> users = accountHeadFmRepository.findAll();
        return users;
    }

    @Transactional(rollbackFor = AccountHeadFmNotFoundException.class)
    @Override
    public AccountHeadFm update(AccountHeadFm updated) throws AccountHeadFmNotFoundException {

        AccountHeadFm accountHeadFm = (AccountHeadFm) accountHeadFmRepository.findOne(updated.getId());

        if (accountHeadFm == null) {
            throw new AccountHeadFmNotFoundException();
        }

        try {
            PropertyUtils.copyProperties(accountHeadFm, updated);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
        }

        accountHeadFmRepository.save(accountHeadFm);
        return updated;
    }

    @Transactional(rollbackFor = AccountHeadFmNotFoundException.class)
    @Override
    public AccountHeadFm update(AccountHeadFm updated, String cols) throws AccountHeadFmNotFoundException {

        AccountHeadFm accountHeadFm = (AccountHeadFm) accountHeadFmRepository.findOne(updated.getId());

        if (accountHeadFm == null) {
            throw new AccountHeadFmNotFoundException();
        }
        try {
            MacUtils.copyProperties(accountHeadFm, updated, cols);
        } catch (Exception e) {
        }

        accountHeadFm = accountHeadFmRepository.save(accountHeadFm);
        return accountHeadFm;
    }

    @Transactional
    @Override
    public List<AccountHeadFm> findAll(_SearchDTO pageable) {

        Query query = new Query();

        PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "title"));

        query.with(request);

        List<AccountHeadFm> users = mongoTemplate.find(query, AccountHeadFm.class);

        long asd = mongoTemplate.count(query, AccountHeadFm.class);

        //  System.out.println("data on srach: " + asd + " data: " + users);
        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));
        pageable.setTotalRecs(asd);
        return users;
    }

    @Transactional
    @Override
    public List<AccountHeadFm> search(_SearchDTO pageable) {
     
        String yy = "{"
                + "$or: ["
                + " {\"code\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + ","
                + " {\"title\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + "]"
                + "}";
        //'$regex':'^win$'
        Query query = new BasicQuery(yy);

         PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "title"));

        query.with(request);

        List<AccountHeadFm> users = mongoTemplate.find(query, AccountHeadFm.class);

        long asd = mongoTemplate.count(query, AccountHeadFm.class);
       
        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));

        pageable.setTotalRecs(asd);

        return users;
    }
}
