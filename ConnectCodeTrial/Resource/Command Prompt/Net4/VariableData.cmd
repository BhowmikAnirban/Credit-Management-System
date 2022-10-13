ECHO OFF
FOR /L %%G IN (12345670,1,12345678) DO BarcodeCommand Code39 %%G 1 >> %HOMEPATH%\outputfile.txt