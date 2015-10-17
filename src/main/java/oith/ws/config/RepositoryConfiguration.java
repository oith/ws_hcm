package oith.ws.config;

import oith.ws.repo.RepositoryPackage;
import com.mongodb.MongoClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;
import org.springframework.data.mongodb.gridfs.GridFsTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@Configuration
@EnableMongoRepositories(basePackageClasses = RepositoryPackage.class)
public class RepositoryConfiguration {

    private final String dbName = "demodb";
    private final String HOST = "127.0.0.1";
    private final int PORT = 27017;

    @Bean
    public SimpleMongoDbFactory simpleMongoDbFactory() throws Exception {
        MongoClient m = new MongoClient(HOST, PORT);
        return new SimpleMongoDbFactory(m, dbName);
    }

    @Bean
    public GridFsTemplate gridFsTemplate() throws Exception {
        MongoOperations operations = new MongoTemplate(simpleMongoDbFactory());
        return new GridFsTemplate(simpleMongoDbFactory(), operations.getConverter());
    }

    @Bean
    public MongoOperations mongoTemplate() throws Exception {

        MongoOperations operations = new MongoTemplate(simpleMongoDbFactory());

//        if (!operations.collectionExists("User")) {
//            operations.createCollection("User");
//        }
//        if (!operations.collectionExists("Profile")) {
//            operations.createCollection("Profile");
//        }
        return operations;
    }

    /*
     @Bean
     public MongoDbFactory mongoDbFactory() throws Exception {
     String openshiftMongoDbHost = System.getenv("OPENSHIFT_MONGODB_DB_HOST");
     int openshiftMongoDbPort = Integer.parseInt(System
     .getenv("OPENSHIFT_MONGODB_DB_PORT"));
     String username = System.getenv("OPENSHIFT_MONGODB_DB_USERNAME");
     String password = System.getenv("OPENSHIFT_MONGODB_DB_PASSWORD");
     Mongo mongo = new Mongo(openshiftMongoDbHost, openshiftMongoDbPort);
     UserCredentials userCredentials = new UserCredentials(username,
     password);
     String databaseName = System.getenv("OPENSHIFT_APP_NAME");
     MongoDbFactory mongoDbFactory = new SimpleMongoDbFactory(mongo,
     databaseName, userCredentials);
     return mongoDbFactory;
     }

     @Bean
     public GridFsTemplate gridFsTemplate() throws Exception{
     MongoDbFactory dbFactory = mongoDbFactory();
     MongoConverter converter = mongoConverter();
     GridFsTemplate gridFsTemplate = new GridFsTemplate(dbFactory, converter);
     return gridFsTemplate;
     }

     @Bean
     public MongoConverter mongoConverter() throws Exception{
     MongoMappingContext mappingContext = new MongoMappingContext();
     MappingMongoConverter mappingMongoConverter = new MappingMongoConverter(mongoDbFactory(), mappingContext);
     return mappingMongoConverter;
     }*/
}
