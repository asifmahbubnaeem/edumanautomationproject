*** Settings ***
Resource  utility/common.robot

Suite Setup  Suite Setup Actions
Suite Teardown  Close Browser

*** Keywords ***
Suite Setup Actions
    Log In To Eduman

Go To Student Attendance Menu
    Wait Until Page Contains Element  ${Menu_Student_Atendance}  10
    Click Element  xpath=//span[contains(text(), 'Student Attendance')]
    Wait Until Page Contains Element  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]  10

Select Settings
    Wait Until Element Is Enabled  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]  10
    Click Element  xpath=//li[@class='attendanceSettingsMenu']//span[contains(text(), 'Settings')]
    Wait Until Page Contains Element  xpath=//span[contains(text(), 'ID Mapping')]

Select ID Mappings
    Click Element  xpath=//span[contains(text(), 'ID Mapping')]
    Wait Until Keyword Succeeds     20x     .5s         Page Should Contain Element  xpath=//div[@class='progress-bar progress-color-bar progress-bar-striped page-head-title']/span[contains(text(), 'ID Mapping')]
    #Wait Until Page Contains Element  xpath=//div[@class='progress-bar progress-color-bar progress-bar-striped page-head-title']/span[contains(text(), 'ID Mapping')]  15

Page Should Redirect To IDMapping
    Wait Until Page Contains Element  xpath=//div[@class='progress-bar progress-color-bar progress-bar-striped page-head-title']/span[contains(text(), 'ID Mapping')]
    ${url} =  Execute Javascript  return window.location.href;
    #Get Location
    Log To Console  ${url}
    ${containsIDMapping}=  Run Keyword and Return Status  Should Contain  ${url}  IDMapping
    Log To Console  ${containsIDMapping}
    Run Keyword If  '${containsIDMapping}' == 'False'  Fail  msg=Url does not ridirect to IdMapping
    #IDMapping

Page Should show proper page header title ID Mapping
    Page Should Contain Element  xpath=//div[@class='progress-bar progress-color-bar progress-bar-striped page-head-title']/span[contains(text(), 'ID Mapping')]

Should show mandatory icon in mandatory field
    Wait Until Page Contains Element  xpath=//span[contains(text(), '*')]
    Page Should Contain Element  xpath=//div/label[@class='input-label']/span[text()='*']
    Page Should Contain Element  xpath=//div/label[@class='input-label']/span[@class='required' and text()='*']

Should show proper placeholder text
    Wait Until Page Contains Element  xpath=//div[@class='ui-helper-hidden-accessible']/input[@role='listbox']  10
    Page Should Contain Element  xpath=//div[@class='ui-dropdown ui-widget ui-state-default ui-corner-all ui-helper-clearfix']/label[text()='Select Section']

Should show proper search button icon
    Wait Until Page Contains Element  xpath=//button/span[@class='ui-icon-search ui-button-icon ui-c fa fa-fw ui-button-icon-left']  10
    Page Should Contain Element  xpath=//button/span[@class='ui-icon-search ui-button-icon ui-c fa fa-fw ui-button-icon-left']
    Wait Until Page Contains Element  xpath=//button/span/span[contains(text(), 'Search')]  10
    Page Should Contain Element  xpath=//button/span/span[contains(text(), 'Search')]

Page Should Contain Section Drop Down
    Wait Until Page Contains Element  //div[@class='ui-dropdown ui-widget ui-state-default ui-corner-all ui-helper-clearfix']  10
    Page Should Contain Element  //div[@class='ui-dropdown ui-widget ui-state-default ui-corner-all ui-helper-clearfix']
    Page Should Contain Element  //input[@role='listbox']

Expand Drop Down
    Wait Until Keyword Succeeds    20x     .5s     Page Should Contain Element  ${SectionDropDwnExpand}
    #Wait Until Page Contains Element  ${SectionDropDwnExpand}
    Click Element   ${SectionDropDwnExpand}

Check Drop Down Activity
    Wait Until Page Contains Element  //div[@class='ui-dropdown-items-wrapper']
    Page Should Contain Element  //ul[@class='ui-dropdown-items ui-dropdown-list ui-widget-content ui-widget ui-corner-all ui-helper-reset']
    Page Should Contain Element  //li[contains(text(), 'Ad-One-Morning-GREEN')]

Blank mandatory field check
    Wait Until Page Contains Element  ${DefaultSectionDropDown}  10
    Page Should Contain Element  ${DefaultSectionDropDown}
    Wait Until Page Contains Element  ${SearchBtnInsideStdntAttendace}  10
    Click Element  ${SearchBtnInsideStdntAttendace}
    Wait Until Page Contains Element  ${SectionRequiredMsg}  10
    Wait Until Page Contains Element  ${DropDownWithRequiredSymbol}
    Page Should Contain Element  ${DropDownWithRequiredSymbol}

