// TestFont_MFC_NativeDlg.h : header file
//

#pragma once
#include "afxwin.h"
#include "afxcmn.h"


// CTestFont_MFC_NativeDlg dialog
class CTestFont_MFC_NativeDlg : public CDialog
{
// Construction
public:
	CTestFont_MFC_NativeDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	enum { IDD = IDD_TESTFONT_MFC_NATIVE_DIALOG };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support


// Implementation
protected:
	HICON m_hIcon;

	// Generated message map functions
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton1();
	CComboBox m_combo_barcode;
	CEdit m_edit_data;
	CEdit m_edit_output;
	CEdit m_edit_font;
	CRichEditCtrl m_richedit;
	afx_msg void OnCbnSelchangeCombo1();
};
