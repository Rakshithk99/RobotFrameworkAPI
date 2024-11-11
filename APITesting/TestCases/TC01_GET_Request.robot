*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     OperatingSystem
Library     String




*** Variables ***
${base_url}     http://10.246.4.103/spatialSTORM/spatialSUITE/v8_6_2/custom
${service}      PayloadReport

#http://10.246.4.103/spatialSTORM/spatialSUITE/v8_6_2/custom/PayloadReport?ReportType=Third_Party&Sheath=CG-SH3-264f&Segment=2


*** Test Cases ***
Get_ThirdParty
    ${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1
    ${params} =    Create Dictionary    ReportType=Third_Party    Sheath=CG-SH3-264f    Segment=2
    Create Session    mysession    ${base_url}      auth=${auth}
    ${response}=    GET On Session   mysession    /${service}       params=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

Data_Driven_API_Tests
    ${auth}=    Create List     SPATIALNETWORX\\rakk0001     Rakshi@spatial1
    Create Session    mysession    ${base_url}      auth=${auth}
    ${data}=    Read CSV File       C:/Users/rakk0001.SPATIALNETWORX/Desktop/TestData.csv
    FOR    ${row}    IN    @{data}
        Log    Testing with data: ${row}
        ${response}=    GET On Session  mysession   /${service}     params=${row}
        Log To Console    ${response.status_code}
        Log To Console    ${response.content}

    END

*** Keywords ***
Read CSV File
    [Arguments]     ${file_path}
    ${file}=    Get File  ${file_path}
    #${data}=    Evaluate    [line.strip().split(',') for line in ${file}.readlines()[1:]]
    #${headers}=    Get From List    ${data}    0
    #${rows}=    Get From List    ${data}    1
    @{read}=    Create List    ${file}

    @{lines}=    Split To Lines    @{read}    1


    FOR    ${line_csv}    IN    @{lines}
        Log To Console    \n${line_csv}
        FOR    ${index}    IN RANGE    ${len(${headers})}
            Set To Dictionary    ${result}    ${headers}[${index}]    ${row}[${index}]
        END
        Append To List    ${results}    ${result}
    END
    RETURN      ${results}







