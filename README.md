
# Survey API Application

[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-red)](https://www.ruby-lang.org/en/)
[![Rails](https://img.shields.io/badge/Rails-7.1.3.4-red)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14.0-blue)](https://www.postgresql.org/)
[![GraphQL](https://img.shields.io/badge/GraphQL-API-pink)](https://graphql.org/)
[![RSpec](https://img.shields.io/badge/RSpec-4.0-green)](https://rspec.info/)

## 📘 Descrição do Projeto

A Survey API Application é uma aplicação backend desenvolvida em Ruby on Rails com GraphQL e PostgreSQL. Seu objetivo é fornecer uma API para criação, condução e visualização de pesquisas, retornando dados em formato JSON. A aplicação não possui interface de usuário e foi projetada para ser consumida via ferramentas como o Postman. O projeto é testado com RSpec para garantir a qualidade do código e a cobertura de testes.

## ⚙️ Estrutura do Projeto

### 1. Configuração do Ambiente de Desenvolvimento

- **Ruby e Rails**: O ambiente foi configurado com Ruby e Rails para o desenvolvimento da aplicação.
- **PostgreSQL**: Configurado como banco de dados principal, com detalhes de conexão definidos no arquivo `database.yml`.
- **GraphQL**: Utilizado para construir a API, permitindo interações flexíveis e eficientes.
- **RSpec**: Configurado para escrita de testes unitários e de integração.

### 2. Funcionalidades Principais

#### 2.1. Criação de Pesquisas

- **Modelos e Relacionamentos**: Implementação dos modelos `Survey`, `Question` e `Option` com relacionamentos e validações adequadas.
- **API GraphQL**: Definição de tipos GraphQL para pesquisas, perguntas e opções, incluindo mutations para criação e atualização.

#### 2.2. Responder Pesquisas

- **API GraphQL**: Implementação de mutations para que os usuários respondam às perguntas das pesquisas.
- **Validações**: Regras de negócio para garantir que respostas sejam válidas e de acordo com as regras definidas.

#### 2.3. Visualização de Resultados

- **API GraphQL**: Queries para buscar e filtrar os resultados das pesquisas.
- **Filtros**: Implementação de filtros para facilitar a visualização dos dados com base em critérios como data e usuário.

#### 2.4. Gerenciamento de Pesquisas

- **Administração**: Coordenadores de Pesquisa podem criar, editar, reorganizar e excluir perguntas.
- **Autenticação e Autorização**: Implementação de autenticação para coordenadores, garantindo acesso restrito às funções administrativas.

### 3. Testes e Qualidade

- **Testes Unitários e de Integração**: Implementados com RSpec
- **Integração Contínua**: Configuração de um pipeline CI/CD com GitHub Actions, garantindo testes automatizados e deploy contínuo.

## 🚀 Instalação

### Pré-requisitos

- **Ruby 3.3.0** e **Rails 7.1.3.4** instalados.
- **PostgreSQL** configurado e em execução.
- **Redis** para suporte ao Sidekiq (se necessário).

### Passo a Passo

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/survey-api-application.git
   cd survey-api-application
   ```

2. **Instale as dependências:**
   ```bash
   bundle install
   yarn install
   ```

3. **Configure o banco de dados:**
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Inicie o servidor Rails:**
   ```bash
   rails server
   ```

5. **Acesse a aplicação via Postman ou outra ferramenta em** `http://localhost:3000/graphql`.

## ✅ Testes

Para executar os testes automatizados, utilize o seguinte comando:
```bash
bundle exec rspec
```

