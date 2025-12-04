# ----- Stage 1 building JAR file -----

FROM maven:3.8.3-openjdk-17 AS builder

# Making working directory

WORKDIR /app

# Copying source code file to directory

COPY . /app

# Building JAR file

RUN mvn clean install -DskipTests=true

# ----- Stage 2 app build-----

# Using Small Image for running app

FROM eclipse-temurin:17-jdk-alpine

# Creating a WorkDirectory

WORKDIR /app

# Copying JAR file from Stage 1 to WorkDirectory

COPY --from=builder /app/target/*.jar /app/target/expenseapp.jar

# Running the java Command to run the build

CMD ["java", "-jar", "/app/target/expenseapp.jar"] 
