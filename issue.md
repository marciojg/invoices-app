## Husky challenge!

### Problema:
Desenvolver um gerador de invoices.

### Escopo:
O sistema terá duas interfaces sendo uma Web (HTML, CSS, JS) e a outra API (Ex: REST).

### Web:
Visitante (usuário não logado)
Para fazer uso do sistema o usuário precisará de um token. Ou seja, ao acessar a aplicação na versão WEB ele deverá ver duas opções:

### Gerar token de acesso
Login via token
Gerar token de acesso

Esse é o processo que deverá criar um usuário no sistema, sendo que para gerar o token de acesso o usuário deverá fornecer seu email. Após submeter o form, informe que o usuário precisará acessar o email para ativar sua conta.

No conteúdo do e-mail deverá ter um link que ativará o token e fará login do usuário logo em seguida.

### Login via token

Apresentará um campo texto para o token e um botão para submeter o form e então acessar o sistema. Sendo que o usuário só poderá entrar no sistema caso o token seja válido.

### Esqueci minha senha
Nesse sistema não haverá esse recurso, se necessário o usuário poderá usar o recurso de gerar token para esse propósito. Se um usuário gerar um novo token, o token antigo só será invalidado caso o mesmo faça uso do novo link de ativação (que foi enviado por email).

*Usuário (fez login via token)*

As funcionalidades previstas são:

- Listar invoices (Filtros: número da invoice, data)
- Visualizar invoice
- Criar e enviar invoice
- Logout

*Criar e enviar invoice*

Esse sistema é extremamente básico, ou seja, para criar uma invoice serão necessários os seguintes campos:

- Número da Invoice
- Data
- Empresa (textarea para receber os dados da empresa que está emitindo a invoice)
- Cobrança para (textarea para adicionar os dados de quem receberá a cobrança)
- Valor total
- Emails (para enviar a Invoice aos responsáveis pela cobrança)

Ao criar a invoice, o usuário será redirecionado para tela de visualização que apresentará todos os dados da invoice mais um alerta informando que a mesma foi enviada para os emails informados na criação.

*Envio de invoices:*

As invoices deverão ser enviadas por email com:

- Corpo de e-mail
  - Link para visualização
- Anexo
  - Versão da invoice como PDF

*Visualização da invoice*

- Apresentar todos os dados da invoice.
- Ação:
  - Download da invoice como PDF.
  - Se logado
    - O usuário poderá enviar a invoice para novos emails.

### API:

Usará o token de acesso como autenticação e deverá conter os seguintes endpoints:

- Listar invoices (Filtros: número da invoice, data)
- Visualizar invoice
- Criar e enviar invoice
- Enviar invoices para novos emails

### Solução

Além do código, queremos receber um racional do que foi feito (porque priorizou A em vez de B), como foi feito (gems, patterns, paradigmas...) e do que poderia ser melhorado. Registre isso em um README.
Use isso a seu favor: Você não precisa fazer tudo, mas o que fizer faça bem feito. Defina um escopo que possa vender bem o teu peixe e que se adeque a disponibilidade / prazo que você tem para realizar o teste.

### Expectativas:

- Utilize Ruby on Rails;
- Escreva testes automatizados;
- Faça commits atômicos e progressivos;
- Documente a API;
- Trabalhe a separação de responsabilidades na aplicação;
- Trabalhe a representação dos conceitos, faça uso de bons nomes em variáveis, métodos, classes, módulos/- namespaces;
- Trabalhe requisitos não funcionais como: segurança, performance, disponibilidade, confiabilidade, observabilidade, manutenibilidade.
- Contexto: O que utilizamos / fazemos na Husky.
- Ruby 2.7 e Rails 6.0, estamos nos preparando para atualizar ambos. Então pedimos que teu teste use dessas versões para cima.

Fazemos uso de casos de uso para encapsular as regras de negócio. Ou seja, nós não implementamos o código diretamente nos controllers, models, jobs. Todo ponto de entrada delega a operação para um caso de uso.

Testes: Rspec, factory bot, shoulda matchers.

Namespaces: Curtimos muito modularizar o código, ao agrupar classes, módulos, constantes que tenham relação ao conceito / domínio que representam.

Bons nomes para métodos, constantes (classes e módulos), namespaces.

Garanta que o setup seja fácil e que tanto a aplicação quanto o teste rodem. Pode não parecer, mas recebemos diversos testes que ao fazer o git clone e realizar o setup o projeto não rodava de primeira. Nosso time teve de ajustar N entregas para conseguir avaliar o que foi feito (mas isso não é legal e tira pontos de quem aplicou).

PS: Sinta-se a vontade para apresentar sugestões, práticas na qual você acredita serem melhores. ;)
