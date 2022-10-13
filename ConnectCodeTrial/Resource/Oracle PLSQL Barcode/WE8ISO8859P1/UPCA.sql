-- Copyright 2006-2009 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_UPCA AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2, hr IN NUMBER) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION generateCheckDigitUPCA(data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_UPCA;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_UPCA AS  

  FUNCTION generateCheckDigitUPCA(data IN VARCHAR2) RETURN VARCHAR2 IS
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
	IF MOD(x,2)=1 THEN
		sumvalue := sumvalue + (3*barcodevalue);
	ELSE
		sumvalue := sumvalue + barcodevalue;
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
 END generateCheckDigitUPCA;

 FUNCTION ENCODE (data IN VARCHAR2, hr IN NUMBER) RETURN VARCHAR2 IS
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
   IF filteredlength > 11 THEN
    filtereddata := SUBSTR(filtereddata,1,11);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength < 11 THEN
	lendiff:=11-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;

   cd:=generateCheckDigitUPCA(filtereddata);
   filtereddata:=filtereddata||cd;
   FOR x IN 1..6
   LOOP
	transformdataleft:=transformdataleft||SUBSTR(filtereddata,x,1);
   END LOOP;

   FOR x IN 7..12
   LOOP
	transformchar:=SUBSTR(filtereddata,x,1);
	transformvalue:=ASCII(transformchar)+49; 
	transformdataright:=transformdataright||CHR(transformvalue);
   END LOOP;
   	
   IF hr=1 THEN
		resultdata:=   CHR(ASCII(SUBSTR(transformdataleft,1,1))-15) || '[' || CHR(ASCII(SUBSTR(transformdataleft,1,1))+110) || SUBSTR(transformdataleft,2,5) || '-' || SUBSTR(transformdataright,1,5) || CHR(ASCII(SUBSTR(transformdataright,6,1))-49+159) || ']' || CHR(ASCII(SUBSTR(transformdataright,6,1))-49-15);
   ELSE
		resultdata:='[' || transformdataleft || '-' || transformdataright || ']';
   END IF;
  
   RETURN resultdata;

 END ENCODE;

END CONNECTCODE_UPCA;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCA.ENCODE('12345678901',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCA.ENCODE('12345678901',1));

END;
/