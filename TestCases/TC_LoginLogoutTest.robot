*** Settings ***
Resource  utility/common.robot
*** Test Cases ***
Login Test
    Log In To Eduman

Logout Test
    Log Out From Eduman
    Close Browser

