FROM maven:3.8.5-openjdk-17-slim as builder-jar

WORKDIR /app
COPY pom.xml /app/pom.xml
COPY src/ /app/src/

RUN mvn clean package -DskipTests

FROM ghcr.io/graalvm/native-image:ol8-java17-22.3.3 as builder-bin

WORKDIR /app

COPY --from=builder-jar /app/target/healthcheck.jar /app/healthcheck.jar

RUN native-image --static -jar healthcheck.jar healthcheck

FROM scratch as runner

COPY --from=builder-bin /app/healthcheck /app/healthcheck

ENTRYPOINT ["/app/healthcheck"]