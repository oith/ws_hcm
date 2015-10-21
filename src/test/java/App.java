
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import java.util.Set;

import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {

    public static void main(String[] args) {

        //SpringApplication.run(Application.class, args);
        try {
            MongoClient mongo = new MongoClient("localhost", 27017);
            mongo.setWriteConcern(WriteConcern.JOURNALED);
            // if database doesn't exists, MongoDB will create it for you
            DB dbS = mongo.getDB("demodb");
            DB dbD = mongo.getDB("demodbNew");

            //  cpTab(dbS, dbD, "AccountHeadFm");
            Set<String> hj = dbS.getCollectionNames();
            System.out.println("hj: " + hj);
            for (String arg : hj) {

                cpTab(dbS, dbD, arg);

            }
            // BasicDBObject searchQuery2= new BasicDBObject().append("username", "mac");
            // DBCursor cursor2 = table.find(searchQuery2);
          /*  DBCollection table = dbS.getCollection("User");
             DBCursor cursor2 = table.find();

             while (cursor2.hasNext()) {

             DBObject doo = cursor2.next();

             System.out.println(">" + doo);
             }*/

            // if collection doesn't exists, MongoDB will create it for you
        /*    DBCollection table = db.getCollection("test");

    
             // create a document to store key and value
             BasicDBObject document = new BasicDBObject();
             document.put("name", "mkyong");
             document.put("age", 30);
             document.put("createdDate", new Date());
             table.insert(document);

           
             BasicDBObject searchQuery = new BasicDBObject();
             searchQuery.put("name", "mkyong");

             DBCursor cursor = table.find(searchQuery);

             while (cursor.hasNext()) {
             System.out.println(cursor.next());
             }

   
             // search document where name="mkyong" and update it with new values
             BasicDBObject query = new BasicDBObject();
             query.put("name", "mkyong");

             BasicDBObject newDocument = new BasicDBObject();
             newDocument.put("name", "mkyong-updated");

             BasicDBObject updateObj = new BasicDBObject();
             updateObj.put("$set", newDocument);

             table.update(query, updateObj);

        
             BasicDBObject searchQuery2
             = new BasicDBObject().append("name", "mkyong-updated");

             DBCursor cursor2 = table.find(searchQuery2);

             while (cursor2.hasNext()) {
             System.out.println(cursor2.next());
             }

             */
            System.out.println("Done");

        } catch (MongoException e) {
            e.printStackTrace();
        }

    }

    static void cpTab(DB dbS, DB dbD, String coll) {
        DBCollection tableS = dbS.getCollection(coll);
        DBCollection tableD = dbD.getCollection(coll);

        if (!coll.equals("system.indexes")) {
            tableD.drop();
        }

        // BasicDBObject searchQuery2= new BasicDBObject().append("username", "mac");
        // DBCursor cursor2 = table.find(searchQuery2);
        DBCursor cursor2 = tableS.find();

        while (cursor2.hasNext()) {

            DBObject doo = cursor2.next();
            System.out.println(">" + doo);
            try {
                tableD.insert(doo);
            } catch (Exception e) {

                System.out.println("Err mac: " + e);

                System.exit(1);
            }

        }

    }
}
