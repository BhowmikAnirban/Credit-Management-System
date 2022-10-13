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
		$.fn.Encode_POSTNET = function(options) {
			var opts = $.extend({}, $.fn.Encode_POSTNET.defaults, options);
			return this.each(function() {
				if ($(this).text()!="")
				{
					opts.data=$(this).text();
				}
				$(this).text(ConnectCode_Encode_POSTNET(opts.data,opts.checkDigit,opts.humanReadableTextOutput));
			});
		};

		$.Encode_POSTNET = function(data,checkDigit,humanReadableTextOutput) {
			return ConnectCode_Encode_POSTNET(data,checkDigit,humanReadableTextOutput);
		};
				

		function ConnectCode_Encode_POSTNET(data,checkDigit,humanReadableTextOutput)
		{
			var Result="";
			var cd="";
			var filtereddata="";
			filtereddata = filterInput(data);
			var filteredlength = filtereddata.length;
			if (filteredlength > 11)
			{
				filtereddata = filtereddata.substr(0,11);
			}
			cd = generateCheckDigit(filtereddata);
			
			if (humanReadableTextOutput==1)
			{
				return html_decode(html_escape(filtereddata+cd ));
			}

			Result = "{"+filtereddata+cd+"}";
  		      Result=html_decode(html_escape(Result));	
			return Result;
		}

		function getPOSTNETCharacter(inputdecimal) {
			return inputdecimal+48;
		}

		function getPOSTNETValue(inputdecimal) {
			return inputdecimal-48;
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
                  var Sumx = 0;
                  var result = -1;
                  var strResult = "";
                  var barcodechar = "";
                
                  datalength = data.length;
                  for (x = 0;x<datalength;x++)
			{     
                        Sumx = Sumx + getPOSTNETValue(data.charCodeAt(x));
                  }
                
                  result = Sumx % 10;
                  if (result != 0)
			{
                    result = (10 - result);
                  }

                  strResult = result.toString();
                
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


		$.fn.Encode_POSTNET.defaults = {
			data: "12345678",
			checkDigit: 1,
			humanReadableTextOutput: 0
		};
	})(jQuery);
