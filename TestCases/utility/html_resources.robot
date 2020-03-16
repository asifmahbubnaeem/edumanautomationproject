*** Settings ***
Resource  common.robot

*** Keywords ***
Log In To Eduman
    OPEN BROWSER  ${EdumanUrl}  ${BrowserDriver}
    Wait Until Page Contains Element  xpath=//input[@id='loginUserName']  30
    Maximize Browser Window
    Input Text  xpath=//input[@id='loginUserName']  01799339292
    Input Text  xpath=//input[@id='loginPassword']  eduman6
    ${numberOne}=  Get Text  xpath=//span[@id='digit1']
    ${numberOne}=  Convert To Integer  ${numberOne}
    ${numberTwo}=  Get Text  xpath=//span[@id='digit2']
    ${numberTwo}=  Convert To Integer  ${numberTwo}
    ${numberAns}=  Evaluate  ${numberOne}+${numberTwo}
    Input Text  xpath=//input[@id='numberAnswer']  ${numberAns}
    Wait Until Page Contains Element  xpath=//button[@id='LoginEnablebutton']  10
    Click Element  xpath=//button[@id='LoginEnablebutton']
    Wait Until Page Contains Element  xpath=//div[contains(text(), 'Search')]  30

Log Out From Eduman
    ${status}  ${msg}=  Run Keyword and Ignore Error  Page Should Contain Element  //span[@class='topBarMenuImage']
    Log to Console  status is ${status}
    Run Keyword If  '${status}' == 'FAIL'  Click Element  //span[text()='Home']
    Run Keyword If  '${status}' == 'FAIL'  Wait Until Page Contains Element  //span[@class='topBarMenuImage']  15
    Click Element  //span[@class='topBarMenuImage']
    Wait Until Page Contains Element  //a[@role='button']/span[text()='Log Out']  15
    Click Element  //a[@role='button']/span[text()='Log Out']
    Wait Until Page Contains Element  //button[text()='Login']  20

Go To Home
    Click Element  //div[@class='ui-g ui-fluid']//span[contains(text(), 'Home')]
    :FOR  ${i}  IN RANGE  10
    \  ${url} =  Execute Javascript  return window.location.href;
    \  Run Keyword If  '${url}' == '${EdumanHomeUrl}'  Exit For Loop
    ${url} =  Execute Javascript  return window.location.href;
    Run Keyword If  '${url}' != '${EdumanHomeUrl}'  Fail  msg=Home Page Not Found