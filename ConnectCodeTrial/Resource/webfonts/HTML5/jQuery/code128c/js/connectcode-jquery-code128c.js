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
		$.fn.Encode_Code128C = function(options) {
			var opts = $.extend({}, $.fn.Encode_Code128C.defaults, options);
			return this.each(function() {
				if ($(this).text()!="")
				{
					opts.data=$(this).text();
				}
				$(this).text(ConnectCode_Encode_Code128C(opts.data,opts.humanReadableTextOutput));
			});
		};

		$.Encode_Code128C = function(data,humanReadableTextOutput) {
			return ConnectCode_Encode_Code128C(data,humanReadableTextOutput);
		};
				

		function ConnectCode_Encode_Code128C(data,humanReadableTextOutput)
		{
                   var cd = "";
                   var Result = "";
                   var filtereddata = filterInput(data);
                   filteredlength = filtereddata.length;

                   if (filteredlength > 253)
			 {
                       filtereddata = filtereddata.substr(0, 253);
                   }

		       if (filtereddata.length % 2 == 1)
			 {
			        filtereddata = "0" + filtereddata;
			 }

			 var connectcode_human_readable_text="";
			 if (humanReadableTextOutput==1)
			 {
				connectcode_human_readable_text=html_decode(html_escape(filtereddata));
				return connectcode_human_readable_text;
			 }

                   cd = generateCheckDigit(filtereddata);
                   for (x = 0;x<filtereddata.length;x=x+2)
		       {                 
			        num = parseInt(filtereddata.substr(x,2),10);
			        Result = Result + getCode128CCharacter(num);
                   }
               
                   Result = Result + cd;
               
                   var startc = 237;
                   var stopc = 238;
                   Result = String.fromCharCode(startc) + Result + String.fromCharCode(stopc);
  		       Result=html_decode(html_escape(Result));	
                   return Result;
		}

		function getCode128CCharacter(inputvalue) {
                   if ((inputvalue <= 94) && (inputvalue >= 0))
			 {
                       inputvalue = inputvalue + 32;
			 }
                   else if ((inputvalue <= 106) && (inputvalue >= 95))
			 {
                       inputvalue = inputvalue + 32 + 100;
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
			for (x=0;x<datalength;x++)
			{
				if (data.charCodeAt(x)>=48 && data.charCodeAt(x)<=57)
				{
					Result = Result + data.substr(x,1);
				}
			}

			return Result;
		}

		function generateCheckDigit(data)
		{
                 var datalength = 0;
                 var Sum = 105;
                 var Result = -1;
                 var strResult = "";
               
                 datalength = data.length;
               
                 var x = 0;
                 var Weight = 1;
                 var num = 0;
                 
                 for (x = 0 ;x<data.length;x=x+2)
		     { 
                   num = parseInt(data.substr(x,2),10);
                   Sum = Sum + (num * Weight);
                   Weight = Weight + 1;
                 }
               
                 Result = Sum % 103;
                 strResult = getCode128CCharacter(Result);
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

		$.fn.Encode_Code128C.defaults = {
			data: "12345678",
			humanReadableTextOutput: 0
		};
	})(jQuery);
