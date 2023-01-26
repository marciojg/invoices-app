### Execução

Ao clonar o projeto, vá até a pasta raiz do projeto e execute:

```bash
  docker-compose up -d
```

Com isso a aplicação já estará de pé, respondendo no endereço: `http://localhost:3030`. A documentação a seguir deve ajudar a testar:

- [Postman collection](backend/public/doc/postman_collection.json)
- [Swagger HTML arquivo](backend/public/doc/openapi.html)
- [Swagger Link](http://localhost:3030/api-doc)

### Testes

Para rodar os testes, basta executar:

```bash
  docker-compose run --rm backend rspec
```

Para conferir a cobertura de 100% o arquivo de coverage está neste [path](backend/coverage/index.html) `backend/coverage/index.html`

### Solução:

O racional utilizado foi criar o máximo da regra de negócio primeiro, antes do requisitos não funcionais e frontend (que não rolou de fazer até nesse momento :0 ).

Primeiramente procurei executar cada passo produzindo código e teste, seguindo a lógica da camada mais interna para a camada mais externa. Fiz uso da gem `u-case` para auxiliar neste processo, e como a utilizei pela primeira vez, foi uma experiência interessante. Pois como já tinha interesse em testá-la, foi juntar o útil ao agradável. Anteriormente somente havia utilizado soluções mais caseiras para concentrar a lógica de negócios.

Procurei deixar o máximo de lógica de um caso de uso concentrada nos conjuntos de `Micro::Case`'s, onde o controller por exemplo teria a única responsabilidade de encaminhar params e renderizar json.

Sobre outras gems, destacaria as gems que me auxiliaram nos testes e qualidade de código como `rspec`, `shoulda-matchers`, `factory_bot_rails`, `rubocop` e `simplecov` que é sempre um prazer usar esse grupinho de gems. :)


### Coisas que podem melhorar

Do que está construído enxergo que é possível melhorar transferindo as validações do modelo para os casos de uso. Como precisei fazer algumas validações manuais vi que seria necessário reescrever/duplicar muito código pois iria precisar replicar algumas validações em mais de um `Micro::Case`. Como não gostei muito dessa abordagem preferi manter no modelo, mesmo que isso fira um pouco o conceito que a gem oferece.

Acredito também que seria interessante implementar serializers para evitar a exposição de atributos que não agregam o futuro front. Somente expõe regra de negócio sem necessidade. Mas neste primeiro momento julguei que da pra seguir de boa sem.

Pegando gancho nos serializers também acho que dá pra evoluir os tratamentos de erro para serem mais especialistas.
