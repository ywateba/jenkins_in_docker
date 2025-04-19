services:
  jenkins:
    image: jenkins/jenkins:lts # Use the LTS Jenkins image
    container_name: jenkins # Give your container a name
    ports:
      - 8080:8080 # Map host port 8080 to container port 8080 (Jenkins web UI)
      - 50000:50000 # Map host port 50000 to container port 50000 (Jenkins agents)
    volumes:
      - jenkins_home:/var/jenkins_home # Use a named volume for Jenkins data
      - /var/apps:/home/jenkins/apps # Mount your local Git repo
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker
    environment:
      - JENKINS_HOME=/var/jenkins_home #Explicitly set the Jenkins Home
      - JAVA_OPTS=-Dhudson.plugins.git.GitSCM.ALLOW_LOCAL_CHECKOUT=true
    restart: always #Restart Jenkins on reboot
    networks:
      - jenkins_network

volumes:
  jenkins_home: # Declare the named volume

networks:
  jenkins_network:
    driver: bridge
