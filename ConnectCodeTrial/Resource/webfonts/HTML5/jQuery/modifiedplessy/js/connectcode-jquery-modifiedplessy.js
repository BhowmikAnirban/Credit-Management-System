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
		$.fn.Encode_ModifiedPlessy = function(options) {
			var opts = $.extend({}, $.fn.Encode_ModifiedPlessy.defaults, options);
			return this.each(function() {
				if ($(this).text()!="")
				{
					opts.data=$(this).text();
				}
				$(this).text(ConnectCode_Encode_ModifiedPlessy(opts.data,opts.checkDigit,opts.humanReadableTextOutput));
			});
		};

		$.Encode_ModifiedPlessy = function(data,checkDigit,humanReadableTextOutput) {
			return ConnectCode_Encode_ModifiedPlessy(data,checkDigit,humanReadableTextOutput);
		};
				

		function ConnectCode_Encode_ModifiedPlessy(data,checkDigit,humanReadableTextOutput)
		{
			var Result="";
			var cd="";
			var filtereddata="";
			filtereddata = filterInput(data);
			var filteredlength = filtereddata.length;
			if (checkDigit==1)
			{
				if (filteredlength > 15)
				{
					filtereddata = filtereddata.substr(0,15);
				}
				cd = generateCheckDigit(filtereddata);
			}
			else
			{
				if (filteredlength > 16)
				{
					filtereddata = filtereddata.substr(0,16);
				}
			}

			if (humanReadableTextOutput==1)
			{
				return html_decode(html_escape(filtereddata +cd ));
			}

			Result = "{" + filtereddata+cd+"}";
  		      Result=html_decode(html_escape(Result));	
			return Result;
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
                  var doublechar = "";
                  var doubleStr = "";
                  var doubleNumber = 0;
                
                  var datalength = 0;
                  var lastcharpos = 0;
                  var Result = 0;
                  var strResult = "";
                  var barcodechar = "";
                  var barcodevalue = 0;
                  var toggle = 1;
                  var Sum = 0;
                
                  datalength = data.length;
                  lastcharpos = datalength - 1;
                
                  for (x=lastcharpos;x>=0;x--)
                  {
                      barcodevalue = data.charCodeAt(x) - 48;
                       
                      if (toggle == 1)
			    {
                            doubleStr = data.substr(x,1) + doubleStr;
                            toggle = 0;
                      }
			    else
			    {
                            Sum = Sum + barcodevalue;
                            toggle = 1;
                      }
                  }
                  
                  doubleNumber = parseInt(doubleStr,10);
                  doubleNumber = doubleNumber * 2;
                  doubleStr = doubleNumber.toString();
                  
                  for (y = 0;y<doubleStr.length;y++)
			{                  
                    barcodevalue = doubleStr.charCodeAt(y)-48;
                    Sum = Sum + barcodevalue;
                  }
                
                  if ((Sum % 10) == 0)
			{
                        Result = 48;
			}
                  else
			{
                        Result = (10 - (Sum % 10)) + 48;
                  }
                  strResult = (Result-48).toString();
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

		$.fn.Encode_ModifiedPlessy.defaults = {
			data: "12345678",
			checkDigit: 1,
			humanReadableTextOutput: 0
		};
	})(jQuery);
