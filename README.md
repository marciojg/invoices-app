### Execução

Ao clonar o projeto, vá até a pasta raiz do projeto e execute:

```bash
  docker-compose up -d
```

Com isso a aplicação já estará de pé, respondendo no endereço: `http://localhost:3030`. O servidor de email local vai responder no endereço `http://localhost:1080`.

A documentação a seguir deve ajudar a testar:

- [Postman collection](backend/public/doc/postman_collection.json)
- [Swagger HTML arquivo](backend/public/doc/openapi.html)
- [Swagger Link](http://localhost:3030/api-doc)

### Testes

Para rodar os testes, basta executar:

```bash
  docker-compose run --rm backend rspec
```

### Covertura de código

![code-coverage](backend/public/coverage.png "Code Coverage")

### Solução:

Priorizei o backend e o uso da gem `u-case` para testa-la principalmente pois ela permite uma arquitetura orientada a caso de uso, deixando o código mais preparado para evolução e testes isolados.

### Coisas que podem melhorar

- Transferir validações do modelo para os casos de uso, tive dificuldade de lidar com os testes manuais `validate: method`.
- Remover duplicações de casos de uso.
- Implementar serializers
- Serializar erros específicos e tratar com mais carinhos os status code em caso de erro.
- Remover sobrescrita do método `attributes` de um `Micro::Case`, foi necessários pq não vejo o pq retornar um hash usando string como chave e sugerir essa feature na gem.
- Evitar uso de cookie de sessão para melhorar a segurança.
