#!/bin/bash

#---------------
#Initialisation des variables et gestion des options
#---------------
FORCE=0
DELIMITER_IN='\t'
DELIMITER_OUT=';'
QUOTECHAR_IN='\"'
QI_ACTIVE=0
QUOTECHAR_OUT='\"'

while [ $# -gt 2 ]
do
	echo "args $@"
	case "$1" in
		-f) 	FORCE=1  
			echo "option -f activée";;
		-di)	DELIMITER_IN=$2
			shift
			echo "option -di activée";;
		-do)	DELIMITER_OUT=$2
			shift
			echo "option -do activée";;
		-qi)	QUOTECHAR_IN=$2
			QI_ACTIVE=1
			shift
			echo "option -qi activée";;
		-qo) 	QUOTECHAR_OUT=$2
			shift
			echo "option -qo activée";;
		*) echo "option inconnue : $1"
			exit -1;;
	esac
	shift
done

echo "------ RECAP ------"
echo "Force mode: ${FORCE}"
echo "Delimiter in: ${DELIMITER_IN}"
echo "Delimiter out: ${DELIMITER_OUT}"
echo "Quote char IN: ${QUOTECHAR_IN}"
echo "Quote char OUT: ${QUOTECHAR_OUT}"
echo "args: $@"

#Vérifier la présence de deux paramètres
if [ $# -ne 2 ]; then
	echo "nombre de paramètres incorrect: 2 attendus"
	exit -1
fi

FILENAMEIN=$1
FILENAMEOUT=$2

#Vérifier que le 1er paramètre est un fichier existant

if [ ! -f "${FILENAMEIN}" ]; then
	echo "le premier paramètre n'est pas un fichier: ${FILENAMENIN}"
	exit -1
fi

#Vérifier que le 2nd paramètre n'est pas un fichier existant
if [ -e "${FILENAMEOUT}" ]; then
	if [ "${FORCE}" -eq 0 ]; then
		echo "Le fichier de sortie existe déjà: ${FILENAMEOUT}, utiliser -f pour écraser"
		exit -1
	fi
fi

echo "---test quote char in----"
echo "OUT : ${QUOTECHAR_OUT}"

if [ "${QI_ACTIVE}" -ne 0 ]; then
	QUOTECHAR_OUT="${QUOTECHAR_IN}"
fi
echo "OUT CHANGED ? ${QUOTECHAR_OUT}"

echo ${FILENAMEIN}
echo ${FILENAMEOUT}

# Transforme le fichier FILENAMEIN en FILENAMEOUT
# cat ${FILENAMEIN} | sed -r -e "s/([^\t]*;[^\t]*)/\"\1\"/g" -e "y/\t/;/" > ${FILENAMEOUT}
cat ${FILENAMEIN} | sed -r -e "s/([^${DELIMITER_IN}]*${DELIMITER_OUT}[^${DELIMITER_IN}]*)/${QUOTECHAR_OUT}\1${QUOTECHAR_OUT}/g" \
	-e "y/${DELIMITER_IN}/${DELIMITER_OUT}/" > ${FILENAMEOUT}


