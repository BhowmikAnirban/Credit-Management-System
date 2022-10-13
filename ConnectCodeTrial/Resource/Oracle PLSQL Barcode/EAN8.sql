-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_EAN8 AS

--Public Functions  
  FUNCTION ENCODE(data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION getEAN8PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION generateCheckDigitEAN8(data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_EAN8;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_EAN8 AS  

  FUNCTION generateCheckDigitEAN8(data IN VARCHAR2) RETURN VARCHAR2 IS
   datalength NUMBER:=Length(data);
   parity NUMBER:=0; 
   sumvalue INTEGER:=0;
   resultvalue INTEGER:=-1;
   strResult VARCHAR2(30):='';
   barcodechar VARCHAR2(1):='';
   barcodevalue NUMBER:=0;
  BEGIN
  
   FOR x IN 1..datalength 
   LOOP
	barcodechar:=SUBSTR(data,x,1);
	barcodevalue:=ASCII(barcodechar);
	barcodevalue:=barcodevalue - 48;
	IF parity=0 THEN
		sumvalue := sumvalue + (3*barcodevalue);
		parity:=1;
	ELSE
		sumvalue := sumvalue + barcodevalue;
		parity:=0;
	END IF;
   END LOOP;
   resultvalue := MOD(sumvalue,10);
   IF resultvalue = 0 THEN 
	resultvalue := 0;
   ELSE
	resultvalue := 10 - resultvalue;
   END IF;
   resultvalue := resultvalue+48;	
   strResult:=strResult || CHR(resultvalue);
 
   RETURN strResult;
 END generateCheckDigitEAN8;

 FUNCTION getEAN8PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN

	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 0;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 1;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 1;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 0;
	END IF;

	IF digit1=4 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=4 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=5 THEN
		RETURN 1;
	END IF;

	IF digit1=5 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=4 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=5 THEN
		RETURN 1;
	END IF;

	IF digit1=6 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=4 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=5 THEN
		RETURN 0;
	END IF;

	IF digit1=7 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=4 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=5 THEN
		RETURN 1;
	END IF;

	IF digit1=8 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=4 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=5 THEN
		RETURN 0;
	END IF;

	IF digit1=9 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=4 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=5 THEN
		RETURN 0;
	END IF;

	RETURN 0;
 END getEAN8PARITYMAP;

 FUNCTION ENCODE(data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   transformchar     VARCHAR2(1);
   weight       NUMBER := 1;
   transformvalue       NUMBER := 0;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chkvalue     NUMBER := 0;	
   lendiff      NUMBER := 0;
   cd           VARCHAR2(1);
   filtereddata VARCHAR2(255) := '';
   returndata   VARCHAR2(255) := '';
   resultdata   VARCHAR2(30) := '';
   filteredlength NUMBER(5) := Length(data);	
   paritybit    NUMBER:=0;
   firstdigit   NUMBER:=0; 
   datalength   NUMBER:=0;
   transformdataleft VARCHAR2(255):='';
   transformdataright VARCHAR2(255):='';
  BEGIN

   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   FOR counter IN 1..filteredlength
   LOOP
    tempchar := SUBSTR(data,counter,1);
    onevalue := ASCII(tempchar);
    IF onevalue >= 48 AND onevalue <=57 THEN 
	filtereddata := filtereddata || tempchar;
    END IF;
   END LOOP;

   filteredlength := Length(filtereddata);
   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength > 7 THEN
    filtereddata := SUBSTR(filtereddata,1,7);
   END IF;

   filteredlength := Length(filtereddata);
   IF filteredlength < 7 THEN
	lendiff:=7-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;

   cd:=generateCheckDigitEAN8(filtereddata);
   filtereddata:=filtereddata||cd;
   FOR x IN 1..4
   LOOP
	transformdataleft:=transformdataleft||SUBSTR(filtereddata,x,1);
   END LOOP;

   FOR x IN 5..8
   LOOP
	transformchar:=SUBSTR(filtereddata,x,1);
	transformvalue:=ASCII(transformchar)+49; 
	transformdataright:=transformdataright||CHR(transformvalue);
   END LOOP;
   	
   resultdata:='[' || transformdataleft || '-' || transformdataright || ']';
  
   RETURN resultdata;

 END ENCODE;

END CONNECTCODE_EAN8;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_EAN8.ENCODE('1234567'));
END;
/