-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_UPCE AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2, hr IN NUMBER) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION generateCheckDigitUPCE(data IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION getUPCEPARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER, digit3 IN NUMBER) RETURN NUMBER;
END CONNECTCODE_UPCE;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_UPCE AS  

  FUNCTION getUPCEPARITYMAP(digit1 IN NUMBER, digit2 IN NUMBER, digit3 IN NUMBER) RETURN NUMBER IS

  BEGIN

	IF digit1=0 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=0 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=0 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=0 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=1 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=0 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=0 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=1 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=1 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=1 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=1 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=2 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=0 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=0 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=2 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=1 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=1 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=2 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=3 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=0 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=0 AND digit3=5 THEN
		RETURN 1;

	ELSIF digit1=3 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=1 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=3 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=1 AND digit3=5 THEN
		RETURN 0;
	END IF;

	IF digit1=4 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=0 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=0 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=4 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=1 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=1 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=4 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=5 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=0 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=0 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=5 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=1 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=1 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=5 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=6 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=0 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=0 AND digit3=5 THEN
		RETURN 1;

	ELSIF digit1=6 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=1 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=6 AND digit2=1 AND digit3=5 THEN
		RETURN 0;
	END IF;

	IF digit1=7 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=0 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=0 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=0 AND digit3=5 THEN
		RETURN 0;

	ELSIF digit1=7 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=1 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=1 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=7 AND digit2=1 AND digit3=5 THEN
		RETURN 1;
	END IF;

	IF digit1=8 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=0 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=0 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=0 AND digit3=5 THEN
		RETURN 1;

	ELSIF digit1=8 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=1 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=8 AND digit2=1 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=1 AND digit3=5 THEN
		RETURN 0;
	END IF;

	IF digit1=9 AND digit2=0 AND digit3=0 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=0 AND digit3=1 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=0 AND digit3=2 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=0 AND digit3=3 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=0 AND digit3=4 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=0 AND digit3=5 THEN
		RETURN 1;

	ELSIF digit1=9 AND digit2=1 AND digit3=0 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=1 AND digit3=1 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=1 AND digit3=2 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=1 AND digit3=3 THEN
		RETURN 0;
	ELSIF digit1=9 AND digit2=1 AND digit3=4 THEN
		RETURN 1;
	ELSIF digit1=9 AND digit2=1 AND digit3=5 THEN
		RETURN 0;
	END IF;
  RETURN 0;

  END getUPCEPARITYMAP;

  FUNCTION generateCheckDigitUPCE(data IN VARCHAR2) RETURN VARCHAR2 IS
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
 END generateCheckDigitUPCE;

 FUNCTION ENCODE(data IN VARCHAR2, hr IN NUMBER) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   transformchar     VARCHAR2(1);
   thirdch      VARCHAR2(1);
   lastchar     VARCHAR2(1);
   smalllen     NUMBER := 0;
   weight       NUMBER := 1;
   transformvalue       NUMBER := 0;
   productvalue     NUMBER := 0;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chkvalue     NUMBER := 0;	
   nsvalue      NUMBER := 0;	
   lendiff      NUMBER := 0;
   cd           VARCHAR2(1);
   filtereddata VARCHAR2(255) := '';
   returndata   VARCHAR2(255) := '';
   upcestr      VARCHAR2(255) := '';
   upcastr      VARCHAR2(255) := '0';
   resultdata   VARCHAR2(30) := '';
   filteredlength NUMBER(5) := Length(data);	
   paritybit    NUMBER:=0;
   firstdigit   NUMBER:=0; 
   datalength   NUMBER:=0;
   transformdata VARCHAR2(255):='';
   nschar     VARCHAR2(1):='0';
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
   IF filteredlength > 6 THEN
    filtereddata := SUBSTR(filtereddata,1,6);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength < 6 THEN
	lendiff:=6-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;
   
