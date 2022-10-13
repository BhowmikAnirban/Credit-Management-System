-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_CODE39 AS
  
--Public Functions  
  FUNCTION ENCODE(data VARCHAR2, chk NUMBER) RETURN VARCHAR2;
END CONNECTCODE_CODE39;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_CODE39 AS  

  FUNCTION ENCODE(data IN VARCHAR2, chk IN NUMBER) RETURN VARCHAR2 IS
    tempchar     VARCHAR2(1);
    sumvalue     NUMBER := 0;
    onevalue     NUMBER := 0;	
    cd           VARCHAR2(1);
    filtereddata VARCHAR2(255) := '';
    filteredlength NUMBER(5) := Length(data);	
  BEGIN
    IF filteredlength IS NULL THEN
	RETURN '**';
    END IF;

    FOR counter IN 1..filteredlength
    LOOP
	tempchar := SUBSTR(data,counter,1);
        if tempchar = '0' OR tempchar = '1' OR tempchar = '2' OR tempchar = '3' OR tempchar = '4' OR tempchar = '5' OR tempchar = '6' OR tempchar = '7' OR tempchar = '8' OR 

tempchar = '9' OR tempchar = 'A' OR tempchar = 'B' OR tempchar = 'C' OR tempchar = 'D' OR tempchar = 'E' OR tempchar = 'F' OR tempchar = 'G' OR tempchar = 'H' OR tempchar = 'I' OR 

tempchar = 'J' OR tempchar = 'K' OR tempchar = 'L' OR tempchar = 'M' OR tempchar = 'N' OR tempchar = 'O' OR tempchar = 'P' OR tempchar = 'Q' OR tempchar = 'R' OR tempchar = 'S' OR 

tempchar = 'T' OR tempchar = 'U' OR tempchar = 'V' OR tempchar = 'W' OR tempchar = 'X' OR tempchar = 'Y' OR tempchar = 'Z' OR tempchar = '-' OR tempchar = '.' OR tempchar = ' ' OR 

