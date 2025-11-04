# Etapa 1: Build da aplicação usando Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
 
# Copia o pom.xml e baixa as dependências primeiro (para melhor cache)
COPY pom.xml .
# O projeto usa Flyway, que executa scripts SQL na inicialização.
# O comando 'mvn dependency:go-offline -B' é suficiente para baixar as dependências.
RUN mvn dependency:go-offline -B
 
# Copia o código fonte e faz o build
COPY src ./src
# O projeto usa Spring Boot 3.3.3, que requer Java 17.
# O build deve ser feito com o profile 'dev' ou sem especificar, pois o 'prod' usa PostgreSQL.
RUN mvn clean package -DskipTests
 
# Etapa 2: Imagem final (mais leve)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
 
# Copia o JAR gerado da etapa anterior. O nome do JAR é mottu-1.0.0.jar.
COPY --from=build /app/target/mottu-1.0.0.jar app.jar
 
# Expõe a porta padrão do Spring Boot
EXPOSE 8080
 
# Comando de inicialização
# Usamos o profile 'dev' que utiliza o banco de dados H2 em memória.
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=dev"]
