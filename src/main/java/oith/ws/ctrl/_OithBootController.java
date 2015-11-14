package oith.ws.ctrl;

import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.gridfs.GridFSFile;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import javax.imageio.ImageIO;
import oith.ws.dom.core.Client;
import oith.ws.dom.core.Lookup;
import oith.ws.dom.core.Post;
import oith.ws.dom.core.Profile;
import oith.ws.dom.core.RememberMeToken;
import oith.ws.dom.core.Role;
import oith.ws.dom.core.User;
import oith.ws.dom.core.hrm.om.Emp;
import oith.ws.dom.core.hrm.om.OrgUnit;
import oith.ws.dom.hcm.fm.AccountHeadFm;
import oith.ws.dom.hcm.fm.TrnscFm;
import oith.ws.service.AccountHeadFmService;
import oith.ws.service.ClientService;
import oith.ws.service.EmpService;
import oith.ws.service.LookupService;
import oith.ws.service.OrgUnitService;
import oith.ws.service.PostService;
import oith.ws.service.ProfileService;
import oith.ws.service.RememberMeTokenService;
import oith.ws.service.RoleService;
import oith.ws.service.TrnscFmService;
import oith.ws.service.UserService;
import oith.ws.util.MacTestBoot;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.gridfs.GridFsOperations;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/boot")
public class _OithBootController extends _OithController {

    @Autowired
    private GridFsOperations gridFsTemplate;
    @Autowired
    private AccountHeadFmService accountHeadFmService;
    @Autowired
    private ClientService clientService;
    @Autowired
    private EmpService empService;
    @Autowired
    private LookupService lookupService;
    @Autowired
    private OrgUnitService orgUnitService;
    @Autowired
    private PostService postService;
    @Autowired
    private ProfileService profileService;
    @Autowired
    private RememberMeTokenService rememberMeTokenService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private TrnscFmService trnscFmService;
    @Autowired
    private UserService userService;

    private final MacTestBoot macTestBoot = new MacTestBoot();

    @RequestMapping(value = "/bootInit", method = RequestMethod.GET)
    public String init(ModelMap model) {
        //macTestBoot.setAccountHeadFmService(accountHeadFmService);
        macTestBoot.setClientService(clientService);
        macTestBoot.setEmpService(empService);
        macTestBoot.setGridFsTemplate(gridFsTemplate);
        macTestBoot.setLookupService(lookupService);
        macTestBoot.setOrgUnitService(orgUnitService);
        macTestBoot.setPostService(postService);
        macTestBoot.setProfileService(profileService);
        macTestBoot.setRememberMeTokenService(rememberMeTokenService);
        macTestBoot.setRoleService(roleService);
        //macTestBoot.setTrnscFmService(trnscFmService);
        macTestBoot.setUserService(userService);
        return "index";
    }

    @RequestMapping(value = "/dataA", method = RequestMethod.GET)
    public String indexA(ModelMap model) {

        macTestBoot.testA();
        return "index";
    }

    @RequestMapping(value = "/dataB", method = RequestMethod.GET)
    public String indexB(ModelMap model) {
        macTestBoot.testB();
        return "index";
    }

    @RequestMapping(value = "/dataC", method = RequestMethod.GET)
    public String indexC(ModelMap model) {
        macTestBoot.testC();
        return "index";
    }

    @RequestMapping(value = "/dataD", method = RequestMethod.GET)
    public String indexD(ModelMap model) {
        macTestBoot.testD();
        return "index";
    }

