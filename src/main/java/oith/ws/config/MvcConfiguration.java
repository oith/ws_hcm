package oith.ws.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
@EnableWebMvc
@PropertySource(value = {"classpath:application.properties"})
public class MvcConfiguration extends WebMvcConfigurerAdapter {

    private static final String VIEW_RESOLVER_PREFIX = "/vu/";
    private static final String VIEW_RESOLVER_SUFFIX = ".jsp";
    @Autowired
    private Environment environment;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(localeChangeInterceptor());
    }

    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver() {
        return new CookieLocaleResolver();
    }

    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        //multipartResolver.setMaxUploadSize(10000000);
        return multipartResolver;
    }

    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.ignoreAcceptHeader(true).defaultContentType(
                MediaType.TEXT_HTML);
    }

//    @Override
//    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
//        configurer.enable();
//    }
    /*
     * Configure View resolver to provide HTML output This is the default format
     * in absence of any type suffix.
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix(VIEW_RESOLVER_PREFIX);
        viewResolver.setSuffix(VIEW_RESOLVER_SUFFIX);
        return viewResolver;
    }

    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
        messageSource.setBasename("/i18n/messages");
        messageSource.setDefaultEncoding("UTF-8");
        messageSource.setFallbackToSystemLocale(false);
        return messageSource;
    }

    @Bean
    public LocaleChangeInterceptor localeChangeInterceptor() {
        LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
        localeChangeInterceptor.setParamName("lang");
        return localeChangeInterceptor;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {

        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/").setCachePeriod(31556926);
//        registry.addResourceHandler("/css/**").addResourceLocations("/assets/css/*");
//        registry.addResourceHandler("/js/**").addResourceLocations("/assets/js/*");
//        registry.addResourceHandler("/images/**").addResourceLocations("/assets/images/*");
        //    <!--macs non static path-->
        registry.addResourceHandler("/reports/**").addResourceLocations("/reports/*");
    }

    @Bean
    public org.springframework.web.filter.CharacterEncodingFilter characterEncodingFilter() {
        org.springframework.web.filter.CharacterEncodingFilter characterEncodingFilter = new org.springframework.web.filter.CharacterEncodingFilter();
        characterEncodingFilter.setEncoding("utf-8");
        return characterEncodingFilter;
    }

    @Bean
    public org.springframework.context.support.ConversionServiceFactoryBean conversionService() {
        org.springframework.context.support.ConversionServiceFactoryBean conversionServiceFactoryBean = new org.springframework.context.support.ConversionServiceFactoryBean();
        return conversionServiceFactoryBean;
    }
}
