/*
 * ConnectCode
 *
 * Copyright (c) 2006-2018 ConnectCode Pte Ltd (http://www.barcoderesource.com)
 * All Rights Reserved.
 *
 * This source code is protected by International Copyright Laws. You are only allowed to modify
 * and include the source in your application if you have purchased a Distribution License.
 *
 * http://www.barcoderesource.com
 *
 */

		var connectcode_human_readable_text="";

		function ConnectCode_Encode_EAN13(data,hr)
		{
                   var EAN13PARITYMAP=new Array(10);
                   EAN13PARITYMAP[0]=new Array(6);
                   EAN13PARITYMAP[1]=new Array(6);
                   EAN13PARITYMAP[2]=new Array(6);
                   EAN13PARITYMAP[3]=new Array(6);
                   EAN13PARITYMAP[4]=new Array(6);
                   EAN13PARITYMAP[5]=new Array(6);
                   EAN13PARITYMAP[6]=new Array(6);
                   EAN13PARITYMAP[7]=new Array(6);
                   EAN13PARITYMAP[8]=new Array(6);
                   EAN13PARITYMAP[9]=new Array(6);
                   
                   EAN13PARITYMAP[0][0] = 0;
                   EAN13PARITYMAP[0][1] = 0;
                   EAN13PARITYMAP[0][2] = 0;
                   EAN13PARITYMAP[0][3] = 0;
                   EAN13PARITYMAP[0][4] = 0;
                   EAN13PARITYMAP[0][5] = 0;
                   
                   EAN13PARITYMAP[1][0] = 0;
                   EAN13PARITYMAP[1][1] = 0;
                   EAN13PARITYMAP[1][2] = 1;
                   EAN13PARITYMAP[1][3] = 0;
                   EAN13PARITYMAP[1][4] = 1;
                   EAN13PARITYMAP[1][5] = 1;
                   
                   EAN13PARITYMAP[2][0] = 0;
                   EAN13PARITYMAP[2][1] = 0;
                   EAN13PARITYMAP[2][2] = 1;
                   EAN13PARITYMAP[2][3] = 1;
                   EAN13PARITYMAP[2][4] = 0;
                   EAN13PARITYMAP[2][5] = 1;
                   
                   EAN13PARITYMAP[3][0] = 0;
                   EAN13PARITYMAP[3][1] = 0;
                   EAN13PARITYMAP[3][2] = 1;
                   EAN13PARITYMAP[3][3] = 1;
                   EAN13PARITYMAP[3][4] = 1;
                   EAN13PARITYMAP[3][5] = 0;
                   
                   EAN13PARITYMAP[4][0] = 0;
                   EAN13PARITYMAP[4][1] = 1;
                   EAN13PARITYMAP[4][2] = 0;
                   EAN13PARITYMAP[4][3] = 0;
                   EAN13PARITYMAP[4][4] = 1;
                   EAN13PARITYMAP[4][5] = 1;
                   
                   EAN13PARITYMAP[5][0] = 0;
                   EAN13PARITYMAP[5][1] = 1;
                   EAN13PARITYMAP[5][2] = 1;
                   EAN13PARITYMAP[5][3] = 0;
                   EAN13PARITYMAP[5][4] = 0;
                   EAN13PARITYMAP[5][5] = 1;
                   
                   EAN13PARITYMAP[6][0] = 0;
                   EAN13PARITYMAP[6][1] = 1;
                   EAN13PARITYMAP[6][2] = 1;
                   EAN13PARITYMAP[6][3] = 1;
                   EAN13PARITYMAP[6][4] = 0;
                   EAN13PARITYMAP[6][5] = 0;
                   
                   EAN13PARITYMAP[7][0] = 0;
                   EAN13PARITYMAP[7][1] = 1;
                   EAN13PARITYMAP[7][2] = 0;
                   EAN13PARITYMAP[7][3] = 1;
                   EAN13PARITYMAP[7][4] = 0;
                   EAN13PARITYMAP[7][5] = 1;
                   
                   EAN13PARITYMAP[8][0] = 0;
                   EAN13PARITYMAP[8][1] = 1;
                   EAN13PARITYMAP[8][2] = 0;
                   EAN13PARITYMAP[8][3] = 1;
                   EAN13PARITYMAP[8][4] = 1;
                   EAN13PARITYMAP[8][5] = 0;
                   
                   EAN13PARITYMAP[9][0] = 0;
                   EAN13PARITYMAP[9][1] = 1;
                   EAN13PARITYMAP[9][2] = 1;
                   EAN13PARITYMAP[9][3] = 0;
                   EAN13PARITYMAP[9][4] = 1;
                   EAN13PARITYMAP[9][5] = 0;
               
                   var Result="";
                   var cd="";
                   var filtereddata="";
                         
                   var transformdataleft = "";
                   var transformdataright = "";
                   filtereddata = filterInput(data);
                   var filteredlength = filtereddata.length;
                   
               
                   if (filteredlength > 12)	
			 {
                       filtereddata = filtereddata.substr(0,12);
                   }
               
                   if (filteredlength < 12)
			 {
                       var addcharlength = 12 - filtereddata.length;
                       for (var x = 0;x<addcharlength;x++)
			     {
                           filtereddata = "0" + filtereddata;
                       }
                   }
               

                   cd = generateCheckDigit(filtereddata);

			 connectcode_human_readable_text=html_decode(html_escape(filtereddata+cd));

                   filtereddata = filtereddata + cd;
                   var datalength = 0;
                   datalength = filtereddata.length;
               
                   var parityBit = 0;
                   var firstdigit = 0;
                   for (x = 0;x<7;x++)
			 {
                       if (x == 0)
			     {
                           firstdigit = filtereddata.charCodeAt(x) - 48; 
			     }
                       else
                       {
                           parityBit = EAN13PARITYMAP[firstdigit][x - 1];
                           if (parityBit == 0)
				   {
                               transformdataleft = transformdataleft + filtereddata.substr(x,1);
				   }
                           else
				   {
                               transformdataleft = transformdataleft + String.fromCharCode(filtereddata.charCodeAt(x) + 49 + 14);
                           }
                       }   
                   }
                   
                   var transformchar = "";
                   for (x = 7;x<13;x++)
			 {
                       transformchar = String.fromCharCode(filtereddata.charCodeAt(x) + 49);
                       transformdataright = transformdataright + transformchar;
                   }    
                   
                   if (hr == 1)
			 {
                       Result = String.fromCharCode(firstdigit + "!".charCodeAt(0)) + "[" + transformdataleft + "-" + transformdataright + "]"
                   }
			 else
			 {
                       Result = "[" + transformdataleft + "-" + transformdataright + "]"
                   }
  		       Result=html_decode(html_escape(Result));	                   
                   return Result;
		}

		function Get_HRText()
		{
			return connectcode_human_readable_text;
		}

		function generateCheckDigit(data)
		{
                 var datalength = 0;
                 var parity = 0;
                 var Sum = 0;
                 var Result = -1;
                 var strResult = "";
                 var barcodechar = "";
                 var barcodevalue = 0;
               
                 datalength = data.length;
               
                 for (var x = datalength - 1;x>=0;x--)
		     {
                 
                   barcodevalue = (data.charCodeAt(x) - 48);
                   if ((x % 2) == 1)
			 {
                       Sum = Sum + (3 * barcodevalue);
			 }
                   else
			 {
                       Sum = Sum + barcodevalue;
                   }
                 }
               
                 Result = Sum % 10;
                 if (Result == 0)
		     {
                   Result = 0;
		     }
                 else
		     {
                   Result = 10 - Result;
		     }
                 
                 strResult = String.fromCharCode(Result + 48);
                 return strResult;
		}


		function filterInput(data)
		{
			var Result="";
			var datalength=data.length;
			for (var x=0;x<datalength;x++)
			{
				if (data.charCodeAt(x)>=48 && data.charCodeAt(x)<=57)
				{
					Result = Result + data.substr(x,1);
				}
			}
			return Result;
		}

		function html_escape(data)
		{
			var Result="";
			for (var x=0;x<data.length;x++)
			{
				Result=Result+"&#"+data.charCodeAt(x).toString()+";";
			}
			return Result;
		}

		function html_decode(str) {
			var ta=document.createElement("textarea");
		      ta.innerHTML=str.replace(/</g,"&lt;").replace(/>/g,"&gt;");
		      return ta.value;
		}


		function encode(data,hr)
		{
			return ConnectCode_Encode_EAN13(data,hr);
		}

		function getText()
		{
			return Get_HRText();
		}

		//export {encode,getText};
