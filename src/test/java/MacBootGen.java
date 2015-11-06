
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.DBRef;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import java.io.FileWriter;
import java.util.Date;
import java.util.Set;
import org.bson.types.ObjectId;

public class MacBootGen {

    static String dec = "";
    static String ret = "";

    public static void main(String[] args) {

        try {
            MongoClient mongo = new MongoClient("localhost", 27017);

            DB dbS = mongo.getDB("demodb");

            Set<String> hj = dbS.getCollectionNames();
            System.out.println("mac all collections: " + hj);

            for (String arg : hj) {
                if (!arg.contains(".")) {
                    makeObj(dbS, arg);
                }
            }

            try {
                FileWriter fw = new FileWriter("Boot.java");
                fw.write(dec + "\n\n" + ret);
                fw.close();
                System.out.println("Done file write");
            } catch (Exception e) {
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

    static void makeObj(DB dbS, String coll) {

        DBCollection tableS = dbS.getCollection(coll);
        DBCursor cursor2 = tableS.find();

        String instNma = (coll.charAt(0) + "").toLowerCase() + coll.substring(1);

        dec += "@Autowired" + "\n";
        dec += "private " + coll + "Service " + instNma + "Service;" + "\n";

        int ins = 1;
        while (cursor2.hasNext()) {

            DBObject doo = cursor2.next();

            Set mm = doo.keySet();

            ret += coll + " " + instNma + ins + "=new " + coll + "();" + "\n";
            System.out.println(coll + " " + instNma + ins + "=new " + coll + "();");

            for (Object mm1 : mm) {

                String hggh = (String) mm1;
                if (hggh.equals("_class")) {
                    continue;
                } else if (hggh.equals("_id")) {
                    hggh = "id";
                }

                String kkk = (hggh.charAt(0) + "").toUpperCase() + hggh.substring(1);

                Object val = doo.get(mm1.toString());

                System.out.println("ppppppppppppp" + val.getClass().getSimpleName());
                if (val instanceof String) {
                    val = "\"" + val + "\"";
                } else if (val instanceof Number) {
                    val = "" + val + "";
                } else if (val instanceof Date) {
                    val = "new java.util.Date(" + ((Date) val).getTime() + "L)";
                } else if (val instanceof ObjectId) {
                    val = "\"" + val + "\"";
                } else if (val instanceof DBRef) {
                    val = "null";
                } else if (val instanceof BasicDBList) {
                    val = "null";
                } else if (val instanceof BasicDBObject) {
                    val = "null";
                }

                ret += instNma + ins + ".set" + kkk + "(" + val + ");" + "\n";
                System.out.println(instNma + ins + ".set" + kkk + "(" + val + ");");

            }

            ret += instNma + "Service.create(" + instNma + ins + ");" + "\n\n";
            ins++;
        }
    }
}
