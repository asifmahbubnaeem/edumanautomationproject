*** Settings ***
Resource  utility/common.robot

*** Test Cases ***
Test lower case
     ${sml}=  Convert To Lowercase  TEST DATA
    Log To Console  test text = ${sml}
MandaoryIconCheck
    Log In To Eduman
    Wait Until Page Contains Element  ${Menu_Student_Atendance}  10
    Click Element  xpath=//span[contains(text(), 'Student Attendance')]
    Wait Until Page Contains Element  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]  10
    Wait Until Element Is Enabled  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]  10
    Click Element  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]
    Wait Until Page Contains Element  xpath=//span[contains(text(), 'ID Mapping')]
    Click Element  xpath=//span[contains(text(), 'ID Mapping')]
    Wait Until Page Contains Element  xpath=//div[@class='progress-bar progress-color-bar progress-bar-striped page-head-title']/span[contains(text(), 'ID Mapping')]
    Wait Until Page Contains Element  xpath=//span[contains(text(), '*')]
    Page Should Contain Element  xpath=//div/label[@class='input-label']/span[text()='*']
    Page Should Contain Element  xpath=//div/label[@class='input-label']/span[@class='required' and text()='*']
    Close Browser
