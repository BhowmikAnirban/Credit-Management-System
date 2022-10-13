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

	;(function($) {
		$.fn.Encode_Code128B = function(options) {
			var opts = $.extend({}, $.fn.Encode_Code128B.defaults, options);
			return this.each(function() {
				if ($(this).text()!="")
				{
					opts.data=$(this).text();
				}
				$(this).text(ConnectCode_Encode_Code128B(opts.data,opts.humanReadableTextOutput));
			});
		};

		$.Encode_Code128B = function(data) {
			return ConnectCode_Encode_Code128B(data,humanReadableTextOutput);
		};
				

		function ConnectCode_Encode_Code128B(data,humanReadableTextOutput)
		{
                   var cd = "";
                   var Result = "";
                   var filtereddata = filterInput(data);
                   filteredlength = filtereddata.length;

                   if (filteredlength > 254)
			 {
                       filtereddata = filtereddata.substr(0, 254);
                   }
                   cd = generateCheckDigit(filtereddata);
               
			 if (humanReadableTextOutput==1)
			 {
	   		       return html_decode(html_escape(filtereddata ));	
			 }

                   for (x = 0;x<filtereddata.length;x++)
		       {                 
                       c = filtereddata.charCodeAt(x);
               	     if (c == 127)
			     {
                        c = c + 100
			     }
                       else
			     {
                        c = c;
			     } 
               
                     Result = Result + String.fromCharCode(c);    
                 
                   }
               
                   Result = Result + cd;
               
                   var startc = 236;
                   var stopc = 238;
                   Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);
   		       Result=html_decode(html_escape(Result));	
                   return Result;
		}

		function getCode128BCharacter(inputvalue) {

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

		function getCode128BValue(inputchar) {
               
                   var returnvalue = 0;
               
                   if ((inputchar <= 127) && (inputchar >= 32))
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
			for (x=0;x<datalength;x++)
			{
				if (data.charCodeAt(x)>=32 && data.charCodeAt(x)<=127)
				{
					Result = Result + data.substr(x,1);
				}
			}

			return Result;
		}

		function generateCheckDigit(data)
		{
                 var datalength = 0;
                 var Sum = 104;
                 var Result = -1;
                 var strResult = "";
               
                 datalength = data.length;
               
                 var x = 0;
                 var Weight = 1;
                 var num = 0;
                 
                 for (x = 0 ;x<data.length;x++)
		     { 
                   num = data.charCodeAt(x);
                   Sum = Sum + (getCode128BValue(num) * (Weight));
                   Weight = Weight + 1;
                 }
               
                 Result = Sum % 103;
                 strResult = getCode128BCharacter(Result);
                 return strResult;
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

		$.fn.Encode_Code128B.defaults = {
			data: "12345678",
			humanReadableTextOutput: 0
		};
	})(jQuery);
