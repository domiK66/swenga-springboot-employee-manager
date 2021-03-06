package at.fhj.ima.employee.employeemanager.security

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter

@Configuration
@EnableWebSecurity
class WebSecurityConfiguration : WebSecurityConfigurerAdapter() {

    @Autowired
    private lateinit var myUserDetailsService: MyUserDetailsService;

    override fun configure(http: HttpSecurity) {
        http
            .authorizeRequests()
            // you anonymous urls here
            .antMatchers("/anonymous").permitAll()
            //.antMatchers("/anonymous1").permitAll()
            //.antMatchers("/anonymous2").permitAll()
            //.antMatchers("/anonymous3").permitAll()
            .anyRequest().authenticated()
            .and()
            .formLogin()
            .and()
            // hash - uniqueAndSecret
            .rememberMe().key("uniqueAndSecret").userDetailsService(myUserDetailsService);
    }
}