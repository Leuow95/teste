# README

## Sobre o Projeto

Este projeto é uma API RESTful desenvolvida utilizando o framework **Vaden** [[4]], uma ferramenta para criação de aplicações backend em **Dart** que traz uma experiência familiar para desenvolvedores que já trabalharam com frameworks como o **Spring Boot**. O Vaden simplifica a criação de APIs, oferecendo recursos modernos e prontos para uso, como integração com banco de dados, geração automática de documentação e suporte a injeção de dependência.

A API implementada neste projeto gerencia produtos (!Product!), permitindo operações CRUD (Create, Read, Update, Delete) através de rotas bem definidas. Além disso, o framework **Vaden** já inclui um **Swagger UI** integrado por padrão, facilitando a visualização e teste das rotas diretamente no navegador.

---

## Requisitos do Projeto

Para executar este projeto, você precisará de:

1. **PostgreSQL**: Um banco de dados PostgreSQL configurado conforme as informações abaixo.
2. **Dart SDK**: Certifique-se de que o Dart está instalado em sua máquina. Você pode baixá-lo [aqui](https://dart.dev/get-dart).

### Configuração do Banco de Dados

O projeto utiliza o banco de dados **PostgreSQL** para persistir os dados. Certifique-se de que o banco de dados esteja configurado corretamente com os seguintes parâmetros, conforme o arquivo !application.yaml!:

!postgres:
  host: 0.0.0.0
  password: '123456'
  database: banco_teste
  port: 5432
  username: admin
  ssl: disable!

Certifique-se de que a tabela !products! exista no banco de dados. Você pode criá-la executando o seguinte comando SQL:

!CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price NUMERIC(10, 2) NOT NULL
);!

---

## Rotas da API

O projeto implementa as seguintes rotas para gerenciar produtos:

### 1. **Listar Todos os Produtos**
- **Rota**: !GET /v1/product/all!
- **Descrição**: Retorna uma lista de todos os produtos cadastrados no banco de dados.
- **Resposta**:
  - !200!: Lista de produtos.
  - Exemplo:
    ```json
    [
      {
        "id": 1,
        "name": "Laptop",
        "price": 1200.99
      },
      {
        "id": 2,
        "name": "Smartphone",
        "price": 899.99
      }
    ]
    ```

### 2. **Buscar Produto por ID**
- **Rota**: !GET /v1/product/<id>!
- **Descrição**: Retorna os detalhes de um produto específico com base no ID fornecido.
- **Resposta**:
  - !200!: Detalhes do produto.
  - !404!: Produto não encontrado.
  - Exemplo:
    ```json
    {
      "id": 1,
      "name": "Laptop",
      "price": 1200.99
    }
    ```

### 3. **Criar um Novo Produto**
- **Rota**: !POST /v1/product/!
- **Descrição**: Cria um novo produto no banco de dados.
- **Corpo da Requisição**:
  ```json
  {
    "name": "Tablet",
    "price": 499.99
  }