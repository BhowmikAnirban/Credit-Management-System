-- Copyright 2006-2017 ConnectCode Pte Ltd. All Rights Reserved.
-- This source code is protected by Copyright Laws. You are only allowed to modify
-- and include the source in your application if you have purchased a Distribution License.
-- ===================================================================================
-- ConnectCode Barcode PL/SQL for Oracle
--
-- The formulas in this file can be used for creating barcodes in Oracle.

CREATE OR REPLACE PACKAGE CONNECTCODE_GS1DATABAR14 AS

--Public Functions  
  FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2;

--Internal Functions  
  TYPE V_ARRY IS VARRAY(4) of NUMBER;
  FUNCTION WIDTH16_4_0(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION WIDTH16_4_1(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION WIDTH15_4_0(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION WIDTH15_4_1(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION getCHECKSUM(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION getGS1DATABAR14FINDERS(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER;
  FUNCTION combins(n IN NUMBER, r IN NUMBER) RETURN NUMBER;
  FUNCTION CCBITOR(x IN NUMBER, y IN NUMBER) RETURN NUMBER;
  FUNCTION CCBITNOT (x IN NUMBER) RETURN NUMBER;
  PROCEDURE getGS1widths(widths IN OUT V_ARRY,val IN NUMBER, n IN NUMBER, elements IN NUMBER, maxWidth IN NUMBER, noNarrow IN NUMBER);
  PROCEDURE getGS1widths(widths IN OUT V_ARRY, data IN NUMBER, oddeven IN NUMBER, modules IN NUMBER);
END CONNECTCODE_GS1DATABAR14;
/

CREATE OR REPLACE PACKAGE BODY CONNECTCODE_GS1DATABAR14 AS  
 PROCEDURE getGS1widths(widths IN OUT V_ARRY, data IN NUMBER, oddeven IN NUMBER, modules IN NUMBER) IS
	y NUMBER;
 BEGIN
	IF modules=16 THEN
		IF oddeven=0 THEN
			FOR x IN 0..4
			LOOP
				IF data>=WIDTH16_4_0(x,0) AND data <=WIDTH16_4_0(x,1) THEN
			getGS1widths(widths,MOD((data-WIDTH16_4_0(x,0)),WIDTH16_4_0(x,2)),WIDTH16_4_0(x,3),WIDTH16_4_0(x,4),WIDTH16_4_0(x,5),WIDTH16_4_0(x,6));
				END IF;
			END LOOP;
		ELSE
			FOR x IN 0..4
			LOOP
				IF (data>=WIDTH16_4_1(x,0) AND data <=WIDTH16_4_1(x,1)) THEN
			getGS1widths(widths,TRUNC((data-WIDTH16_4_1(x,0))/WIDTH16_4_1(x,2)),WIDTH16_4_1(x,3),WIDTH16_4_1(x,4),WIDTH16_4_1(x,5),WIDTH16_4_1(x,6));
				END IF;
			END LOOP;
		END IF;
	ELSIF modules=15 THEN
		IF oddeven=0 THEN
			FOR x IN 0..3
			LOOP
				IF (data>=WIDTH15_4_0(x,0) AND data <=WIDTH15_4_0(x,1)) THEN
			getGS1widths(widths,TRUNC((data-WIDTH15_4_0(x,0)) / WIDTH15_4_0(x,2)),WIDTH15_4_0(x,3),WIDTH15_4_0(x,4),WIDTH15_4_0(x,5),WIDTH15_4_0(x,6));
				END IF;
			END LOOP;
		ELSE
			FOR x IN 0..3
			LOOP
				IF (data>=WIDTH15_4_1(x,0) AND data <=WIDTH15_4_1(x,1)) THEN
			getGS1widths(widths,MOD((data-WIDTH15_4_1(x,0)),WIDTH15_4_1(x,2)),WIDTH15_4_1(x,3),WIDTH15_4_1(x,4),WIDTH15_4_1(x,5),WIDTH15_4_1(x,6));
				END IF;
			END LOOP;
		END IF;
	END IF; 
 END getGS1widths;

 PROCEDURE getGS1widths(widths IN OUT V_ARRY, val IN NUMBER, n IN NUMBER, elements IN NUMBER, maxWidth IN NUMBER, noNarrow IN NUMBER) IS
	bar NUMBER;
	elmWidth NUMBER;
	i NUMBER;
	mxwElement NUMBER;
	subVal NUMBER;
      lessVal NUMBER;
	narrowMask  NUMBER := 0;
	newVal NUMBER:=val;
	newN NUMBER:=n;
	expon NUMBER:=0;
 BEGIN

	FOR bar IN 1..elements-1
	LOOP
		elmWidth := 1;
		expon:= (2**(bar-1));

		narrowMask := CCBITOR(narrowMask,expon);

		WHILE newVal >= 0 
		LOOP
			subVal := combins(newN-elmWidth-1, elements-bar-2 +1);
			IF noNarrow=0 AND narrowMask=0 AND (newN-elmWidth-elements+bar-1 +1) >= (elements-bar-1 +1) THEN
				subVal := subVal - combins(newN-elmWidth-(elements-bar +1), elements-bar-2 +1);
			END IF;
			IF (elements-bar-1+1> 1) THEN
				lessVal := 0;
				mxwElement := newN-elmWidth-(elements-bar-2 +1);
				WHILE mxwElement > maxWidth
				LOOP
					lessVal := lessVal + combins(newN-elmWidth-mxwElement-1, elements-bar-3 +1);
					mxwElement:=mxwElement-1;
				END LOOP;
				subVal := subVal - (lessVal * (elements-1-bar +1));
			ELSIF (newN-elmWidth > maxWidth) THEN
				subVal:=subVal-1;
			END IF;
			newVal := newVal - subVal;
			--Post Operations
                  IF (newVal>=0) THEN
				elmWidth:=elmWidth+1;
				narrowMask := bitand(narrowMask,CCBITNOT(2**(bar-1)));
			END IF;

		END LOOP;
		newVal := newVal+subVal;
		newN := newN-elmWidth;
		widths(bar) := elmWidth;	
      END LOOP;
	widths(elements) := newN;

 END getGS1widths;

 FUNCTION combins(n IN NUMBER, r IN NUMBER) RETURN NUMBER IS
	i NUMBER:=0;
      j NUMBER:=0;
      tj NUMBER:=0;
	maxDenom NUMBER:=0;
	minDenom NUMBER:=0;
	val NUMBER:=0;
 BEGIN

	IF (n-r) > r THEN
		minDenom := r;
		maxDenom := n-r;
	ELSE
		minDenom := n-r;
		maxDenom := r;
	END IF;

	val := 1;
	j := 1;
	FOR i IN REVERSE (maxDenom+1)..n 
	LOOP
		val := val*i;
		IF j <= minDenom THEN
			val := val / j;
			j:=j+1;
		END IF;
	END LOOP;

	tj:=j;
	FOR j IN tj..minDenom 
	LOOP	
		val := val/ j;
	END LOOP;

	RETURN val;
 END combins;

 FUNCTION CCBITOR(x IN NUMBER, y IN NUMBER) RETURN NUMBER IS
 BEGIN
  RETURN (x + y - BITAND(x, y));
 END CCBITOR;

 FUNCTION CCBITNOT (x IN NUMBER) RETURN NUMBER IS
 BEGIN
  RETURN (-1 - x);
 END;

 FUNCTION WIDTH16_4_0(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN
	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 160;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 161;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 960;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 10;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 6;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 3;
	ELSIF digit1=1 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 961;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 2014;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 34;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 8;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 5;
	ELSIF digit1=2 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 2015;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 2714;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 70;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 10;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 6;
	ELSIF digit1=3 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=4 AND digit2=0 THEN
		RETURN 2715;
	ELSIF digit1=4 AND digit2=1 THEN
		RETURN 2840;
	ELSIF digit1=4 AND digit2=2 THEN
		RETURN 126;
	ELSIF digit1=4 AND digit2=3 THEN
		RETURN 12;
	ELSIF digit1=4 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=4 AND digit2=5 THEN
		RETURN 8;
	ELSIF digit1=4 AND digit2=6 THEN
		RETURN 0;
	END IF;

	RETURN 0;
 END WIDTH16_4_0;

 FUNCTION WIDTH16_4_1(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN
	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 160;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 12;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 8;
	ELSIF digit1=0 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 161;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 960;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 10;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 10;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 6;
	ELSIF digit1=1 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 961;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 2014;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 34;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 8;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 4;
	ELSIF digit1=2 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 2015;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 2714;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 70;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 6;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 3;
	ELSIF digit1=3 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=4 AND digit2=0 THEN
		RETURN 2715;
	ELSIF digit1=4 AND digit2=1 THEN
		RETURN 2840;
	ELSIF digit1=4 AND digit2=2 THEN
		RETURN 126;
	ELSIF digit1=4 AND digit2=3 THEN
		RETURN 4;
	ELSIF digit1=4 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=4 AND digit2=5 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=6 THEN
		RETURN 1;
	END IF;

	RETURN 0;
 END WIDTH16_4_1;

 FUNCTION WIDTH15_4_0(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN
	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 335;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 10;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 7;
	ELSIF digit1=0 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 336;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 1035;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 20;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 8;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 5;
	ELSIF digit1=1 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 1036;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 1515;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 48;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 6;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 3;
	ELSIF digit1=2 AND digit2=6 THEN
		RETURN 1;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 1516;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 1596;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 81;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 4;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=6 THEN
		RETURN 1;
	END IF;

	RETURN 0;
 END WIDTH15_4_0;

 FUNCTION WIDTH15_4_1(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN
	IF digit1=0 AND digit2=0 THEN
		RETURN 0;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 335;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 5;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 2;
	ELSIF digit1=0 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 336;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 1035;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 20;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 7;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 1036;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 1515;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 48;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 9;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 6;
	ELSIF digit1=2 AND digit2=6 THEN
		RETURN 0;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 1516;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 1596;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 81;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 11;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 4;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 8;
	ELSIF digit1=3 AND digit2=6 THEN
		RETURN 0;
	END IF;

	RETURN 0;
 END WIDTH15_4_1;

 FUNCTION getCHECKSUM(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN
	IF digit1=0 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 3;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 9;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 27;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 2;
	ELSIF digit1=0 AND digit2=5 THEN
		RETURN 6;
	ELSIF digit1=0 AND digit2=6 THEN
		RETURN 18;
	ELSIF digit1=0 AND digit2=7 THEN
		RETURN 54;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 4;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 12;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 36;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 29;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 8;
	ELSIF digit1=1 AND digit2=5 THEN
		RETURN 24;
	ELSIF digit1=1 AND digit2=6 THEN
		RETURN 72;
	ELSIF digit1=1 AND digit2=7 THEN
		RETURN 58;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 16;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 48;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 65;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 37;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 32;
	ELSIF digit1=2 AND digit2=5 THEN
		RETURN 17;
	ELSIF digit1=2 AND digit2=6 THEN
		RETURN 51;
	ELSIF digit1=2 AND digit2=7 THEN
		RETURN 74;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 64;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 34;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 23;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 69;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 49;
	ELSIF digit1=3 AND digit2=5 THEN
		RETURN 68;
	ELSIF digit1=3 AND digit2=6 THEN
		RETURN 46;
	ELSIF digit1=3 AND digit2=7 THEN
		RETURN 59;
	END IF;

	RETURN 0;
 END getCHECKSUM;

 FUNCTION getGS1DATABAR14FINDERS(digit1 IN NUMBER, digit2 IN NUMBER) RETURN NUMBER IS
 BEGIN

	IF digit1=0 AND digit2=0 THEN
		RETURN 3;
	ELSIF digit1=0 AND digit2=1 THEN
		RETURN 8;
	ELSIF digit1=0 AND digit2=2 THEN
		RETURN 2;
	ELSIF digit1=0 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=0 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=1 AND digit2=0 THEN
		RETURN 3;
	ELSIF digit1=1 AND digit2=1 THEN
		RETURN 5;
	ELSIF digit1=1 AND digit2=2 THEN
		RETURN 5;
	ELSIF digit1=1 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=1 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=2 AND digit2=0 THEN
		RETURN 3;
	ELSIF digit1=2 AND digit2=1 THEN
		RETURN 3;
	ELSIF digit1=2 AND digit2=2 THEN
		RETURN 7;
	ELSIF digit1=2 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=2 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=3 AND digit2=0 THEN
		RETURN 3;
	ELSIF digit1=3 AND digit2=1 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=2 THEN
		RETURN 9;
	ELSIF digit1=3 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=3 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=4 AND digit2=0 THEN
		RETURN 2;
	ELSIF digit1=4 AND digit2=1 THEN
		RETURN 7;
	ELSIF digit1=4 AND digit2=2 THEN
		RETURN 4;
	ELSIF digit1=4 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=4 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=5 AND digit2=0 THEN
		RETURN 2;
	ELSIF digit1=5 AND digit2=1 THEN
		RETURN 5;
	ELSIF digit1=5 AND digit2=2 THEN
		RETURN 6;
	ELSIF digit1=5 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=5 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=6 AND digit2=0 THEN
		RETURN 2;
	ELSIF digit1=6 AND digit2=1 THEN
		RETURN 3;
	ELSIF digit1=6 AND digit2=2 THEN
		RETURN 8;
	ELSIF digit1=6 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=6 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=7 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=1 THEN
		RETURN 5;
	ELSIF digit1=7 AND digit2=2 THEN
		RETURN 7;
	ELSIF digit1=7 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=7 AND digit2=4 THEN
		RETURN 1;
	END IF;

	IF digit1=8 AND digit2=0 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=1 THEN
		RETURN 3;
	ELSIF digit1=8 AND digit2=2 THEN
		RETURN 9;
	ELSIF digit1=8 AND digit2=3 THEN
		RETURN 1;
	ELSIF digit1=8 AND digit2=4 THEN
		RETURN 1;
	END IF;

	RETURN 0;

 END getGS1DATABAR14FINDERS;

 FUNCTION ENCODE (data IN VARCHAR2) RETURN VARCHAR2 IS
   linkage      NUMBER := 0;
   black      NUMBER := 0;
   tempchar     VARCHAR2(2);
   sumvalue     NUMBER := 0;
   onevalue     NUMBER := 0;	
   lendiff      NUMBER := 0;
   filtereddata VARCHAR2(255) := '';
   resultdata   VARCHAR2(560) := '';
   bwresult   VARCHAR2(560) := '';
   filteredlength NUMBER(5) := Length(data);	
   datalength   NUMBER:=0;
   value NUMBER(20):=0;
   leftdata NUMBER(20);
   rightdata NUMBER(20);
   data1 NUMBER(20);
   data2 NUMBER(20);
   data3 NUMBER(20);
   data4 NUMBER(20);
   sumdata NUMBER(20);
   cleft NUMBER(20);
   cright NUMBER(20);
   ctemp NUMBER(20);
   checksum NUMBER(20);
   widthsodd V_ARRY:=V_ARRY();
   widthseven V_ARRY:=V_ARRY();
   results1odd V_ARRY:=V_ARRY();
   results1even V_ARRY:=V_ARRY();
   results2odd V_ARRY:=V_ARRY();
   results2even V_ARRY:=V_ARRY();
   results3odd V_ARRY:=V_ARRY();
   results3even V_ARRY:=V_ARRY();
   results4odd V_ARRY:=V_ARRY();
   results4even V_ARRY:=V_ARRY();

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
   IF filteredlength > 14 THEN
    filtereddata := SUBSTR(filtereddata,1,14);
   END IF;

   filteredlength := Length(filtereddata);	
   IF filteredlength < 14 THEN
	lendiff:=14-filteredlength;
	FOR counter IN 1..lendiff
   	LOOP
	    filtereddata := '0' || filtereddata;	
	END LOOP;
   END IF;

   filtereddata := SUBSTR(filtereddata,1,13);  --Exclude Check Digit

   IF linkage=1 THEN
	filtereddata := '1' || filtereddata;
   END IF;

   FOR x IN 1..Length(filtereddata)
   LOOP
	value:= (value * 10) + ASCII(SUBSTR(filtereddata,x,1))-48;	
   END LOOP;

   sumdata:=0;
   leftdata:=TRUNC(value / 4537077);
   rightdata:=MOD(value,4537077);
   data1:=TRUNC(leftdata / 1597); 
   data2:=MOD(leftdata,1597);
   data3:=TRUNC(rightdata / 1597); 
   data4:=MOD(rightdata,1597);

   widthsodd.EXTEND(4);
   widthseven.EXTEND(4);
   results1odd.EXTEND(4);
   results1even.EXTEND(4);
   results2odd.EXTEND(4);
   results2even.EXTEND(4);
   results3odd.EXTEND(4);
   results3even.EXTEND(4);
   results4odd.EXTEND(4);
   results4even.EXTEND(4);
   getGS1widths(widthsodd,data1,1,16);
   getGS1widths(widthseven,data1,0,16);

   FOR x IN 1..4
   LOOP
	results1odd(x):=widthsodd(x);
	results1even(x):=widthseven(x);
	sumdata:=sumdata+getCHECKSUM(0,((x-1)*2))*widthsodd(x)+getCHECKSUM(0,((x-1)*2)+1)*widthseven(x);
   END LOOP;

   getGS1widths(widthsodd,data2,1,15);
   getGS1widths(widthseven,data2,0,15);

   FOR x IN 1..4
   LOOP
	results2odd(x):=widthsodd(x);
	results2even(x):=widthseven(x);
	sumdata:=sumdata+getCHECKSUM(1,((x-1)*2))*widthsodd(x)+getCHECKSUM(1,((x-1)*2)+1)*widthseven(x);
   END LOOP;

   getGS1widths(widthsodd,data3,1,16);
   getGS1widths(widthseven,data3,0,16);

   FOR x IN 1..4
   LOOP
	results3odd(x):=widthsodd(x);
	results3even(x):=widthseven(x);
	sumdata:=sumdata+getCHECKSUM(2,((x-1)*2))*widthsodd(x)+getCHECKSUM(2,((x-1)*2)+1)*widthseven(x);
   END LOOP;

   getGS1widths(widthsodd,data4,1,15);
   getGS1widths(widthseven,data4,0,15);

   FOR x IN 1..4
   LOOP
	results4odd(x):=widthsodd(x);
	results4even(x):=widthseven(x);
	sumdata:=sumdata+getCHECKSUM(3,((x-1)*2))*widthsodd(x)+getCHECKSUM(3,((x-1)*2)+1)*widthseven(x);
   END LOOP;

   checksum:=MOD(sumdata,79);

   ctemp:=checksum;
   IF ctemp >= 8 THEN
 	ctemp:=ctemp+1;
   END IF;

   IF ctemp >= 72 THEN
	ctemp:=ctemp+1;
   END IF;

    cleft := TRUNC(ctemp / 9);	
    cright := MOD(ctemp,9);

    resultdata := '11'; --Left Guard

    FOR x IN 1..4  
    LOOP
	resultdata := resultdata || CHR(results1odd(x)+48) || CHR(results1even(x)+48);
    END LOOP;

    FOR x IN 1..5  
    LOOP
	resultdata := resultdata || CHR(getGS1DATABAR14FINDERS(cleft,x-1)+48);
    END LOOP;

    FOR x IN REVERSE 1..4 
    LOOP
	resultdata := resultdata || CHR(results2even(x)+48) || CHR(results2odd(x)+48);
    END LOOP;

    FOR x IN 1..4 
    LOOP
	resultdata := resultdata || CHR(results4odd(x)+48) || CHR(results4even(x)+48);
    END LOOP;

    FOR x IN REVERSE 1..5 
    LOOP
	resultdata := resultdata || CHR(getGS1DATABAR14FINDERS(cright,x-1)+48);
    END LOOP;

    FOR x IN REVERSE 1..4 
    LOOP
	resultdata := resultdata || CHR(results3even(x)+48) || CHR(results3odd(x)+48);
    END LOOP;

    resultdata := resultdata||'11'; --Right Guard

    bwresult:='';
    black:=0;
    filteredlength:=Length(resultdata);
    FOR x IN 1..filteredlength 
    LOOP
	IF black=0 THEN
		bwresult:=bwresult||CHR(ASCII(SUBSTR(resultdata,x,1))+48);
		black:=1;
	ELSE
		bwresult:=bwresult||CHR(ASCII(SUBSTR(resultdata,x,1))+16);
		black:=0;
	END IF;
    END LOOP;

   RETURN bwresult;

 END ENCODE;

END CONNECTCODE_GS1DATABAR14;
/

-- Test the barcode encodation
DECLARE
BEGIN
  DBMS_OUTPUT.put_line(CONNECTCODE_GS1DATABAR14.ENCODE('12401234567898'));

END;
/