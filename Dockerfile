# fetch basic image
FROM maven:3.3.9-jdk-8

# application placed into /opt/app
RUN mkdir -p /opt/app
WORKDIR /opt/app

# selectively add the POM file and
# install dependencies
COPY pom.xml /opt/app/
RUN mvn install

# rest of the project
COPY src /opt/app/src
RUN mvn package

# local application port
EXPOSE 8080

# as per heroku docs https://devcenter.heroku.com/articles/container-registry-and-runtime#run-the-image-as-a-non-root-user
#RUN useradd -m myuser
#USER myuser

# as per heroku docs https://devcenter.heroku.com/articles/container-registry-and-runtime#get-the-port-from-the-environment-variable
#CMD gunicorn --bind 0.0.0.0:$PORT wsgi

# execute it
CMD ["mvn", "exec:java"]