    public String noNeed(ModelMap model) {

        Client client1 = new Client();
        client1.setId("55cef88a27b665569010f650");
        client1.setCode("0002");
        client1.setName("IBCS Group");
        client1.setDomain("ibcs-primax");
        client1.setUserCreateUrl("ibc");
        client1.setLoginUrl("xbc");
        client1.setActive(true);
        client1.setRemarks("n/a man.");
        client1.setClientCategory(Client.ClientCategory.DEMO);
        clientService.create(client1);

        Client client2 = new Client();
        client2.setId("55cef88a27b665569010f651");
        client2.setCode("0001");
        client2.setName("Oith Group");
        client2.setDomain("oith");
        client2.setUserCreateUrl("oc");
        client2.setLoginUrl("obc");
        client2.setActive(true);
        client2.setRemarks("n/agv");
        client2.setClientCategory(Client.ClientCategory.OITH);
        clientService.create(client2);

        Client client3 = new Client();
        client3.setId("55cef88a27b665569010f652");
        client3.setCode("0000");
        client3.setName("Anonimous");
        client3.setDomain("anonimous");
        client3.setLoginUrl("abc3");
        client3.setUserCreateUrl("acx2");
        client3.setActive(true);
        client3.setRemarks("n/a man.m hib");
        client3.setClientCategory(Client.ClientCategory.DEMO);
        clientService.create(client3);

        Client client4 = new Client();
        client4.setId("55cef88a27b665569010f658");
        client4.setCode("0003");
        client4.setName("Biman Group");
        client4.setUserCreateUrl("bgc");
        client4.setLoginUrl("kbc");
        client4.setDomain("bdbiman");
        client4.setActive(true);
        client4.setRemarks("n/a.");
        client4.setClientCategory(Client.ClientCategory.CORPORATE);
        clientService.create(client4);

        Role role1 = new Role();
        role1.setId("55cef88a27b665569010fccc");
        role1.setCode("USER");
        role1.setClient(client4);
        role1.setName("User");
        roleService.create(role1);

        Role role2 = new Role();
        role2.setId("55cef88a27b665569010fccd");
        role2.setCode("ADMIN");
        role2.setClient(client4);
        role2.setName("Administrator");
        roleService.create(role2);

        Role role3 = new Role();
        role3.setId("55cef88a27b665569010fcce");
        role3.setCode("*");
        role3.setClient(client4);
        role3.setName("Permit All");
        roleService.create(role3);

        User user1 = new User();
        user1.setId("55cef88a27b665569010f65c");
        user1.setUsername("mac");
        user1.setPassword("123");
        user1.setFullName("Sheikh Mohammad Badiuzzaman Manik.");
        user1.setGender(User.Gender.MALE);
        user1.setDob(new java.util.Date(421092000000L));
        user1.setAccountNonExpired(true);
        user1.setAccountNonLocked(true);
        user1.setCredentialsNonExpired(true);
        user1.setEnabled(true);
        user1.setAuthorities(new HashSet(Arrays.asList(role1, role2, role3)));
        user1.setFavorites(new HashSet(Arrays.asList("Client", "Account Head", "Post")));

        Map<String, String> hashMap = new HashMap();
        hashMap.put("param1", "value1");
        hashMap.put("param2", "value2");
        hashMap.put("param3", "value3");
        hashMap.put("param4", "value4");
        user1.setParams(hashMap);

        user1.setClient(client4);
        userService.create(user1);

        User user2 = new User();
        user2.setId("55cefcb727b6653e0447414a");
        user2.setClient(null);
        user2.setUsername("anisa");
        user2.setPassword("123");
        user2.setFullName("Anisa Rani");
        user2.setGender(User.Gender.FEMALE);
        user2.setDob(new java.util.Date(976557600000L));
        user2.setAccountNonExpired(true);
        user2.setAccountNonLocked(true);
        user2.setCredentialsNonExpired(true);
        user2.setEnabled(true);
        user2.setAuthorities(null);
        userService.create(user2);

        User user3 = new User();
        user3.setId("55d5866d27b66547dcdf3548");
        user3.setUsername("deb");
        user3.setPassword("123");
        user3.setFullName("Debashis Kumar");
        user3.setGender(User.Gender.MALE);
        user3.setDob(new java.util.Date(978285600000L));
        user3.setAccountNonExpired(true);
        user3.setAccountNonLocked(true);
        user3.setCredentialsNonExpired(true);
        user3.setEnabled(true);
        user3.setAuthorities(null);
        user3.setClient(client1);
        userService.create(user3);

        User user4 = new User();
        user4.setId("55d9664e0e40cd8110998c1f");
        user4.setClient(client2);
        user4.setUsername("anis");
        user4.setPassword("123");
        user4.setFullName("Anisur Rahman Khan");
        user4.setGender(User.Gender.MALE);
        user4.setDob(new java.util.Date(1438624800000L));
        user4.setAccountNonExpired(true);
        user4.setAccountNonLocked(true);
        user4.setCredentialsNonExpired(true);
        user4.setEnabled(true);
        user4.setAuthorities(null);
        userService.create(user4);

        User user5 = new User();
        user5.setId("55f3c39a055a113744175fd1");
        user5.setFullName("Reza Khan");
        user5.setGender(User.Gender.MALE);
        user5.setDob(new java.util.Date(777492000000L));
        user5.setUsername("reza");
        user5.setPassword("123");
        user5.setAccountNonExpired(true);
        user5.setAccountNonLocked(true);
        user5.setCredentialsNonExpired(true);
        user5.setEnabled(true);
        user5.setClient(null);
        userService.create(user5);

        User user6 = new User();
        user6.setId("55f56ece055a1101f87b8cf0");
        user6.setFullName("Razib Khan");
        user6.setGender(User.Gender.MALE);
        user6.setDob(new java.util.Date(1441044000000L));
        user6.setUsername("rajib");
        user6.setPassword("123");
        user6.setAccountNonExpired(true);
        user6.setAccountNonLocked(true);
        user6.setCredentialsNonExpired(true);
        user6.setEnabled(true);
        user6.setClient(null);
        userService.create(user6);

        User user7 = new User();
        user7.setId("560251678f66474288204ce4");
        user7.setUsername("rch");
        user7.setPassword("123");
        user7.setFullName("Rowshon Chowdhury.");
        user7.setGender(User.Gender.FEMALE);
        user7.setDob(new java.util.Date(946663200000L));
        user7.setAccountNonExpired(true);
        user7.setAccountNonLocked(true);
        user7.setCredentialsNonExpired(true);
        user7.setEnabled(true);
        user7.setAuthorities(null);
        user7.setClient(client3);
        userService.create(user7);

        User user8 = new User();
        user8.setId("560296878f664719f8a57e02");
        user8.setUsername("saif");
        user8.setPassword("123");
        user8.setFullName("Saif Hossain Khan");
        user8.setGender(User.Gender.MALE);
        user8.setDob(new java.util.Date(654458400000L));
        user8.setAccountNonExpired(true);
        user8.setAccountNonLocked(true);
        user8.setCredentialsNonExpired(true);
        user8.setEnabled(true);
        user8.setAuthorities(null);
        user8.setClient(null);
        userService.create(user8);

        Profile profile1 = new Profile();
        profile1.setId("55cef88a27b665569010f85c");
        profile1.setFirstName("Sheikh");
        profile1.setMiddleName("Mohammad");
        profile1.setLastName("Badiuzzaman");
        profile1.setNickName("Manik");
        profile1.setProfilePicFile(imageHandle(new File("D:\\_OITH_OUTPUT\\oith_ws_hcm\\trunk\\sampleImage\\mac.jpg")));
        profile1.setContactInfo(null);
        profile1.setProfileEduDtls(null);
        profile1.setProfileJobDtls(null);
        profile1.setInsertDate(new java.util.Date(1442148416378L));
        profile1.setUpdateDate(new java.util.Date(1445459263860L));
        profile1.setUser(user1);
        profile1.setInsertByUser(user1);
        profile1.setUpdateByUser(null);
        profile1.setClient(client1);
        profileService.create(profile1);

        Profile profile2 = new Profile();
        profile2.setId("55d8345866fbe278e0be3128");
        profile2.setFirstName("debasis");
        profile2.setMiddleName("kumar");
        profile2.setLastName("dakua");
        profile2.setClient(client3);
        profile2.setNickName("debasis");
        profile2.setProfilePicFile("560bf3768f664717f4353e66");
        profile2.setContactInfo(null);
        profile2.setProfileEduDtls(null);
        profile2.setProfileJobDtls(null);
        profile2.setUser(user8);
        profileService.create(profile2);

        Profile profile3 = new Profile();
        profile3.setId("55d966690e40cd8110998c20");
        profile3.setFirstName("Anisur");
        profile3.setClient(null);
        profile3.setMiddleName("Rahman");
        profile3.setLastName("Khan");
        profile3.setNickName("Babu");
        profile3.setProfilePicFile("5608f15b0100fbb2ecd22c3d");
        profile3.setContactInfo(null);
        profile3.setUser(user4);
        profileService.create(profile3);

        Profile profile4 = new Profile();
        profile4.setId("55f3c4a5055a113744175fda");
        profile4.setFirstName("Reza");
        profile4.setMiddleName("Khan");
        profile4.setLastName("Reza");
        profile4.setClient(client2);
        profile4.setNickName("Reza");
        profile4.setProfilePicFile("5608f19b0100fbb2ecd22c5d");
        profile4.setContactInfo(null);
        profile4.setUser(user5);
        profileService.create(profile4);

        Profile profile5 = new Profile();
        profile5.setId("5608eb4c0100fbb2ecc3aa5a");
        profile5.setFirstName("Saif");
        profile5.setMiddleName("Hossain");
        profile5.setLastName("Khan");
        profile5.setNickName("Saif");
        profile5.setClient(client4);
        profile5.setProfilePicFile("5608ebc00100fbb2ecc3aa6f");
        profile5.setContactInfo(null);
        profile5.setProfileEduDtls(null);
        profile5.setProfileJobDtls(null);
        profile5.setUpdateDate(new java.util.Date(1443852993166L));
        profile5.setUser(user8);
        profile5.setUpdateByUser(null);
        profileService.create(profile5);

        Profile profile6 = new Profile();
        profile6.setId("560a5e770100fb8870862ea5");
        profile6.setFirstName("Rawsan");
        profile6.setMiddleName("Begum");
        profile6.setClient(client4);
        profile6.setLastName("raw");
        profile6.setNickName("bbgm");
        profile6.setProfilePicFile("560bf3528f664717f4353e13");
        profile6.setProfileEduDtls(null);
        profile6.setProfileJobDtls(null);
        profile6.setUser(user7);
        profileService.create(profile6);

        RememberMeToken rememberMeToken1 = new RememberMeToken();
        rememberMeToken1.setId("55f3c7ee055a11374417608c");
        rememberMeToken1.setUsername("anis");
        rememberMeToken1.setSeries("A1HocSmGwx3RZJz2GaGkBQ==");
        rememberMeToken1.setTokenValue("rNloqNxaU1r2MKgWeG6J9w==");
        rememberMeToken1.setDate(new java.util.Date(1442041274547L));
        rememberMeTokenService.create(rememberMeToken1);

        RememberMeToken rememberMeToken2 = new RememberMeToken();
        rememberMeToken2.setId("5628d2910100fb15f4a47bca");
        rememberMeToken2.setUsername("mac");
        rememberMeToken2.setSeries("F7cwroAV3lGfLcLR+pqhsQ==");
        rememberMeToken2.setTokenValue("oEgswJcSQM1pCyeqbBvETQ==");
        rememberMeToken2.setDate(new java.util.Date(1445546844479L));
        rememberMeTokenService.create(rememberMeToken2);

        AccountHeadFm accountHeadFm1 = new AccountHeadFm();
        accountHeadFm1.setId("562004ee8f66172d94d81a2a");
        accountHeadFm1.setCode("432");
        accountHeadFm1.setTitle("rrr");
        accountHeadFm1.setClient(client4);
        accountHeadFm1.setAccNo(" dfgdf");
        accountHeadFm1.setActive(false);
        accountHeadFm1.setSlNo(1);
        accountHeadFm1.setEmpRequired(true);
        accountHeadFm1.setDescription("u gj  jgjghjg");
        accountHeadFm1.setInsertDate(new java.util.Date(1442381494947L));
        accountHeadFm1.setUpdateDate(new java.util.Date(1444678793274L));
        accountHeadFm1.setInsertByUser(null);
        accountHeadFm1.setUpdateByUser(null);
        accountHeadFmService.create(accountHeadFm1);

        AccountHeadFm accountHeadFm2 = new AccountHeadFm();
        accountHeadFm2.setId("562004ee8f66472d94d81a2a");
        accountHeadFm2.setCode("00001");
        accountHeadFm2.setTitle("Sefl Own ma");
        accountHeadFm2.setAccNo("1");
        accountHeadFm2.setClient(client4);
        accountHeadFm2.setActive(true);
        accountHeadFm2.setSlNo(45);
        accountHeadFm2.setEmpRequired(true);
        accountHeadFm2.setDescription("fhgfh hh mm lonmmm");
        accountHeadFm2.setInsertDate(new java.util.Date(1442381494947L));
        accountHeadFm2.setUpdateDate(new java.util.Date(1444678793274L));
        accountHeadFm2.setInsertByUser(null);
        accountHeadFmService.create(accountHeadFm2);

        AccountHeadFm accountHeadFm3 = new AccountHeadFm();
        accountHeadFm3.setId("56211bc98f66472114fac9d1");
        accountHeadFm3.setCode("56756");
        accountHeadFm3.setTitle("ytry");
        accountHeadFm3.setAccNo("543543");
        accountHeadFm3.setClient(client4);
        accountHeadFm3.setActive(true);
        accountHeadFm3.setSlNo(54);
        accountHeadFm3.setEmpRequired(true);
        accountHeadFm3.setDescription("fhgfh");
        accountHeadFm3.setInsertDate(new java.util.Date(1442381494947L));
        accountHeadFm3.setUpdateDate(new java.util.Date(1444678793274L));
        accountHeadFm3.setInsertByUser(null);
        accountHeadFmService.create(accountHeadFm3);

        AccountHeadFm accountHeadFm4 = new AccountHeadFm();
        accountHeadFm4.setId("56211d388f66472114e5f3b0");
        accountHeadFm4.setCode("00867");
        accountHeadFm4.setTitle("mac oith accx");
        accountHeadFm4.setClient(client1);
        accountHeadFm4.setAccNo("6546");
        accountHeadFm4.setActive(true);
        accountHeadFm4.setSlNo(33);
        accountHeadFm4.setEmpRequired(true);
        accountHeadFm4.setDescription("hfgh v");
        accountHeadFm4.setInsertDate(new java.util.Date(1442381494947L));
        accountHeadFm4.setUpdateDate(new java.util.Date(1444678793274L));
        accountHeadFm4.setInsertByUser(null);
        accountHeadFmService.create(accountHeadFm4);

        AccountHeadFm accountHeadFm5 = new AccountHeadFm();
        accountHeadFm5.setId("56211f588f66472114302678");
        accountHeadFm5.setCode("gdfg");
        accountHeadFm5.setTitle("Own PF Subscription");
        accountHeadFm5.setAccNo("4");
        accountHeadFm5.setActive(true);
        accountHeadFm5.setSlNo(1);
        accountHeadFm5.setEmpRequired(true);
        accountHeadFm5.setDescription("gfd mmm.");
        accountHeadFm5.setInsertDate(new java.util.Date(1445011297268L));
        accountHeadFm5.setUpdateDate(new java.util.Date(1445455536789L));
        accountHeadFm5.setInsertByUser(null);
        accountHeadFm5.setUpdateByUser(null);
        accountHeadFm5.setClient(client4);
        accountHeadFmService.create(accountHeadFm5);

        AccountHeadFm accountHeadFm6 = new AccountHeadFm();
        accountHeadFm6.setId("5627e8690100fb39441c3ddd");
        accountHeadFm6.setCode("wecm");
        accountHeadFm6.setTitle("mac head");
        accountHeadFm6.setAccNo("345");
        accountHeadFm6.setActive(true);
        accountHeadFm6.setSlNo(2);
        accountHeadFm6.setEmpRequired(true);
        accountHeadFm6.setDescription("hhh mm");
        accountHeadFm6.setInsertDate(new java.util.Date(1445455998803L));
        accountHeadFm6.setUpdateDate(new java.util.Date(1445512492946L));
        accountHeadFm6.setInsertByUser(null);
        accountHeadFm6.setUpdateByUser(null);
        accountHeadFm6.setClient(null);
        accountHeadFmService.create(accountHeadFm6);

        TrnscFm trnscFm1 = new TrnscFm();
        trnscFm1.setId("5620ea678f664716d49f8a93");
        trnscFm1.setCode("00001");
        trnscFm1.setTransDate(new java.util.Date(1443636000000L));
        trnscFm1.setSign(TrnscFm.Sign.CR);
        trnscFm1.setAmount(12000.0);
        trnscFm1.setNarration("n./a ok");
        trnscFm1.setAccountHeadFm(null);
        trnscFm1.setAccountHeadFmOpposite(null);
        trnscFm1.setEmp(null);
        trnscFmService.create(trnscFm1);

        TrnscFm trnscFm2 = new TrnscFm();
        trnscFm2.setId("5628ca220100fb4c348a8752");
        trnscFm2.setCode("00002");
        trnscFm2.setTransDate(new java.util.Date(1443895200000L));
        trnscFm2.setSign(TrnscFm.Sign.DR);
        trnscFm2.setAmount(7800.0);
        trnscFm2.setNarration("okmm b");
        trnscFm2.setAccountHeadFm(null);
        trnscFm2.setEmp(null);
        trnscFmService.create(trnscFm2);

        TrnscFm trnscFm3 = new TrnscFm();
        trnscFm3.setId("562926180100fb4c6c7b99cc");
        trnscFm3.setCode("gfgd");
        trnscFm3.setTransDate(new java.util.Date(1443981600000L));
        trnscFm3.setSign(TrnscFm.Sign.DR);
        trnscFm3.setAmount(1111.0);
        trnscFm3.setNarration("nbgfhfg...");
        trnscFm3.setAccountHeadFm(null);
        trnscFm3.setEmp(null);
        trnscFmService.create(trnscFm3);

        TrnscFm trnscFm4 = new TrnscFm();
        trnscFm4.setId("56292f010100fb3db8ae8a87");
        trnscFm4.setCode("66666");
        trnscFm4.setTransDate(new java.util.Date(1443895200000L));
        trnscFm4.setSign(TrnscFm.Sign.CR);
        trnscFm4.setAmount(8888.0);
        trnscFm4.setNarration("etretre");
        trnscFm4.setAccountHeadFm(null);
        trnscFm4.setAccountHeadFmOpposite(null);
        trnscFm4.setEmp(null);
        trnscFmService.create(trnscFm4);

        Post post1 = new Post();
        post1.setId("55d62f7127b6656e24220491");
        post1.setSubject("oh good. yaa......");
        post1.setClient(null);
        post1.setContent("Shahid Anower School.");
        post1.setUser(null);
        postService.create(post1);

        Post post2 = new Post();
        post2.setId("55d630a427b6656e24220492");
        post2.setSubject("Saleha High School");
        post2.setClient(null);
        post2.setContent("Its a school in Hazaribagh, Dhaka..");
        post2.setUser(null);
        postService.create(post2);

        Post post3 = new Post();
        post3.setId("55dc437e055a112becdc0544");
        post3.setSubject("sub not have..d");
        post3.setContent("what can be write.");
        post3.setClient(null);
        post3.setUser(null);
        postService.create(post3);

        Post post4 = new Post();
        post4.setId("55ef19a5055a1117a4f562c6");
        post4.setSubject("anis yaa");
        post4.setContent("s e e w h a t  ?");
        post4.setClient(null);
        post4.setUser(null);
        postService.create(post4);

        Post post5 = new Post();
        post5.setId("55f29d51055a1143d073a3b5");
        post5.setSubject("tghtgtmm");
        post5.setContent("gtgtg");
        post5.setUser(null);
        postService.create(post5);

        Post post6 = new Post();
        post6.setId("55f3c4fa055a113744175ff8");
        post6.setSubject("i am reza");
        post6.setContent("oooitthhh");
        post6.setClient(null);
        post6.setUser(null);
        postService.create(post6);

        Post post7 = new Post();
        post7.setId("55f56fa1055a1101f87b8d35");
        post7.setSubject("gdfgdfg");
        post7.setContent("gdfgdgdf");
        post7.setClient(null);
        post7.setUser(null);
        postService.create(post7);

        Post post8 = new Post();
        post8.setId("5628bb500100fb2c8caeb429");
        post8.setSubject("gggm");
        post8.setContent("ooo clnt");
        post8.setUser(null);
        postService.create(post8);

        Post post9 = new Post();
        post9.setId("5628bb500100fb2c8cafb429");
        post9.setSubject("hhhh");
        post9.setContent("ppp");
        post9.setUser(null);
        postService.create(post9);

        Post post10 = new Post();
        post10.setId("5628c4980100fb46b0eba58a");
        post10.setSubject("hgfhf");
        post10.setContent("hfghgf ddd");
        post10.setInsertDate(new java.util.Date(1445512350889L));
        post10.setUser(null);
        post10.setInsertByUser(null);
        post10.setClient(null);
        postService.create(post10);

        Emp emp1 = new Emp();
        emp1.setId("5616d5649cdc291aa09e5bd6");
        emp1.setCode("000321");
        emp1.setClient(null);
        emp1.setDoj(new java.util.Date(382298400000L));
        emp1.setDoe(new java.util.Date(1601488800000L));
        emp1.setProfile(null);
        empService.create(emp1);

        Emp emp2 = new Emp();
        emp2.setId("5616d5649cdc291aa09eabd6");
        emp2.setCode("000166");
        emp2.setDoj(new java.util.Date(382298400000L));
        emp2.setDoe(new java.util.Date(1443636000000L));
        emp2.setProfile(null);
        empService.create(emp2);

        Emp emp3 = new Emp();
        emp3.setId("5617932e9cdc293434a18d15");
        emp3.setCode("000422");
        emp3.setClient(null);
        emp3.setDoj(new java.util.Date(323719200000L));
        emp3.setDoe(new java.util.Date(1633456800000L));
        emp3.setProfile(null);
        empService.create(emp3);

        Lookup lookup1 = new Lookup();
        lookup1.setId("55f29974055a1143d0a9a34f");
        lookup1.setCode("001");
        lookup1.setName("SSC");
        lookup1.setActive(true);
        lookup1.setClient(null);
        lookup1.setSlNo(1);
        lookup1.setRemarks("hthy");
        lookup1.setLookupKeyword(Lookup.LookupKeyword.EDUCATION);
        lookup1.setInsertDate(new java.util.Date(1441962366692L));
        lookup1.setUpdateDate(new java.util.Date(1444592518542L));
        lookup1.setInsertByUser(null);
        lookup1.setUpdateByUser(null);
        lookupService.create(lookup1);

        Lookup lookup2 = new Lookup();
        lookup2.setId("55f8feb68f664720b809df42");
        lookup2.setCode("002");
        lookup2.setName("Programmingx");
        lookup2.setActive(true);
        lookup2.setClient(null);
        lookup2.setSlNo(1);
        lookup2.setRemarks("wwww mAN");
        lookup2.setLookupKeyword(Lookup.LookupKeyword.PROFESSION);
        lookup2.setInsertDate(new java.util.Date(1442381494947L));
        lookup2.setUpdateDate(new java.util.Date(1444678793274L));
        lookup2.setInsertByUser(null);
        lookup2.setUpdateByUser(null);
        lookupService.create(lookup2);

        Lookup lookup3 = new Lookup();
        lookup3.setId("55f8feb68f664720b809df43");
        lookup3.setCode("003r");
        lookup3.setName("Film");
        lookup3.setActive(true);
        lookup3.setClient(null);
        lookup3.setSlNo(1);
        lookup3.setRemarks("wwww mAN");
        lookup3.setLookupKeyword(Lookup.LookupKeyword.PROFESSION);
        lookup3.setInsertDate(new java.util.Date(1442381494947L));
        lookup3.setUpdateDate(new java.util.Date(1444678793274L));
        lookup3.setInsertByUser(null);
        lookup3.setUpdateByUser(null);
        lookupService.create(lookup3);

        Lookup lookup4 = new Lookup();
        lookup4.setId("561ac00d8f664712d4904619");
        lookup4.setCode("003");
        lookup4.setName("HSC");
        lookup4.setActive(true);
        lookup4.setClient(null);
        lookup4.setSlNo(2);
        lookup4.setRemarks("n/a");
        lookup4.setLookupKeyword(Lookup.LookupKeyword.EDUCATION);
        lookup4.setInsertDate(new java.util.Date(1444593677722L));
        lookup4.setInsertByUser(null);
        lookupService.create(lookup4);

        Lookup lookup5 = new Lookup();
        lookup5.setId("5629219b0100fb4c54888461");
        lookup5.setCode("vxvxdd");
        lookup5.setName("BSC");
        lookup5.setActive(true);
        lookup5.setSlNo(53);
        lookup5.setRemarks("xvxv..");
        lookup5.setLookupKeyword(Lookup.LookupKeyword.EDUCATION);
        lookup5.setInsertDate(new java.util.Date(1445536155804L));
        lookup5.setUpdateDate(new java.util.Date(1445536180364L));
        lookup5.setInsertByUser(null);
        lookup5.setUpdateByUser(null);
        lookup5.setClient(null);
        lookupService.create(lookup5);

        OrgUnit orgUnit1 = new OrgUnit();
        orgUnit1.setId("56150b839cdc292c3c948b9e");
        orgUnit1.setCode("001");
        orgUnit1.setName("Accounts");
        orgUnit1.setClient(null);
        //orgUnit1.setOrgType(OrgUnit.OrgUnitType.DEPT);
        orgUnit1.setDescription("Accounting..");
        orgUnitService.create(orgUnit1);

        OrgUnit orgUnit2 = new OrgUnit();
        orgUnit2.setId("5616ca339cdc294f1c873e20");
        orgUnit2.setCode("ytry uu");
        orgUnit2.setName("ytry");
        orgUnit2.setClient(null);
        orgUnit2.setDescription("yyyyy");
        orgUnit2.setInsertDate(new java.util.Date(1442381494947L));
        orgUnit2.setUpdateDate(new java.util.Date(1444592603237L));
        orgUnit2.setInsertByUser(null);
        orgUnit2.setUpdateByUser(null);
        orgUnitService.create(orgUnit2);

        OrgUnit orgUnit3 = new OrgUnit();
        orgUnit3.setId("56178f739cdc293434a18c95");
        orgUnit3.setCode("1");
        orgUnit3.setName("a");
        orgUnit3.setClient(null);
        //orgUnit3.setOrgType("DEPARTMENT");
        orgUnit3.setDescription("gdfg anis");
        orgUnitService.create(orgUnit3);

        OrgUnit orgUnit4 = new OrgUnit();
        orgUnit4.setId("56224f228f66471dbc19f9c0");
        orgUnit4.setCode("0002");
        orgUnit4.setClient(null);
        orgUnit4.setName("Ibcs Primax soft bd ltd");
        //orgUnit4.setOrgType("OPERATING_UNIT");
        orgUnit4.setDescription("gfdg");
        orgUnitService.create(orgUnit4);
        return "index";
    }

