// TestFont_MFC_NativeDlg.cpp : implementation file
//

#include "stdafx.h"
#include "TestFont_MFC_Native.h"
#include "TestFont_MFC_NativeDlg.h"
#include ".\testfont_mfc_nativedlg.h"
#include "connectcodefont.h"

 
#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	enum { IDD = IDD_ABOUTBOX };

	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Implementation
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()


// CTestFont_MFC_NativeDlg dialog



CTestFont_MFC_NativeDlg::CTestFont_MFC_NativeDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CTestFont_MFC_NativeDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CTestFont_MFC_NativeDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);	
	DDX_Control(pDX, IDC_COMBO1, m_combo_barcode);
	DDX_Control(pDX, IDC_EDIT1, m_edit_data);
	DDX_Control(pDX, IDC_EDIT2, m_edit_output);
	DDX_Control(pDX, IDC_EDIT3, m_edit_font);
	DDX_Control(pDX, IDC_RICHEDIT21, m_richedit);
}

BEGIN_MESSAGE_MAP(CTestFont_MFC_NativeDlg, CDialog)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDC_BUTTON1, OnBnClickedButton1)
	ON_CBN_SELCHANGE(IDC_COMBO1, OnCbnSelchangeCombo1)
END_MESSAGE_MAP()


// CTestFont_MFC_NativeDlg message handlers

BOOL CTestFont_MFC_NativeDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon

	// TODO: Add extra initialization here
	m_combo_barcode.SetCurSel(0);
	m_edit_data.SetWindowText("12345678");


	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CTestFont_MFC_NativeDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CTestFont_MFC_NativeDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this function to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CTestFont_MFC_NativeDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}