Select From Section Drop Down  [Arguments]  ${section-name}
    Expand Drop Down
    Wait Until Page Contains Element  //input[@class='ui-dropdown-filter ui-inputtext ui-widget ui-state-default ui-corner-all']  10
    Click Element  //input[@class='ui-dropdown-filter ui-inputtext ui-widget ui-state-default ui-corner-all']
    Input Text  //input[@class='ui-dropdown-filter ui-inputtext ui-widget ui-state-default ui-corner-all']  ${section-name}
    Wait Until Page Contains Element  //li[@class='ui-dropdown-item ui-corner-all'][contains(text(), '${section-name}')]  10
    Click Element  //li[@class='ui-dropdown-item ui-corner-all'][contains(text(), '${section-name}')]
Invalid section select check
    Select From Section Drop Down  NURSERY-Morning-JABA
    Click Element  ${SearchBtnInsideStdntAttendace}
    Wait Until Page Contains Element  //p[contains(text(), 'No records found')]  10
    Page Should Contain Element  //h1[@class='no-data-msg']

Check Valid section selection  [Arguments]  ${sectionname}
    Select From Section Drop Down  ${sectionname}
    Click Element  ${SearchBtnInsideStdntAttendace}
    Wait Until Page Contains Element  //div[@class='table-header-wrapper']/div[@class='table-header']/span[text()='Student List']  10
    Page Should Contain Element  //div[@class='ui-datatable-tablewrapper']/table

Table instruction check
    Page Should Contain Element  //div[@class='table-instrauction']/p[contains(text(), '( Check the left box ')]
    Page Should Contain Element  //div[@class='table-instrauction']/p[contains(text(), 'to update data fields )')]
    Page Should Contain Element  //div[@class='table-instrauction']/div[@class='checkBox']

Check Total Data Found For A Section
    ${totalevenrows}=  Get Element Count   //tr[@class="ui-widget-content ui-datatable-even"]
    ${totaloddrows}=  Get Element Count   //tr[@class="ui-widget-content ui-datatable-odd"]
    ${totalrows}=  Evaluate  ${totalevenrows} + ${totaloddrows}
    Log To Console  Total data found = ${totalrows}
    ${totalfoundString}=  Catenate  Total Found :       ${totalrows}
    Set Suite Variable      ${totalfoundString}
    Log To Console         ${totalfoundString}
    Page Should Contain Element  //div[contains(text(), "${totalfoundString}")]

Machine ID column instruction data check
    Wait Until Keyword Succeeds    20x     .5s     Page Should Contain Element  span[contains(text(), "Check for use student ID as Machine ID )")]

*** Test Cases ***

Page redirection check
    Set Tags  [EM6-TC0001]
    #Log In To Eduman
    Go To Student Attendance Menu
    Select Settings
    Select ID Mappings
    Page Should Redirect To IDMapping

Page head title check
    Set Tags  [EM6-TC0002]
    Page Should show proper page header title ID Mapping

Mandaory Icon Check
    Set Tags  [EM6-TC0003]
    Should show mandatory icon in mandatory field

PlaceHolder Text Check
    Set Tags  [EM6-TC0004]
    Should show proper placeholder text

Search and Save ButtonIcon Check
    Set Tags  [EM6-TC0005]
    Should show proper search button icon

Drop down activity check
    Set Tags  [EM6-TC0006]
    Page Should Contain Section Drop Down
    Expand Drop Down
    Check Drop Down Activity

Blank Input fields check
    Set Tags  [EM6-TC0007]
    Blank mandatory field check

Ivalid Input fields check
    Set Tags  [EM6-TC0008]
    Go To Home
    Go To Student Attendance Menu
    Select Settings
    Select ID Mappings
    Invalid section select check
    #Log Out From Eduman
    #Close Browser
Valid Input fields check
    Set Tags  [EM6-TC0009]
    #Log In To Eduman
    Go To Home
    Go To Student Attendance Menu
    Select Settings
    Select ID Mappings
    Check Valid section selection  PLAY-Morning-JAMUNA

Data Table CheckBox Instruction Check
    Set Tags  [EM6-TC0014]
    Machine ID column instruction data check

Data Table Intruction Check
    Set Tags  [EM6-TC0010]
    Table instruction check

Data Table Total Count Check
    Set Tags  [EM6-TC0011]
    Check Total Data Found For A Section


