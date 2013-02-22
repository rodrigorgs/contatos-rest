Este um web service baseado em [REST](http://en.wikipedia.org/wiki/representational_state_transfer) para listar, inserir, modificar e remover contatos telefônicos. O propósito é servir como exemplo para quem deseja criar o seu próprio.

O código está em Ruby, usando o [Sinatra](http://www.sinatrarb.com/) para lidar com requisições HTTP e o [DataMapper](http://datamapper.org/getting-started.html) para lidar com o banco de dados.

Quer saber como rodar este web service sem instalar nada no computador e sem gastar nenhum tostão? Continue lendo...

# Pré-requisitos

* Crie uma conta gratuita no [GitHub](https://github.com/).
* Use sua conta do GitHub para acessar o [Cloud9 IDE](https://c9.io/).
* Crie uma conta gratuita no [Heroku](http://www.heroku.com/) (opcional).

# Criando sua cópia deste projeto

Acesse o [repositório deste projeto no GitHub](https://github.com/rodrigorgs/contatos-rest) e clique no botão `Fork` (canto superior direito da página). Isso vai criar uma cópia do repositório na sua conta do GitHub. O endereço deve ser algo do tipo <https://github.com/SEU-NOME-DE-USUÁRIO/contatos-rest>.

# Configurando o projeto do Cloud9 IDE

Entre no [Cloud9 IDE](https://c9.io/) usando sua conta do GitHub.

Na barra lateral, embaixo de `Projects on GitHub`, clique no projeto `contatos-rest` e então clique no botão `Clone to Edit`. Depois de um tempo, o projeto deve aparecer sob `My Projects`. Clique nele e então clique no botão `Start Editing`.

Abra o `Console`, na parte de baixo da tela, e digite

    bundle install
   
Isso vai baixar e instalar todas as dependências do projeto. Pode demorar alguns minutos.

# Rodando no Cloud9 IDE

Abra o arquivo `server.rb` (dê dois cliques). Clique no botão `Run`, no topo da tela.

Observe as mensagens que aparecem embaixo, na aba `Output`. Se não houver nenhum erro, deve aparecer uma mensagem parecida com a seguinte:

    Your code is running at 'http://contatos-rest.SEU-USUARIO.c9.io'.
    Important: use 'ruby app.rb -p $PORT -b $IP' to run your server apps!
    == Sinatra/1.3.3 has taken the stage on 8080 for development with backup from Thin

Observe a URL que apareceu na mensagem. Este é o endereço de seu web service. Abra-o em uma nova aba de seu navegador. Se o resultado for `Hello World`, é porque deu tudo certo.

# Usando o web service

Você pode ver a lista de contatos acessando o endereço do web service seguido de `/contatos` (exemplo: <http://contatos-rest.SEU-USUARIO.c9.io/contatos>). Inicialmente você não tem nenhum contato, então o resultado deve ser

    []

Para outros tipos de requisição (inserir contato, remover contato etc.) você vai precisar de um cliente REST. Eis algumas opções:

* [apigee console](apigee.com/console/others): cliente online, não precisa instalar nada
* [Simple REST Client](https://chrome.google.com/webstore/detail/simple-rest-client/fhjcajmcbmldlhcimfajhfbgofnpcjmb): extensão para o navegador Chrome
* [RESTClient](https://addons.mozilla.org/en-us/firefox/addon/restclient/): extensão para o navegador Firefox

Eis as requisições atendidas por este web service:

* `GET /contatos` - lista todos os contatos
* `GET /contatos/5` - lista o contato com id = 5
* `POST /contatos` - insere um contato
  * Corpo: `{"nome": "Fulano", "telefone": "555-555"}`
* `PUT /contatos/5` - modifica o contato com id = 5
  * Corpo: `{"nome": "Fulano", "telefone": "555-555"}`
* `DELETE /contatos/5` - remove o contato com id = 5

# Entendendo o código-fonte

Se você quiser adaptar o código-fonte para o seu próprio web service, basta editar o arquivo `contatos.rb`. Ele contém a definição do banco de dados e o comportamento do web service para cada requisição HTTP.

Outros arquivos importantes:

* `server.rb`: configurações gerais de banco de dados, servidor web etc. No final, ele referencia o arquivo `contatos.rb`. Você pode editar este arquivo para incluir outros arquivos `.rb`.
* `Gemfile` e `Gemfile.lock`: descrevem as dependências do projeto. São usados pelo comando `bundle install`. Não precisa mexer.
* `Procfile`: necessário para o Heroku saber como rodar o seu programa. Não precisa mexer.

# Rodando no Heroku (opcional mas recomendado)

Rodar o web service no Cloud9 IDE é conveniente para fazer alguns testes, mas se você pretende usar seu web service pra valer, é melhor usar um servidor mais robusto, como o Heroku.

## Configurando um app

Primeiro vamos criar um app no Heroku (i.e., um servidor web) e configurar o Cloud9 IDE para fazer deploy nesse app (i.e., instalar nosso web service no Heroku). Tudo pode ser feito pelo Cloud9 IDE:

1. Clique no balão (deploy).
2. Então clique no + para adicionar um app
3. Escolha Heroku.com. 
4. Clique em "Sign in to Heroku"
5. Preencha seu e-mail e senha do Heroku e clique em Sign-in
6. Ao lado de "Your Heroku apps", clique em Create new.
7. Selecione o app recém criado e clique no botão Add.

A seguir, vamos criar um banco de dados Postgres no Heroku e configurar nosso app para usá-lo:

1. Abra a página <https://dashboard.heroku.com/apps/>
2. Clique sobre seu app.
3. Embaixo de Add-ons, clique em `Get Add-ons`
4. Na página que se abre, escolha Heroku Postgres (na seção Data Stores).
5. Na parte de baixo, selecione o seu app e clique em `Add Dev for Free`.

<!-- (Alternativa) (Onde se lê -app, insira mais um hífen no início)

Baixe e instale o Heroku Toolbelt, disponível em https://toolbelt.herokuapp.com/

Abra o terminal de seu computador e digita o seguinte comando:

    heroku login

Informe o e-mail e a senha de sua conta no Heroku. Então execute os seguintes comandos (troque `$NOME_DO_APP` pelo nome de seu app):

    heroku addons:add heroku-postgresql:dev -app $NOME_DO_APP
    heroku config -app $NOME_DO_APP | grep HEROKU_POSTGRESQL

O último comando vai retornar algo do tipo

    HEROKU_POSTGRESQL_RED_URL: postgres://user3123:passkja83kd8@ec2-117-21-174-214.compute-1.amazonaws.com:6212/db982398

Note que, em vez de `RED`, pode aparecer `GOLD`, `AMBER`, `COBALT` ou outra cor. Então execute a seguinte linha, trocando `RED` pela cor retornada pelo último comando:
    
    heroku pg:promote HEROKU_POSTGRESQL_RED_URL -app $NOME_DO_APP
-->

Mesmo depois de seguir esse procedimento, pode demorar até 5 minutos para o banco de dados ser efetivamente criado.

## Fazendo deploy no Heroku

Voltando ao Cloud9 IDE, clique no balão, então clique no app que você criou, e por fim clique no botão deploy. Se aparecer algum aviso, clique em Yes.

Se tudo der certo, acesse o endereço de seu app, que deve ser `http://$NOME_DO_APP.herokuapp.com/`. Se aparecer `Hello World` é porque funcionou! Se der erro 503, pode ser que o banco de dados ainda esteja sendo criado. Aguarde alguns minutos e tente novamente.

## Alterando o código-fonte

Se você fez alguma mudança no código-fonte do web service, você precisa seguir alguns passos antes de fazer um novo deploy no Heroku. Basicamente, você precisa dar um "commit" de suas mudanças.

Abra o console do Cloud9 IDE. Se você adicionou algum arquivo que deve ser enviado para o Heroku, digite

    git add nome_do_arquivo

Após adicionar todos os arquivos, digite

    git commit -am "Mensagem descrevendo sua mudança"

Opcionalmente, para enviar suas mudanças para o seu repositório no github, digite

    git push origin master

Depois disso, você pode realizar o deploy no Heroku pelo Cloud9 IDE.

<!-- 
Opção interessante para fazer deploy de GitHub para Heroku: https://deploybutton.com/
-->
