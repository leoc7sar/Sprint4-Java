🏍️ Sistema de Gestão de Motos em Galpões - Mottu

🚀 Proposta da Solução

O Sistema de Gestão de Motos em Galpões foi desenvolvido para atender à necessidade de controle e rastreabilidade de motocicletas e entregadores em um ambiente logístico, como um galpão ou centro de distribuição. A solução visa otimizar a gestão de ativos (motos), recursos humanos (entregadores) e processos financeiros (locações e pagamentos), fornecendo uma interface web segura e eficiente.

A proposta central é oferecer uma plataforma que centralize as seguintes funcionalidades:

1. Cadastro e Gestão de Motos: CRUD completo para motos, incluindo informações como placa, modelo, ano e status.

2. Cadastro e Gestão de Entregadores: CRUD para entregadores, com dados essenciais para a operação.

3. Gestão de Locações: Registro de abertura e fechamento de locações de motos por entregadores, garantindo a rastreabilidade.

4. Gestão de Pagamentos: Controle dos pagamentos relacionados às locações.

5. Segurança: Autenticação e autorização robustas para proteger o acesso aos dados.

🛠️ Decisões de Design e Escolhas Tecnológicas

A arquitetura do projeto segue o padrão MVC (Model-View-Controller), amplamente adotado em aplicações web, e é implementada utilizando o ecossistema Spring Boot, o que garante um desenvolvimento rápido e uma aplicação robusta e escalável.

Tabela de Tecnologias Chave e Justificativas

Categoria
Tecnologia
Versão
Justificativa da Escolha
Backend
Spring Boot
3.3.3
Framework líder de mercado para Java, oferece convenção sobre configuração, facilitando o setup e a execução da aplicação.
Persistência
Spring Data JPA
Integrado
Simplifica a implementação da camada de acesso a dados (Repository), reduzindo o código boilerplate e aplicando o padrão Repository.
Banco de Dados
H2 (Dev) / PostgreSQL (Prod)
-
H2 para desenvolvimento e testes em memória (agilidade). PostgreSQL para produção (robustez, escalabilidade e conformidade com SQL padrão).
Migração de DB
Flyway
Integrado
Gerencia o versionamento do esquema do banco de dados de forma segura e incremental, essencial para ambientes de CI/CD e para manter a integridade dos dados.
Segurança
Spring Security
Integrado
Solução de segurança de nível empresarial, provendo autenticação (login) e autorização (perfis ADMIN e USUARIO) de forma declarativa e robusta.
Frontend
Thymeleaf
Integrado
Motor de template Server-Side Rendering (SSR), que permite a construção de interfaces dinâmicas utilizando HTML puro, facilitando a integração com o backend Spring.
Build
Maven
3.9.6
Ferramenta padrão para gerenciamento de dependências e ciclo de vida do projeto Java.


✨ Originalidade e Criatividade

A originalidade do projeto reside na integração coesa de múltiplos domínios de negócio (ativos, logística e financeiro) em uma única plataforma com foco na rastreabilidade.

• Rastreabilidade Completa: A modelagem de dados conecta Entregadores, Motos, Locações e Pagamentos, permitindo consultas complexas sobre o histórico de uso de cada moto e o desempenho de cada entregador.

• Segurança por Perfil: A implementação de perfis de acesso (ADMIN e USUARIO) com o Spring Security garante que apenas usuários autorizados possam realizar operações críticas (como o CRUD completo de motos e entregadores), enquanto outros podem apenas visualizar ou realizar ações específicas (como abrir/fechar locações).

• Infraestrutura como Código (Dockerfile): A inclusão de um Dockerfile para o build multi-stage demonstra a preocupação com a deployabilidade e a padronização do ambiente, um diferencial de maturidade em projetos de software.

📚 Aplicação de Outras Disciplinas

O desenvolvimento desta solução exigiu a aplicação prática de conhecimentos adquiridos em diversas disciplinas:

