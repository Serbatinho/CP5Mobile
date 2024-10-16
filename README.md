# Navigation and Routing
A sample that shows how to use [go_router][https://pub.dev/packages/go_router]
API to handle common navigation scenarios.

## Goals
- Demonstrate common navigation scenarios:
  - Parsing path parameters ('/user/:id')
  - Sign in (redirection)
  - Nested navigation using ShellRoute
- Demonstrate how [deep linking][] is configured on iOS and Android
- Demonstrate how to use the Link widget from `package:url_Launcher` with the
  Router API.

# Implementações:
- Agora o APP salva o nome do usuario localmente e mostra ele na tela de 
- Página de Adicionar Livros (AddBookPage):
- Verificação para garantir que todos os campos estão preenchidos antes de submeter.
- Callback para Adicionar o Livro.
- O novo livro é passado para a função onBookAdded.
- A lista de livros é atualizada automaticamente após a adição do novo livro, utilizando o setState.

INNOV8TECH – PROJETO FLUTTER

# Descrição do Projeto - Negócio

Este projeto tem como objetivo fornecer uma plataforma para gerenciar livros e autores.
Ele é desenvolvido para ser uma aplicação simples de gerenciamento de conteúdo, onde os usuários podem adicionar, visualizar e gerenciar livros e seus autores. O foco é permitir que usuários administrem uma coleção de livros de forma eficiente, com uma navegação simples e adaptável a diferentes dispositivos.

# Melhorias

## Melhorias de design e técnicas implementadas:

### Overview
- **Navegação Adaptativa**: Implementamos o AdaptiveNavigationScaffold, que ajusta automaticamente o layout de navegação de acordo com o tamanho da tela, proporcionando uma experiência de uso consistente e responsiva, independentemente do dispositivo.
- **Página de Adicionar Livros**: Criamos uma página específica para adicionar novos livros. Nessa página, o usuário pode preencher um formulário com título, ano de publicação, gênero e escolher um autor. A página inclui validação de campos e feedback visual, garantindo que todos os campos obrigatórios sejam preenchidos antes de submeter o formulário.
- **Lógica de Adição de Livros**: A funcionalidade de adicionar livros foi aprimorada, permitindo que o usuário adicione novos livros ao sistema de forma intuitiva. Isso inclui a seleção de um autor da lista e a inserção de detalhes do livro, com a validação de todos os dados inseridos.
- **Uso de FloatingActionButton**: O botão flutuante foi adicionado em várias telas para facilitar a adição de novos livros, melhorando a usabilidade e tornando a interface mais amigável ao usuário.

## Componentes Utilizados

- **Flutter**: Framework utilizado para desenvolvimento multiplataforma (mobile e web).
- **GoRouter**: Gerencia as rotas e navegação entre páginas de forma declarativa e dinâmica.
- **AdaptiveNavigationScaffold**: Responsável por adaptar a navegação para diferentes tamanhos de tela, alternando entre barra de navegação inferior e lateral.
- **TextFields e Dropdowns**: Componentes de formulário para entrada de dados como título, ano, gênero e autor do livro.

# Dados

## Dados importantes para a correção do checkpoint.

### Integrantes:

- **552364** - Ronald de Oliveira Farias
- **552466** - Gustavo Carvalho Noia
- **552228** - Vitor Teixeira Silva
- **551821** - Lucas Serbato de Barros
- **550687** - Phablo Isaias Silva Santos

## Link do Repositório:

[GitHub - CP5Mobile](https://github.com/Serbatinho/CP5Mobile)

