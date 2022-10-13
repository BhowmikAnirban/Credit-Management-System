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

		function ConnectCode_Encode_EXT2(data)
		{
                    var EXT2PARITYMAP = new Array(4);
			  EXT2PARITYMAP[0]=new Array(2);
			  EXT2PARITYMAP[1]=new Array(2);
			  EXT2PARITYMAP[2]=new Array(2);
			  EXT2PARITYMAP[3]=new Array(2);

                    EXT2PARITYMAP[0][0] = 0;
                    EXT2PARITYMAP[0][1] = 0;
                    
                    EXT2PARITYMAP[1][0] = 0;
                    EXT2PARITYMAP[1][1] = 1;
                    
                    EXT2PARITYMAP[2][0] = 1;
                    EXT2PARITYMAP[2][1] = 0;
                    
                    EXT2PARITYMAP[3][0] = 1;
                    EXT2PARITYMAP[3][1] = 1;
                
                    var Result="";
                    var cd="";
                    var filtereddata="";
                          
                    var transformdataleft = "";
                    var transformdataright = "";
                    filtereddata = filterInput(data);
                    filteredlength = filtereddata.length;
                    
                    if (filteredlength > 2)
			  {
                        filtereddata = filtereddata.substr(0, 2);
                    }
                
                    if (filteredlength < 2 )
			  {                    
                        addcharlength = 2 - filtereddata.length;
                        for (x = 0;x<addcharlength;x++)
				{
                            filtereddata = "0" + filtereddata;
                        }                   
                    }
                    
			  connectcode_human_readable_text=html_decode(html_escape(filtereddata ));

                    var Sum = 0;
                    var value1 = 0;
                    var Value2 = 0;
                    parityindex = 0
                    value1 = (filtereddata.charCodeAt(0) - 48) * 10;
                    Value2 = (filtereddata.charCodeAt(1) - 48);
                    Sum = value1 + Value2;
                    var parityindex = Sum % 4;
                
                    var datalength = 0;
                    datalength = filtereddata.length;
                
                    var parityBit = 0;
                    parityBit = EXT2PARITYMAP[parityindex][0];

                    if (parityBit == 0)
			  {
                        transformdataleft = transformdataleft + filtereddata.substr(0,1);
			  }
                    else
			  {
                        transformdataleft = transformdataleft + String.fromCharCode(filtereddata.charCodeAt(0) + 49 + 14);
                    }
                
                    parityBit = EXT2PARITYMAP[parityindex][1];
                    if (parityBit == 0)
			  {
                        transformdataright = transformdataright + filtereddata.substr(1,1);
                    } 
			  else
			  {
                        transformdataright = transformdataright + String.fromCharCode(filtereddata.charCodeAt(1) + 49 + 14);
                    }
                
                    Result = "<" + transformdataleft + "+" + transformdataright;
   		        Result=html_escape(Result);	
                    return Result;
		}

		function Get_HRText()
		{
			return connectcode_human_readable_text;
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

