*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     String

Test Template    PayloadReport_Data

*** Variables ***
${base_url}     http://10.246.4.103/spatialSTORM/spatialSUITE/v8_6_2/custom
${service}      PayloadReport
${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1
#http://10.246.4.103/spatialSTORM/spatialSUITE/v8_6_2/custom/PayloadReport?ReportType=Third_Party&Sheath=CG-SH3-264f&Segment=2

*** Test Cases ***              ReportType      Sheath      Segment
TC01        Third_Party     CG-SH3-264f     2
TC02        Third_Party     CG-SH185-48f    2

*** Keywords ***
PayloadReport_Data
    ${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1
    [Arguments]     ${ReportType}   ${Sheath}   ${Segment}
    ${params} =    Create Dictionary    ReportType=${ReportType}    Sheath=${Sheath}    Segment=${Segment}
    Create Session    mysession    ${base_url}      auth=${auth}
    ${response}=    GET On Session   mysession    /${service}       params=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}


