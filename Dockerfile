FROM maven:3.8.3-openjdk-17 as buildstage
RUN mkdir /opt/note
WORKDIR /opt/note
COPY . .
RUN mvn clean package -Dmaven.test.skip=true

FROM openjdk:17
RUN mkdir /opt/note
WORKDIR /opt/note
COPY --from=buildstage /opt/note/target/poc-bullla-1.0.0.jar app.jar
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar","app.jar"]
