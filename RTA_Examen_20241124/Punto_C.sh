#!/bin/bash
#despues de haber instalado Docker se accede con usuario y token generado
docker login -u milka445
Password:  
#se genera una imagen docker 
docker build -t milka445/web1aguilar:latest .
# se modifica el archivo index.html
 vim index.html
 # se crea un archivo dockerfile y se lo edita 

touch Dockerfile
vim Dockerfile
#FROM nginx:latest
#COPY index.html /usr/share/nginx/html
 
docker image list
# con este comando se publica
docker push milka445/web1aguilar:latest 
# se crea y se edita un archivo run.sh
touch run.sh
vim run.sh
# dentro del editor se coloca la linea de ejecucion
#docker run -d -p 8080:80 milka445/web1aguilar:latest
sudo chmod 764 run.sh # se cambia los permisos al archivo run.sh
./run.sh # se ejecuta el comando
docker ps
docker pull milka445/web1aguilar

