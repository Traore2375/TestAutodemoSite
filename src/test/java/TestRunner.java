import com.intuit.karate.junit5.Karate;

class TestRunner {

    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:feature").relativeTo(getClass())
                .outputCucumberJson(true)   // <-- très important
                .outputHtmlReport(true);    // optionnel
    }

}
