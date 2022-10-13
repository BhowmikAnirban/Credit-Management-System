-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.


CREATE OR REPLACE PACKAGE CONNECTCODE_CODE39ASCII AS
  
--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2, chk IN NUMBER) RETURN VARCHAR2;

--Internal Functions
  FUNCTION getCode39MappedString (asciivalue IN NUMBER) RETURN VARCHAR2;
END CONNECTCODE_CODE39ASCII;
/


CREATE OR REPLACE PACKAGE BODY CONNECTCODE_CODE39ASCII AS  

  FUNCTION getCode39MappedString (asciivalue IN NUMBER) RETURN VARCHAR2 IS
	returnstring VARCHAR2(2); 
  BEGIN
	IF asciivalue = 0 THEN 
		returnstring:='%U';
	ELSIF asciivalue = 1 THEN
		returnstring:='$A';
	ELSIF asciivalue = 2 THEN
		returnstring:='$B';
	ELSIF asciivalue = 3 THEN
		returnstring:='$C';
	ELSIF asciivalue = 4 THEN
		returnstring:='$D';
	ELSIF asciivalue = 5 THEN
		returnstring:='$E';
	ELSIF asciivalue = 6 THEN
		returnstring:='$F';
	ELSIF asciivalue = 7 THEN
		returnstring:='$G';
	ELSIF asciivalue = 8 THEN
		returnstring:='$H';
	ELSIF asciivalue = 9 THEN
		returnstring:='$I';
	ELSIF asciivalue = 10 THEN
		returnstring:='$J';
	ELSIF asciivalue = 11 THEN
		returnstring:='$K';
	ELSIF asciivalue = 12 THEN
		returnstring:='$L';
	ELSIF asciivalue = 13 THEN
		returnstring:='$M';
	ELSIF asciivalue = 14 THEN
		returnstring:='$N';
	ELSIF asciivalue = 15 THEN
		returnstring:='$O';
	ELSIF asciivalue = 16 THEN
		returnstring:='$P';
	ELSIF asciivalue = 17 THEN
		returnstring:='$Q';
	ELSIF asciivalue = 18 THEN
		returnstring:='$R';
	ELSIF asciivalue = 19 THEN
		returnstring:='$S';
	ELSIF asciivalue = 20 THEN
		returnstring:='$T';
	ELSIF asciivalue = 21 THEN
		returnstring:='$U';
	ELSIF asciivalue = 22 THEN
		returnstring:='$V';
	ELSIF asciivalue = 23 THEN
		returnstring:='$W';
	ELSIF asciivalue = 24 THEN
		returnstring:='$X';
	ELSIF asciivalue = 25 THEN
		returnstring:='$Y';
	ELSIF asciivalue = 26 THEN
		returnstring:='$Z';
	ELSIF asciivalue = 27 THEN
		returnstring:='%A';
	ELSIF asciivalue = 28 THEN
		returnstring:='%B';
	ELSIF asciivalue = 29 THEN
		returnstring:='%C';
	ELSIF asciivalue = 30 THEN
		returnstring:='%D';
	ELSIF asciivalue = 31 THEN
		returnstring:='%E';
	ELSIF asciivalue = 32 THEN
		returnstring:=' ';
	ELSIF asciivalue = 33 THEN
		returnstring:='/A';
	ELSIF asciivalue = 34 THEN
		returnstring:='/B';
	ELSIF asciivalue = 35 THEN
		returnstring:='/C';
	ELSIF asciivalue = 36 THEN
		returnstring:='/D';
	ELSIF asciivalue = 37 THEN
		returnstring:='/E';
	ELSIF asciivalue = 38 THEN
		returnstring:='/F';
	ELSIF asciivalue = 39 THEN
		returnstring:='/G';
	ELSIF asciivalue = 40 THEN
		returnstring:='/H';
	ELSIF asciivalue = 41 THEN
		returnstring:='/I';
	ELSIF asciivalue = 42 THEN
		returnstring:='/J';
	ELSIF asciivalue = 43 THEN
		returnstring:='/K';
	ELSIF asciivalue = 44 THEN
		returnstring:='/L';
	ELSIF asciivalue = 45 THEN
		returnstring:='-';
	ELSIF asciivalue = 46 THEN
		returnstring:='.';
	ELSIF asciivalue = 47 THEN
		returnstring:='/O';
	ELSIF asciivalue = 48 THEN
		returnstring:='0';
	ELSIF asciivalue = 49 THEN
		returnstring:='1';
	ELSIF asciivalue = 50 THEN
		returnstring:='2';
	ELSIF asciivalue = 51 THEN
		returnstring:='3';
	ELSIF asciivalue = 52 THEN
		returnstring:='4';
	ELSIF asciivalue = 53 THEN
		returnstring:='5';
	ELSIF asciivalue = 54 THEN
		returnstring:='6';
	ELSIF asciivalue = 55 THEN
		returnstring:='7';
	ELSIF asciivalue = 56 THEN
		returnstring:='8';
	ELSIF asciivalue = 57 THEN
		returnstring:='9';
	ELSIF asciivalue = 58 THEN
		returnstring:='/Z';
	ELSIF asciivalue = 59 THEN
		returnstring:='%F';
	ELSIF asciivalue = 60 THEN
		returnstring:='%G';
	ELSIF asciivalue = 61 THEN
		returnstring:='%H';
	ELSIF asciivalue = 62 THEN
		returnstring:='%I';
	ELSIF asciivalue = 63 THEN
		returnstring:='%J';
	ELSIF asciivalue = 64 THEN
		returnstring:='%V';
	ELSIF asciivalue = 65 THEN
		returnstring:='A';
	ELSIF asciivalue = 66 THEN
		returnstring:='B';
	ELSIF asciivalue = 67 THEN
		returnstring:='C';
	ELSIF asciivalue = 68 THEN
		returnstring:='D';
	ELSIF asciivalue = 69 THEN
		returnstring:='E';
	ELSIF asciivalue = 70 THEN
		returnstring:='F';
	ELSIF asciivalue = 71 THEN
		returnstring:='G';
	ELSIF asciivalue = 72 THEN
		returnstring:='H';
	ELSIF asciivalue = 73 THEN
		returnstring:='I';
	ELSIF asciivalue = 74 THEN
		returnstring:='J';
	ELSIF asciivalue = 75 THEN
		returnstring:='K';
	ELSIF asciivalue = 76 THEN
		returnstring:='L';
	ELSIF asciivalue = 77 THEN
		returnstring:='M';
	ELSIF asciivalue = 78 THEN
		returnstring:='N';
	ELSIF asciivalue = 79 THEN
		returnstring:='O';
	ELSIF asciivalue = 80 THEN
		returnstring:='P';
	ELSIF asciivalue = 81 THEN
		returnstring:='Q';
	ELSIF asciivalue = 82 THEN
		returnstring:='R';
	ELSIF asciivalue = 83 THEN
		returnstring:='S';
	ELSIF asciivalue = 84 THEN
		returnstring:='T';
	ELSIF asciivalue = 85 THEN
		returnstring:='U';
	ELSIF asciivalue = 86 THEN
		returnstring:='V';
	ELSIF asciivalue = 87 THEN
		returnstring:='W';
	ELSIF asciivalue = 88 THEN
		returnstring:='X';
	ELSIF asciivalue = 89 THEN
		returnstring:='Y';
	ELSIF asciivalue = 90 THEN
		returnstring:='Z';
	ELSIF asciivalue = 91 THEN
		returnstring:='%K';
	ELSIF asciivalue = 92 THEN
		returnstring:='%L';
	ELSIF asciivalue = 93 THEN
		returnstring:='%M';
	ELSIF asciivalue = 94 THEN
		returnstring:='%N';
	ELSIF asciivalue = 95 THEN
		returnstring:='%O';
	ELSIF asciivalue = 96 THEN
		returnstring:='%W';
	ELSIF asciivalue = 97 THEN
		returnstring:='+A';
	ELSIF asciivalue = 98 THEN
		returnstring:='+B';
	ELSIF asciivalue = 99 THEN
		returnstring:='+C';
	ELSIF asciivalue = 100 THEN
		returnstring:='+D';
	ELSIF asciivalue = 101 THEN
		returnstring:='+E';
	ELSIF asciivalue = 102 THEN
		returnstring:='+F';
	ELSIF asciivalue = 103 THEN
		returnstring:='+G';
	ELSIF asciivalue = 104 THEN
		returnstring:='+H';
	ELSIF asciivalue = 105 THEN
		returnstring:='+I';
	ELSIF asciivalue = 106 THEN
		returnstring:='+J';
	ELSIF asciivalue = 107 THEN
		returnstring:='+K';
	ELSIF asciivalue = 108 THEN
		returnstring:='+L';
	ELSIF asciivalue = 109 THEN
		returnstring:='+M';
	ELSIF asciivalue = 110 THEN
		returnstring:='+N';
	ELSIF asciivalue = 111 THEN
		returnstring:='+O';
	ELSIF asciivalue = 112 THEN
		returnstring:='+P';
	ELSIF asciivalue = 113 THEN
		returnstring:='+Q';
	ELSIF asciivalue = 114 THEN
		returnstring:='+R';
	ELSIF asciivalue = 115 THEN
		returnstring:='+S';
	ELSIF asciivalue = 116 THEN
		returnstring:='+T';
	ELSIF asciivalue = 117 THEN
		returnstring:='+U';
	ELSIF asciivalue = 118 THEN
		returnstring:='+V';
	ELSIF asciivalue = 119 THEN
		returnstring:='+W';
	ELSIF asciivalue = 120 THEN
		returnstring:='+X';
	ELSIF asciivalue = 121 THEN
		returnstring:='+Y';
	ELSIF asciivalue = 122 THEN
		returnstring:='+Z';
	ELSIF asciivalue = 123 THEN
		returnstring:='%P';
	ELSIF asciivalue = 124 THEN
		returnstring:='%Q';
	ELSIF asciivalue = 125 THEN
		returnstring:='%R';
	ELSIF asciivalue = 126 THEN
		returnstring:='%S';
	ELSIF asciivalue = 127 THEN
		returnstring:='%T';
	END IF;		
	RETURN returnstring;
  END;

  FUNCTION ENCODE(data IN VARCHAR2, chk IN NUMBER) RETURN VARCHAR2 IS
    tempchar     VARCHAR2(1);
    sumvalue     NUMBER := 0;
    onevalue     NUMBER := 0;	
    cd           VARCHAR2(1);
    filtereddata VARCHAR2(255) := '';
    returndata   VARCHAR2(560) := '';
    filteredlength NUMBER(5) := Length(data);	
  BEGIN
    IF filteredlength IS NULL THEN
	RETURN '**';
    END IF;

    FOR counter IN 1..filteredlength
    LOOP
	tempchar := SUBSTR(data,counter,1);
	onevalue := ASCII(tempchar);
	IF onevalue >= 0 OR onevalue <=127 THEN 
		filtereddata := filtereddata || tempchar;
	END IF;
    END LOOP;

    filteredlength := Length(filtereddata);	
    IF chk = 1 THEN
	IF filteredlength > 254 THEN
		filtereddata := SUBSTR(filtereddata,1,254);
	END IF;
    ELSE
	IF filteredlength > 255 THEN
		filtereddata := SUBSTR(filtereddata,1,255);
	END IF;
    END IF;

    filteredlength := Length(filtereddata);	
    FOR counter IN 1..filteredlength
    LOOP
	tempchar := SUBSTR(filtereddata,counter,1);
	onevalue := ASCII(tempchar);
	IF onevalue >= 0 OR onevalue <=127 THEN 
		returndata := returndata || getCode39MappedString(onevalue);
	END IF;
    END LOOP;
    filtereddata := returndata;

    IF chk = 1 THEN
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
	
    END IF;
    RETURN '*' || filtereddata || cd || '*';

  END ENCODE;

END CONNECTCODE_CODE39ASCII;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_CODE39ASCII.ENCODE('12345678',1));
END;
/