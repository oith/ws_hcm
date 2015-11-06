
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import java.util.Set;

public class App {

    public static void main(String[] args) {

        //SpringApplication.run(Application.class, args);
        try {
            MongoClient mongo = new MongoClient("localhost", 27017);
            mongo.setWriteConcern(WriteConcern.JOURNALED);
            // if database doesn't exists, MongoDB will create it for you
            DB dbS = mongo.getDB("demodb");
            DB dbD = mongo.getDB("demodbNew");

            //cpTab(dbS, dbD, "AccountHeadFm");
            Set<String> hj = dbS.getCollectionNames();
            System.out.println("mac all collections: " + hj);
            for (String arg : hj) {
                if (!arg.contains(".")) {
                    cpTab(dbS, dbD, arg);
                }
            }

            System.out.println("Done");

        } catch (MongoException e) {
            e.printStackTrace();
        }

    }

    static void cpTab(DB dbS, DB dbD, String coll) {
        DBCollection tableS = dbS.getCollection(coll);
        DBCollection tableD = dbD.getCollection(coll);

        //if (!coll.equals("system.indexes")) {
        tableD.drop();
        //}

        // BasicDBObject searchQuery2= new BasicDBObject().append("username", "mac");
        // DBCursor cursor2 = table.find(searchQuery2);
        DBCursor cursor2 = tableS.find();

        while (cursor2.hasNext()) {

            DBObject doo = cursor2.next();

            Set mm = doo.keySet();

            for (Object mm1 : mm) {

                String hggh = (String) mm1;
                if (hggh.equals("_class")) {
                    continue;
                } else if (hggh.equals("_id")) {
                    hggh = "id";
                }

                String kkk = (hggh.charAt(0) + "").toUpperCase() + hggh.substring(1);
                System.out.println("x1.set" + kkk + "(" + "\"" + doo.get(mm1.toString()) + "\");");
            }

            String clz = (String) doo.get("_class");

            if (clz != null && clz.contains(".")) {
                String jj = clz.substring(clz.lastIndexOf(".") + 1);

                doo.put("_class", jj);
            }

            System.out.println(">" + clz);
            try {
                tableD.insert(doo);
            } catch (Exception e) {

                System.out.println("Err mac: " + e);

                System.exit(1);
            }
        }
    }
}
