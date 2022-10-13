-- Copyright 2006-2009 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.


CREATE OR REPLACE PACKAGE CONNECTCODE_CODE128C AS
  
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_CODE128C;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_CODE128C AS  

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   weight       NUMBER := 1;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chkvalue     NUMBER := 0;	
   cd           VARCHAR2(1);
   filtereddata VARCHAR2(255) := '';
   returndata   VARCHAR2(560) := '';
   filteredlength NUMBER(5) := Length(data);	
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
   IF filteredlength > 253 THEN
    filtereddata := SUBSTR(filtereddata,1,253);
   END IF;

   filteredlength := Length(filtereddata);	
   IF MOD(filteredlength,2) =1 THEN
    filtereddata := '0' || filtereddata;
   END IF;

   sumvalue := 105;
   filteredlength := Length(filtereddata);	
   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   FOR counter IN 1..filteredlength
   LOOP
    IF MOD(counter,2) = 1 THEN
      tempchar := SUBSTR(filtereddata,counter,2);
      onevalue := TO_NUMBER(tempchar);
      chkvalue := onevalue;
      sumvalue := sumvalue + (chkvalue * weight);
      weight := weight + 1;
      IF onevalue <= 94 AND onevalue >= 0 THEN
        returndata := returndata || CHR(onevalue+32);
      ELSIF onevalue <= 106 AND onevalue >= 95 THEN
        returndata := returndata || CHR(onevalue+100+32);
      ELSE
        returndata := returndata;
      END IF;
      
    END IF;
   END LOOP;
   filtereddata:=returndata;
   sumvalue := MOD(sumvalue,103);
   IF sumvalue <= 94 AND sumvalue >= 0 THEN
    cd := CHR(sumvalue+32);
   ELSIF sumvalue <= 106 AND sumvalue >= 95 THEN
    cd := CHR(sumvalue+100+32);
   ELSE
    cd := ''; -- inputvalue = -1 
   END IF;

   RETURN CHR(237) || filtereddata || cd || CHR(238);

 END ENCODE;

END CONNECTCODE_CODE128C;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE128C.ENCODE('12345678'));
END;
/