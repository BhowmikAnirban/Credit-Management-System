-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_POSTNET AS
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_POSTNET;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_POSTNET AS  

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   barcodechar     VARCHAR2(1);
   barcodevalue       NUMBER := 0;
   sumvalue     NUMBER := 0;
   resultvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   filtereddata VARCHAR2(255) := '';
   resultdata   VARCHAR2(30) := '';
   strResult   VARCHAR2(30) := '';
   filteredlength NUMBER(5) := Length(data);	
   datalength   NUMBER:=0;
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

  datalength:=0;
  sumvalue:=0;
  resultvalue:=-1;

  datalength:=Length(filtereddata);
  FOR x IN 1..datalength
  LOOP
	barcodechar:=SUBSTR(filtereddata,x,1);
	sumvalue := sumvalue + ASCII(barcodechar) - 48;		
  END LOOP;

  resultvalue:=MOD(sumvalue,10);
  IF resultvalue <> 0 THEN
	resultvalue := (10 - resultvalue); 
  END IF;

 resultdata := '{' || filtereddata || CHR(resultvalue+48) || '}';
 RETURN resultdata;

 END ENCODE;

END CONNECTCODE_POSTNET;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_POSTNET.ENCODE('12345'));
  DBMS_OUTPUT.put_line(CONNECTCODE_POSTNET.ENCODE('123456789012'));

END;
/