package oith.ws.service;

import oith.ws.dto._SearchDTO;
import oith.ws.exception.EmpNotFoundException;
import oith.ws.repo.EmpRepository;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import oith.ws.dom.core.hrm.om.Emp;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("empService")
@Transactional(readOnly = true)
public class EmpServiceImpl implements EmpService {

    @Autowired
    private EmpRepository empRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    public void setEmpRepository(EmpRepository empRepository) {
        this.empRepository = empRepository;
    }

    public MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }

    @Override
    @Transactional
    public Emp findByCode(String code) {
        Emp emp = empRepository.findByCode(code);
        return emp;
    }

    @Transactional
    @Override
    public Emp create(Emp emp) {
        Emp userSaved = empRepository.save(emp);
        return userSaved;
    }

    @Override
    @Transactional
    public Emp findById(String id) {
        Emp user = (Emp) empRepository.findOne(id);
        return user;
    }

    @Override
    @Transactional(rollbackFor = EmpNotFoundException.class)
    public Emp delete(String userId) throws EmpNotFoundException {

        Emp user = (Emp) empRepository.findOne(userId);

        if (user == null) {
            throw new EmpNotFoundException();
        }

        empRepository.delete(user);
        return user;
    }

    @Override
    @Transactional
    public Iterable<Emp> findAll() {
        Iterable<Emp> users = empRepository.findAll();//createQuery("FROM " + Person.class.getName()).list();
        return users;
    }

    @Transactional(rollbackFor = EmpNotFoundException.class)
    @Override
    public Emp update(Emp updated) throws EmpNotFoundException {

        Emp user = (Emp) empRepository.findOne(updated.getId());

        if (user == null) {
            throw new EmpNotFoundException();
        }

        try {
            PropertyUtils.copyProperties(user, updated);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {

        }

        empRepository.save(user);
        return updated;
    }

    @Transactional(rollbackFor = EmpNotFoundException.class)
    @Override
    public Emp update(Emp updated, String cols) throws EmpNotFoundException {

        Emp emp = (Emp) empRepository.findOne(updated.getId());

        if (emp == null) {
            throw new EmpNotFoundException();
        }
        //updated.setUser(userRepository.findByUsername("mac"));
        try {
            MacUtils.copyProperties(emp, updated, cols);
        } catch (Exception e) {
        }

        emp = empRepository.save(emp);
        return emp;
    }

    @Transactional
    @Override
    public List<Emp> findAll(_SearchDTO pageable) {

        Query query = new Query();
        //query.addCriteria(Criteria.where("loginId").regex(pageable.getSearchTerm(),"i"));
        //query.with(new Sort(Sort.Direction.DESC, "fullName"));

        PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "name"));

        query.with(request);

        List<Emp> users = mongoTemplate.find(query, Emp.class);

        long asd = mongoTemplate.count(query, Emp.class);

        //  System.out.println("data on srach: " + asd + " data: " + users);
        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));
        pageable.setTotalRecs(asd);
        return users;
    }

    @Transactional
    @Override
    public List<Emp> search(_SearchDTO pageable) {

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

        List<Emp> users = mongoTemplate.find(query, Emp.class);

        long asd = mongoTemplate.count(query, Emp.class);

        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));

        pageable.setTotalRecs(asd);

        return users;
    }

}
