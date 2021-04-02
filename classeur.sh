#!/bin/bash

if [ $# -ne 2 ]; then
	echo "nb de paramètres nécessaire: 2. PATHIN et PATHOUT"
	exit -1
fi

PATHIN=$1
PATHOUT=$2

#vérifier les entrées

if [ ! -d "${PATHIN}" ]; then
	echo "le premier paramètre n'est pas un dossier ou n'existe pas: ${PATHIN}"
	exit -1
fi
if [ ! -d "${PATHOUT}" ]; then
	echo "le second paramètre n'est pas un dossier ou n'existe pas: ${PATHOUT}"
	exit -1
fi

#commande
mv ${PATHIN}/*.jpg ${PATHOUT}
echo "Les photos de ${PATHIN} ont été transférées vers  ${PATHOUT}"
