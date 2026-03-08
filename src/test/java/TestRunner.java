import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate testAll() {
        // IMPORTANT : JSON Cucumber pour le HTML report
        return Karate.run().outputCucumberJson(true).relativeTo(getClass());
    }
}
