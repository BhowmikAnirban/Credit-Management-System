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

		function ConnectCode_Encode_Codabar(data)
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
			connectcode_human_readable_text=Result;
			return Result;
		}

		function Get_HRText()
		{
			return connectcode_human_readable_text;
		}

		function getCodeCodabarValue(inputchar) {
			var CODECODABARMAP=new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "-", ".", "$", "/", "+", ":");

			var RVal=-1;
			for (var i=0;i<20;i++)
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
			for (var x=0;x<datalength;x++)
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
			return ConnectCode_Encode_Codabar(data);
		}

		function getText()
		{
			return Get_HRText();
		}

		//export {encode,getText};

