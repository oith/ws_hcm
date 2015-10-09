
package oith.ws.config;

import oith.ws.repo.RoleConfigRepository;
import oith.ws.dom.core.RoleConfig;
import oith.ws.repo.RememberMeTokenRepository;
import oith.ws.service.LoginService;
import oith.ws.service.RememberMeTokenServiceImpl;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import oith.ws.dom.core.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

    @Autowired
    private LoginService loginService;
    @Autowired
    private RememberMeTokenRepository rememberMeTokenRepository;
    @Autowired
    private RoleConfigRepository roleConfigRepository;

//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
//        return passwordEncoder;
//    }
    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        // The authentication provider below uses MongoDB to store SHA1 hashed passwords
        // To see how to configure users for the example below, please see the README file

//        ReflectionSaltSource rss = new ReflectionSaltSource();
//       // rss.setUserPropertyToUse("loginId");
//        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
//        provider.setSaltSource(rss);
//        provider.setUserDetailsService(loginService);
//        provider.setPasswordEncoder(bCryptPasswordEncoder());
//        auth.authenticationProvider(provider);
        auth
                .userDetailsService(loginService) //  .passwordEncoder(passwordEncoder()) //                .passwordEncoder(new ShaPasswordEncoder())
                ;
        // The authentication provider below is the simplest provider you can use
        // The users, their passwords and roles are all added as clear text
//        auth
//                .inMemoryAuthentication()
//                .withUser("admin")
//                .password("admin")
//                .roles("ADMIN")
//                .and()
//                .withUser("user")
//                .password("user")
//                .roles("USER");
        // The authentication provider below hashes incoming passwords using SHA1
        // The users passwords below are hashed using SHA1 (see README for values)
//      auth
//          .inMemoryAuthentication()
//          .passwordEncoder( new ShaPasswordEncoder() )
//          .withUser( "admin" )
//              .password( "d033e22ae348aeb5660fc2140aec35850c4da997" )
//              .roles( "ADMIN" )
//              .and()
//          .withUser( "user" )
//              .password( "12dea96fec20593566ab75692c9949596833adc9" )
//              .roles( "USER" );
        // The authentication provider below uses JDBC to retrieve your credentials
        // The data source bean configuration can be found at the bottom of this file
        // The first example uses the default Spring Security tables, see link below
        // http://docs.spring.io/spring-security/site/docs/3.0.x/reference/appendix-schema.html
//      auth
//          .jdbcAuthentication()
//          .dataSource( dataSource )
//          .passwordEncoder( new ShaPasswordEncoder() );
        // The second example shows how you can override the default queries in order
        // to use your own tables rather than Spring Security's default tables
        // The SQL is relatively simple and should be easy to figure out and map to your needs
