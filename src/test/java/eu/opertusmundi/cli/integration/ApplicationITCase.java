package eu.opertusmundi.cli.integration;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.File;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.ApplicationContext;
import org.springframework.core.io.ResourceLoader;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.jdbc.JdbcTestUtils;
import org.testcontainers.containers.JdbcDatabaseContainer;
import org.testcontainers.containers.PostgisContainerProvider;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;

@SpringBootTest
@ActiveProfiles("testing")
@Testcontainers
public class ApplicationITCase {

    private static final String DB_NAME     = "opertusmundi";
    private static final String DB_USERNAME = "username";
    private static final String DB_PASSWORD = "password";

    @Container
    private static final JdbcDatabaseContainer<?> postgisContainer = new PostgisContainerProvider()
        .newInstance("10-2.5-alpine")
        .withDatabaseName(DB_NAME)
        .withUsername(DB_USERNAME)
        .withPassword(DB_PASSWORD);

    static {
        postgisContainer.start();
    }

    @DynamicPropertySource
    private static void setDynamicProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgisContainer::getJdbcUrl);
        registry.add("spring.datasource.username", () -> DB_USERNAME);
        registry.add("spring.datasource.password", () -> DB_PASSWORD);
    }

    @Value("${spring.flyway.locations}")
    private String locations;

    @Value("${spring.flyway.table}")
    private String dbVersionTable;

    @Value("${spring.flyway.baseline-on-migrate}")
    private boolean baselineOnMigrate;

    @Autowired
    private ApplicationContext context;

    @Autowired
    private ResourceLoader resourceLoader;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    @DisplayName(value = "PostGIS container is running")
    @Order(1)
    public void postgisContainerInitialized() throws Exception {
        assertThat(postgisContainer.isRunning()).isTrue();
    }

    @Test
    @DisplayName(value = "All migration scripts are executed")
    @Order(2)
    public void allScriptsExecuted() throws Exception {
        final var migrationsUri   = this.resourceLoader.getResource(locations).getURI();
        final var migrationFolder = new File(migrationsUri);
        final var migrationCount  = migrationFolder.listFiles().length;

        final var versionRows = JdbcTestUtils.countRowsInTable(this.jdbcTemplate, dbVersionTable);

        // Assert that all migration scripts have been executed
        assertThat(versionRows).isEqualTo(baselineOnMigrate ? migrationCount + 1 : migrationCount);
    }

    @Test
    @DisplayName(value = "Context loads")
    @Order(3)
    public void contextLoads() throws Exception {
        assertThat(this.context).isNotNull();
    }

}
