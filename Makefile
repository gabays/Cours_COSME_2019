transform: 1

1: 
	java -jar saxon9he.jar -o:Partie_1/partie1.html Corpus/Andromaque_c.xml chemin_fichier_Ariane.xsl;
	java -jar saxon9he.jar -o:Partie_2/partie2.html Corpus/Andromaque_c.xml chemin_fichier_Simon.xsl;
	java -jar saxon9he.jar -o:Partie_3/partie3.html Corpus/Andromaque_c.xml Partie_3/xsl_etape_3.xsl;
