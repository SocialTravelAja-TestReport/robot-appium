*** Settings ***
Library         SeleniumLibrary
Library    Process
Library    Collections
Library    XML
Resource        Resources/LoginPage.resource

Suite Setup     Begin Tests
Test Setup      User already on User Management Page
Suite Teardown  Close Browser

*** Variables ***
${BASE_URL}         https://dev-app.travelaja.id/
${ADMIN_HOME_URL}   /home
${EMAIL_ADMIN}      benson@yopmail.com
${PASSWORD_ADMIN}   Keon!123

*** Test Cases ***
TableView-001 - Verify all required data provided on column
    Sleep    5
    Page Should Contain    Name
    Page Should Contain    Phone Number
    Page Should Contain    Email
    Page Should Contain    Register Date
    Page Should Contain    Role
    Page Should Contain    Status

TableView-002 - Verify id is sorted ascending
TableView-003 - Verify data shown limited by 10
    Sleep    5
    ${element_found}=   Get data count
    Should Be Equal    ${element_found}    10
    Log To Console    ${element_found}


*** Keywords ***
Begin Tests
    Open Browser    ${BASE_URL}     Firefox
    Maximize Browser Window

User already login as Admin
    Click Element    ${EMAIL_FIELD}
    Input Text    ${EMAIL_FIELD}        ${EMAIL_ADMIN}
    Click Element    ${PASSWORD_FIELD}
    Input Text    ${PASSWORD_FIELD}     ${PASSWORD_ADMIN}
    Click Element    ${SUBMIT_BUTTON}
    Sleep   5
    Wait Until Location Is Not    ${BASE_URL}login

User already on User Management Page
    User already login as Admin
    Go To    ${BASE_URL}/users
#    Click Element    css=.CustomLayout-module__navBar___f8Ykn
#    Click Element    link=User
#    Create User interaction

Get data count
    ${source}=    Get Element    # you have the whole html of the page here
    ${matches}=   Get Regexp Matches    ${source}   >.*\b(Success)\b.*<
    ${count}=     Get Length    ${matches}