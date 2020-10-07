package eu.opertusmundi.cli.config;

import org.springframework.context.annotation.AdviceMode;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableJpaRepositories(
    basePackageClasses = { }
)
@EnableTransactionManagement(mode = AdviceMode.PROXY)
public class DatabaseConfiguration {

}
