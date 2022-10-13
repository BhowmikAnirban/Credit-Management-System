-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.


CREATE OR REPLACE PACKAGE CONNECTCODE_CODE128C AS
  
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2;

END CONNECTCODE_CODE128C;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_CODE128C AS  

 FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2 IS
 BEGIN
    IF datanum=191 THEN 
	   RETURN unistr('\00bf');
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
    ELSIF datanum=227 THEN 	
	   RETURN unistr('\00e3');
    ELSIF datanum=228 THEN 	
	   RETURN unistr('\00e4');
    ELSIF datanum=229 THEN 	
	   RETURN unistr('\00e5');
    ELSIF datanum=230 THEN 	
	   RETURN unistr('\00e6');
    ELSIF datanum=231 THEN 	
	   RETURN unistr('\00e7');
    ELSIF datanum=232 THEN 	
	   RETURN unistr('\00e8');
    ELSIF datanum=233 THEN 	
	   RETURN unistr('\00e9');
    ELSIF datanum=234 THEN 	
	   RETURN unistr('\00ea');
    ELSIF datanum=235 THEN 	
	   RETURN unistr('\00eb');
    ELSIF datanum=236 THEN 	
	   RETURN unistr('\00ec');
    ELSIF datanum=237 THEN 	
	   RETURN unistr('\00ed');
    ELSIF datanum=238 THEN 	
	   RETURN unistr('\00ee');
    ELSE
	   RETURN CHR(datanum);
    END IF;
    
 END unichr;

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   weight       NUMBER := 1;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chkvalue     NUMBER := 0;	
   cd           VARCHAR2(2);
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
        returndata := returndata || UNICHR(onevalue+32);
      ELSIF onevalue <= 106 AND onevalue >= 95 THEN
        returndata := returndata || UNICHR(onevalue+100+32);
      ELSE
        returndata := returndata;
      END IF;
      
    END IF;
   END LOOP;
   filtereddata:=returndata;
   sumvalue := MOD(sumvalue,103);
   IF sumvalue <= 94 AND sumvalue >= 0 THEN
    cd := UNICHR(sumvalue+32);
   ELSIF sumvalue <= 106 AND sumvalue >= 95 THEN
    cd := UNICHR(sumvalue+100+32);
   ELSE
    cd := ''; -- inputvalue = -1 
   END IF;

   RETURN UNICHR(237) || filtereddata || cd || UNICHR(238);

 END ENCODE;

END CONNECTCODE_CODE128C;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE128C.ENCODE('12345678'));
END;
/