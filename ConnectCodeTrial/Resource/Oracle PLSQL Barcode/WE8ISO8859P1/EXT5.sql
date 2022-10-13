-- Copyright 2006-2009 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_EXT5 AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION getEXT5PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
END CONNECTCODE_EXT5;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_EXT5 AS  

 FUNCTION getEXT5PARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN

	IF digit1=0 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 0;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 0;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 0;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=4 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=4 THEN
		RETURN 0;
	END IF;

	IF digit1=5 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=4 THEN
		RETURN 0;
	END IF;

	IF digit1=6 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=4 THEN
		RETURN 1;
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
	END IF;

	IF digit1=8 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=2 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=9 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=1 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=3 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=4 THEN
		RETURN 1;
	END IF;

	RETURN 0;
 END getEXT5PARITYMAP;

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   barcodechar     VARCHAR2(1);
   barcodevalue       NUMBER := 0;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chk     NUMBER := 0;	
   lendiff      NUMBER := 0;
   modvalue1      NUMBER := 0;
   filtereddata VARCHAR2(255) := '';
   resultdata   VARCHAR2(30) := '';
   filteredlength NUMBER(5) := Length(data);	
   parityindex    NUMBER:=0;
   paritybit    NUMBER:=0;
   datalength   NUMBER:=0;
   transformdata VARCHAR2(255):='';
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
   IF filteredlength > 5 THEN
    filtereddata := SUBSTR(filtereddata,1,5);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength < 5 THEN
	lendiff:=5-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;

   sumvalue:=0;
   datalength:=Length(filtereddata);	

   FOR x IN REVERSE 1..datalength
    LOOP
      barcodechar:=SUBSTR(filtereddata,x,1);
      barcodevalue:=ASCII(barcodechar);	
	modvalue1 := MOD(x,2);

      IF modvalue1=1 THEN
	  sumvalue := sumvalue + (3 * (barcodevalue-48));
      ELSE
	  sumvalue := sumvalue + (9 * (barcodevalue-48));
	END IF;

    END LOOP;

    chk := MOD(sumvalue,10);

    FOR x IN 1..5
    LOOP
 	  paritybit:=0;
	  paritybit:=getEXT5PARITYMAP(chk,x-1);
	  IF paritybit=0 THEN 
		transformdata:=transformdata||SUBSTR(filtereddata,x,1);
	  ELSE
		transformdata:=transformdata||CHR(ASCII(SUBSTR(filtereddata,x,1)) + 49 + 14);				
	  END IF;
     END LOOP;

     resultdata:= '<' || SUBSTR(transformdata,1,1) || '+' || SUBSTR(transformdata,2,1) || '+' || SUBSTR(transformdata,3,1) || '+' || SUBSTR(transformdata,4,1) || '+' || SUBSTR(transformdata,5,1);    

 RETURN resultdata;

 END ENCODE;

END CONNECTCODE_EXT5;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_EXT5.ENCODE('12345'));
  DBMS_OUTPUT.put_line(CONNECTCODE_EXT5.ENCODE('34567'));
END;
/