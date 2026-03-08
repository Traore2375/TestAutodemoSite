import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import java.io.File;
import java.util.Collections;

public class GenerateReport {
    public static void main(String[] args) {
        File reportOutputDirectory = new File("target/cucumber-html-reports");
        java.util.List<String> jsonFiles = Collections.singletonList("target/surefire-reports/karate-summary.json");
        Configuration configuration = new Configuration(reportOutputDirectory, "Karate Project");
        ReportBuilder reportBuilder = new ReportBuilder(jsonFiles, configuration);
        reportBuilder.generateReports();
    }
}