Disciplina
Conceitos Aplicados
Demonstração no Projeto
Programação Orientada a Objetos (POO)
Encapsulamento, Herança, Polimorfismo, Classes e Objetos.
Implementação das classes de domínio (Moto, Entregador, Locacao, Pagamento) e seus respectivos DTOs, seguindo o princípio de Domain-Driven Design.
Estrutura de Dados e Algoritmos
Estruturas de dados para coleções e otimização de consultas.
Uso eficiente de coleções em Java (Listas, Streams) e a criação de índices no banco de dados (Flyway V4) para otimizar o desempenho das consultas.
Banco de Dados (SQL)
Modelagem Relacional, Normalização, DDL e DML.
Criação do esquema do banco de dados (tabelas motos, entregadores, locacoes, pagamentos) e scripts de seed (Flyway V2 e V3) para popular o sistema com dados iniciais.
Engenharia de Software
Padrão MVC, Versionamento de Código (Git), Testes Unitários (Mocks e skipTests no Maven), e o uso de ferramentas de build (Maven).
Organização do código em camadas (Controller, Service, Repository), uso de version control e a estrutura de projeto Spring Boot.
Segurança da Informação
Autenticação, Autorização, Criptografia de Senhas.
Implementação do Spring Security, uso de BCryptPasswordEncoder para criptografar senhas e controle de acesso baseado em papéis (ROLE_ADMIN, ROLE_USUARIO).


📝 Evidências e Documentação

A seguir, apresentamos as evidências que comprovam a implementação e o funcionamento da solução:

1. Estrutura de Código e Configuração

O projeto está estruturado de forma clara, separando as responsabilidades em pacotes:

• com.mottu.dominio: Classes de Entidade (Model)

• com.mottu.repositorio: Interfaces de Acesso a Dados (Spring Data JPA)

• com.mottu.servico: Camada de Regras de Negócio (Service)

• com.mottu.web: Controladores (Controller)

• com.mottu.seguranca: Classes de Segurança e Usuários

• com.mottu.configuracao: Configurações do Spring Security

2. Scripts SQL (Flyway)

Os scripts de migração do Flyway garantem a criação e o preenchimento inicial do banco de dados:

• V1__criar_tabelas.sql: Contém o DDL para as tabelas principais (motos, entregadores, locacoes, pagamentos).

• V2__seguranca_e_seed.sql: Cria as tabelas de segurança (usuarios, papeis, usuarios_papeis) e insere os usuários iniciais (admin/123 e usuario/123).

• V3__dados_exemplo.sql: Insere dados de exemplo para motos, entregadores e locações.

• V4__indices.sql: Cria índices para otimizar consultas no banco de dados.

3. Dockerfile (Infraestrutura)

O Dockerfile (disponível na raiz do projeto) permite a conteinerização da aplicação, facilitando o deploy em qualquer ambiente Docker:

```dockerfile

Exemplo de Dockerfile para build multi-stage

FROM maven:3.9.6-eclipse-temurin-17 AS build WORKDIR /app COPY pom.xml . RUN mvn dependency:go-offline -B COPY src ./src RUN mvn clean package -DskipTests FROM eclipse-temurin:17-jre-alpine WORKDIR /app COPY --from=build /app/target/mottu-1.0.0.jar app.jar EXPOSE 8080 ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=dev"] ```

4. Protótipos e Interface (Thymeleaf)

A interface do usuário é construída com Thymeleaf, utilizando o arquivo fragmentos/layout.html para manter a consistência visual. Páginas como moto/form.html e entregador/lista.html demonstram a implementação do CRUD e a navegação entre as funcionalidades.

⚙️ Como Executar o Projeto

Pré-requisitos

•
Java 17+

•
Maven 3.6+

Execução Local

1.
Clone o repositório: ```bash git clone [URL_DO_SEU_REPOSITORIO] cd mottu_project/mottu_project/mottu_project ```

2.
Compile e execute: ```bash mvn clean install java -jar target/mottu-1.0.0.jar ```

3.
Acesse a aplicação: Abra seu navegador e acesse http://localhost:8080.

4.
Credenciais de Teste:

•
Admin: admin / 123

•
Usuário: usuario / 123



Execução com Docker

1.
Construa a imagem: ```bash docker build -t mottu-app . ```

2.
Execute o container: ```bash docker run -p 8080:8080 mottu-app ```

3.
Acesse a aplicação: Abra seu navegador e acesse http://localhost:8080.




Desenvolvido por Leonardo Cesar, Rodrigo Mantovanello e Gustavo Camargo


