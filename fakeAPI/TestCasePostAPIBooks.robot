**** Settings ***
Documentation     Documentação da API: http://fakerestapi.azurewebsites.net/swagger/ui/index#/Books
Resource          ResourceAPI.robot
Suite Setup       Conectar API

*** Test Case ***
Cadastrar um novo livro
  Cadastrar um novo livro
