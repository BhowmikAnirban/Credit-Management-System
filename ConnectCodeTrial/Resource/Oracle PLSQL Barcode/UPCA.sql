-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_UPCA AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2, hr IN NUMBER) RETURN VARCHAR2;
  FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION generateCheckDigitUPCA(data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_UPCA;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_UPCA AS  

 FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2 IS
 BEGIN
    IF datanum=158 THEN 	
	   RETURN unistr('\009e');
    ELSIF datanum=159 THEN 	
	   RETURN unistr('\009f');
    ELSIF datanum=160 THEN 	
	   RETURN unistr('\00a0');
    ELSIF datanum=161 THEN 	
	   RETURN unistr('\00a1');
    ELSIF datanum=162 THEN 	
	   RETURN unistr('\00a2');
    ELSIF datanum=163 THEN 	
	   RETURN unistr('\00a3');
    ELSIF datanum=164 THEN 	
	   RETURN unistr('\00a4');
    ELSIF datanum=165 THEN 	
	   RETURN unistr('\00a5');
    ELSIF datanum=166 THEN 	
	   RETURN unistr('\00a6');
    ELSIF datanum=167 THEN 	
	   RETURN unistr('\00a7');
    ELSIF datanum=192 THEN 	
	   RETURN unistr('\00c0');
    ELSIF datanum=193 THEN 	
	   RETURN unistr('\00c1');
    ELSIF datanum=194 THEN 	
	   RETURN unistr('\00c2');
    ELSIF datanum=195 THEN 	
	   RETURN unistr('\00c3');
    ELSIF datanum=196 THEN 	
	   RETURN unistr('\00c4');
    ELSIF datanum=197 THEN 	
	   RETURN unistr('\00c5');
    ELSIF datanum=198 THEN 	
	   RETURN unistr('\00c6');
    ELSIF datanum=199 THEN 	
	   RETURN unistr('\00c7');
    ELSIF datanum=200 THEN 	
	   RETURN unistr('\00c8');
    ELSIF datanum=201 THEN 	
	   RETURN unistr('\00c9');
    ELSIF datanum=207 THEN 	
	   RETURN unistr('\00cf');
    ELSIF datanum=208 THEN 	
	   RETURN unistr('\00d0');
    ELSIF datanum=209 THEN 	
	   RETURN unistr('\00d1');
    ELSIF datanum=210 THEN 	
	   RETURN unistr('\00d2');
    ELSIF datanum=211 THEN 	
	   RETURN unistr('\00d3');
    ELSIF datanum=212 THEN 	
	   RETURN unistr('\00d4');
    ELSIF datanum=213 THEN 	
	   RETURN unistr('\00d5');
    ELSIF datanum=214 THEN 	
	   RETURN unistr('\00d6');
    ELSIF datanum=215 THEN 	
	   RETURN unistr('\00d7');
    ELSIF datanum=216 THEN 	
	   RETURN unistr('\00d8');
    ELSE
	   RETURN CHR(datanum);
    END IF;
    
 END unichr;

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
   strResult:=strResult || UNICHR(resultvalue);
 
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
	transformdataright:=transformdataright||UNICHR(transformvalue);
   END LOOP;
   	
   IF hr=1 THEN
		resultdata:=   UNICHR(ASCII(SUBSTR(transformdataleft,1,1))-15) || '[' || UNICHR(ASCII(SUBSTR(transformdataleft,1,1))+110) || SUBSTR(transformdataleft,2,5) || '-' || SUBSTR(transformdataright,1,5) || UNICHR(ASCII(SUBSTR(transformdataright,6,1))-49+159) || ']' || UNICHR(ASCII(SUBSTR(transformdataright,6,1))-49-15);
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