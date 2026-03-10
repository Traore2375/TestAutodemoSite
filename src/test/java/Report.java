import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class Report {

    public static void main(String[] args) {

        File reportOutputDirectory = new File("target/cucumber-report");

        List<String> jsonFiles = new ArrayList<>();
        jsonFiles.add("target/karate-reports");

        Configuration configuration =
                new Configuration(reportOutputDirectory, "My Project");

        ReportBuilder reportBuilder =
                new ReportBuilder(jsonFiles, configuration);

        reportBuilder.generateReports();
    }
}