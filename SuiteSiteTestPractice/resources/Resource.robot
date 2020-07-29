*** Settings ***
Library   SeleniumLibrary

*** Variables ***
${URL}       http://automationpractice.com/index.php
${BROWSER}   firefox

*** Keywords ***
#### Setup e Teardown
Abrir navegador
    Open Browser  about:blank   ${BROWSER}
    Maximize Browser Window

Fechar navegador
    Close Browser

#### Passo-a-Passo
Acessar a página home do site
    Go To             http://automationpractice.com/index.php
    Title Should Be   My Store

Digitar o nome do produto "${PRODUTO}" no campo de Pesquisa
    Input Text    name=search_query    ${PRODUTO}

Clicar no botão Pesquisar
    Click Element   name=submit_search

Conferir se o produto "${PRODUTO}" foi listado no site
    Wait Until Element Is Visible   css=#center_column > h1
    Title Should Be                 Search - My Store
    Page Should Contain Image       xpath=//*[@id="center_column"]//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']
    Page Should Contain Link        xpath=//*[@id="center_column"]//a[@class='product-name'][contains(text(),'${PRODUTO}')]

Conferir mensagem de erro "No results were found for your search "${PRODUTO}""
    Wait Until Element Is Visible   xpath=//*[@id="center_column"]/p[@class='alert alert-warning']
    Title Should Be                 Search - My Store
    Page Should Contain Element     //*[@id="center_column"]//span[@class='heading-counter'][contains(text(), '0 results have been found.')]
