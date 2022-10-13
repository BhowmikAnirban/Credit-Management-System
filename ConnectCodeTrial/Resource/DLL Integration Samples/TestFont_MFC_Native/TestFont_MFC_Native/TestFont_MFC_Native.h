// TestFont_MFC_Native.h : main header file for the PROJECT_NAME application
//

#pragma once

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols


// CTestFont_MFC_NativeApp:
// See TestFont_MFC_Native.cpp for the implementation of this class
//

class CTestFont_MFC_NativeApp : public CWinApp
{
public:
	CTestFont_MFC_NativeApp();

// Overrides
	public:
	virtual BOOL InitInstance();

// Implementation

	DECLARE_MESSAGE_MAP()
};

extern CTestFont_MFC_NativeApp theApp;