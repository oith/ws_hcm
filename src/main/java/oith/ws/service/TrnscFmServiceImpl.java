package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.TrnscFmNotFoundException;
import oith.ws.repo.TrnscFmRepository;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import oith.ws.dom.hcm.fm.TrnscFm;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("trnscFmService")
@Transactional(readOnly = true)
public class TrnscFmServiceImpl implements TrnscFmService {

    @Autowired
    private TrnscFmRepository trnscFmRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    public void setTrnscFmRepository(TrnscFmRepository trnscFmRepository) {
        this.trnscFmRepository = trnscFmRepository;
    }

    public MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }

    @Transactional
    @Override
    public TrnscFm create(TrnscFm trnscFm) {
        TrnscFm userSaved = trnscFmRepository.save(trnscFm);
        return userSaved;
    }

    @Override
    @Transactional
    public TrnscFm findById(String id) {
        TrnscFm user = (TrnscFm) trnscFmRepository.findOne(id);
        return user;
    }

    @Override
    @Transactional(rollbackFor = TrnscFmNotFoundException.class)
    public TrnscFm delete(String userId) throws TrnscFmNotFoundException {

        TrnscFm user = (TrnscFm) trnscFmRepository.findOne(userId);

        if (user == null) {
            throw new TrnscFmNotFoundException();
        }

        trnscFmRepository.delete(user);
        return user;
    }

    @Override
    @Transactional
    public Iterable<TrnscFm> findAll() {
        Iterable<TrnscFm> users = trnscFmRepository.findAll();//createQuery("FROM " + Person.class.getName()).list();
        return users;
    }

    @Transactional(rollbackFor = TrnscFmNotFoundException.class)
    @Override
    public TrnscFm update(TrnscFm updated) throws TrnscFmNotFoundException {

        TrnscFm user = (TrnscFm) trnscFmRepository.findOne(updated.getId());

        if (user == null) {
            throw new TrnscFmNotFoundException();
        }

        try {
            PropertyUtils.copyProperties(user, updated);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {

        }

        trnscFmRepository.save(user);
        return updated;
    }

    @Transactional(rollbackFor = TrnscFmNotFoundException.class)
    @Override
    public TrnscFm update(TrnscFm updated, String cols) throws TrnscFmNotFoundException {

        TrnscFm trnscFm = (TrnscFm) trnscFmRepository.findOne(updated.getId());

        if (trnscFm == null) {
            throw new TrnscFmNotFoundException();
        }
        try {
            MacUtils.copyProperties(trnscFm, updated, cols);
        } catch (Exception e) {
        }

        trnscFm = trnscFmRepository.save(trnscFm);
        return trnscFm;
    }

    @Transactional
    @Override
    public List<TrnscFm> findAll(_SearchDTO pageable) {

        Query query = new Query();
        //query.addCriteria(Criteria.where("loginId").regex(pageable.getSearchTerm(),"i"));
        //query.with(new Sort(Sort.Direction.DESC, "fullName"));

        PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "name"));

        query.with(request);

        List<TrnscFm> users = mongoTemplate.find(query, TrnscFm.class);

        long asd = mongoTemplate.count(query, TrnscFm.class);

        //  System.out.println("data on srach: " + asd + " data: " + users);
        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));
        pageable.setTotalRecs(asd);
        return users;
    }

    @Transactional
    @Override
    public List<TrnscFm> search(_SearchDTO pageable) {

        String yy = "{"
                + "$or: ["
                + " {\"code\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + ","
                + " {\"name\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + "]"
                + "}";
        //'$regex':'^win$'
        Query query = new BasicQuery(yy);

        // query.addCriteria(Criteria.where("loginId").regex(pageable.getSearchTerm(), "i").orOperator(Criteria.where("fullName").regex(pageable.getSearchTerm(), "i"))
        //  );
        //query.with(new Sort(Sort.Direction.DESC, "fullName"));
        PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "name"));

        query.with(request);

        List<TrnscFm> users = mongoTemplate.find(query, TrnscFm.class);

        long asd = mongoTemplate.count(query, TrnscFm.class);

        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));

        pageable.setTotalRecs(asd);

        return users;
    }
}
