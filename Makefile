transform:
	java -jar saxon9he.jar -o:output/partie1.html Corpus/Andromaque_c.xml Xpath_FondamentauxXSLT/XSL_HTML_step1.xsl;
	java -jar saxon9he.jar -o:output/partie2.html Corpus/Andromaque_c.xml XSLT_Publication/XSL_HTML_step2-4.xsl;
	java -jar saxon9he.jar -o:output/partie3.html Corpus/Andromaque_c.xml Partie_3/xsl_etape_3.xsl;

