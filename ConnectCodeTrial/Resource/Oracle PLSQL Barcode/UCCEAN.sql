-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_UCCEAN AS
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  FUNCTION ScanAhead_8orMore_UCCEAN (data IN VARCHAR2, x IN NUMBER) RETURN NUMBER;
  FUNCTION generateCheckDigitABUCCEAN(data IN VARCHAR2) RETURN VARCHAR2;
  FUNCTION generateCheckDigitCUCCEAN(data IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION detectAllNumbersUCCEAN (data IN VARCHAR2) RETURN NUMBER;  

  FUNCTION OptimizeNumbersUCCEAN(data IN VARCHAR2, x IN OUT NUMBER, strResult IN VARCHAR2, num IN NUMBER) RETURN VARCHAR2;
  FUNCTION getAutoSwitchingABUCCEAN(data IN VARCHAR2) RETURN VARCHAR2;

  FUNCTION replace234(data IN VARCHAR2, fncvalue IN NUMBER) RETURN VARCHAR2;
  FUNCTION unichr (datanum IN NUMBER) RETURN VARCHAR2;

END CONNECTCODE_UCCEAN;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_UCCEAN AS  

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

 FUNCTION replace234(data IN VARCHAR2, fncvalue IN NUMBER) RETURN VARCHAR2 IS
   TYPE v_arr IS VARRAY(8) of NUMBER;
   TYPE v_arrstr IS VARRAY(8) of VARCHAR2(50);
   tempchar     VARCHAR2(2);
   onevalue     NUMBER := 0;	
   datalength   NUMBER := Length(data);	
   resultdata   VARCHAR2(255):='';
   barcodechar     VARCHAR2(2);
   barcodecharx     VARCHAR2(2);
   barcodechary     VARCHAR2(2);
   fncstring    VARCHAR2(10):='';
   x            NUMBER := 0;	
   y            NUMBER := 0;	
   numset       NUMBER := 1;	
   exitvalue    NUMBER := 0;	
   startBracketPosition v_arr := v_arr();
   stopBracketPosition v_arr  := v_arr();   
   aiset v_arrstr := v_arrstr();
   dataset v_arrstr := v_arrstr();
 BEGIN

  startBracketPosition.EXTEND(8);
  stopBracketPosition.EXTEND(8);
  aiset.EXTEND(8);
  dataset.EXTEND(8);

  FOR counter IN 1..8 
  LOOP
	startBracketPosition(counter) := -1;
  	stopBracketPosition(counter) := -1;
  END LOOP;

  x:=1;
  WHILE x <= datalength
  LOOP
    barcodecharx:=SUBSTR(data,x,1);
    IF barcodecharx='(' THEN
	y:=x+1;
	exitvalue:=0;	
      WHILE y <= datalength AND exitvalue=0
      LOOP
		barcodechary:=SUBSTR(data,y,1);
		IF barcodechary=')' THEN
			startBracketPosition(numset):=x;
			stopBracketPosition(numset):=y;
			numset:=numset+1;
			exitvalue:=1;
		END IF;
		IF exitvalue=0 THEN
			y:=y+1;
		END IF;
      END LOOP;
 	x:=y;
     END IF;	
     x:=x+1;	
  END LOOP;

  IF numset=0 THEN
     fncstring:=fncstring||UNICHR(fncvalue);
     RETURN fncstring||data;
  END IF;
	
  FOR x IN 1..(numset-1) 
  LOOP
      aiset(x):='';
      dataset(x):='';

      IF stopBracketPosition(x)<=startBracketPosition(x) THEN
      	RETURN '';
      END IF;

      IF stopBracketPosition(x)-1 = startBracketPosition(x) THEN
      	RETURN '';
      END IF;

	FOR y IN (startBracketPosition(x)+1)..stopBracketPosition(x)
	LOOP
		barcodechar:=SUBSTR(data,y,1);
		IF (ASCII(barcodechar) <= 57 AND ASCII(barcodechar) >= 48) OR (ASCII(barcodechar) <= 90 AND ASCII(barcodechar) >= 65) OR (ASCII(barcodechar) <= 122 AND ASCII

(barcodechar) >= 97) THEN
			aiset(x):=aiset(x) || barcodechar;
		END IF;
	END LOOP;

        IF x=numset-1 THEN
	FOR y IN (stopBracketPosition(x)+1)..Length(data)
	LOOP 
		barcodechar:=SUBSTR(data,y,1);

		IF (ASCII(barcodechar) <= 57 AND ASCII(barcodechar) >= 48) OR (ASCII(barcodechar) <= 90 AND ASCII(barcodechar) >= 65) OR (ASCII(barcodechar) <= 122 AND ASCII

(barcodechar) >= 97) THEN
			dataset(x):=dataset(x) || barcodechar;
		END IF;
	END LOOP;
	ELSE
	FOR y IN (stopBracketPosition(x)+1)..startBracketPosition(x+1)
	LOOP
		barcodechar:=SUBSTR(data,y,1);

		IF (ASCII(barcodechar) <= 57 AND ASCII(barcodechar) >= 48) OR (ASCII(barcodechar) <= 90 AND ASCII(barcodechar) >= 65) OR (ASCII(barcodechar) <= 122 AND ASCII

(barcodechar) >= 97) THEN
			dataset(x):=dataset(x) || barcodechar;
		END IF;
	END LOOP;
	END IF;

  END LOOP;

  resultdata:='' || UNICHR(fncvalue);
  fncstring:='' || UNICHR(fncvalue);

  FOR x IN 1..(numset-1)
  LOOP
	IF x=(numset-1) THEN
		resultdata:=resultdata || aiset(x) || dataset(x);
	ELSE
		IF aiset(x)='8002' OR	aiset(x)='8003' OR aiset(x)='8004' OR aiset(x)='8007' OR	aiset(x)='8008' OR	aiset(x)='8020' OR	aiset(x)='240' OR	

aiset(x)='241' OR aiset(x)='250' OR aiset(x)='251' OR aiset(x)='400' OR	aiset(x)='401' OR	aiset(x)='403' OR	aiset(x)='420' OR	aiset(x)='421' OR	aiset(x)

='423' OR	aiset(x)='10' OR	aiset(x)='21' OR	aiset(x)='22' OR aiset(x)='23' OR	aiset(x)='30' OR aiset(x)='37' OR	aiset(x)='90' OR aiset(x)='91' OR 

aiset(x)='92' OR aiset(x)='93' OR	aiset(x)='94' OR aiset(x)='95' OR	aiset(x)='96' OR aiset(x)='97' OR	aiset(x)='98' OR aiset(x)='99' THEN
			resultdata:=resultdata || aiset(x) || dataset(x) || fncstring; 
		ELSE
			resultdata:=resultdata || aiset(x) || dataset(x);
		END IF;
	END IF;
  END LOOP;
  RETURN resultdata;
 END replace234;

 FUNCTION detectAllNumbersUCCEAN (data IN VARCHAR2) RETURN NUMBER IS
   tempchar     VARCHAR2(2);
   onevalue     NUMBER := 0;	
   allnumbers   NUMBER :=1;
   inrange      NUMBER :=0;
   datalength   NUMBER(5) := Length(data);
 BEGIN
   FOR counter IN 1..datalength LOOP
    tempchar := SUBSTR(data,counter,1);
    onevalue := ASCII(tempchar);

    IF onevalue >= 48 AND onevalue <=57 THEN
	inrange:=1;
    ELSE
	inrange:=0;
    END IF;

    IF inrange=1 OR onevalue = 234 THEN
      onevalue:=onevalue;
    ELSE
      allnumbers:=0;      
    END IF;
   END LOOP;

   RETURN allnumbers; 
 END detectAllNumbersUCCEAN;

 FUNCTION getAutoSwitchingABUCCEAN(data IN VARCHAR2) RETURN VARCHAR2 IS 
   tempchar     VARCHAR2(2);
   onevalue     NUMBER := 0;	
   x            NUMBER := 1;
   num          NUMBER := 0;
   shiftvalue   NUMBER :=230;
   datalength   NUMBER(5) := Length(data);
   strResult    VARCHAR2(255):='';
 BEGIN

   WHILE  x <= datalength LOOP
 	tempchar := SUBSTR(data,x,1);
 	onevalue:=ASCII(tempchar);
 
 	IF onevalue <= 31 AND onevalue>=0 THEN
 		onevalue := onevalue + 96 + 100; 
 		strResult := strResult || UNICHR(onevalue);
 	ELSIF onevalue = 127 THEN
 		onevalue := onevalue+ 100; 
 		strResult := strResult || UNICHR(onevalue);
 	ELSE
 		num:=ScanAhead_8orMore_UCCEAN(data,x);
 		IF num>=8 THEN
 			strResult:=OptimizeNumbersUCCEAN(data,x,strResult,num);
 			x:=x-1;
 		ELSE
       		strResult := strResult || UNICHR(onevalue);
   		END IF;
 	END IF;
 
 	x:=x+1;
   END LOOP;
   RETURN strResult;
 End getAutoSwitchingABUCCEAN;
 
 FUNCTION OptimizeNumbersUCCEAN(data IN VARCHAR2, x IN OUT NUMBER, strResult IN VARCHAR2, num IN NUMBER) RETURN VARCHAR2 IS
    twonum   VARCHAR2(2);
    onevalue NUMBER :=0;
    BtoC     NUMBER := 231;
    CtoB     NUMBER := 232;
    endpoint NUMBER := x+num;
    newResult VARCHAR2(255) := '';  
 BEGIN
    newResult := strResult || UNICHR(BtoC);
    WHILE x < endpoint LOOP
    	twonum := SUBSTR(data,x,2);
    	onevalue := TO_NUMBER(twonum);
        IF onevalue <= 94 AND onevalue >= 0 THEN
          newResult := newResult || UNICHR(onevalue+32);
        ELSIF onevalue <= 106 AND onevalue >= 95 THEN
          newResult := newResult || UNICHR(onevalue+100+32);
        ELSE
          newResult := newResult; --do nothing
        END IF;
    	x:=x+2;
    END LOOP;
    newResult := newResult || UNICHR(CtoB);
    RETURN newResult;
 END OptimizeNumbersUCCEAN;

FUNCTION ScanAhead_8orMore_UCCEAN (data IN VARCHAR2, x IN NUMBER) RETURN NUMBER IS
   onevalue     NUMBER := 0;	
   numNumbers   NUMBER := 0;	
   exitvalue         NUMBER := 0;	
   tempchar     VARCHAR2(2); 
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
 END ScanAhead_8orMore_UCCEAN;

   
FUNCTION generateCheckDigitABUCCEAN(data IN VARCHAR2) RETURN VARCHAR2 IS
  tempchar     VARCHAR2(2);
  datalength NUMBER(5) :=Length(data);
  sumvalue        NUMBER :=104;
  result     NUMBER := -1;
  strResult  VARCHAR2(2) := '';
  x          NUMBER :=1;
  endpoint   NUMBER :=0;
  num        NUMBER :=0;
  weight     NUMBER :=1;
  BtoC       NUMBER :=99;
  CtoB       NUMBER :=100;
BEGIN

  WHILE  x <= datalength LOOP
	num:=ScanAhead_8orMore_UCCEAN(data,x);
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
    strResult:=UNICHR(result);	
  END IF;

  return strResult;

END generateCheckDigitABUCCEAN;

 FUNCTION generateCheckDigitCUCCEAN(data IN VARCHAR2) RETURN VARCHAR2 IS
  sumvalue NUMBER:=105;
  numvalue NUMBER:=0;
  resultvalue NUMBER:=-1;
  strResult VARCHAR2(2):='';
  datalength NUMBER:=Length(data);
  x NUMBER:= 1;
  weight NUMBER:=1;
  skip NUMBER:=0;
  barcodechar1 VARCHAR2(2):=UNICHR(0);
  barcodechar2 VARCHAR2(2):=UNICHR(0);
  CtoB NUMBER:= 100;
  BtoC NUMBER:= 99;
 BEGIN

  WHILE x <= datalength 
  LOOP
	skip:=0;
	IF ASCII(SUBSTR(data,x,1)) = 234 THEN
		numvalue := 102;
        	sumvalue :=sumvalue+ (numvalue * weight);		
		x:=x+1;
		weight:=weight+1;
		skip:=1;
	END IF;

	IF skip=0 THEN
 		barcodechar1 :=UNICHR(0);
		barcodechar2 :=UNICHR(0);
 		barcodechar1:=SUBSTR(data,x,1);
		IF x+1<=datalength THEN	
			barcodechar2:=SUBSTR(data,x+1,1);
		END IF;

		IF ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2)>=48 AND ASCII(barcodechar2)<=57 THEN
			    numvalue := TO_NUMBER(SUBSTR(data,x,2));
			    sumvalue := sumvalue+ (numvalue * weight);
			    x:=x+2;
			    weight:=weight+1;
		ELSIF (ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2) =234) OR (ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2) =0) THEN
	                    sumvalue := sumvalue + (CtoB * weight);
	  		    weight:=weight+1;
			    numvalue := ASCII(SUBSTR(data,x,1));

			    IF numvalue <= 31 AND numvalue >= 0 THEN
				numvalue := numvalue + 64;
		   	    ELSIF numvalue <= 127 AND numvalue >= 32 THEN
				numvalue := numvalue- 32;
			    ELSIF numvalue= 230 THEN
				numvalue := 98;
 		  	    END IF;

			    sumvalue := sumvalue + (numvalue * weight);

			    weight:=weight+1;
		            sumvalue := sumvalue+ (BtoC * weight);
			    weight:=weight+1;
			    x:=x+1;
		END IF;
	END IF;
  END LOOP;
	
  resultvalue:=MOD(sumvalue,103);

  IF resultvalue <= 94 AND resultvalue >= 0 THEN
	resultvalue:=resultvalue + 32;
  ELSIF resultvalue <= 106 AND resultvalue >= 95 THEN
	resultvalue:=resultvalue + 32 + 100;
  ELSE 
	resultvalue := -1;
  END IF;

  strResult:=UNICHR(resultvalue);
  return strResult;

 END generateCheckDigitCUCCEAN;

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   tempchar     VARCHAR2(2);
   weight       NUMBER := 1;
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   chkvalue     NUMBER := 0;	
   cd           VARCHAR2(2);
   filtereddata VARCHAR2(255) := '';
   replacedata234   VARCHAR2(255) := '';
   returndata   VARCHAR2(255) := '';
   filteredlength NUMBER(5) := Length(data);	
   x NUMBER:= 1;
   skip NUMBER:=0;
   barcodechar1 VARCHAR(2):=UNICHR(0);
   barcodechar2 VARCHAR(2):=UNICHR(0);
   CtoB VARCHAR2(2):=UNICHR(232);
   BtoC VARCHAR2(2):=UNICHR(231);
   numvalue NUMBER :=0;

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
   IF filteredlength IS NULL THEN
	RETURN '';
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength > 254 THEN
    filtereddata := SUBSTR(filtereddata,1,254);
   END IF;
	
   filtereddata:=replace234(filtereddata,234);

   IF detectAllNumbersUCCEAN(filtereddata) = 0 THEN
      cd:=generateCheckDigitABUCCEAN(filtereddata); 
      filtereddata:=getAutoSwitchingABUCCEAN(filtereddata);
      returndata := UNICHR(236) || filtereddata || cd || UNICHR(238);
   ELSE
     filteredlength := Length(filtereddata);
     cd:=generateCheckDigitCUCCEAN(filtereddata); 
     replacedata234:=filtereddata;
	
     WHILE  x <= Length(replacedata234) 
     LOOP
	skip:=0;
	IF ASCII(SUBSTR(replacedata234,x,1)) = 234 THEN
		returndata:=returndata || UNICHR(234);
		x:=x+1;
		skip:=1;
	END IF;

	IF skip=0 THEN
 		barcodechar1 :=UNICHR(0);
		barcodechar2 :=UNICHR(0);
 
		barcodechar1:=SUBSTR(replacedata234,x,1);

		IF x+1<=Length(replacedata234) THEN
			barcodechar2:=SUBSTR(replacedata234,x+1,1);
		END IF;

		IF ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2)>=48 AND ASCII(barcodechar2)<=57 THEN
			numvalue:= TO_NUMBER(SUBSTR(replacedata234,x,2));

			IF numvalue <= 94 AND numvalue >= 0 THEN
				numvalue:=numvalue + 32;
			ELSIF numvalue <= 106 AND numvalue >= 95 THEN
				numvalue:=numvalue + 32 + 100;
			ELSE 
				numvalue := -1;
			END IF;
			returndata:=returndata || UNICHR(numvalue);
			x:=x+2;	

		ELSIF (ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2) =234) OR (ASCII(barcodechar1)>=48 AND ASCII(barcodechar1)<=57 AND ASCII(barcodechar2) =0) THEN
			returndata:=returndata || CtoB;
			returndata:=returndata || barcodechar1;
			x:=x+1;
			returndata:=returndata || BtoC;
		END IF;
        END IF;


     END LOOP;

     returndata := returndata || cd;
     returndata := UNICHR(237) || returndata || UNICHR(238);

   END IF; 
   RETURN returndata;

 END ENCODE;

END CONNECTCODE_UCCEAN;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_UCCEAN.ENCODE('(10)1234'));
  DBMS_OUTPUT.put_line(CONNECTCODE_UCCEAN.ENCODE('(10)12345'));
  DBMS_OUTPUT.put_line(CONNECTCODE_UCCEAN.ENCODE('(10)123456789012345675(10)12345'));

END;
/