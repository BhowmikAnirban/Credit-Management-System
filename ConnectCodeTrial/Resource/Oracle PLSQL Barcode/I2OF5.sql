-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_I2OF5 AS
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2, chk IN NUMBER, itfrectangle IN NUMBER) RETURN VARCHAR2;
  FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2;

END CONNECTCODE_I2OF5;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_I2OF5 AS  
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

 FUNCTION ENCODE (data IN VARCHAR2, chk IN NUMBER, itfrectangle IN NUMBER) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   weight       NUMBER := 1;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   toggle       NUMBER := 1;	
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
   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   IF chk=1 THEN	
	filteredlength := Length(filtereddata);	
   	IF filteredlength > 253 THEN
    		filtereddata := SUBSTR(filtereddata,1,253);
   	END IF;

   	filteredlength := Length(filtereddata);	
   	IF MOD(filteredlength,2) = 0 THEN
    		filtereddata := '0' || filtereddata;
   	END IF;

	filteredlength := Length(filtereddata);	
	FOR x IN REVERSE 1..filteredlength
      LOOP
		tempchar:=SUBSTR(filtereddata,x,1);
		onevalue:=ASCII(tempchar) - 48;

		IF toggle = 1 THEN 
			sumvalue := sumvalue + (onevalue*3);
			toggle := 0;
		ELSE
			sumvalue := sumvalue + onevalue;
			toggle := 1;
		END IF;
	END LOOP;
      IF MOD(sumvalue,10) = 0 THEN 
		chkvalue := 0 + 48;
  	ELSE
		chkvalue := (10 - MOD(sumvalue,10)) + 48;
	END IF;
	cd:=UNICHR(chkvalue);
   ELSE
	filteredlength := Length(filtereddata);	
   	IF filteredlength > 254 THEN
    		filtereddata := SUBSTR(filtereddata,1,254);
   	END IF;

   	filteredlength := Length(filtereddata);	
   	IF MOD(filteredlength,2) = 1 THEN
    		filtereddata := '0' || filtereddata;
   	END IF;
   END IF;

   filtereddata := filtereddata || cd;	
   filteredlength := Length(filtereddata);	
   FOR counter IN 1..filteredlength
   LOOP
    IF MOD(counter,2) = 1 THEN
      tempchar := SUBSTR(filtereddata,counter,2);
      onevalue := TO_NUMBER(tempchar);

      IF onevalue <= 90 AND onevalue >= 0 THEN
        returndata := returndata || UNICHR(onevalue+32);
      ELSIF onevalue <= 99 AND onevalue >= 91 THEN
        returndata := returndata || UNICHR(onevalue+100);
      ELSE
        returndata := returndata;
      END IF;
      
    END IF;
   END LOOP;

   IF itfrectangle = 1 THEN
	   returndata := '|' || returndata || '~';
   ELSE
	   returndata := '{' || returndata || '}';
   END IF;
	
   return returndata;

 END ENCODE;

END CONNECTCODE_I2OF5;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_I2OF5.ENCODE('12345678',0,0));
  DBMS_OUTPUT.put_line(CONNECTCODE_I2OF5.ENCODE('12345678',1,0));
  DBMS_OUTPUT.put_line(CONNECTCODE_I2OF5.ENCODE('12345678',0,1));
  DBMS_OUTPUT.put_line(CONNECTCODE_I2OF5.ENCODE('12345678',1,1));
END;
/