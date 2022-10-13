-- Copyright 2006-2009 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_EXT2 AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION getEXT2PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
END CONNECTCODE_EXT2;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_EXT2 AS  

 FUNCTION getEXT2PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN

	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 1;
	END IF;

	RETURN 0;
 END getEXT2PARITYMAP;

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   transformchar     VARCHAR2(1);
   transformvalue       NUMBER := 0;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   value1     NUMBER := 0;	
   value2     NUMBER := 0;	
   lendiff      NUMBER := 0;
   filtereddata VARCHAR2(255) := '';
   resultdata   VARCHAR2(30) := '';
   filteredlength NUMBER(5) := Length(data);	
   parityindex    NUMBER:=0;
   paritybit    NUMBER:=0;
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
   IF filteredlength > 2 THEN
    filtereddata := SUBSTR(filtereddata,1,2);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength < 2 THEN
	lendiff:=2-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;

   sumvalue:=0;
   value1:=0;
   value2:=0;
   parityindex:=0;

   value1:=(ASCII(SUBSTR(filtereddata,1,1)) -48) * 10;
   value2:=ASCII(SUBSTR(filtereddata,2,1)) -48;
   sumvalue := value1 + value2;
   parityindex := MOD(sumvalue,4);

   datalength:=Length(filtereddata);

   paritybit:=0;
   paritybit:=getEXT2PARITYMAP(parityindex,0);
   IF paritybit=0 THEN 
	transformdataleft:=transformdataleft||SUBSTR(filtereddata,1,1);
   ELSE
	transformdataleft:=transformdataleft||CHR(ASCII(SUBSTR(filtereddata,1,1))+49+14);
   END IF;

   paritybit:=getEXT2PARITYMAP(parityindex,1);
   IF paritybit=0 THEN 
	transformdataright:=transformdataright||SUBSTR(filtereddata,2,1);
   ELSE
	transformdataright:=transformdataright||CHR(ASCII(SUBSTR(filtereddata,2,1))+49+14);
   END IF;

   resultdata:='<' || transformdataleft || '+' || transformdataright;
   RETURN resultdata;

 END ENCODE;

END CONNECTCODE_EXT2;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_EXT2.ENCODE('12'));
  DBMS_OUTPUT.put_line(CONNECTCODE_EXT2.ENCODE('34'));
END;
/