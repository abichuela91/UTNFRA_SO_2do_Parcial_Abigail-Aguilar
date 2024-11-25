#!/bin/bash
#
ARCHIVO_USUARIOS="/home/aguilarabigail/UTN-FRA_SO_Examenes/202406/bash_s
cript/Lista_Usuarios.txt"

USUARIO_BASE="aguilarabigail"
if [ ! -f "$ARCHIVO_USUARIOS" ];then
	echo "Error: nose encontro el archivo $ARCHIVO_USUARIOS."
       	exit 1
	fi

CLAVE_BASE=$(sudo grep "^$USUARIO_BASE:" /etc/shadow | awk -f ':' '{prin
t $2}')
         if [ -z "$CLAVE_BASE" ]; then
         echo "Error: No se encontro la clave del usuario $USUARIO_BASE."
	 exit 
	 fi


while IFS=','read -r USUARIO GRUPO DIRECTORIO; do [[ "$USUARIO" =~ ^#.*$
|| -z "$USUARIO" ]] && continue
         if ! grep -q "^$GRUPO:" etc/group;then
         sudo groupadd "$GRUPO"
         echo "Grupo $GRUPO" creado."
         fi

         if ! id "$USUARIO" &>/dev/null; then
         sudo useradd -m -s /bin/bash -g "$GRUPO" -d "$DIRECTORIO" -p "$CLAVE_BASE" "USUARIO"
         echo "Usuario $USUARIO creado con grupo $GRUPO y directorio $DIRECTORIO."
         fi
	 
         done < "$ARCHIVO_USUARIOS"



