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

		function ConnectCode_Encode_Code128A(data)
		{
                   var cd = "";
                   var Result = "";
                   var filtereddata = filterInput(data);
                   var filteredlength = filtereddata.length;

                   if (filteredlength > 254)
			 {
                       filtereddata = filtereddata.substr(0, 254);
                   }


                   cd = generateCheckDigit(filtereddata);
                   for (var x = 0;x<filtereddata.length;x++)
		       {                 
  				  var c ="";
				  c= translateCharacter(filtereddata.charCodeAt(x));
			        Result = Result + c;
                   }
               
			 connectcode_human_readable_text=html_decode(html_escape(Result));
                   Result = Result + cd;
               
                   var startc = 235;
                   var stopc = 238;
                   Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);
  		       Result=html_decode(html_escape(Result));	
                   return Result;
		}

		function Get_HRText()
		{
			return connectcode_human_readable_text;
		}

		function getCode128ACharacter(inputvalue) {
               
		       if ((inputvalue <= 94) && (inputvalue >= 0))
			 {
                       inputvalue = inputvalue + 32;
			 }
                   else if ((inputvalue <= 106) && (inputvalue >= 95))
			 {
                       inputvalue = inputvalue + 100 + 32;
			 }
                   else
			 {
                       inputvalue = -1;
			 }
               
                   return String.fromCharCode(inputvalue);
		}

            function translateCharacter(inputchar)
            {   

                   var returnvalue = 0;
               
                   if ((inputchar <= 30) && (inputchar >= 0))
			 {
                       returnvalue = (inputchar + 96);
			 }
                   else if (inputchar == 31)
			 {
                       returnvalue = (inputchar + 96 + 100);
			 }
                   else if ((inputchar <= 95) && (inputchar >= 32))
			 {
                       returnvalue = inputchar;
			 }
                   else
			 {
                       returnvalue = -1;
			 }
                   return String.fromCharCode(returnvalue);
               
             }

		function getCode128AValue(inputchar) {
              
                   var returnvalue = 0;
               
                   if ((inputchar <= 31) && (inputchar >= 0))
			 {
                       returnvalue = (inputchar + 64);
			 }
                   else if ((inputchar <= 95) && (inputchar >= 32))
			 {
                       returnvalue = (inputchar - 32);
			 }
                   else
			 {
                       returnvalue = -1;
                   }
               
                   return returnvalue;
   
		}

		function filterInput(data)
		{
			var Result="";
			var datalength=data.length;
			for (var x=0;x<datalength;x++)
			{
				if (data.charCodeAt(x)>=0 && data.charCodeAt(x)<=95)
				{
					Result = Result + data.substr(x,1);
				}
			}

			return Result;
		}

		function generateCheckDigit(data)
		{
                 var datalength = 0;
                 var Sum = 103;
                 var Result = -1;
                 var strResult = "";
               
                 datalength = data.length;
               
                 var x = 0;
                 var Weight = 1;
                 var num = 0;
                 
                 for (x = 0 ;x<data.length;x++)
		     { 
                   num = data.charCodeAt(x);
                   Sum = Sum + (getCode128AValue(num) * (Weight));
                   Weight = Weight + 1;
                 }
               
                 Result = Sum % 103;
                 strResult = getCode128ACharacter(Result);
                 return strResult;
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

		function encode(data)
		{
			return ConnectCode_Encode_Code128A(data);
		}

		function getText()
		{
			return Get_HRText();
		}

		//export {encode,getText};