tempchar = '$' OR tempchar = '/' OR tempchar = '+' OR tempchar = '%' THEN 
		filtereddata := filtereddata || tempchar;
	END IF;
    END LOOP;

    filteredlength := Length(filtereddata);	

    IF chk = 1 THEN
	IF filteredlength > 254 THEN
		filtereddata := SUBSTR(filtereddata,1,254);
	END IF;
      filteredlength := Length(filtereddata);	

      IF filteredlength IS NULL THEN
		RETURN '**';
      END IF;

	FOR counter IN 1..filteredlength
	LOOP
			tempchar := SUBSTR(filtereddata,counter,1);
		        IF tempchar = '0' THEN
				onevalue:=0;
			ELSIF tempchar = '1' THEN
				onevalue:=1;
			ELSIF tempchar = '2' THEN
				onevalue:=2;
			ELSIF tempchar = '3' THEN
				onevalue:=3;
			ELSIF tempchar = '4' THEN
				onevalue:=4;
			ELSIF tempchar = '5' THEN
				onevalue:=5;
			ELSIF tempchar = '6' THEN
				onevalue:=6;
			ELSIF tempchar = '7' THEN
				onevalue:=7;
			ELSIF tempchar = '8' THEN
				onevalue:=8;
			ELSIF tempchar = '9' THEN
				onevalue:=9;
			ELSIF tempchar = 'A' THEN
				onevalue:=10;
			ELSIF tempchar = 'B' THEN
				onevalue:=11;
			ELSIF tempchar = 'C' THEN
				onevalue:=12;
			ELSIF tempchar = 'D' THEN
				onevalue:=13;
			ELSIF tempchar = 'E' THEN
				onevalue:=14;
			ELSIF tempchar = 'F' THEN
				onevalue:=15;
			ELSIF tempchar = 'G' THEN
				onevalue:=16;
			ELSIF tempchar = 'H' THEN
				onevalue:=17;
			ELSIF tempchar = 'I' THEN
				onevalue:=18;
			ELSIF tempchar = 'J' THEN
				onevalue:=19;
			ELSIF tempchar = 'K' THEN
				onevalue:=20;
			ELSIF tempchar = 'L' THEN
				onevalue:=21;
			ELSIF tempchar = 'M' THEN
				onevalue:=22;
			ELSIF tempchar = 'N' THEN
				onevalue:=23;
			ELSIF tempchar = 'O' THEN
				onevalue:=24;
			ELSIF tempchar = 'P' THEN
				onevalue:=25;
			ELSIF tempchar = 'Q' THEN
				onevalue:=26;
			ELSIF tempchar = 'R' THEN
				onevalue:=27;
			ELSIF tempchar = 'S' THEN
				onevalue:=28;
			ELSIF tempchar = 'T' THEN
				onevalue:=29;
			ELSIF tempchar = 'U' THEN
				onevalue:=30;
			ELSIF tempchar = 'V' THEN
				onevalue:=31;
			ELSIF tempchar = 'W' THEN
				onevalue:=32;
			ELSIF tempchar = 'X' THEN
				onevalue:=33;
			ELSIF tempchar = 'Y' THEN
				onevalue:=34;
			ELSIF tempchar = 'Z' THEN
				onevalue:=35;
			ELSIF tempchar = '-' THEN
				onevalue:=36;
			ELSIF tempchar = '.' THEN
				onevalue:=37;
			ELSIF tempchar = ' ' THEN
				onevalue:=38;
			ELSIF tempchar = '$' THEN
				onevalue:=39;
			ELSIF tempchar = '/' THEN
				onevalue:=40;
			ELSIF tempchar = '+' THEN
				onevalue:=41;
			ELSIF tempchar = '%' THEN 
				onevalue:=42;
			END IF;
			sumvalue := sumvalue + onevalue;						
	END LOOP;
	sumvalue := MOD(sumvalue,43);
	IF sumvalue = 0 THEN
		cd:='0';
	ELSIF sumvalue = 1 THEN
		cd:='1';
	ELSIF sumvalue = 2 THEN
		cd:='2';
	ELSIF sumvalue = 3 THEN
		cd:='3';
	ELSIF sumvalue = 4 THEN
		cd:='4';
	ELSIF sumvalue = 5 THEN
		cd:='5';
	ELSIF sumvalue = 6 THEN
		cd:='6';
	ELSIF sumvalue = 7 THEN
		cd:='7';
	ELSIF sumvalue = 8 THEN
		cd:='8';
	ELSIF sumvalue = 9 THEN
		cd:='9';
	ELSIF sumvalue = 10 THEN
		cd:='A';
	ELSIF sumvalue = 11 THEN
		cd:='B';
	ELSIF sumvalue = 12 THEN
		cd:='C';
	ELSIF sumvalue = 13 THEN
		cd:='D';
	ELSIF sumvalue = 14 THEN
		cd:='E';
	ELSIF sumvalue = 15 THEN
		cd:='F';
	ELSIF sumvalue = 16 THEN
		cd:='G';
	ELSIF sumvalue = 17 THEN
		cd:='H';
	ELSIF sumvalue = 18 THEN
		cd:='I';
	ELSIF sumvalue = 19 THEN
		cd:='J';
	ELSIF sumvalue = 20 THEN
		cd:='K';
	ELSIF sumvalue = 21 THEN
		cd:='L';
	ELSIF sumvalue = 22 THEN
		cd:='M';
	ELSIF sumvalue = 23 THEN
		cd:='N';
	ELSIF sumvalue = 24 THEN
		cd:='O';
	ELSIF sumvalue = 25 THEN
		cd:='P';
	ELSIF sumvalue = 26 THEN
		cd:='Q';
	ELSIF sumvalue = 27 THEN
		cd:='R';
	ELSIF sumvalue = 28 THEN
		cd:='S';
	ELSIF sumvalue = 29 THEN
		cd:='T';
	ELSIF sumvalue = 30 THEN
		cd:='U';
	ELSIF sumvalue = 31 THEN
		cd:='V';
	ELSIF sumvalue = 32 THEN
		cd:='W';
	ELSIF sumvalue = 33 THEN
		cd:='X';
	ELSIF sumvalue = 34 THEN
		cd:='Y';
	ELSIF sumvalue = 35 THEN
		cd:='Z';
	ELSIF sumvalue = 36 THEN
		cd:='-';
	ELSIF sumvalue = 37 THEN
		cd:='.';
	ELSIF sumvalue = 38 THEN
		cd:=' ';
	ELSIF sumvalue = 39 THEN
		cd:='$';
	ELSIF sumvalue = 40 THEN
		cd:='/';
	ELSIF sumvalue = 41 THEN
		cd:='+';
	ELSIF sumvalue = 42 THEN
		cd:='%';
	END IF;
    ELSE
	IF filteredlength > 255 THEN
		filtereddata := SUBSTR(filtereddata,1,255);
	END IF;
    END IF;
    RETURN '*' || filtereddata || cd || '*';
  END ENCODE;

END CONNECTCODE_CODE39;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE39.ENCODE('12345678',1));
END;
/