// connectcodefont.h : main header file for the connectcodefont DLL
//

#pragma once

//#ifndef __AFXWIN_H__
//	#error include 'stdafx.h' before including this file for PCH
//#endif

//#include "resource.h"		// main symbols


// CconnectcodefontApp
// See connectcodefont.cpp for the implementation of this class
//
extern "C" int WINAPI Encode_Code128Auto(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code39(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_POSTNET(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code93(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Codabar(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code39Ascii(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_I2of5(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_ITF14(LPSTR instr, int checkdigit, int bearer, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Industrial2of5(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_ModifiedPlessy(LPSTR instr, int checkdigit, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_EAN13(LPSTR instr, int humantext, LPSTR outstr, int outstrmax);
extern "C" int WINAPI RetrieveOptionalString_EAN13(LPSTR instr, int humantext, int strtype, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_UPCA(LPSTR instr, int humantext, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_EAN8(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_UCCEAN(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code128A(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code128B(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_Code128C(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_UPCE(LPSTR instr, int humantext, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_EXT2(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_EXT5(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBar14(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarLimited(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarExpanded(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarTruncated(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarStacked(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarStackedOmni(LPSTR instr, LPSTR outstr, int outstrmax);
extern "C" int WINAPI Encode_GS1DataBarExpandedStacked(LPSTR instr, int numSegmentsPerRow, LPSTR outstr, int outstrmax);



