#include "gtest/gtest.h"
#include <string>
#include <unordered_map>

using namespace testing;
using namespace std;

// adapted from https://gist.github.com/elliotchance/8215283

unordered_map<string,bool> showAllOptions{
    {"environment", true},
    {"testCases", true},
    {"testNames", true},
    {"successes", true},
    {"inlineFailures", true}
};

unordered_map<string,bool> showNoOptions{
    {"environment", false},
    {"testCases", false},
    {"testNames", false},
    {"successes", false},
    {"inlineFailures", false}
};

class ConfigurableEventListener : public TestEventListener {
    
protected:
    TestEventListener* eventListener;
    
public:
    virtual ~ConfigurableEventListener() {
        delete eventListener;
    }
    
    bool showTestCases;
    bool showTestNames;
    bool showSuccesses;
    bool showInlineFailures;
    bool showEnvironment;
    
    explicit ConfigurableEventListener(
        TestEventListener* theEventListener,
        unordered_map<string, bool>& toShow) 
      : eventListener(theEventListener) {
        showTestCases = toShow["testCases"];
        showTestNames = toShow["testNames"];
        showSuccesses = toShow["successes"];
        showInlineFailures = toShow["inlineFailures"];
        showEnvironment = toShow["environment"];
    }
    
    virtual void OnTestProgramStart(const UnitTest& unit_test) {
        eventListener->OnTestProgramStart(unit_test);
    }
    
    virtual void OnTestIterationStart(const UnitTest& unit_test, int iteration) {
        eventListener->OnTestIterationStart(unit_test, iteration);
    }
    
    virtual void OnEnvironmentsSetUpStart(const UnitTest& unit_test) {
        if (showEnvironment) {
            eventListener->OnEnvironmentsSetUpStart(unit_test);
        }
    }
    
    virtual void OnEnvironmentsSetUpEnd(const UnitTest& unit_test) {
        if (showEnvironment) {
            eventListener->OnEnvironmentsSetUpEnd(unit_test);
        }
    }
    
    virtual void OnTestCaseStart(const TestCase& test_case) {
        if (showTestCases) {
            eventListener->OnTestCaseStart(test_case);
        }
    }
    
    virtual void OnTestStart(const TestInfo& test_info) {
        if (showTestNames) {
            eventListener->OnTestStart(test_info);
        }
    }
    
    virtual void OnTestPartResult(const TestPartResult& result) {
        eventListener->OnTestPartResult(result);
    }
    
    virtual void OnTestEnd(const TestInfo& test_info) {
        if ((showInlineFailures && test_info.result()->Failed()) || (showSuccesses && !test_info.result()->Failed())) {
            eventListener->OnTestEnd(test_info);
        }
    }
    
    virtual void OnTestCaseEnd(const TestCase& test_case) {
        if (showTestCases) {
            eventListener->OnTestCaseEnd(test_case);
        }
    }
    
    virtual void OnEnvironmentsTearDownStart(const UnitTest& unit_test) {
        if (showEnvironment) {
            eventListener->OnEnvironmentsTearDownStart(unit_test);
        }
    }
    
    virtual void OnEnvironmentsTearDownEnd(const UnitTest& unit_test) {
        if (showEnvironment) {
            eventListener->OnEnvironmentsTearDownEnd(unit_test);
        }
    }
    
    virtual void OnTestIterationEnd(const UnitTest& unit_test, int iteration) {
        eventListener->OnTestIterationEnd(unit_test, iteration);
    }
    
    virtual void OnTestProgramEnd(const UnitTest& unit_test) {
        eventListener->OnTestProgramEnd(unit_test);
    }
    
};

bool hasShowFailuresOnlyOption(int argc, char **argv) {
    auto showFailuresOnly = false;
    for (unsigned int i = 1; i < argc; i++) {
        auto option = string{argv[i]};
        if (option == "--failed-only")
            showFailuresOnly = true;
    }
    return showFailuresOnly;
}

int main(int argc, char **argv) {
     cout << endl << "NOTE: The --failed-only option is also available." << endl << endl;

    ::testing::InitGoogleTest(&argc, argv);

    auto showFailuresOnly = hasShowFailuresOnlyOption(argc, argv);

    // remove the default listener
    testing::TestEventListeners& listeners = testing::UnitTest::GetInstance()->listeners();
    auto default_printer = listeners.Release(listeners.default_result_printer());
    
    ConfigurableEventListener *listener = new ConfigurableEventListener(
        default_printer, 
        showFailuresOnly ? showNoOptions : showAllOptions);
    listeners.Append(listener);
    
    return RUN_ALL_TESTS();
}
