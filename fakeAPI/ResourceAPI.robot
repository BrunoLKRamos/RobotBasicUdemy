**** Settings ***
Documentation     Documentação da API: http://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Library           RequestsLibrary
Library           Collections

*** Variables ***
${URL_API}        http://fakerestapi.azurewebsites.net/api/
&{BOOK_15}        ID=15
...               Title=Book 15
...               Description=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\n
...               PageCount=1500
...               Excerpt=Lorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\nLorem lorem lorem. Lorem lorem lorem. Lorem lorem lorem.\r\n

*** Keywords ***
####SETUP E TEARDOWNS
Conectar API
    Create Session    fakeAPI   ${URL_API}

#### Ações
Requisitar todos os livros
    ${RESPOSTA}   Get request   fakeAPI   Books
    Log           ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}   Get request   fakeAPI   Books/${ID_LIVRO}
    Log           ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

Cadastrar um novo livro
    ${HEADERS}    Create Dictionary     content-type=application/json
    ${RESPOSTA}   Post request   fakeAPI   Books
    ...                          data={"ID": 2323,"Title": "teste","Description": "teste","PageCount": 200,"Excerpt": "teste","PublishDate": "2020-07-04T23:31:39.305Z"}
    ...                          headers=${HEADERS}
    Log           ${RESPOSTA.text}
    Set Test Variable   ${RESPOSTA}

#### Conferências
Conferir o status code
    [Arguments]     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}      ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be    ${RESPOSTA.json()}    ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro "${ID_LIVRO}"
    Dictionary Should Contain Item    ${RESPOSTA.json()}    ID            ${BOOK_15.ID}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Title         ${BOOK_15.Title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Description   ${BOOK_15.Description}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    PageCount     ${BOOK_15.PageCount}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    Excerpt       ${BOOK_15.Excerpt}
    Should Not Be Empty    ${RESPOSTA.json()["Description"]}
    Should Not Be Empty    ${RESPOSTA.json()["PublishDate"]}