--Expand
   datalength := Length(filtereddata);	
   lastchar:=SUBSTR(filtereddata,datalength,1);

   IF lastchar = '0' OR lastchar = '1' OR lastchar = '2' THEN
	upcastr := upcastr || SUBSTR(filtereddata,1,2);
	upcastr := upcastr || lastchar;
	upcastr := upcastr || '0000';
	upcastr := upcastr || SUBSTR(filtereddata,3,3);
   ELSIF lastchar = '3' THEN
	upcastr := upcastr || SUBSTR(filtereddata,1,3);
	upcastr := upcastr || '00000';
	upcastr := upcastr || SUBSTR(filtereddata,4,2);
   ELSIF lastchar = '4' THEN
	upcastr := upcastr || SUBSTR(filtereddata,1,4);
	upcastr := upcastr || '00000';
	upcastr := upcastr || SUBSTR(filtereddata,5,1);
   ELSIF lastchar = '5' OR lastchar = '6' OR lastchar = '7' OR lastchar = '8' OR lastchar = '9' THEN
	upcastr := upcastr || SUBSTR(filtereddata,1,5);
	upcastr := upcastr || '0000';
	upcastr := upcastr || lastchar;
   END IF;

   filtereddata:=upcastr;

   cd:=generateCheckDigitUPCE(filtereddata);
--Contract
   upcestr:=upcastr;
   productvalue := TO_NUMBER(SUBSTR(upcastr,7,5));

   IF SUBSTR(upcestr,4,3)='000' OR SUBSTR(upcestr,4,3)='100' OR SUBSTR(upcestr,4,3)='200' THEN
	IF productvalue >= 0 AND productvalue <=999 THEN
		smalllen:=Length(upcestr);
		thirdch:=SUBSTR(upcestr,4,1);
		upcestr:=SUBSTR(upcestr,1,3) || SUBSTR(upcestr,9,(smalllen-9+1));
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,6) || thirdch;  
	ELSE
		upcestr:='000000';
	END IF;
   ELSIF SUBSTR(upcestr,5,2)='00' THEN
	IF productvalue >= 0 AND productvalue <=99 THEN
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,4) || SUBSTR(upcestr,10,(smalllen-10+1));
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,6) || '3';  
	ELSE
		upcestr:='000000';
	END IF;
   ELSIF SUBSTR(upcestr,6,1)='0' THEN
	IF productvalue >= 0 AND productvalue <=9 THEN
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,5) || SUBSTR(upcestr,11,(smalllen-11+1));
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,6) || '4';  
	ELSE
		upcestr:='000000';
	END IF;
   ELSIF SUBSTR(upcestr,6,1)<>'0' THEN
	IF productvalue >= 5 AND productvalue <=9 THEN
		smalllen:=Length(upcestr);
		upcestr:=SUBSTR(upcestr,1,6) || SUBSTR(upcestr,11,(smalllen-11+1));
	ELSE 
		upcestr:='000000';
	END IF;
   ELSE
	upcestr:='000000';
   END IF;
	
   filtereddata:=upcestr;

   parityBit:=0;
   nschar:='0'; 
   chkvalue := ASCII(cd) - 48;

   FOR x IN 2..7
   LOOP
	nsvalue := ASCII(nschar) - 48;
	transformchar:=SUBSTR(filtereddata,x,1);
	parityBit:=getUPCEPARITYMAP(chkvalue,nsvalue,x-2);
	IF parityBit=1 THEN
		transformchar:=CHR(ASCII(transformchar)+48+15); 
	END IF;
	transformdata := transformdata || transformchar;
   END LOOP;
   	
   IF hr=1 THEN
		resultdata := CHR(ASCII(nschar)-15) || '{' || transformdata || '}' || CHR(chkvalue+48-15);
   ELSE
		resultdata := '{' || transformdata || '}';
   END IF;

   RETURN resultdata;
 END ENCODE;
END CONNECTCODE_UPCE;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123450',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123451',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123452',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123453',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123454',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123455',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123456',0));
  DBMS_OUTPUT.put_line(CONNECTCODE_UPCE.ENCODE('123457',0));

END;
/