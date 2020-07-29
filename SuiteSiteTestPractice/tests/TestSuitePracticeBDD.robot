*** Settings ***
Resource         ../resources/Resource.robot
Test Setup       Abrir navegador
Test Teardown    Fechar navegador

*** Variables ***
${URL}       http://automationpractice.com/index.php
${BROWSER}   chrome

*** Test Case ***
Cenário 01: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "Blouse"
    Então o produto "Blouse" deve ser listado na página de resultado da busca

Cenário 02: Pesquisar produto não existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "itemNaoExistente"
    Então a página deve exibir a mensagem "No results were found for your search "itemNaoExistente""

Cenário 03: Listar produtos
    Dado que estou na página home do site
    Quando eu passar pela categoria "Women" no menu principal
    Então deve-se clicar e acessar a sub categoria "Summer Dresses"

Cenário 04: Adicionar produtos no carrinho
    Dado que estou na página home do site
    Quando eu pesquisar pelo produto "t-shirt"
    E adicionar o produto ao carrinho
    E clicar em "Proceed to checkout"
    Então deve ser exibido os dados do produto e seus valores

Cenário 05: Remover produtos
    Dado que estou na página home do site
    E tenho algum produto adicionado ao carrinho
    Quando eu clicar no ícone carrinho de compras no menu superior direito
    E Clicar para remover o prouto do carrinho
    Então deve ser exibida a mensagem "Your shopping cart is empty"

Cenário 06: Adicionar cliente
    Dado que estou na página home do site
    E clico no botão "Sign in"
    E insiro o e-mail "test01@teste.com"
    Quando clico para criar uma conta
    Então a página de registro deve ser exibida

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar pelo produto "${PRODUTO}"
    Digitar o nome do produto "${PRODUTO}" no campo de Pesquisa
    Clicar no botão Pesquisar

Então o produto "${PRODUTO}" deve ser listado na página de resultado da busca
    Conferir se o produto "${PRODUTO}" foi listado no site

Então a página deve exibir a mensagem "No results were found for your search "${PRODUTO}""
    Conferir mensagem de erro "No results were found for your search "${PRODUTO}""

Quando eu passar pela categoria "${CATEGORIA}" no menu principal
    Mouse Over   xpath=//*[@id="block_top_menu"]//a[@class='sf-with-ul'][@title='Women']

Então deve-se clicar e acessar a sub categoria "${SUBCATEGORIA}"
    Click Element       xpath=//*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a
    Title Should Be     Summer Dresses - My Store

E adicionar o produto ao carrinho
    Wait Until Element Is Visible   css=#center_column > div:nth-child(2) > div.top-pagination-content.clearfix > div.product-count
    Mouse Over        xpath=//*[@id="center_column"]/ul/li/div/div[2]/span/span
    Click Element     xpath=//*[@id="center_column"]//*[@title='Add to cart']

E clicar em "Proceed to checkout"
    Wait Until Element Is Visible   xpath=//*[@id="layer_cart"]//i[@class='icon-ok']
    Click Element     xpath=//*[@id="layer_cart"]/div[1]/div[2]/div[4]/a/span

Então deve ser exibido os dados do produto e seus valores
    Page Should Contain Element   xpath=//*[@id="product_1_1_0_0"]/td[2]/p/a
    Title Should Be     Order - My Store

E tenho algum produto adicionado ao carrinho
    Quando eu pesquisar pelo produto "t-shirt"
    E adicionar o produto ao carrinho
    E clicar em "Proceed to checkout"
    Acessar a página home do site

Quando eu clicar no ícone carrinho de compras no menu superior direito
    Click Element     xpath=//*[@title='View my shopping cart']

E Clicar para remover o prouto do carrinho
    Wait until Element Is Visible   xpath=//*[@class='label label-success'][contains(text(), 'In stock')]
    Click Element     xpath=//*[@title='Delete'][@class='cart_quantity_delete']

Então deve ser exibida a mensagem "${MENSAGEM}"
    Page Should Contain Element   xpath=//*[@id='order'][@class='order hide-left-column hide-right-column lang_en']

E clico no botão "Sign in"
    Click Element     xpath=//*[@class='login'][@title='Log in to your customer account']

E insiro o e-mail "${EMAIL}"
    Wait until Element Is Visible     id=SubmitCreate
    Input text       name=email_create    ${EMAIL}

Quando clico para criar uma conta
    Click Element     id=SubmitCreate

Então a página de registro deve ser exibida
    Wait until Element Is Visible     id=submitAccount
