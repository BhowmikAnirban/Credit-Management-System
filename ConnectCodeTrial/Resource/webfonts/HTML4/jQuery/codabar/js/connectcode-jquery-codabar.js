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
		$.fn.Encode_Codabar = function(options) {
			var opts = $.extend({}, $.fn.Encode_Codabar.defaults, options);
			return this.each(function() {
				if ($(this).text()!="")
				{
					opts.data=$(this).text();
				}
				$(this).text(ConnectCode_Encode_Codabar(opts.data,opts.humanReadableTextOutput));
			});
		};

		$.Encode_Codabar = function(data,humanReadableTextOutput) {
			return ConnectCode_Encode_Codabar(data,humanReadableTextOutput);
		};
				

		function ConnectCode_Encode_Codabar(data,humanReadableTextOutput)
		{
			var Result="";
			var cd="";
			var filtereddata="";
			filtereddata = filterInput(data);
			var filteredlength = filtereddata.length;
			if (filteredlength > 255)
			{
				filtereddata = filtereddata.substr(0,255);
			}
			Result = filtereddata;
  		      Result=html_decode(html_escape(Result));	
			var connectcode_human_readable_text=Result;
			if (humanReadableTextOutput==1) 
				Result=connectcode_human_readable_text;
				
			return Result;
		}

		function getCodeCodabarValue(inputchar) {
			var CODECODABARMAP=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "-", ".", "$", "/", "+", ":");

			var RVal=-1;
			for (i=0;i<20;i++)
			{
				if (inputchar==CODECODABARMAP[i])
				{
					RVal=i;
				}
			}
			return RVal;
		}

		function filterInput(data)
		{
			var Result="";
			var datalength=data.length;
			for (x=0;x<datalength;x++)
			{
				if (getCodeCodabarValue(data.substr(x,1)) != -1)
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

		$.fn.Encode_Codabar.defaults = {
			data: "12345678",
			humanReadableTextOutput: 0
		};
	})(jQuery);
