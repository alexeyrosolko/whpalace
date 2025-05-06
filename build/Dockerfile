FROM alpine/java:22-jre
COPY wh-0.0.1-SNAPSHOT.jar /usr/src/wh/wh-0.0.1-SNAPSHOT.jar
RUN chmod 755 /usr/src/wh
WORKDIR /usr/src/wh
EXPOSE 8080
#CMD ["java", "-jar", "/usr/src/wh/wh-0.0.1-SNAPSHOT.jar", "--spring.profiles.active=container"]
CMD ["java", "-jar", "/usr/src/wh/wh-0.0.1-SNAPSHOT.jar"]
#CMD ["java", "--version"]
#CMD ["ip",