//      auth
//          .jdbcAuthentication()
//          .dataSource( dataSource )
//          .usersByUsernameQuery( "select username,password from users where username=?" )
//          .authoritiesByUsernameQuery( "select u.username, r.authority from users u, roles r where u.userid = r.userid and u.username =?" );
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        // This is here to ensure that the static content (JavaScript, CSS, etc)
        // is accessible from the login page without authentication
        web
                .ignoring()
                .antMatchers("/css/**")
                .antMatchers("/fonts/**")
                .antMatchers("/i18n/**")
                .antMatchers("/resources/**")
                .antMatchers("/js/**")
                .antMatchers("/media/**")
                .antMatchers("/template/**")
                .antMatchers("/themes/**");
    }

    private class MacAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

        @Override
        public void onAuthenticationSuccess(HttpServletRequest httpServletRequest,
                HttpServletResponse httpServletResponse,
                Authentication authentication)
                throws IOException, ServletException {
            //do some logic here if you want something to be done whenever
            //the user successfully logs in.

            //UserMac authUser = (UserMac) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            //User user = userRepository.findByUsername(authUser.getUsername());
            //   HttpSession session = httpServletRequest.getSession();
            // session.setAttribute("fullName", authUser.getDisplayName());
            // session.setAttribute("userId", authUser.getUserId());
            // session.setAttribute("profileId", authUser.getProfileId());
//            Enumeration<String> yyy = session.getAttributeNames();
//            while (yyy.hasMoreElements()) {
//                String nextElement = yyy.nextElement();
//                System.out.println("session " + nextElement + " with val " + session.getAttribute(nextElement));
//            }
            //set our response to OK status
            httpServletResponse.setStatus(HttpServletResponse.SC_OK);

            //since we have created our custom success handler, its up to us to where
            //we will redirect the user after successfully login
            httpServletResponse.sendRedirect("indexSecure");
        }
    }

    private class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler implements LogoutSuccessHandler {

        // Just for setting the default target URL
//        public CustomLogoutSuccessHandler(String defaultTargetURL) {
//            this.setDefaultTargetUrl(defaultTargetURL);
//        }
        @Override
        public void onLogoutSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse,
                Authentication authentication) throws IOException, ServletException {

            if (authentication != null && authentication.getDetails() != null) {

                httpServletRequest.getSession().invalidate();
                System.out.println("User Successfully Logout");
                //you can add more codes here when the user successfully logs out,
                //such as updating the database for last active.

            }

            httpServletResponse.setStatus(HttpServletResponse.SC_OK);
            //redirect to login
            httpServletResponse.sendRedirect("/login");

//            HttpSession session = request.getSession();
//            session.setAttribute("fullName", null);
//            session.setAttribute("userId", null);
//            session.setAttribute("profileId", null);
//
//            // do whatever you want
//            super.onLogoutSuccess(request, response, authentication);
        }
    }

    private class CustomLogoutHandler implements LogoutHandler {

        @Override
        public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {

            System.out.println("ooooooooooooooooooo");
            //HttpSession session = request.getSession();
            //session.setAttribute("fullName", null);
            //session.setAttribute("userId", null);
            //session.setAttribute("profileId", null);
            // business logic here
        }
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        //http.authorizeRequests().antMatchers("/", "/index", "/login", "/logout").permitAll();
        //http.authorizeRequests().antMatchers("/,/index,/login,/logout".split(",")).permitAll();
        //http.authorizeRequests().antMatchers("/user/create").permitAll();
        Iterable<RoleConfig> kk = roleConfigRepository.findAll();
//        List<RoleConfig> kk = new ArrayList();
//        kk.add(new RoleConfig("/,/index,/login,/logout", new Role("55cef88a27b665569010fcce", "*","Permit All"), null));
//        kk.add(new RoleConfig("/org/**", new Role("55cef88a27b665569010fccd", "ADMIN","Administrator"), null));
//        kk.add(new RoleConfig("/user/show", new Role("55cef88a27b665569010fccc", "USER","User"), null));
//        kk.add(new RoleConfig("/user/create", new Role("55cef88a27b665569010fcce", "*","Permit All"), null));
//        kk.add(new RoleConfig("/profile/create", new Role("55cef88a27b665569010fccc", "USER","User"), null));
//        kk.add(new RoleConfig("/post/**", new Role("55cef88a27b665569010fcce", "*","Permit All"), null));
//        kk.add(new RoleConfig("/admin/**", new Role("55cef88a27b665569010fccd", "ADMIN","Administrator"), null));

        for (RoleConfig roleConfig : kk) {

            Role role=roleConfig.getRole();
            
            if (role.getCode().equals("*")) {
                http.authorizeRequests().antMatchers(roleConfig.getUrls().split(",")).permitAll();
            } else {
                http.authorizeRequests().antMatchers(roleConfig.getUrls().split(",")).hasRole(role.getCode());
//                http.authorizeRequests().antMatchers(kk1.getUrls().split(",")).hasAnyRole(kk1.getRole().getName());
            }
        }
        http.authorizeRequests()
                .antMatchers("/resources/**").permitAll()
                .anyRequest().authenticated();
        /*
         http.authorizeRequests()
         //.antMatchers("/org/**").hasRole("ADMIN")
         //.antMatchers("/org/**").access("hasRole('ROLE_ADMIN')")
         //.antMatchers("/user/show").access("hasRole('ROLE_ADMIN')")
         //.antMatchers("/user/show").access("hasRole('ROLE_USER')")
         //.antMatchers("/user/**").access("hasRole('ROLE_USER')")
         .antMatchers("/indexSecure").permitAll()
         .antMatchers("/profile/**").permitAll()
         .antMatchers("/post/**").permitAll()
         .antMatchers("/comment/**").permitAll()
         .antMatchers("/profileEduDtl/**").permitAll()
         .antMatchers("/lookup/**").permitAll()
         // .antMatchers("/lookup/**").access("hasRole('ADMIN') and hasRole('USER')")
         .antMatchers("/**").hasRole("USER")
         .anyRequest().authenticated() //                .and()
         */

        http
                .exceptionHandling()
                .accessDeniedPage("/denied")
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .failureUrl("/login?error=1")
                .defaultSuccessUrl("/indexSecure") //or /

                .usernameParameter("username")
                .passwordParameter("password")
                .successHandler(new MacAuthenticationSuccessHandler())
                .permitAll()
                .and()
                .logout()
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login")
                //.logoutSuccessUrl("/login")
                //.addLogoutHandler(new CustomLogoutHandler())

                //.logoutSuccessUrl("/index")
                //.logoutSuccessHandler(new CustomLogoutSuccessHandler())

                .and()
                // The session management is used to ensure the user only has one session. This isn't
                // compulsory but can add some extra security to your application.
                //.sessionManagement()
                //.invalidSessionUrl("/login?time=1")
                //.maximumSessions(1);

                .rememberMe()
                .key("oith_key")
                .rememberMeServices(rememberMeServices())
                //.useSecureCookie(true)
                //.useSecureCookie(true)
                .and()
                .csrf().disable();
//        .rememberMe().
//                tokenRepository(persistentTokenRepository())
//		.tokenValiditySeconds(1209600);
    }