    private String imageHandle(File file) {
        String ret = null;
        long size;

        if ((file != null && (size = file.length()) > 0)) {

            byte[] buf = new byte[(int) size];

            try {
                InputStream inputStream = new FileInputStream(file);
                inputStream.read(buf);
                inputStream.close();
            } catch (Exception e) {
            }

            DBObject metaData = new BasicDBObject();
            metaData.put("status", "active");
            metaData.put("size", "big");

            GridFSFile trt = gridFsTemplate.store(new ByteArrayInputStream(buf), file.getName(), "jpg", metaData);
            ret = trt.getId().toString();

            try {
                BufferedImage bsrc = ImageIO.read(new ByteArrayInputStream(buf));//  new File(data));
                BufferedImage bdest = new BufferedImage(45, 55, BufferedImage.TYPE_INT_RGB);
                Graphics2D g = bdest.createGraphics();
                AffineTransform at = AffineTransform.getScaleInstance((double) 45 / bsrc.getWidth(),
                        (double) 55 / bsrc.getHeight());
                g.drawRenderedImage(bsrc, at);

                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bdest, "png", baos);
                InputStream is = new ByteArrayInputStream(baos.toByteArray());

                metaData = new BasicDBObject();
                metaData.put("parent", trt.getId());
                metaData.put("status", "active");
                metaData.put("size", "small");
                GridFSFile trtx = gridFsTemplate.store(is, file.getName(), "png", metaData);

                //ret= trt.getId().toString();
                System.out.println("done small image id: " + trtx.getId().toString());
                //ImageIO.write(bdest, "jpg", filet);
            } catch (Exception e) {
                System.out.println("eeeeeeeee" + e);
            }

        }
        return ret;
    }
}
