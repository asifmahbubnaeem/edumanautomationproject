*** Variables ***

${EdumanUrl}        https://dev.edumanbd.com/#/login
${EdumanHomeUrl}        https://dev.edumanbd.com/#/
${BrowserDriver}    chrome

${Menu_Student_Atendance}    xpath=//span[contains(text(), 'Student Attendance')]

#### Student Attendance Page Locators
=========================================
${DefaultSectionDropDown}           //div[@class='ui-dropdown ui-widget ui-state-default ui-corner-all ui-helper-clearfix']
${DropDownWithRequiredSymbol}      //div[@class='ui-dropdown ui-widget ui-state-default ui-corner-all ui-helper-clearfix required-error']
${SearchBtnInsideStdntAttendace}          //button/span/span[contains(text(), 'Search')]
${SectionRequiredMsg}               //p[contains(text(), 'Please fill up all required fields.')]
${SectionDropDwnExpand}           //div[@class='ui-dropdown-trigger ui-state-default ui-corner-right']/span[@class='fa fa-fw fa-caret-down ui-clickable']