//    @Bean
//	public PersistentTokenRepository persistentTokenRepository() {
//		JdbcTokenRepositoryImpl db = new JdbcTokenRepositoryImpl();
//                db.
//		db.setDataSource(dataSource);
//		return db;
//	}
    @Bean
    public RememberMeServices rememberMeServices() {
        PersistentTokenBasedRememberMeServices rememberMeServices = new PersistentTokenBasedRememberMeServices(
                "oith_key",
                loginService,
                persistentTokenRepository());
        rememberMeServices.setAlwaysRemember(true);
        return rememberMeServices;
    }

//    @Bean
//    public RememberMeAuthenticationProvider rememberMeAuthenticationProvider() {
//        RememberMeAuthenticationProvider rememberMeAuthenticationProvider = new RememberMeAuthenticationProvider("oith_key");
//        return rememberMeAuthenticationProvider;
//    }
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        return new RememberMeTokenServiceImpl(rememberMeTokenRepository);
    }

//    @Override
//    protected void configure(HttpSecurity http) throws Exception {
//        http
//                // access-denied-page: this is the page users will be
//                // redirected to when they try to access protected areas.
//                .exceptionHandling()
//                .accessDeniedPage("/403")
//                .and()
//                // The intercept-url configuration is where we specify what roles are allowed access to what areas.
//                // We specifically force the connection to https for all the pages, although it could be sufficient
//                // just on the login page. The access parameter is where the expressions are used to control which
//                // roles can access specific areas. One of the most important things is the order of the intercept-urls,
//                // the most catch-all type patterns should at the bottom of the list as the matches are executed
//                // in the order they are configured below. So /** (anyRequest()) should always be at the bottom of the list.
//                .authorizeRequests()
//                .antMatchers("/login**").permitAll()
//                .antMatchers("/admin/**").hasRole("ADMIN")
//                .anyRequest().authenticated()
//                .and()
//                .requiresChannel()
//                .anyRequest().requiresSecure()
//                .and()
//                // This is where we configure our login form.
//                // login-page: the page that contains the login screen
//                // login-processing-url: this is the URL to which the login form should be submitted
//                // default-target-url: the URL to which the user will be redirected if they login successfully
//                // authentication-failure-url: the URL to which the user will be redirected if they fail login
//                // username-parameter: the name of the request parameter which contains the username
//                // password-parameter: the name of the request parameter which contains the password
//                .formLogin()
//                .loginPage("/login")
//                .loginProcessingUrl("/login.do")
//                .defaultSuccessUrl("/")
//                .failureUrl("/login?err=1")
//                .usernameParameter("username")
//                .passwordParameter("password")
//                .and()
//                // This is where the logout page and process is configured. The logout-url is the URL to send
//                // the user to in order to logout, the logout-success-url is where they are taken if the logout
//                // is successful, and the delete-cookies and invalidate-session make sure that we clean up after logout
//                .logout()
//                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
//                .logoutSuccessUrl("/login?out=1")
//                .deleteCookies("JSESSIONID")
//                .invalidateHttpSession(true)
//                .and()
//                // The session management is used to ensure the user only has one session. This isn't
//                // compulsory but can add some extra security to your application.
//                .sessionManagement()
//                .invalidSessionUrl("/login?time=1")
//                .maximumSessions(1);
//    }
//    @Bean
//    public RememberMeServices rememberMeServices() {
//        // Key must be equal to rememberMe().key()
//        TokenBasedRememberMeServices rememberMeServices = new TokenBasedRememberMeServices("your_key", loginService);
//        rememberMeServices.setCookieName("remember_me_cookie");
//        rememberMeServices.setParameter("remember_me_checkbox");
//        rememberMeServices.setTokenValiditySeconds(2678400); // 1month
//        return rememberMeServices;
//    }
}
