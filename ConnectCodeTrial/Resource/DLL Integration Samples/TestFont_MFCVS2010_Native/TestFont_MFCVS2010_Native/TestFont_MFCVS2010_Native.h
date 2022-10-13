
// TestFont_MFCVS2010_Native.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error "include 'stdafx.h' before including this file for PCH"
#endif

#include "resource.h"		// main symbols


// CTestFont_MFCVS2010_NativeApp:
// See TestFont_MFCVS2010_Native.cpp for the implementation of this class
//

class CTestFont_MFCVS2010_NativeApp : public CWinApp
{
public:
	CTestFont_MFCVS2010_NativeApp();

// Overrides
public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CTestFont_MFCVS2010_NativeApp theApp;