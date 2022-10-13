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

		function ConnectCode_Encode_ITF14(data,checkDigit,itfRectangle)
		{
			var Result="";
			var cd="";
			var filtereddata="";
			filtereddata = filterInput(data);
			var filteredlength = filtereddata.length;
			if (checkDigit==1)
			{
				if (filteredlength > 253)
				{
					filtereddata = filtereddata.substr(0,253);
				}
				
				if (filtereddata.length % 2 ==0)
				{
			            filtereddata = "0" + filtereddata
				}

				cd = generateCheckDigit(filtereddata);
			}
			else
			{
				if (filteredlength > 254)
				{
					filtereddata = filtereddata.substr(0,254);
				}
				if (filtereddata.length % 2 ==1)
				{
			            filtereddata = "0" + filtereddata
				}

			}
			filtereddata = filtereddata+cd;
      		
			connectcode_human_readable_text=html_decode(html_escape(filtereddata ));	
		
		      var num = 0;
    			for (var x=0;x<filtereddata.length;x=x+2)
			{
		        num = parseInt(filtereddata.substr(x,2),10);
		        Result = Result + getI2of5Character(num)
    			}

		      if (itfRectangle == 1)
			{
		        var startITF = String.fromCharCode(124);
		        var stopITF = String.fromCharCode(126);
		        Result = startITF + Result + stopITF;
    			}
			else
			{
		        Result = "{" + Result + "}";
			}
  		      Result=html_decode(html_escape(Result));	
			return Result;
		}

		function Get_HRText()
		{
			return connectcode_human_readable_text;
		}

		function getI2of5Character(inputvalue) 
            {
		    if ((inputvalue <= 90) && (inputvalue >= 0))
		    {
		        inputvalue = inputvalue + 32;
		    }
		    else if ((inputvalue <= 99) && (inputvalue >= 91))
		    {
		        inputvalue = inputvalue + 100;
		    }
		    else
		    {
		        inputvalue = -1;
		    }
		    return String.fromCharCode(inputvalue);
		}

		function filterInput(data)
		{
			var Result="";
			var datalength=data.length;
			for (var x=0;x<datalength;x++)
			{
				if ((data.charCodeAt(x)>=48) && (data.charCodeAt(x)<=57))
				{
					Result = Result + data.substr(x,1);
				}
			}

			return Result;
		}

		function generateCheckDigit(data)
		{
		     var datalength = 0;
                 var lastcharpos = 0;
                 var Result = 0;
                 var strResult = "";
                 var barcodechar = "";
                 var barcodevalue = 0;
                 var toggle = 1;
                 var sum = 0;
               
                 datalength = data.length;
                 lastcharpos = datalength - 1;
               
                 for (var x = lastcharpos ; x>=0 ; x--)
                 {
                     barcodevalue = data.charCodeAt(x)-48;
                     
                     if (toggle == 1)
			   {
                           sum = sum + (barcodevalue * 3);
                           toggle = 0;
                     }
			   else
			   {
                           sum = sum + barcodevalue;
                           toggle = 1;
                     }
                 }
                 if ((sum % 10) == 0)
		     {
                       Result = 48;
                 }
		     else
                 {
		           Result = (10 - (sum % 10)) + 48;
                 }
               
                 strResult = String.fromCharCode(Result);
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

		function encode(data,checkDigit,itfRectangle)
		{
			return ConnectCode_Encode_ITF14(data,checkDigit,itfRectangle);
		}

		function getText()
		{
			return Get_HRText();
		}

		//export {encode,getText};
