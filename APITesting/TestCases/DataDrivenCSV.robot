*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     DataDriver      C:/Users/rakk0001.SPATIALNETWORX/Desktop/TestData.csv


Test Template       ReadDataUsingCSV

*** Variables ***
${base_url}     http://10.246.4.103/spatialSTORM/spatialSUITE/v8_6_2/custom
${service}      PayloadReport
${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1

*** Test Cases ***
${ReportType} Report using ${Sheath} and ${Segment}

*** Keywords ***
ReadDataUsingCSV
    [Arguments]     ${ReportType}   ${Sheath}       ${Segment}      ${ExpectedResponse}
    ${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1
    ${params} =    Create Dictionary    ReportType=${ReportType}    Sheath=${Sheath}    Segment=${Segment}
    Create Session    mysession    ${base_url}      auth=${auth}
    ${response}=    GET On Session   mysession    /${service}       params=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    ${source data}=    Evaluate     json.loads("""${response.content}""")    json
    ${data}=        Set Variable    ${source data["Data"]}
    #Log To Console    "Data is======="+${data}
    
#Compare Response with Expected Response
   # [Arguments]     ${data}
    #${actualResponse}=  ${data}
    #${expectedResponse}=    Evaluate    open("./ExpectedResponses/Expected1.txt", "r")  f.read()
    ${expectedResponse}     Get File    ${ExpectedResponse}
    Should Be Equal As Strings   ${data}    ${expectedResponse}
