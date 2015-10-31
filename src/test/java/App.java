
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.WriteConcern;
import java.io.File;
import java.net.URI;
import java.net.URL;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Vector;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class App {

    public static void main(String[] args) {

        try {
            ClassLoader myCL = Thread.currentThread().getContextClassLoader();
            while (myCL != null) {
                System.out.println("ClassLoader: " + myCL);
                for (Iterator iter = list(myCL); iter.hasNext();) {
                    System.out.println("\t" + iter.next());
                }
                myCL = myCL.getParent();
            }

        } catch (Exception e) {
            System.out.println("errrr:" + e);
        }

        if (1 == 1) {
            return;
        }

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

        //if (!coll.equals("system.indexes")) {
        tableD.drop();
        //}

        // BasicDBObject searchQuery2= new BasicDBObject().append("username", "mac");
        // DBCursor cursor2 = table.find(searchQuery2);
        DBCursor cursor2 = tableS.find();

        while (cursor2.hasNext()) {

            DBObject doo = cursor2.next();

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

    ////////////////////////
    public static List<String> getClassNamesFromPackage(String packageName) throws Exception {
        ClassLoader classLoader = Thread.currentThread().getContextClassLoader();
        URL packageURL;
        List<String> names = new ArrayList();;

        // packageName = packageName.replace(".", "/");
        packageURL = classLoader.getResource(packageName);

        if (packageURL.getProtocol().equals("jar")) {
            String jarFileName;
            JarFile jf;
            Enumeration<JarEntry> jarEntries;
            String entryName;

            // build jar file name, then loop through zipped entries
            jarFileName = URLDecoder.decode(packageURL.getFile(), "UTF-8");
            jarFileName = jarFileName.substring(5, jarFileName.indexOf("!"));
            System.out.println(">" + jarFileName);
            jf = new JarFile(jarFileName);
            jarEntries = jf.entries();
            while (jarEntries.hasMoreElements()) {
                entryName = jarEntries.nextElement().getName();
                if (entryName.startsWith(packageName) && entryName.length() > packageName.length() + 5) {
                    entryName = entryName.substring(packageName.length(), entryName.lastIndexOf('.'));
                    names.add(entryName);
                }
            }

            // loop through files in classpath
        } else {
            URI uri = new URI(packageURL.toString());
            File folder = new File(uri.getPath());
            // won't work with path which contains blank (%20)
            // File folder = new File(packageURL.getFile()); 
            File[] contenuti = folder.listFiles();
            String entryName;
            for (File actual : contenuti) {
                entryName = actual.getName();
                entryName = entryName.substring(0, entryName.lastIndexOf('.'));
                names.add(entryName);
            }
        }
        return names;
    }

    private static Iterator list(ClassLoader CL)
            throws NoSuchFieldException, SecurityException,
            IllegalArgumentException, IllegalAccessException {
        Class CL_class = CL.getClass();
        while (CL_class != java.lang.ClassLoader.class) {
            CL_class = CL_class.getSuperclass();
        }
        java.lang.reflect.Field ClassLoader_classes_field = CL_class
                .getDeclaredField("classes");
        ClassLoader_classes_field.setAccessible(true);
        Vector classes = (Vector) ClassLoader_classes_field.get(CL);
        return classes.iterator();
    }
}
