package oith.ws.service;

import oith.ws.dom.hcm.pmis.Emp;
import oith.ws.dto._SearchDTO;
import oith.ws.exception.EmpNotFoundException;
import oith.ws.repo.EmpRepository;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
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

@Service("empService")
@Transactional(readOnly = true)
public class EmpServiceImpl implements EmpService {

    private static final Logger LOGGER = LoggerFactory.getLogger(EmpServiceImpl.class);

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

    @Transactional
    @Override
    public Emp create(Emp emp) {
        //ObjectId objectId = new ObjectId();
        LOGGER.debug("Creating a new user with information: " + emp);
        //emp.setId(objectId.toString());
        Emp userSaved = empRepository.save(emp);
        return userSaved;
    }



    @Override
    @Transactional
    public Emp findById(String id) {
        Emp user = (Emp) empRepository.findOne(id);

        //Hibernate.initialize(emp.getLookupAnyTypeId());
        //Hibernate.initialize(emp.getPersonEduDtlList());
        //Hibernate.initialize(emp.getHrTlShftDtlId());
        //Hibernate.initialize(emp.getPersonEduDtlList());
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

//        List<Person> jj = new ArrayList<>();
//        for (Person user : users) {
//            jj.add(user);
//            Query query2 = new Query();
//            query2.addCriteria(Criteria.where("name").is("dog").and("age").is(40));
//
//            Person userTest2 = mongoOperation.findOne(query2, Person.class);
//            System.out.println("query2 - " + query2.toString());
//            System.out.println("userTest2 - " + userTest2);
        //Hibernate.initialize(emp.getLookupAnyTypeId());
        //Hibernate.initialize(emp.getPersonEduDtlList());
        //Hibernate.initialize(emp.getHrTlShftDtlId());
        //Hibernate.initialize(emp.getPersonEduDtlList());
        // }
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
            LOGGER.info("No user found with err: " + e);
        }

        empRepository.save(user);
        return updated;
    }

    @Transactional
    @Override
    public List<Emp> findAll(_SearchDTO pageable) {

//        Session session = userRepository;
//
//        Query query = session.createQuery("FROM Person m");
//        query.setFirstResult((pageable.getPage() - 1) * pageable.getPageSize());
//        query.setMaxResults(pageable.getPageSize());
//
//        List<Person> users = (List<Person>) query.list();
//        String serTxt=pageable.getSearchTerm();
//        Query query2 = new Query();
//        query2.addCriteria(Criteria.where("loginId").regex(serTxt));
//        query2.with(new Sort(Sort.Direction.DESC, "fullName"));
//
//        Iterable<Person> users = mongoTemplate.find(query2, Person.class);
        // pageable.setPage(1);
        //  pageable.setPageSize(5);
        //  PageRequest request = new PageRequest(pageable.getPage(),
        //          pageable.getPageSize(),
        //          new Sort(Sort.Direction.ASC, "fullName"));
        //   Page<Person> userPages = userRepository.findAll(request);
        //    Iterable<Person> users = userRepository.findAll();
//        List<Person> jj = new ArrayList<>();
//        for (Person user : users) {
//            jj.add(user);
//            //Hibernate.initialize(emp.getLookupAnyTypeId());
//            //Hibernate.initialize(emp.getPersonEduDtlList());
//
//            //Hibernate.initialize(emp.getHrTlShftDtlId());
//            //Hibernate.initialize(emp.getPersonEduDtlList());
//        }
        // ((MongoOperations) mongoTemplate).
        //  int totRecs = users.getTotalPages();//  userRepository.count();
//        Long totRecs = (Long) session.createQuery("SELECT count(m) FROM Person m").uniqueResult();
//
        //   pageable.setTotalPages(userPages.getTotalPages());
        //   pageable.setTotalRecs(userPages.getTotalElements());
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
        LOGGER.debug("Searching accBnks with search criteria: " + pageable);

//        String searchTerm = pageable.getSearchTerm().toUpperCase();
//        Session session = userRepository;
//
//        //String qu = "FROM Person m WHERE 1=1 AND UPPER(m.title) LIKE UPPER(CONCAT('%',:search,'%'))";
//        String qu = "FROM Person m WHERE 1=1  AND UPPER(CONCAT(m.remarks, m.title, m.code)) LIKE CONCAT('%',:search,'%')";
//
//        Query queryCount = session.createQuery("SELECT count(m) " + qu);
//        queryCount.setParameter("search", searchTerm);
//        Long totRecs = (Long) queryCount.uniqueResult();
//
//        Query query = session.createQuery(qu);
//        query.setParameter("search", searchTerm);
//
//        query.setFirstResult((pageable.getPage() - 1) * pageable.getPageSize());
//        query.setMaxResults(pageable.getPageSize());
        //  Query query = new Query();
        String yy = "{"
                + "$or: ["
                + " {\"code\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + ","
                + " {\"name\": {$regex : '" + pageable.getSearchTerm() + "' , $options: 'i'} }"
                + "]"
                + "}";
        //'$regex':'^win$'
        Query query= new BasicQuery(yy);

        // query.addCriteria(Criteria.where("loginId").regex(pageable.getSearchTerm(), "i").orOperator(Criteria.where("fullName").regex(pageable.getSearchTerm(), "i"))
        //  );
        //query.with(new Sort(Sort.Direction.DESC, "fullName"));
        PageRequest request = new PageRequest(pageable.getPage(),
                pageable.getPageSize(),
                new Sort(Sort.Direction.ASC, "name"));

        query.with(request);

        List<Emp> users = mongoTemplate.find(query, Emp.class);

        long asd = mongoTemplate.count(query, Emp.class);

        System.out.println("data on srach: " + asd + " data: " + users);

        pageable.setTotalPages((int) Math.ceil(1d * asd / pageable.getPageSize()));

        System.out.println("yyyyyyyyy: rr:" + (int) Math.ceil(1d * 15 / 10));
        pageable.setTotalRecs(asd);
    //    users.

        //  Page<Person> userPages = userRepository.findAll(request);
//
//        pageable.setTotalPages(userPages.getTotalPages());
//        pageable.setTotalRecs(userPages.getTotalElements());
        return users;
    }
}
