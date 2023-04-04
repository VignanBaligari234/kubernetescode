# syntax=docker/dockerfile:1

FROM python:3.8-slim-buster

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
RUN apt-get update && apt-get install -y \
    sudo
RUN useradd -ms /bin/bash jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
RUN mkdir /home/jenkins/mydir && sudo chmod 777 /home/jenkins/mydir
COPY . .

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]
