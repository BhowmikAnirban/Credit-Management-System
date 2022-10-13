ECHO OFF
FOR /F "tokens=1" %%G IN (barcodedata.txt) DO BarcodeCommand Code39 %%G 1 >> %HOMEPATH%\"outputfiledata.txt"