/*
 * ConnectCode
 *
 * Copyright (c) 2006-2010 ConnectCode Pte Ltd (http://www.barcoderesource.com)
 * All Rights Reserved.
 *
 * This source code is protected by International Copyright Laws. You are only allowed to modify
 * and include the source in your application if you have purchased a Distribution License.
 *
 * http://www.barcoderesource.com
 *
 */

		var connectcode_human_readable_text="";

		function ConnectCode_Encode_EAN8(data)
		{
                   var Result="";
                   var cd="";
                   var filtereddata="";
                         
                   var transformdataleft = "";
                   var transformdataright = "";
                   filtereddata = filterInput(data);
                   filteredlength = filtereddata.length;
                   
               
                   if (filteredlength > 7)	
			 {
                       filtereddata = filtereddata.substr(0,7);
                   }
               
                   if (filteredlength < 7)
			 {
                       addcharlength = 7 - filtereddata.length;
                       for (x = 0;x<addcharlength;x++)
			     {
                           filtereddata = "0" + filtereddata;
                       }
                   }
               

                   cd = generateCheckDigit(filtereddata);

			 connectcode_human_readable_text=html_decode(html_escape(filtereddata+cd));

                   filtereddata = filtereddata + cd;
                   var datalength = 0;
                   datalength = filtereddata.length;
               
                   for (x = 0;x<4;x++)
		       {
                       transformdataleft = transformdataleft + filtereddata.substr(x,1);
                   }    
                   
                   var transformchar = "";
                   for (x = 4;x<8;x++)
			 {
                       transformchar = filtereddata.substr(x,1);
                       
                       transformchar = String.fromCharCode(filtereddata.charCodeAt(x) + 49);
                       
                       transformdataright = transformdataright + transformchar;
                   }
                   
                   Result = "[" + transformdataleft + "-" + transformdataright + "]";
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
               
                 for (x = 0;x<datalength;x++)
		     {
                 
                   barcodevalue = (data.charCodeAt(x) - 48);
                   if (parity==0)
			 {
                       Sum = Sum + (3 * barcodevalue);
			     parity=1;
			 }
                   else
			 {
                       Sum = Sum + barcodevalue;
			     parity=0;
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
			for (x=0;x<datalength;x++)
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
			for (x=0;x<data.length;x++)
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

