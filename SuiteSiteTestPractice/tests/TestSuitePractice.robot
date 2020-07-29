*** Settings ***
Resource         ../resources/Resource.robot
Test Setup       Abrir navegador
Test Teardown    Fechar navegador
### SETUP roda keywords antes da suite ou antes de um teste
### TEARDOWN roda keyword depois de uma suite ou um teste

*** Test Case ***
Caso de teste 01: Pesquisar produto existente
    Acessar a página home do site
    Digitar o nome do produto "Blouse" no campo de Pesquisa
    Clicar no botão Pesquisar
    Conferir se o produto "Blouse" foi listado no site

Caso de teste 02: Pesquisar produto não existente
    Acessar a página home do site
    Digitar o nome do produto "itemNaoExistente" no campo de Pesquisa
    Clicar no botão Pesquisar
    Conferir mensagem de erro "No results were found for your search "itemNaoExistente""

*** Keywords ***