void CTestFont_MFC_NativeDlg::OnBnClickedButton1()
{
	// TODO: Add your control notification handler code here
	CString inputstr;
	m_edit_data.GetWindowText(inputstr);

	CString barcodestr;		
	int index = m_combo_barcode.GetCurSel();
	m_combo_barcode.GetLBText(index,barcodestr);	

	CString fontstr;
	CString outputstr;	

	char outputbuf[2048];		
	
	
    if (barcodestr == "Code 39")
    {

        fontstr = "CCode39_S3_Trial";  
        //fontstr = "CCode39_S3";
        Encode_Code39((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);
        
    }
    else if (barcodestr == "Postnet")
    {

        fontstr = "CCodePostnet";
        Encode_POSTNET((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);
        
    }
    else if (barcodestr == "Code 93")
    {
        
        fontstr = "CCode93_S3_Trial";
        //fontstr = "CCode93_S3";
        Encode_Code93((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                
        
    }
    else if (barcodestr == "Codabar")
    {

        //fontstr = "CCodeCodabar_S3";
        fontstr = "CCodeCodabar_S3_Trial";
        Encode_Codabar((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                                

    }
    else if (barcodestr == "Code 39 Ascii")
    {

        //fontstr = "CCode39_S3";
        fontstr = "CCode39_S3_Trial";
        Encode_Code39Ascii((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                                                

    }
    else if (barcodestr == "I2of5")
    {

        //fontstr = "CCodeI2of5_S3";
        fontstr =  "CCodeI2of5_S3_Trial";
        Encode_I2of5((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                                                                    
        
    }
    else if (barcodestr == "ITF14")
    {
        //fontstr = "CCodeITF_S3";
        fontstr = "CCodeITF_S3_Trial";
        Encode_ITF14((LPSTR) LPCTSTR(inputstr), 0, 0,outputbuf,2048);    

    }
    else if (barcodestr == "Industrial 2of5")
    {
        //fontstr =  "CCodeIND2of5_S3";
        fontstr =  "CCodeIND2of5_S3_Trial";
        Encode_Industrial2of5((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                    

    }
    else if (barcodestr == "Modified Plessy")
    {
        //fontstr = "CCodeMSI_S3";
        fontstr = "CCodeMSI_S3_Trial";
        Encode_ModifiedPlessy((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);                    
        
    }
    else if (barcodestr == "EAN13")
    {

        //fontstr ="CCodeUPCEAN_HRBS3";
        //fontstr ="CCodeUPCEAN_S3";  
        fontstr = "CCodeUPCEAN_HRBS3_Trial";
        Encode_EAN13((LPSTR) LPCTSTR(inputstr), 1,outputbuf,2048);  

    }
    else if (barcodestr == "UPCA")
    {
        
        //fontstr = "CCodeUPCEAN_HRBS3";                
        //fontstr = "CCodeUPCEAN_S3";
        fontstr =  "CCodeUPCEAN_HRBS3_Trial";
        Encode_UPCA((LPSTR) LPCTSTR(inputstr), 1,outputbuf,2048);  
        
    }
    else if (barcodestr == "EAN8")
    {
        
        //fontstr = "CCodeUPCEAN_HRBS3";
        //fontstr = "CCodeUPCEAN_S3";
        //fontstr = "CCodeUPCEAN_HRBS3_Trial"
        fontstr = "CCodeUPCEAN_S3_Trial";
        Encode_EAN8((LPSTR) LPCTSTR(inputstr),outputbuf,2048);  
        
    }
    else if (barcodestr == "UCCEAN")
    {
        //fontstr = "CCode128_S3";
        fontstr = "CCode128_S3_Trial";                
        Encode_UCCEAN((LPSTR) LPCTSTR(inputstr),outputbuf,2048);  
        
    }
    else if (barcodestr == "Code 128 Auto")
    {

        //fontstr = "CCode128_S3";
        fontstr = "CCode128_S3_Trial";                
        Encode_Code128Auto((LPSTR) LPCTSTR(inputstr),outputbuf,2048);

        
    }
    else if (barcodestr == "Code 128A")
    {

        //fontstr = "CCode128_S3";
        fontstr = "CCode128_S3_Trial";                
        Encode_Code128A((LPSTR) LPCTSTR(inputstr),outputbuf,2048);
        
    }
    else if (barcodestr == "Code 128B")
    {

        //fontstr = "CCode128_S3";
        fontstr = "CCode128_S3_Trial";                
        Encode_Code128B((LPSTR) LPCTSTR(inputstr),outputbuf,2048);

    }
    else if (barcodestr == "Code 128C")
    {

        //fontstr = "CCode128_S3";
        fontstr = "CCode128_S3_Trial";                
        Encode_Code128C((LPSTR) LPCTSTR(inputstr),outputbuf,2048);

    }
    else if (barcodestr == "UPCE")
    {

        //fontstr = "CCodeUPCEAN_HRBS3";
        //fontstr = "CCodeUPCEAN_S3";
        //fontstr = "CCodeUPCEAN_HRBS3_Trial";
        fontstr = "CCodeUPCEAN_S3_Trial";
        Encode_UPCE((LPSTR) LPCTSTR(inputstr), 0,outputbuf,2048);               
                        
    }
    else if (barcodestr == "EXT2")
    {
        
        //fontstr = "CCodeUPCEAN_HRTS3";                
        //fontstr = "CCodeUPCEAN_S3";
        fontstr = "CCodeUPCEAN_HRTS3_Trial";
        //fontstr = "CCodeUPCEAN_S3_Trial";
        Encode_EXT2((LPSTR) LPCTSTR(inputstr),outputbuf,2048);               
        
    }
    else if (barcodestr == "EXT5")
    {
        //fontstr = "CCodeUPCEAN_HRTS3";
        //fontstr = "CCodeUPCEAN_S3";
        fontstr =   "CCodeUPCEAN_HRTS3_Trial";
        //fontstr = "CCodeUPCEAN_S3_Trial";
        Encode_EXT5((LPSTR) LPCTSTR(inputstr),outputbuf,2048);               

    }
	else if (barcodestr=="GS1Databar14")
	{
		//fontstr = "CCodeGS1D_S3";        
		fontstr = "CCodeGS1D_S3_Trial";    
        Encode_GS1DataBar14((LPSTR) LPCTSTR(inputstr),outputbuf,2048);               
	}
	else if (barcodestr=="GS1DatabarLimited")
	{
		//fontstr = "CCodeGS1D_S3";        
		fontstr = "CCodeGS1D_S3_Trial";    
        Encode_GS1DataBarLimited((LPSTR) LPCTSTR(inputstr),outputbuf,2048);               
	}
	else if (barcodestr=="GS1DatabarExpanded")
	{
		//fontstr = "CCodeGS1D_S3";        
		fontstr = "CCodeGS1D_S3_Trial";    
        Encode_GS1DataBarExpanded((LPSTR) LPCTSTR(inputstr),outputbuf,2048);  
	}
	else if (barcodestr=="GS1DatabarTruncated")
	{
		//fontstr = "CCodeGS1DTR_S3";        
		fontstr = "CCodeGS1DTR_S3_Trial";        
        Encode_GS1DataBarTruncated((LPSTR) LPCTSTR(inputstr),outputbuf,2048); 
	}
	else if (barcodestr=="GS1DatabarStacked")
	{
		fontstr = "CCodeGS1DST_Trial";        
        Encode_GS1DataBarStacked((LPSTR) LPCTSTR(inputstr),outputbuf,2048);               
	}
	else if (barcodestr=="GS1DatabarStackedOmni")
	{
		fontstr = "CCodeGS1DSTO_Trial";        
        Encode_GS1DataBarStackedOmni((LPSTR) LPCTSTR(inputstr),outputbuf,2048); 
	}
	else if (barcodestr=="GS1DatabarExpandedStacked")
	{
		int numSegmentsPerRow = 4;
		fontstr = "CCodeGS1DEST_Trial"; 
        Encode_GS1DataBarExpandedStacked((LPSTR) LPCTSTR(inputstr),numSegmentsPerRow, outputbuf,2048); 
	}

	int fontsize = 24;
    if (barcodestr == "Postnet")
            fontsize = 9;

	if (barcodestr == "GS1DatabarStackedOmni")
            fontsize = 48;

	if (barcodestr == "GS1DatabarExpandedStacked")
            fontsize = 48;

	 
	m_edit_output.SetWindowText(outputbuf);
	m_edit_font.SetWindowText(fontstr);
	
	
	m_richedit.SetWindowText(outputbuf);	

	CHARFORMAT	charformat;
	ZeroMemory(&charformat, sizeof(CHARFORMAT));
	charformat.cbSize = sizeof(CHARFORMAT);
	m_richedit.GetSelectionCharFormat(charformat);		
	
	charformat.dwEffects = 0;	
	charformat.dwMask = CFM_FACE | CFM_SIZE;
	charformat.yHeight = fontsize * 20;
	strcpy( charformat.szFaceName, LPCTSTR(fontstr));
	
	m_richedit.SetSel(0,-1);		
	m_richedit.SetSelectionCharFormat(charformat);		

	
	
}


void CTestFont_MFC_NativeDlg::OnCbnSelchangeCombo1()
{
	// TODO: Add your control notification handler code here
	CString barcodestr;		
	int index = m_combo_barcode.GetCurSel();
	m_combo_barcode.GetLBText(index,barcodestr);	
    if (barcodestr == "UCCEAN")
	{
		 m_edit_data.SetWindowText( "(10)12345678");             
	}
	else if (barcodestr=="GS1Databar14")
	{
		m_edit_data.SetWindowText("12401234567898");
	}
	else if (barcodestr=="GS1DatabarLimited")
	{
		m_edit_data.SetWindowText("15012345678907");
	}
	else if (barcodestr=="GS1DatabarExpanded")
	{
		m_edit_data.SetWindowText("(01)90012345678908(3103)001750");
	}
	else if (barcodestr=="GS1DatabarTruncated")
	{
		m_edit_data.SetWindowText("12401234567898");
	}
	else if (barcodestr=="GS1DatabarStacked")
	{
		m_edit_data.SetWindowText("83012345678953");
	}
	else if (barcodestr=="GS1DatabarStackedOmni")
	{
		m_edit_data.SetWindowText("83012345678953");
	}
	else if (barcodestr=="GS1DatabarExpandedStacked")
	{
		m_edit_data.SetWindowText("(01)98898765432106(3202)012345(15)991231");
	}



}
