-- Copyright 2006-2009 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_CODE128AUTO AS

--Public Functions  
  FUNCTION ENCODE(data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION ScanAhead_8orMore_Numbers (data IN VARCHAR2, x IN NUMBER) RETURN NUMBER;
  FUNCTION generateCheckDigitAB(data IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION detectAllNumbers (data IN VARCHAR2) RETURN NUMBER;  

  FUNCTION addShift (data IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION OptimizeNumbers(data IN VARCHAR2, x IN OUT NUMBER, strResult IN VARCHAR2, num IN NUMBER) RETURN VARCHAR2;
  FUNCTION getAutoSwitchingAB(data IN VARCHAR2) RETURN VARCHAR2;
END CONNECTCODE_CODE128AUTO;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_CODE128AUTO AS  
 FUNCTION detectAllNumbers (data IN VARCHAR2) RETURN NUMBER IS
   tempchar     VARCHAR2(1);
   onevalue     NUMBER := 0;	
   allnumbers   NUMBER :=1;
   datalength   NUMBER(5) := Length(data);
 BEGIN
   IF MOD(datalength,2) = 1 THEN
     allnumbers:=0;
   ELSE
   FOR counter IN 1..datalength LOOP
    tempchar := SUBSTR(data,counter,1);
    onevalue := ASCII(tempchar);
    IF onevalue >= 48 AND onevalue <=57 THEN 
      onevalue:=onevalue;
    ELSE
      allnumbers:=0;      
    END IF;
   END LOOP;
   END IF;

   RETURN allnumbers; 
 END detectAllNumbers;

 FUNCTION getAutoSwitchingAB(data IN VARCHAR2) RETURN VARCHAR2 IS 
   tempchar     VARCHAR2(1);
   onevalue     NUMBER := 0;	
   x            NUMBER := 1;
   num          NUMBER := 0;
   shiftvalue   NUMBER :=230;
   datalength   NUMBER(5) := Length(data);
   strResult    VARCHAR2(560):='';
 BEGIN

   WHILE  x <= datalength LOOP
 	tempchar := SUBSTR(data,x,1);
 	onevalue:=ASCII(tempchar);
 
 	IF onevalue = 31 THEN
 		onevalue := onevalue + 96 + 100; 
 		strResult := strResult || CHR(onevalue);
 	ELSIF onevalue = 127 THEN
 		onevalue := onevalue+ 100; 
 		strResult := strResult || CHR(onevalue);
 	ELSE
 		num:=ScanAhead_8orMore_Numbers(data,x);
 		IF num>=8 THEN
 			strResult:=OptimizeNumbers(data,x,strResult,num);
 			x:=x-1;
 		ELSE
       		strResult := strResult || CHR(onevalue);
   		END IF;
 	END IF;
 
 	x:=x+1;
   END LOOP;
   RETURN strResult;
 End getAutoSwitchingAB;
 
 FUNCTION OptimizeNumbers(data IN VARCHAR2, x IN OUT NUMBER, strResult IN VARCHAR2, num IN NUMBER) RETURN VARCHAR2 IS
    twonum   VARCHAR2(2);
    onevalue NUMBER :=0;
    BtoC     NUMBER := 231;
    CtoB     NUMBER := 232;
    endpoint NUMBER := x+num;
    newResult VARCHAR2(560) := '';  
 BEGIN
    newResult := strResult || CHR(BtoC);
    WHILE x < endpoint LOOP
    	twonum := SUBSTR(data,x,2);
    	onevalue := TO_NUMBER(twonum);
        IF onevalue <= 94 AND onevalue >= 0 THEN
          newResult := newResult || CHR(onevalue+32);
        ELSIF onevalue <= 106 AND onevalue >= 95 THEN
          newResult := newResult || CHR(onevalue+100+32);
        ELSE
          newResult := newResult; --do nothing
        END IF;
    	x:=x+2;
    END LOOP;
    newResult := newResult || CHR(CtoB);
    RETURN newResult;
 END OptimizeNumbers;

 FUNCTION addShift (data IN VARCHAR2) RETURN VARCHAR2 IS
    filtereddata VARCHAR2(560):='';
    tempchar     VARCHAR2(1);
    shiftvalue   NUMBER := 230;
    onevalue   NUMBER := 0;
    datalength NUMBER(5) := Length(data);	
 BEGIN
   FOR counter IN 1..datalength
   LOOP
    tempchar := SUBSTR(data,counter,1);
    onevalue := ASCII(tempchar);
    IF onevalue >= 0 AND onevalue <=31 THEN 
	filtereddata := filtereddata || CHR(shiftvalue);
	onevalue := onevalue + 96;
	filtereddata := filtereddata || CHR(onevalue);
    ELSE
	filtereddata := filtereddata || tempchar;
    END IF;
   END LOOP; 
   RETURN filtereddata;
 END addShift;


FUNCTION ScanAhead_8orMore_Numbers (data IN VARCHAR2, x IN NUMBER) RETURN NUMBER IS
   onevalue     NUMBER := 0;	
   numNumbers   NUMBER := 0;	
   exitvalue         NUMBER := 0;	
   tempchar     VARCHAR2(1); 
   datalength NUMBER(5) := Length(data);
   y          NUMBER := x;
 BEGIN
    WHILE y <= datalength AND exitvalue=0 LOOP
    	tempchar := SUBSTR(data,y,1);
    	onevalue := ASCII(tempchar);
    	IF onevalue >= 48 AND onevalue <= 57 THEN
    		numNumbers := numNumbers+1;
    	ELSE
    		exitvalue:=1;
   	END IF;
    	y:=y+1;
    END LOOP;
    IF numNumbers>8 THEN
    	IF MOD(numNumbers,2)=1 THEN
    		numNumbers:=numNumbers-1;
    	END IF;
    END IF;	
    RETURN numNumbers;  
 END ScanAhead_8orMore_Numbers;

   
FUNCTION generateCheckDigitAB(data IN VARCHAR2) RETURN VARCHAR2 IS
  tempchar     VARCHAR2(1);
  datalength NUMBER(5) :=Length(data);
  sumvalue        NUMBER :=104;
  result     NUMBER := -1;
  strResult  VARCHAR2(1) := '';
  x          NUMBER :=1;
  endpoint   NUMBER :=0;
  num        NUMBER :=0;
  weight     NUMBER :=1;
  BtoC       NUMBER :=99;
  CtoB       NUMBER :=100;
BEGIN

  WHILE  x <= datalength LOOP
	num:=ScanAhead_8orMore_Numbers(data,x);
	IF num>=8 THEN
	  endpoint:=x+num;	
	  sumvalue := sumvalue + (BtoC * weight);
	  weight:=weight+1;
	  WHILE  x < endpoint LOOP
		num := TO_NUMBER(SUBSTR(data,x,2));
                sumvalue := sumvalue + (num * weight);
		x:=x+2;
		weight:=weight+1;

	  END LOOP;
	  sumvalue := sumvalue + (CtoB * weight);
	  weight:=weight+1;
	ELSE
 	      tempchar:=SUBSTR(data,x,1);
		num := ASCII(tempchar);
		IF num <= 31 AND num >= 0 THEN
			num := num + 64;
		ELSIF num <= 127 AND num >= 32 THEN
			num := num - 32;
		ELSIF num = 230 THEN
			num := 98;  
		ELSE 
			num := -1;
		END IF;
		
		sumvalue := sumvalue + (num * weight);
		x:=x+1;
		weight:=weight+1;
	END IF;
  END LOOP;  	
  result:=MOD(sumvalue,103);
  IF result <= 94 AND result >= 0 THEN
  	result := result+32;
  ELSIF result <= 106 AND result >= 95 THEN
  	result := result + 100 + 32;
  ELSE 
  	result := -1;
  END IF;
  IF result=-1 THEN
    strResult:='';	  
  ELSE
    strResult:=CHR(result);	
  END IF;

  return strResult;

END generateCheckDigitAB;

 FUNCTION ENCODE(data IN VARCHAR2) RETURN VARCHAR2 IS
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
    IF onevalue >= 0 AND onevalue <=127 THEN 
	filtereddata := filtereddata || tempchar;
    END IF;
   END LOOP;

   filteredlength := Length(filtereddata);	
   IF filteredlength > 254 THEN
    filtereddata := SUBSTR(filtereddata,1,254);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   IF detectAllNumbers(filtereddata) = 0 THEN
      cd:=generateCheckDigitAB(filtereddata); 
      filtereddata:=getAutoSwitchingAB(filtereddata);
      returndata := CHR(236) || filtereddata || cd || CHR(238);
   ELSE
     filteredlength := Length(filtereddata);	
     sumvalue := 105;

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
     returndata := CHR(237) || filtereddata || cd || CHR(238);
   End IF; 
   RETURN returndata;

 END ENCODE;

END CONNECTCODE_CODE128AUTO;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE128AUTO.ENCODE('abcdef'));
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE128AUTO.ENCODE('ABCDEF'));
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE128AUTO.ENCODE('12345678'));
END;
/