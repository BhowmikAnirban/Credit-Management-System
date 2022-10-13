'Copyright 2006-2011 ConnectCode Pte Ltd. All Rights Reserved.
'This source code is protected by International Copyright Laws. You are only allowed to modify
'and include the source in your application if you have purchased a Distribution License.

'Version 8.0 - 23 June 2011

'======================================================================================================
'Code39
'======================================================================================================
   
Public Function Encode_Code39(ByVal data As String, Optional ByVal chk As Integer = 1) As String

      
    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
            
    filtereddata = filterInput_Code39(data)
    filteredlength = Len(filtereddata)

    If chk = 1 Then
    
        If filteredlength > 254 Then
        
            filtereddata = Left$(filtereddata, 254)
            
        End If
        cd = generateCheckDigit_Code39(filtereddata)
    
    Else
    
        If filteredlength > 255 Then
            
            filtereddata = Left$(filtereddata, 255)
            
        End If
    
    End If

    Result = "*" + filtereddata + cd + "*"
    Encode_Code39 = Result

End Function

Public Function getCode39Value(ByVal inputchar As Integer) As Integer

    Dim CODE39MAP() As Variant
    CODE39MAP = Array(Asc("0"), Asc("1"), Asc("2"), Asc("3"), Asc("4"), Asc("5"), Asc("6"), Asc("7"), Asc("8"), Asc("9"), Asc("A"), Asc("B"), Asc("C"), Asc("D"), Asc("E"), Asc("F"), Asc("G"), Asc("H"), Asc("I"), Asc("J"), Asc("K"), Asc("L"), Asc("M"), Asc("N"), Asc("O"), Asc("P"), Asc("Q"), Asc("R"), Asc("S"), Asc("T"), Asc("U"), Asc("V"), Asc("W"), Asc("X"), Asc("Y"), Asc("Z"), Asc("-"), Asc("."), Asc(" "), Asc("$"), Asc("/"), Asc("+"), Asc("%"))
   
    Dim RVal As Integer
    RVal = -1
    For x = 0 To (43 - 1)
        If CODE39MAP(x) = inputchar Then
            RVal = x
            Exit For
        End If
    Next x
    
    getCode39Value = RVal

End Function



Public Function filterInput_Code39(ByVal data As String) As String
  
  Dim Result As String
  Result = ""
  datalength = Len(data)

  Dim barcodechar As String
  For x = 0 To datalength - 1
        barcodechar = Mid(data, x + 1, 1)
        If getCode39Value(AscW(barcodechar)) <> -1 Then
            Result = Result & barcodechar
        End If
  Next x

  filterInput_Code39 = Result

End Function


Public Function getCode39Character(ByVal inputdecimal As Integer) As String

    Dim CODE39MAP() As Variant
    CODE39MAP = Array(Asc("0"), Asc("1"), Asc("2"), Asc("3"), Asc("4"), Asc("5"), Asc("6"), Asc("7"), Asc("8"), Asc("9"), Asc("A"), Asc("B"), Asc("C"), Asc("D"), Asc("E"), Asc("F"), Asc("G"), Asc("H"), Asc("I"), Asc("J"), Asc("K"), Asc("L"), Asc("M"), Asc("N"), Asc("O"), Asc("P"), Asc("Q"), Asc("R"), Asc("S"), Asc("T"), Asc("U"), Asc("V"), Asc("W"), Asc("X"), Asc("Y"), Asc("Z"), Asc("-"), Asc("."), Asc(" "), Asc("$"), Asc("/"), Asc("+"), Asc("%"))

    getCode39Character = CODE39MAP(inputdecimal)

End Function



Public Function generateCheckDigit_Code39(ByVal data As String) As String


  datalength = 0
  Sum = 0
  Result = -1
  strResult = ""
  Dim barcodechar As String
  
  datalength = Len(data)
  For x = 0 To datalength - 1
        barcodechar = Mid(data, x + 1, 1)
        Sum = Sum + getCode39Value(AscW(barcodechar))
        
  Next x
  
  Result = Sum Mod 43
  
  strResult = Chr(getCode39Character(Result))
  generateCheckDigit_Code39 = strResult

End Function

'======================================================================================================
'EAN8
'======================================================================================================

Public Function Encode_EAN8(ByVal data As String) As String

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdataleft = ""
    transformdataright = ""
    filtereddata = filterInput_EAN8(data)
    filteredlength = Len(filtereddata)

    If filteredlength > 7 Then
        filtereddata = Left$(filtereddata, 7)
    End If

    If filteredlength < 7 Then
    
        addcharlength = 7 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
    
    End If

    cd = generateCheckDigit_EAN8(filtereddata)

    'Transformation
    filtereddata = filtereddata + cd
    datalength = 0
    datalength = Len(filtereddata)

    For x = 0 To 4 - 1
        transformdataleft = transformdataleft + Mid(filtereddata, x + 1, 1)
        
    Next x
    
    transformchar = ""
    For x = 4 To 8 - 1
    
        transformchar = Mid(filtereddata, x + 1, 1)
        
        transformchar = Chr(AscW(transformchar) + 49)
        
        transformdataright = transformdataright + transformchar
    
    Next x

    'hr not used.
    Result = "[" + transformdataleft + "-" + transformdataright + "]"
    Encode_EAN8 = Result

End Function




Public Function generateCheckDigit_EAN8(ByVal data As String) As String

  datalength = 0
  parity = 0 '0-odd, 1-even
  Sum = 0
  Result = -1
  strResult = ""
  barcodechar = ""
  barcodevalue = 0

  datalength = Len(data)

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = (AscW(barcodechar) - 48)

    If parity = 0 Then 'odd
    
        Sum = Sum + (3 * barcodevalue)
        parity = 1
    
    Else
        Sum = Sum + barcodevalue
        parity = 0
    End If
  Next x

  Result = Sum Mod 10
  If Result = 0 Then
    Result = 0
  Else
    Result = 10 - Result
  End If
  
  strResult = Chr(Result + AscW("0"))
  generateCheckDigit_EAN8 = strResult

End Function


Public Function filterInput_EAN8(ByVal data As String) As String

  Result = ""
  datalength = Len(data)
  
  barcodechar = ""
  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
         Result = Result + barcodechar
    End If
  Next x

  filterInput_EAN8 = Result


End Function

'======================================================================================================
'EAN13
'======================================================================================================

Public Function Encode_EAN13(ByVal data As String, Optional ByVal hr As Integer = 0) As String

    Dim EAN13PARITYMAP(10, 6) As Integer

    
    EAN13PARITYMAP(0, 0) = 0
    EAN13PARITYMAP(0, 1) = 0
    EAN13PARITYMAP(0, 2) = 0
    EAN13PARITYMAP(0, 3) = 0
    EAN13PARITYMAP(0, 4) = 0
    EAN13PARITYMAP(0, 5) = 0
    
    EAN13PARITYMAP(1, 0) = 0
    EAN13PARITYMAP(1, 1) = 0
    EAN13PARITYMAP(1, 2) = 1
    EAN13PARITYMAP(1, 3) = 0
    EAN13PARITYMAP(1, 4) = 1
    EAN13PARITYMAP(1, 5) = 1
    
    EAN13PARITYMAP(2, 0) = 0
    EAN13PARITYMAP(2, 1) = 0
    EAN13PARITYMAP(2, 2) = 1
    EAN13PARITYMAP(2, 3) = 1
    EAN13PARITYMAP(2, 4) = 0
    EAN13PARITYMAP(2, 5) = 1
    
    EAN13PARITYMAP(3, 0) = 0
    EAN13PARITYMAP(3, 1) = 0
    EAN13PARITYMAP(3, 2) = 1
    EAN13PARITYMAP(3, 3) = 1
    EAN13PARITYMAP(3, 4) = 1
    EAN13PARITYMAP(3, 5) = 0
    
    EAN13PARITYMAP(4, 0) = 0
    EAN13PARITYMAP(4, 1) = 1
    EAN13PARITYMAP(4, 2) = 0
    EAN13PARITYMAP(4, 3) = 0
    EAN13PARITYMAP(4, 4) = 1
    EAN13PARITYMAP(4, 5) = 1
    
    EAN13PARITYMAP(5, 0) = 0
    EAN13PARITYMAP(5, 1) = 1
    EAN13PARITYMAP(5, 2) = 1
    EAN13PARITYMAP(5, 3) = 0
    EAN13PARITYMAP(5, 4) = 0
    EAN13PARITYMAP(5, 5) = 1
    
    EAN13PARITYMAP(6, 0) = 0
    EAN13PARITYMAP(6, 1) = 1
    EAN13PARITYMAP(6, 2) = 1
    EAN13PARITYMAP(6, 3) = 1
    EAN13PARITYMAP(6, 4) = 0
    EAN13PARITYMAP(6, 5) = 0
    
    EAN13PARITYMAP(7, 0) = 0
    EAN13PARITYMAP(7, 1) = 1
    EAN13PARITYMAP(7, 2) = 0
    EAN13PARITYMAP(7, 3) = 1
    EAN13PARITYMAP(7, 4) = 0
    EAN13PARITYMAP(7, 5) = 1
    
    EAN13PARITYMAP(8, 0) = 0
    EAN13PARITYMAP(8, 1) = 1
    EAN13PARITYMAP(8, 2) = 0
    EAN13PARITYMAP(8, 3) = 1
    EAN13PARITYMAP(8, 4) = 1
    EAN13PARITYMAP(8, 5) = 0
    
    EAN13PARITYMAP(9, 0) = 0
    EAN13PARITYMAP(9, 1) = 1
    EAN13PARITYMAP(9, 2) = 1
    EAN13PARITYMAP(9, 3) = 0
    EAN13PARITYMAP(9, 4) = 1
    EAN13PARITYMAP(9, 5) = 0


    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdataleft = ""
    transformdataright = ""
    filtereddata = filterInput_EAN13(data)
    filteredlength = Len(filtereddata)
    

    If filteredlength > 12 Then
        filtereddata = Left$(filtereddata, 12)
        
    End If

    If filteredlength < 12 Then
            
        addcharlength = 12 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
    
    End If

    cd = generateCheckDigit_EAN13(filtereddata)
    
    
    'Transformation
    filtereddata = filtereddata + cd
    datalength = 0
    datalength = Len(filtereddata)

    parityBit = 0
    firstdigit = 0
    For x = 0 To 7 - 1
        
        
        If x = 0 Then
            firstdigit = AscW(Mid(filtereddata, x + 1, 1)) - AscW("0") 'First digit is used for parity
            
        Else
        
            parityBit = EAN13PARITYMAP(firstdigit, x - 1)
            If parityBit = 0 Then 'odd
                transformdataleft = transformdataleft + Mid(filtereddata, x + 1, 1)
            Else
                transformdataleft = transformdataleft + Chr(AscW(Mid(filtereddata, x + 1, 1)) + 49 + 14)
            End If
            
        End If
        
    Next x
    
    transformchar = ""
    For x = 7 To 13 - 1 'include check digit
    
        transformchar = Mid(filtereddata, x + 1, 1)
        transformchar = Chr(AscW(transformchar) + 49)
        transformdataright = transformdataright + transformchar
        
    Next x

    If hr = 1 Then
        Result = Chr(firstdigit + AscW("!")) + "[" + transformdataleft + "-" + transformdataright + "]"
    Else
        Result = "[" + transformdataleft + "-" + transformdataright + "]"
    End If
    
    Encode_EAN13 = Result
    

End Function




Public Function generateCheckDigit_EAN13(ByVal data As String) As String
  
  datalength = 0
  parity = 0 '0-odd, 1-even
  Sum = 0
  Result = -1
  strResult = ""
  barcodechar = ""
  barcodevalue = 0

  datalength = Len(data)

  For x = (datalength - 1) To 0 Step -1
  
     barcodechar = Mid(data, x + 1, 1)
     barcodevalue = (AscW(barcodechar) - 48)

    If (x Mod 2) = 1 Then
        Sum = Sum + (3 * barcodevalue)
    
    Else
    
        Sum = Sum + barcodevalue
    End If
  
  Next x


  Result = Sum Mod 10
  If Result = 0 Then
    Result = 0
  Else
    Result = 10 - Result
  End If
  
  strResult = Chr(Result + AscW("0"))
  generateCheckDigit_EAN13 = strResult



End Function



Public Function filterInput_EAN13(ByVal data As String) As String
  
  Result = ""
  datalength = Len(data)
  
  barcodechar = ""
  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
         Result = Result + barcodechar
    End If
  Next x

  filterInput_EAN13 = Result

End Function

'======================================================================================================
'EXT2
'======================================================================================================

Public Function filterInput_EXT2(ByVal data As String) As String

  Result = ""
  datalength = Len(data)
  
   barcodechar = ""
  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
        
         Result = Result + barcodechar
    End If
  Next x

  
  filterInput_EXT2 = Result

End Function


Public Function Encode_EXT2(ByVal data As String) As String

    Dim EXT2PARITYMAP(4, 2) As Variant
    EXT2PARITYMAP(0, 0) = 0
    EXT2PARITYMAP(0, 1) = 0
    
    EXT2PARITYMAP(1, 0) = 0
    EXT2PARITYMAP(1, 1) = 1
    
    EXT2PARITYMAP(2, 0) = 1
    EXT2PARITYMAP(2, 1) = 0
    
    EXT2PARITYMAP(3, 0) = 1
    EXT2PARITYMAP(3, 1) = 1

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdataleft = ""
    transformdataright = ""
    filtereddata = filterInput_EXT2(data)
    filteredlength = Len(filtereddata)
    
    If filteredlength > 2 Then
        filtereddata = Left$(filtereddata, 2)
    End If

    If filteredlength < 2 Then
    
        addcharlength = 2 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
    
    End If
    
    
    'Transformation
    Sum = 0
    value1 = 0
    Value2 = 0
    parityindex = 0
    value1 = (AscW(Mid(filtereddata, 0 + 1, 1)) - 48) * 10
    Value2 = (AscW(Mid(filtereddata, 1 + 1, 1)) - 48)
    Sum = value1 + Value2
    parityindex = Sum Mod 4

    datalength = 0
    datalength = Len(filtereddata)

    parityBit = 0
    parityBit = EXT2PARITYMAP(parityindex, 0)
    If parityBit = 0 Then 'odd
        transformdataleft = transformdataleft + Mid(filtereddata, 0 + 1, 1)
    Else
        transformdataleft = transformdataleft + Chr(AscW(Mid(filtereddata, 0 + 1, 1)) + 49 + 14)
    End If

    parityBit = EXT2PARITYMAP(parityindex, 1)
    If parityBit = 0 Then 'odd
        transformdataright = transformdataright + Mid(filtereddata, 1 + 1, 1)
    Else
        transformdataright = transformdataright + Chr(AscW(Mid(filtereddata, 1 + 1, 1)) + 49 + 14)
    End If

    Result = "<" + transformdataleft + "+" + transformdataright
    Encode_EXT2 = Result
    

End Function

'======================================================================================================
'EXT5
'======================================================================================================

Public Function filterInput_EXT5(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
        
         Result = Result + barcodechar
    End If
    Next x
  
    filterInput_EXT5 = Result

End Function


Public Function Encode_EXT5(ByVal data As String) As String

    Dim EXT5PARITYMAP(10, 5) As Variant
    EXT5PARITYMAP(0, 0) = 1
    EXT5PARITYMAP(0, 1) = 1
    EXT5PARITYMAP(0, 2) = 0
    EXT5PARITYMAP(0, 3) = 0
    EXT5PARITYMAP(0, 4) = 0
    
    EXT5PARITYMAP(1, 0) = 1
    EXT5PARITYMAP(1, 1) = 0
    EXT5PARITYMAP(1, 2) = 1
    EXT5PARITYMAP(1, 3) = 0
    EXT5PARITYMAP(1, 4) = 0
    
    EXT5PARITYMAP(2, 0) = 1
    EXT5PARITYMAP(2, 1) = 0
    EXT5PARITYMAP(2, 2) = 0
    EXT5PARITYMAP(2, 3) = 1
    EXT5PARITYMAP(2, 4) = 0
    
    EXT5PARITYMAP(3, 0) = 1
    EXT5PARITYMAP(3, 1) = 0
    EXT5PARITYMAP(3, 2) = 0
    EXT5PARITYMAP(3, 3) = 0
    EXT5PARITYMAP(3, 4) = 1
    
    EXT5PARITYMAP(4, 0) = 0
    EXT5PARITYMAP(4, 1) = 1
    EXT5PARITYMAP(4, 2) = 1
    EXT5PARITYMAP(4, 3) = 0
    EXT5PARITYMAP(4, 4) = 0
    
    EXT5PARITYMAP(5, 0) = 0
    EXT5PARITYMAP(5, 1) = 0
    EXT5PARITYMAP(5, 2) = 1
    EXT5PARITYMAP(5, 3) = 1
    EXT5PARITYMAP(5, 4) = 0
    
    EXT5PARITYMAP(6, 0) = 0
    EXT5PARITYMAP(6, 1) = 0
    EXT5PARITYMAP(6, 2) = 0
    EXT5PARITYMAP(6, 3) = 1
    EXT5PARITYMAP(6, 4) = 1
    
    EXT5PARITYMAP(7, 0) = 0
    EXT5PARITYMAP(7, 1) = 1
    EXT5PARITYMAP(7, 2) = 0
    EXT5PARITYMAP(7, 3) = 1
    EXT5PARITYMAP(7, 4) = 0
    
    EXT5PARITYMAP(8, 0) = 0
    EXT5PARITYMAP(8, 1) = 1
    EXT5PARITYMAP(8, 2) = 0
    EXT5PARITYMAP(8, 3) = 0
    EXT5PARITYMAP(8, 4) = 1
    
    EXT5PARITYMAP(9, 0) = 0
    EXT5PARITYMAP(9, 1) = 0
    EXT5PARITYMAP(9, 2) = 1
    EXT5PARITYMAP(9, 3) = 0
    EXT5PARITYMAP(9, 4) = 1

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdata = ""
    filtereddata = filterInput_EXT5(data)
    filteredlength = Len(filtereddata)
    
    If filteredlength > 5 Then
        filtereddata = Left$(filtereddata, 5)
    End If

    If filteredlength < 5 Then
        
        addcharlength = 5 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
    End If

    'Transformation
    Sum = 0
    datalength = 0
    datalength = Len(filtereddata)

    barcodechar = ""
    barcodevalue = 0
    For x = datalength - 1 To 0 Step -1
    
      barcodechar = Mid(filtereddata, x + 1, 1)
      barcodevalue = AscW(barcodechar)
      
      If x Mod 2 = 0 Then
        Sum = Sum + (3 * (barcodevalue - 48))
      Else
        Sum = Sum + (9 * (barcodevalue - 48))
      End If
    Next x
    
    chk = Sum Mod 10

    
    For x = 0 To 5 - 1
     
        parityBit = 0
        parityBit = EXT5PARITYMAP(chk, x)
        If parityBit = 0 Then 'odd
            transformdata = transformdata + Mid(filtereddata, x + 1, 1)
        Else
            transformdata = transformdata + Chr(AscW(Mid(filtereddata, x + 1, 1)) + 49 + 14)
        End If
    
    Next x

    Result = "<" + Mid(transformdata, 0 + 1, 1) + "+" + Mid(transformdata, 1 + 1, 1) + "+" + Mid(transformdata, 2 + 1, 1) + "+" + Mid(transformdata, 3 + 1, 1) + "+" + Mid(transformdata, 4 + 1, 1)
    Encode_EXT5 = Result

End Function

'======================================================================================================
'UPCA
'======================================================================================================

Public Function Encode_UPCA(ByVal data As String, Optional ByVal hr As Integer = 0) As String

    cd = ""
    Result = ""
    filtereddata = filterInput_UPCA(data)
    transformdataleft = ""
    transformdataright = ""

    filteredlength = Len(filtereddata)

    If (filteredlength > 11) Then
        filtereddata = Left$(filtereddata, 11)
    End If

    If (filteredlength < 11) Then
    
        addcharlength = 11 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
    End If

    cd = generateCheckDigit_UPCA(filtereddata)

    'Transformation
    filtereddata = filtereddata + cd
    datalength = 0
    datalength = Len(filtereddata)
    For x = 0 To 6 - 1
        transformdataleft = transformdataleft + Mid(filtereddata, x + 1, 1)
    Next x

    For x = 6 To 12 - 1
        
        transformchar = AscW(Mid(filtereddata, x + 1, 1))
        transformchar = transformchar + 49 'Right Parity Characters transform 0 to a etc...
        transformdataright = transformdataright + Chr(transformchar)
    Next x
    
    If (hr = 1) Then 'make first and last digit use long bars. add 110
        Result = Chr(AscW(Mid(transformdataleft, 0 + 1, 1)) - 15) + "[" + Chr(AscW(Mid(transformdataleft, 0 + 1, 1)) + 110) + Mid(transformdataleft, 1 + 1, 5) + "-" + Mid(transformdataright, 0 + 1, 5) + Chr(AscW(Mid(transformdataright, 5 + 1, 1)) - 49 + 159) + "]" + Chr(AscW(Mid(transformdataright, 5 + 1, 1)) - 49 - 15)
    Else
        Result = "[" + transformdataleft + "-" + transformdataright + "]"
    End If
        
    Encode_UPCA = Result


End Function


Public Function generateCheckDigit_UPCA(ByVal data As String) As String

  datalength = 0
  Sum = 0
  Result = -1
  strResult = ""
  barcodechar = ""
  barcodevalue = 0

  datalength = Len(data)

  For x = 0 To datalength - 1
    
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = (AscW(barcodechar) - 48)

    If (x Mod 2 = 0) Then
        Sum = Sum + (3 * barcodevalue)
    Else
        Sum = Sum + barcodevalue
    End If
    
  Next x

  Result = Sum Mod 10
  If (Result = 0) Then
    Result = 0
  Else
    Result = 10 - Result
  End If
  
  strResult = Chr(Result + AscW("0"))
  generateCheckDigit_UPCA = strResult

End Function


Public Function getUPCACharacter(ByVal inputdecimal As Integer) As Integer

    getUPCACharacter = (inputdecimal + 48)

End Function

    

Public Function filterInput_UPCA(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
        
         Result = Result + barcodechar
    End If
    Next x
  
    filterInput_UPCA = Result

End Function

'======================================================================================================
'UPCE
'======================================================================================================

Public Function filterInput_UPCE(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
        
         Result = Result + barcodechar
    End If
    Next x
  
    filterInput_UPCE = Result

End Function


Public Function getUPCECharacter(ByVal inputdecimal As Integer) As Integer

    getUPCECharacter = (inputdecimal + 48)

End Function



Public Function generateCheckDigit_UPCE(ByVal data As String) As String

  datalength = 0
  Sum = 0
  Result = -1
  strResult = ""
  barcodechar = ""
  barcodevalue = 0

  datalength = Len(data)

  For x = 0 To datalength - 1
    
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = (AscW(barcodechar) - 48)
    
    If (parity = 0) Then
    
        Sum = Sum + (3 * barcodevalue)
        parity = 1
    
    Else
    
        Sum = Sum + barcodevalue
        parity = 0
    End If
    
  Next x

  Result = Sum Mod 10
  If (Result = 0) Then
    Result = 0
  Else
    Result = 10 - Result
  End If
  
  strResult = Chr(getUPCECharacter(Result))
  generateCheckDigit_UPCE = strResult

End Function

 Public Function Encode_UPCE(ByVal data As String, Optional ByVal hr As Integer = 0) As String
 
 
    Dim UPCEPARITYMAP(10, 2, 6) As Integer
    
    UPCEPARITYMAP(0, 0, 0) = 1
    UPCEPARITYMAP(0, 0, 1) = 1
    UPCEPARITYMAP(0, 0, 2) = 1
    UPCEPARITYMAP(0, 0, 3) = 0
    UPCEPARITYMAP(0, 0, 4) = 0
    UPCEPARITYMAP(0, 0, 5) = 0
    
    UPCEPARITYMAP(0, 1, 0) = 0
    UPCEPARITYMAP(0, 1, 1) = 0
    UPCEPARITYMAP(0, 1, 2) = 0
    UPCEPARITYMAP(0, 1, 3) = 1
    UPCEPARITYMAP(0, 1, 4) = 1
    UPCEPARITYMAP(0, 1, 5) = 1
    
    
    UPCEPARITYMAP(1, 0, 0) = 1
    UPCEPARITYMAP(1, 0, 1) = 1
    UPCEPARITYMAP(1, 0, 2) = 0
    UPCEPARITYMAP(1, 0, 3) = 1
    UPCEPARITYMAP(1, 0, 4) = 0
    UPCEPARITYMAP(1, 0, 5) = 0
    
    UPCEPARITYMAP(1, 1, 0) = 0
    UPCEPARITYMAP(1, 1, 1) = 0
    UPCEPARITYMAP(1, 1, 2) = 1
    UPCEPARITYMAP(1, 1, 3) = 0
    UPCEPARITYMAP(1, 1, 4) = 1
    UPCEPARITYMAP(1, 1, 5) = 1
    
    
    UPCEPARITYMAP(2, 0, 0) = 1
    UPCEPARITYMAP(2, 0, 1) = 1
    UPCEPARITYMAP(2, 0, 2) = 0
    UPCEPARITYMAP(2, 0, 3) = 0
    UPCEPARITYMAP(2, 0, 4) = 1
    UPCEPARITYMAP(2, 0, 5) = 0
    
    UPCEPARITYMAP(2, 1, 0) = 0
    UPCEPARITYMAP(2, 1, 1) = 0
    UPCEPARITYMAP(2, 1, 2) = 1
    UPCEPARITYMAP(2, 1, 3) = 1
    UPCEPARITYMAP(2, 1, 4) = 0
    UPCEPARITYMAP(2, 1, 5) = 1
    
    UPCEPARITYMAP(3, 0, 0) = 1
    UPCEPARITYMAP(3, 0, 1) = 1
    UPCEPARITYMAP(3, 0, 2) = 0
    UPCEPARITYMAP(3, 0, 3) = 0
    UPCEPARITYMAP(3, 0, 4) = 0
    UPCEPARITYMAP(3, 0, 5) = 1
    
    UPCEPARITYMAP(3, 1, 0) = 0
    UPCEPARITYMAP(3, 1, 1) = 0
    UPCEPARITYMAP(3, 1, 2) = 1
    UPCEPARITYMAP(3, 1, 3) = 1
    UPCEPARITYMAP(3, 1, 4) = 1
    UPCEPARITYMAP(3, 1, 5) = 0
 
    UPCEPARITYMAP(4, 0, 0) = 1
    UPCEPARITYMAP(4, 0, 1) = 0
    UPCEPARITYMAP(4, 0, 2) = 1
    UPCEPARITYMAP(4, 0, 3) = 1
    UPCEPARITYMAP(4, 0, 4) = 0
    UPCEPARITYMAP(4, 0, 5) = 0
    
    UPCEPARITYMAP(4, 1, 0) = 0
    UPCEPARITYMAP(4, 1, 1) = 1
    UPCEPARITYMAP(4, 1, 2) = 0
    UPCEPARITYMAP(4, 1, 3) = 0
    UPCEPARITYMAP(4, 1, 4) = 1
    UPCEPARITYMAP(4, 1, 5) = 1
    
    UPCEPARITYMAP(5, 0, 0) = 1
    UPCEPARITYMAP(5, 0, 1) = 0
    UPCEPARITYMAP(5, 0, 2) = 0
    UPCEPARITYMAP(5, 0, 3) = 1
    UPCEPARITYMAP(5, 0, 4) = 1
    UPCEPARITYMAP(5, 0, 5) = 0
    
    UPCEPARITYMAP(5, 1, 0) = 0
    UPCEPARITYMAP(5, 1, 1) = 1
    UPCEPARITYMAP(5, 1, 2) = 1
    UPCEPARITYMAP(5, 1, 3) = 0
    UPCEPARITYMAP(5, 1, 4) = 0
    UPCEPARITYMAP(5, 1, 5) = 1
    
    
    UPCEPARITYMAP(6, 0, 0) = 1
    UPCEPARITYMAP(6, 0, 1) = 0
    UPCEPARITYMAP(6, 0, 2) = 0
    UPCEPARITYMAP(6, 0, 3) = 0
    UPCEPARITYMAP(6, 0, 4) = 1
    UPCEPARITYMAP(6, 0, 5) = 1
    
    UPCEPARITYMAP(6, 1, 0) = 0
    UPCEPARITYMAP(6, 1, 1) = 1
    UPCEPARITYMAP(6, 1, 2) = 1
    UPCEPARITYMAP(6, 1, 3) = 1
    UPCEPARITYMAP(6, 1, 4) = 0
    UPCEPARITYMAP(6, 1, 5) = 0
                            
    UPCEPARITYMAP(7, 0, 0) = 1
    UPCEPARITYMAP(7, 0, 1) = 0
    UPCEPARITYMAP(7, 0, 2) = 1
    UPCEPARITYMAP(7, 0, 3) = 0
    UPCEPARITYMAP(7, 0, 4) = 1
    UPCEPARITYMAP(7, 0, 5) = 0
    
    UPCEPARITYMAP(7, 1, 0) = 0
    UPCEPARITYMAP(7, 1, 1) = 1
    UPCEPARITYMAP(7, 1, 2) = 0
    UPCEPARITYMAP(7, 1, 3) = 1
    UPCEPARITYMAP(7, 1, 4) = 0
    UPCEPARITYMAP(7, 1, 5) = 1
    
    UPCEPARITYMAP(8, 0, 0) = 1
    UPCEPARITYMAP(8, 0, 1) = 0
    UPCEPARITYMAP(8, 0, 2) = 1
    UPCEPARITYMAP(8, 0, 3) = 0
    UPCEPARITYMAP(8, 0, 4) = 0
    UPCEPARITYMAP(8, 0, 5) = 1
    
    UPCEPARITYMAP(8, 1, 0) = 0
    UPCEPARITYMAP(8, 1, 1) = 1
    UPCEPARITYMAP(8, 1, 2) = 0
    UPCEPARITYMAP(8, 1, 3) = 1
    UPCEPARITYMAP(8, 1, 4) = 1
    UPCEPARITYMAP(8, 1, 5) = 0
                            
    UPCEPARITYMAP(9, 0, 0) = 1
    UPCEPARITYMAP(9, 0, 1) = 0
    UPCEPARITYMAP(9, 0, 2) = 0
    UPCEPARITYMAP(9, 0, 3) = 1
    UPCEPARITYMAP(9, 0, 4) = 0
    UPCEPARITYMAP(9, 0, 5) = 1
    
    UPCEPARITYMAP(9, 1, 0) = 0
    UPCEPARITYMAP(9, 1, 1) = 1
    UPCEPARITYMAP(9, 1, 2) = 1
    UPCEPARITYMAP(9, 1, 3) = 0
    UPCEPARITYMAP(9, 1, 4) = 1
    UPCEPARITYMAP(9, 1, 5) = 0

 
    upcestr = ""
    cd = ""
    Result = ""
    filtereddata = filterInput_UPCE(data)
    transformdata = ""

    filteredlength = Len(filtereddata)

    If (filteredlength > 6) Then
        filtereddata = Left$(filtereddata, 6)
    End If

    If (filteredlength < 6) Then
    
        addcharlength = 6 - Len(filtereddata)
        For x = 0 To addcharlength - 1
            filtereddata = "0" & filtereddata
        Next x
        
    End If

    'Transformation
    'Expand
    datalength = 0
    datalength = Len(filtereddata)

    upcastr = "0"
    lastchar = Mid$(filtereddata, datalength - 1 + 1, 1)

    If (AscW(lastchar) = AscW("0")) Or (AscW(lastchar) = AscW("1")) Or (AscW(lastchar) = AscW("2")) Then
    
        
        upcastr = upcastr + Mid$(filtereddata, 0 + 1, 2)
        upcastr = upcastr + lastchar
        upcastr = upcastr + "0000"
        upcastr = upcastr + Mid$(filtereddata, 2 + 1, 3)
    
    ElseIf (AscW(lastchar) = AscW("3")) Then
    
        upcastr = upcastr + Mid$(filtereddata, 0 + 1, 3)
        upcastr = upcastr + "00000"
        upcastr = upcastr + Mid$(filtereddata, 3 + 1, 2)
    
    ElseIf (AscW(lastchar) = AscW("4")) Then
    
        upcastr = upcastr + Mid$(filtereddata, 0 + 1, 4)
        upcastr = upcastr + "00000"
        upcastr = upcastr + Mid$(filtereddata, 4 + 1, 1)
    
    ElseIf ((AscW(lastchar) = AscW("5")) Or (AscW(lastchar) = AscW("6")) Or (AscW(lastchar) = AscW("7")) Or (AscW(lastchar) = AscW("8")) Or (AscW(lastchar) = AscW("9"))) Then
    
        upcastr = upcastr + Mid$(filtereddata, 0 + 1, 5)
        upcastr = upcastr + "0000"
        upcastr = upcastr + lastchar
        
    End If
    
    
    filtereddata = upcastr

    cd = generateCheckDigit_UPCE(filtereddata)

    'Contract
    upcestr = upcastr
    productvalue = Val(Mid$(upcastr, 6 + 1, 5))
    If ((Mid$(upcestr, 3 + 1, 3) = "000") Or (Mid$(upcestr, 3 + 1, 3) = "100") Or (Mid$(upcestr, 3 + 1, 3) = "200")) Then
    
        If (productvalue >= 0) And (productvalue <= 999) Then
        
            thirdch = Mid$(upcestr, 3 + 1, 1)
            
            upcestr = DeleteSubString(upcestr, 3 + 1, 5)
            upcestr = InsertSubString(upcestr, thirdch, 6 + 1)
        
        Else
            upcestr = "000000"
        End If
    
    ElseIf (Mid$(upcestr, 4 + 1, 2) = "00") Then
      
        If (productvalue >= 0) And (productvalue <= 99) Then
        
            upcestr = DeleteSubString(upcestr, 4 + 1, 5)
            upcestr = InsertSubString(upcestr, "3", 6 + 1)
        
        Else
            upcestr = "000000"
        End If
    
     ElseIf (Mid$(upcestr, 5 + 1, 1) = "0") Then
      
        If (productvalue >= 0) And (productvalue <= 9) Then
        
            upcestr = DeleteSubString(upcestr, 5 + 1, 5)
            upcestr = InsertSubString(upcestr, "4", 6 + 1)
        
        Else
            upcestr = "000000"
        End If
        
      
     ElseIf (Mid$(upcestr, 5 + 1, 1) <> "0") Then
      
        If ((productvalue >= 5) And (productvalue <= 9)) Then
            upcestr = DeleteSubString(upcestr, 6 + 1, 4)
        
        Else
            upcestr = "000000"
            
        End If
      
     Else
        upcestr = "000000"
        
     End If

    filtereddata = upcestr
  
    parityBit = 0
    nschar = "0"
    chkvalue = (AscW(Mid$(cd, 0 + 1, 1)) - AscW("0"))

    For x = 1 To 7 - 1
    
        nsvalue = (AscW(nschar) - AscW("0"))
        transformchar = Mid$(filtereddata, x + 1, 1)
        parityBit = UPCEPARITYMAP(chkvalue, nsvalue, x - 1)
        If (parityBit = 1) Then
            transformchar = Chr(AscW(transformchar) + 48 + 15)
        End If
        transformdata = transformdata + transformchar
        
    Next x

    If (hr = 1) Then
        Result = Chr(AscW(nschar) - 15) + "{" + transformdata + "}" + Chr(chkvalue + AscW("0") - 15)
    Else
        Result = "{" + transformdata + "}"
    End If
    
    Encode_UPCE = Result

 End Function



Public Function DeleteSubString(ByVal orgStr As String, ByVal start As Integer, ByVal length As Integer) As String


    fulllength = Len(orgStr)
    leftstr = ""
    rightstr = ""
    If (start < 1) Then
        start = 1
    End If
    
    leftstr = Left$(orgStr, start - 1)
    rightstr = Right$(orgStr, fulllength - (start + length) + 1)
    DeleteSubString = leftstr + rightstr

End Function


Public Function InsertSubString(ByVal orgStr As String, ByVal insertStr As String, ByVal start As Integer) As String

    fulllength = Len(orgStr)
    leftstr = ""
    rightstr = ""
    
    If (start < 1) Then
        start = 1
    End If
    
    If (start > fulllength + 1) Then
        start = fulllength + 1
    End If
    
    leftstr = Left$(orgStr, start - 1)
    rightstr = Right$(orgStr, fulllength - start + 1)
    InsertSubString = leftstr + insertStr + rightstr

End Function

'======================================================================================================
'Code128A
'======================================================================================================

Public Function filterInput_Code128A(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = AscW(barcodechar)
    
    If (barcodevalue <= 95) And (barcodevalue >= 0) Then
        Result = Result + barcodechar
    End If
    
    Next x
  
    filterInput_Code128A = Result

End Function


Public Function translateCharacter(ByVal inputchar As Integer) As String

    returnvalue = 0

    If (inputchar <= 30) And (inputchar >= 0) Then
        returnvalue = (inputchar + 96)
    ElseIf (inputchar = 31) Then
        returnvalue = (inputchar + 96 + 100)
    ElseIf (inputchar <= 95) And (inputchar >= 32) Then
        returnvalue = inputchar
    Else
        returnvalue = -1
    End If

    translateCharacter = Chr(returnvalue)

End Function



Public Function getCode128AValue(ByVal inputchar As Integer) As Integer

    returnvalue = 0

    If (inputchar <= 31) And (inputchar >= 0) Then
        returnvalue = (inputchar + 64)
    ElseIf (inputchar <= 95) And (inputchar >= 32) Then
        returnvalue = (inputchar - 32)
    Else
        returnvalue = -1
    End If

    getCode128AValue = returnvalue

End Function


Public Function getCode128ACharacter(ByVal inputvalue As Integer) As String

    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 100 + 32
    Else
        inputvalue = -1
    End If

    getCode128ACharacter = Chr(inputvalue)


End Function


Public Function generateCheckDigit_Code128A(ByVal data As String) As String

  datalength = 0
  Sum = 103
  Result = -1
  strResult = ""

  datalength = Len(data)

  x = 0
  Weight = 1
  
  For x = 0 To Len(data) - 1
  
    c = AscW(Mid$(data, x + 1, 1))
    Sum = Sum + (getCode128AValue(c) * (Weight))
    Weight = Weight + 1
    
  
  Next x

  Result = Sum Mod 103
  strResult = getCode128ACharacter(Result)
  

  generateCheckDigit_Code128A = strResult

End Function


 Public Function Encode_Code128A(ByVal data As String) As String
 
    cd = ""
    Result = ""
    filtereddata = filterInput_Code128A(data)
    filteredlength = Len(filtereddata)
    If (filteredlength > 254) Then
        filtereddata = Left$(filtereddata, 254)
    End If

    cd = generateCheckDigit_Code128A(filtereddata)

    x = 0
  
    For x = 0 To Len(filtereddata) - 1
  
      c = translateCharacter(AscW(Mid$(filtereddata, x + 1, 1)))
      Result = Result + c    
  
    Next x

    Result = Result + cd
    startc = 235
    stopc = 238
    Result = Chr(startc) + Result + Chr(stopc)
    Encode_Code128A = Result

 End Function

'======================================================================================================
'Code128B
'======================================================================================================

Public Function filterInput_Code128B(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = AscW(barcodechar)
    
    If (barcodevalue <= 127) And (barcodevalue >= 32) Then
        Result = Result + barcodechar
    End If
    
    Next x
  
    filterInput_Code128B = Result

End Function


Public Function getCode128BValue(ByVal inputchar As Integer) As Integer

    returnvalue = 0

    If (inputchar <= 127) And (inputchar >= 32) Then
        returnvalue = (inputchar - 32)
    Else
        returnvalue = -1
    End If

    getCode128BValue = returnvalue

End Function



Public Function getCode128BCharacter(ByVal inputvalue As Integer) As String

    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 100 + 32
    Else
        inputvalue = -1
    End If

    getCode128BCharacter = Chr(inputvalue)


End Function







Public Function generateCheckDigit_Code128B(ByVal data As String) As String

  datalength = 0
  Sum = 104
  Result = -1
  strResult = ""

  datalength = Len(data)

  x = 0
  Weight = 1
  num = 0
  
  For x = 0 To Len(data) - 1
    
    num = AscW(Mid$(data, x + 1, 1))
    Sum = Sum + (getCode128BValue(num) * (Weight))
    Weight = Weight + 1
  
  Next x

  Result = Sum Mod 103
  strResult = getCode128BCharacter(Result)
  generateCheckDigit_Code128B = strResult

End Function


 Public Function Encode_Code128B(ByVal data As String) As String
 
    cd = ""
    Result = ""
    filtereddata = filterInput_Code128B(data)
    filteredlength = Len(filtereddata)
    If (filteredlength > 254) Then
        filtereddata = Left$(filtereddata, 254)
    End If

    cd = generateCheckDigit_Code128B(filtereddata)

    x = 0  
    For x = 0 To Len(filtereddata) - 1
  
      c = AscW(Mid$(filtereddata, x + 1, 1))
	If (c = 127) Then
        c = c + 100
   	Else
        c = c
   	End if 

      Result = Result + Chr(c)    
  
    Next x

    Result = Result + cd

    startc = 236
    stopc = 238
    Result = Chr(startc) + Result + Chr(stopc)
    Encode_Code128B = Result

 End Function

'======================================================================================================
'Code128C
'======================================================================================================

Public Function filterInput_Code128C(ByVal data As String) As String

  Result = ""
  datalength = Len(data)
  
  barcodechar = ""
  For x = 0 To datalength - 1
    
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
         Result = Result + barcodechar
    End If
  Next x

  filterInput_Code128C = Result


End Function
  
  

Public Function getCode128CCharacter(ByVal inputvalue As Integer) As String

    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 32 + 100
    Else
        inputvalue = -1
    End If

    getCode128CCharacter = Chr(inputvalue)


End Function



Public Function generateCheckDigit_Code128C(ByVal data As String) As String

  datalength = 0
  Sum = 105
  num = 0
  Result = -1
  strResult = ""

  datalength = Len(data)

  x = 0
  Weight = 1
  
  For x = 0 To Len(data) - 1 Step 2
    
    num = Val(Mid$(data, x + 1, 2))
    Sum = Sum + (num * Weight)
    Weight = Weight + 1
  
  
  Next x

  Result = Sum Mod 103
  strResult = getCode128CCharacter(Result)
  generateCheckDigit_Code128C = strResult
  

End Function




 Public Function Encode_Code128C(ByVal data As String) As String
 
    num = 0
    cd = ""
    Result = ""
    filtereddata = filterInput_Code128C(data)
    filteredlength = Len(filtereddata)
    
    If (filteredlength > 253) Then
        filtereddata = Left$(filtereddata, 253)
    End If

    If (Len(filtereddata) Mod 2 = 1) Then
        filtereddata = "0" + filtereddata
    End If
    
    cd = generateCheckDigit_Code128C(filtereddata)
    
    x = 0
    For x = 0 To Len(filtereddata) - 1 Step 2
    
        num = Val(Mid$(filtereddata, x + 1, 2))
        Result = Result + getCode128CCharacter(num)
    
    
    Next x

    Result = Result + cd

    startc = 237
    stopc = 238
    Result = Chr(startc) + Result + Chr(stopc)
    Encode_Code128C = Result


 End Function
    
'======================================================================================================
'I2of5
'======================================================================================================    
    
Public Function filterInput_I2of5(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
   
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
         Result = Result + barcodechar
    End If
    Next x
  
    filterInput_I2of5 = Result

End Function

Public Function getI2of5Character(ByVal inputvalue As Integer) As String

    If (inputvalue <= 90) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 99) And (inputvalue >= 91) Then
        inputvalue = inputvalue + 100
    Else
        inputvalue = -1
    End If

    getI2of5Character = Chr(inputvalue)

End Function

Public Function generateCheckDigit_I2of5(ByVal data As String) As String

  datalength = 0
  lastcharpos = 0
  Result = 0
  strResult = ""
  barcodechar = ""
  barcodevalue = 0
  toggle = 1
  sum = 0


  datalength = Len(data)
  lastcharpos = datalength - 1

  For x = lastcharpos To 0 Step -1
  
      barcodechar = Mid(data, x + 1, 1)
      barcodevalue = (AscW(barcodechar) - 48)
  
        
      If toggle = 1 Then
            sum = sum + (barcodevalue * 3)
            toggle = 0
      Else
            sum = sum + barcodevalue
            toggle = 1
      End If
  Next x

  If ((sum Mod 10) = 0) Then
        Result = AscW("0")
  Else
        Result = (10 - (sum Mod 10)) + AscW("0")
  End If

  strResult = Chr(Result)
  generateCheckDigit_I2of5 = strResult


End Function


Public Function Encode_I2of5(ByVal data As String, Optional ByVal chk As Integer = 0) As String

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdata = ""
    filtereddata = filterInput_I2of5(data)
    filteredlength = Len(filtereddata)
    
    'Input String including check digit must be even digit numbers in I2of5
    If chk = 1 Then

        If filteredlength > 253 Then
            filtereddata = Left$(filtereddata, 253)
            
        End If

        If (Len(filtereddata) Mod 2 = 0) Then   'Make it odd number of digits
            filtereddata = "0" + filtereddata
        End If

        cd = generateCheckDigit_I2of5(filtereddata)  'Together with check digit, it is even number of digits
    
    Else
        
        If filteredlength > 254 Then
            filtereddata = Left$(filtereddata, 254)
        End If

        If (Len(filtereddata) Mod 2 = 1) Then 'Make it even number of digits
            filtereddata = "0" + filtereddata
         End If
    
    End If

    filtereddata = filtereddata + cd

    
    num = 0
    For x = 0 To Len(filtereddata) - 1 Step 2
    
        num = Val(Mid(filtereddata, x + 1, 2))
        Result = Result + getI2of5Character(num)
    
    Next x
    Result = "{" + Result + "}"
    Encode_I2of5 = Result

End Function

'======================================================================================================
'Code39ASCII
'======================================================================================================

Public Function Encode_Code39ASCII(ByVal data As String, Optional ByVal chk As Integer = 1) As String

        
    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
    Result = ""
    cd = ""
            
    filtereddata = filterInput_Code39ASCII(data)
    filteredlength = Len(filtereddata)

    If chk = 1 Then
    
        If filteredlength > 254 Then
        
            filtereddata = Left$(filtereddata, 254)
            
        End If
        filtereddata = getCode39ASCIIMappedString(filtereddata)
        cd = generateCheckDigit_Code39ASCII(filtereddata)
    
    Else
    
        If filteredlength > 255 Then
            
            filtereddata = Left$(filtereddata, 255)
            
        End If
        filtereddata = getCode39ASCIIMappedString(filtereddata)
    
    End If

    Result = "*" + filtereddata + cd + "*"
    Encode_Code39ASCII = Result

End Function



Public Function getCode39ASCIIMappedString(ByVal inputx As String) As String
    
    Dim CODE39ASCIIMAP() As Variant
    CODE39ASCIIMAP = Array("%U", "$A", "$B", "$C", "$D", "$E", "$F", "$G", "$H", "$I", "$J", "$K", "$L", "$M", "$N", "$O", "$P", "$Q", "$R", "$S", "$T", "$U", "$V", "$W", "$X", "$Y", "$Z", "%A", "%B", "%C", "%D", "%E", " ", "/A", "/B", "/C", "/D", "/E", "/F", "/G", "/H", "/I", "/J", "/K", "/L", "-", ".", "/O", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "/Z", "%F", "%G", "%H", "%I", "%J", "%V", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "%K", "%L", "%M", "%N", "%O", "%W", "+A", "+B", "+C", "+D", "+E", "+F", "+G", "+H", "+I", "+J", "+K", "+L", "+M", "+N", "+O", "+P", "+Q", "+R", "+S", "+T", "+U", "+V", "+W", "+X", "+Y", "+Z", "%P", "%Q", "%R", "%S", "%T")

    strResult = ""
    datalength = 0
    datalength = Len(inputx)
    For x = 0 To datalength - 1
    
        strResult = strResult + CODE39ASCIIMAP(Asc(Mid$(inputx, x + 1, 1)))
        
    Next x
 
    getCode39ASCIIMappedString = strResult
    

End Function
    
Public Function generateCheckDigit_Code39ASCII(ByVal data As String) As String

  datalength = 0
  sum = 0
  Result = -1
  strResult = ""
  Dim barcodechar As String
  
  datalength = Len(data)
  For x = 0 To datalength - 1
        barcodechar = Mid(data, x + 1, 1)
        sum = sum + getCode39ASCIIValue(Asc(barcodechar))
  Next x
  
  Result = sum Mod 43
  
  strResult = Chr(getCode39ASCIICharacter(Result))
  generateCheckDigit_Code39ASCII = strResult

End Function
    
    
    

Public Function getCode39ASCIICharacter(ByVal inputdecimal As Integer) As String

    Dim CODE39ORIMAP() As Variant
    CODE39ORIMAP = Array(Asc("0"), Asc("1"), Asc("2"), Asc("3"), Asc("4"), Asc("5"), Asc("6"), Asc("7"), Asc("8"), Asc("9"), Asc("A"), Asc("B"), Asc("C"), Asc("D"), Asc("E"), Asc("F"), Asc("G"), Asc("H"), Asc("I"), Asc("J"), Asc("K"), Asc("L"), Asc("M"), Asc("N"), Asc("O"), Asc("P"), Asc("Q"), Asc("R"), Asc("S"), Asc("T"), Asc("U"), Asc("V"), Asc("W"), Asc("X"), Asc("Y"), Asc("Z"), Asc("-"), Asc("."), Asc(" "), Asc("$"), Asc("/"), Asc("+"), Asc("%"))

    getCode39ASCIICharacter = CODE39ORIMAP(inputdecimal)

End Function



Public Function getCode39ASCIIValue(ByVal inputchar As Integer) As Integer

        
    Dim CODE39ORIMAP() As Variant
    CODE39ORIMAP = Array(Asc("0"), Asc("1"), Asc("2"), Asc("3"), Asc("4"), Asc("5"), Asc("6"), Asc("7"), Asc("8"), Asc("9"), Asc("A"), Asc("B"), Asc("C"), Asc("D"), Asc("E"), Asc("F"), Asc("G"), Asc("H"), Asc("I"), Asc("J"), Asc("K"), Asc("L"), Asc("M"), Asc("N"), Asc("O"), Asc("P"), Asc("Q"), Asc("R"), Asc("S"), Asc("T"), Asc("U"), Asc("V"), Asc("W"), Asc("X"), Asc("Y"), Asc("Z"), Asc("-"), Asc("."), Asc(" "), Asc("$"), Asc("/"), Asc("+"), Asc("%"))
 
    Dim RVal As Integer
    RVal = -1
    For x = 0 To (43 - 1)
        If CODE39ORIMAP(x) = inputchar Then
            RVal = x
            Exit For
        End If
    Next x
    
    getCode39ASCIIValue = RVal

End Function



Public Function filterInput_Code39ASCII(ByVal data As String) As String

  
  Dim Result As String
  Result = ""
  datalength = Len(data)

  Dim barcodechar As String
  For x = 0 To datalength - 1
        barcodechar = Mid(data, x + 1, 1)
        barcodeasciivalue = Asc(barcodechar)
        If (barcodeasciivalue >= 0) And (barcodeasciivalue <= 127) Then
            Result = Result & barcodechar
        End If
  Next x

  filterInput_Code39ASCII = Result

End Function

'==========================================================================
'Encode_UCCEAN
'==========================================================================
Public Function Encode_UCCEAN(ByVal data As String, Optional ByVal GS1Compliance As Integer = 0) As String

    cd = ""
    result = ""
    replacedata102 = ""
    replacedata234 = ""
    filtereddata = filterInputUCCEAN(data)
    filteredlength = Len(filtereddata)
    If filteredlength > 254 Then
            filtereddata = Left$(filtereddata, 254)
    End If
    
    replacedata234 = replaceUCCEAN(filtereddata, 234, GS1Compliance)
    If (detectAllNumbersUCCEAN(replacedata234, GS1Compliance) = 0) Then
        
                        
        result = getAutoSwitchingABUCCEAN(replacedata234) 'need to update if 234
        cd = generateCheckDigitABUCCEAN(replacedata234)
        result = result + cd
        startc = 236
        stopc = 238
        result = Chr(startc) + result + Chr(stopc)
    
    Else
        
               
        cd = generateCheckDigitCUCCEAN(replacedata234)
    
        x = 0
        Skip = 0
        Do While (x < Len(replacedata234))
        
            Skip = 0
            If (Asc(Mid(replacedata234, x + 1, 1)) = 234) Then
                            
                result = result + Chr(234)
                x = x + 1
                Skip = 1
            
            End If
            
            
            
            Dim barcodechar1 As Integer
            Dim barcodechar2 As Integer
            If (Skip = 0) Then
            
                '5.7
                barcodechar1 = 0
                barcodechar2 = 0
                barcodechar1 = Asc(Mid(replacedata234, x + 1, 1))
                If (x + 1 < Len(replacedata234)) Then
                    barcodechar2 = Asc(Mid(replacedata234, x + 2, 1))
                End If

                If (barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 >= Asc("0") And barcodechar2 <= Asc("9")) Then
                
                        
                        'Existing Code
                        num = Val(Mid(replacedata234, x + 1, 2)) 'Check its x+1 and not x
                        result = result + getUCCEANCCharacter(num)
                        x = x + 2
            
                
                ElseIf ((barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 = 234) Or (barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 = 0)) Then
                                
                        Dim CtoB As String
                        Dim BtoC As String
                
                        'Switch from C back to B
                        CtoB = Chr(232)
                        result = result + CtoB

                        'Single B number
                        result = result + Chr(barcodechar1)
                        x = x + 1
                                
                        'Switch from B to C
                        BtoC = Chr(231)
                        result = result + BtoC
                
                End If
            
            End If
            
        Loop
        result = result + cd
        startc = 237
        stopc = 238
        result = Chr(startc) + result + Chr(stopc)
    End If
    Encode_UCCEAN = result

End Function



Public Function replaceUCCEAN(ByVal data As String, ByVal fncvalue As Integer, ByVal GS1Compliance As Integer) As String

  result = ""
  datalength = Len(data)
  forceNULL = 0

  x = 0
  numset = 0
  exitx = 0
  
  Dim startBracketPosition(8) As Integer
  Dim stopBracketPosition(8) As Integer
  
  Dim aiset(8) As String
  Dim dataset(8) As String
   
  'Check 0 based or 1 based
  For counter = 0 To (8 - 1)
  
    startBracketPosition(counter) = -1
    stopBracketPosition(counter) = -1
    
  Next counter
  
 
  x = 0
  Do While (x < datalength)
  
    barcodecharx = Mid(data, x + 1, 1)
    If (barcodecharx = "(") Then
    
         y = x + 1
         exitx = 0
                Do While ((y < datalength) And (exitx = 0))
                
                  barcodechary = Mid(data, y + 1, 1)
                  If (barcodechary = ")") Then
                  
                      startBracketPosition(numset) = x
                      stopBracketPosition(numset) = y
                      numset = numset + 1
                      exitx = 1
                  
                  End If
                  
                  If (exitx = 0) Then
                      y = y + 1
                  End If
                  
                Loop
          x = y
     
    End If
    x = x + 1
  Loop

  If (numset = 0) Then
    
   'Mod 3.2
    'forceNULL = 1
    forceNULL = 0
    replaceUCCEAN = Chr(fncvalue) + data

  Else

      For x = 0 To numset - 1
      
          aiset(x) = ""
          dataset(x) = ""
    
          If (stopBracketPosition(x) <= startBracketPosition(x)) Then
            forceNULL = 1
            Exit For
          End If
    
          If (stopBracketPosition(x) - 1 = startBracketPosition(x)) Then
            forceNULL = 1
            Exit For
          End If
    
        For y = startBracketPosition(x) + 1 To stopBracketPosition(x) - 1
        
            barcodechar = Mid(data, y + 1, 1)
            barcodevalue = Asc(barcodechar)
            If ((barcodevalue <= Asc("9") And barcodevalue >= Asc("0")) Or (barcodevalue <= Asc("Z") And barcodevalue >= Asc("A")) Or (barcodevalue <= Asc("z") And barcodevalue >= Asc("a"))) Then
                aiset(x) = aiset(x) + barcodechar
            End If
        
        Next y
    
        If (x = numset - 1) Then
        
            For y = stopBracketPosition(x) + 1 To Len(data) - 1
            
                barcodechar = Mid(data, y + 1, 1)
                barcodevalue = Asc(barcodechar)
                If ((barcodevalue <= Asc("9") And barcodevalue >= Asc("0")) Or (barcodevalue <= Asc("Z") And barcodevalue >= Asc("A")) Or (barcodevalue <= Asc("z") And barcodevalue >= Asc("a"))) Then
                    dataset(x) = dataset(x) + barcodechar
                End If
            
            Next y
        
        Else
        
            For y = stopBracketPosition(x) + 1 To startBracketPosition(x + 1) - 1
            
                 barcodechar = Mid(data, y + 1, 1)
                 barcodevalue = Asc(barcodechar)
                If ((barcodevalue <= Asc("9") And barcodevalue >= Asc("0")) Or (barcodevalue <= Asc("Z") And barcodevalue >= Asc("A")) Or (barcodevalue <= Asc("z") And barcodevalue >= Asc("a"))) Then
                    dataset(x) = dataset(x) + barcodechar
                End If
            
            Next y
        
        End If
      Next x
    
     'After Loop Exit, forceNULL may be set to 1
     If (forceNULL = 1) Then
        
        replaceUCCEAN = ""
    
     Else
        
      result = Chr(fncvalue) + result
      fncstring = Chr(fncvalue)
      For x = 0 To numset - 1
      
        If (x = numset - 1) Then
            result = result + aiset(x) + dataset(x)
        Else
            '5.7
            If (GS1Compliance = 0) Then
                result = result + aiset(x) + dataset(x) + fncstring 'existing code
            Else
        
                'Selectively add FNC1 only if compliance is on
                If (aiset(x) = "8002" Or aiset(x) = "8003" Or aiset(x) = "8004" Or aiset(x) = "8007" Or aiset(x) = "8008" Or aiset(x) = "8020" Or aiset(x) = "240" Or aiset(x) = "241" Or aiset(x) = "250" Or aiset(x) = "251" Or aiset(x) = "400" Or aiset(x) = "401" Or aiset(x) = "403" Or aiset(x) = "420" Or aiset(x) = "421" Or aiset(x) = "423" Or aiset(x) = "10" Or aiset(x) = "21" Or aiset(x) = "22" Or aiset(x) = "23" Or aiset(x) = "30" Or aiset(x) = "37" Or aiset(x) = "90" Or aiset(x) = "91" Or aiset(x) = "92" Or aiset(x) = "93" Or aiset(x) = "94" Or aiset(x) = "95" Or aiset(x) = "96" Or aiset(x) = "97" Or aiset(x) = "98" Or aiset(x) = "99") Then
                    result = result + aiset(x) + dataset(x) + fncstring
                Else
                    result = result + aiset(x) + dataset(x)
                End If
                    
        
            End If

        End If
      
      Next x
      replaceUCCEAN = result
      
      End If
  
  End If
  
  If (forceNULL = 1) Then
    replaceUCCEAN = ""
  End If

End Function
   


Public Function detectAllNumbersUCCEAN(ByVal data As String, ByVal GS1Compliance As Integer) As Integer

  'all numbers and even digits
  result = ""
  allNumbers = 1
  numNumbers = 0
  datalength = Len(data)


  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = Asc(barcodechar)
    
    If ((barcodevalue <= Asc("9")) And (barcodevalue >= Asc("0"))) Then
        numNumbers = numNumbers + 1
    ElseIf (barcodevalue = 234) Then
                
        '5.7 Loosen check when compliance is 1
        If (GS1Compliance = 0) Then
        
            If ((numNumbers Mod 2) = 1) Then
                allNumbers = 0
            End If
            
        End If
        numNumbers = 0
    Else
 
        allNumbers = 0
    End If
  Next x
  
  '5.7 Loosen check when compliance is 1
  If (GS1Compliance = 0) Then
    If ((numNumbers Mod 2) = 1) Then
          allNumbers = 0
    End If
  End If
  
  detectAllNumbersUCCEAN = allNumbers

End Function



Public Function getAutoSwitchingABUCCEAN(ByVal data As String) As String

  Dim x As Integer
  
  datalength = 0
  strResult = ""
  shiftchar = Chr(230)

  datalength = Len(data)

  x = 0
  Do While (x < Len(data))

    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = Asc(barcodechar)

    If ((barcodevalue <= 31) And (barcodevalue >= 0)) Then
            
        strResult = strResult + shiftchar
        barcodevalue = barcodevalue + 96
        strResult = strResult + Chr(barcodevalue)
    
    ElseIf (barcodevalue = 127) Then
    
        barcodevalue = barcodevalue + 100
        strResult = strResult + Chr(barcodevalue)
    
    Else
    
        num = ScanAhead_8orMore_NumbersUCCEAN(data, x)
        If (num >= 8) Then
         
            
            strResult = OptimizeNumbersUCCEAN(data, x, strResult, num)
            
            x = x - 1
        
        Else
            
            strResult = strResult + barcodechar
        End If
    
    End If

    x = x + 1
  Loop
  
  getAutoSwitchingABUCCEAN = strResult


End Function



Public Function generateCheckDigitABUCCEAN(ByVal data) As String


  datalength = 0
  Sum = 104
  result = -1
  strResult = ""
 
  datalength = Len(data)

  x = 0
  num = 0
  Weight = 1
  Do While (x < Len(data))
  
    num = ScanAhead_8orMore_NumbersUCCEAN(data, x)
    If (num >= 8) Then
    
       endpoint = x + num

      '105 to Switch from B to C
      BtoC = 99
      Sum = Sum + (BtoC * (Weight))
      Weight = Weight + 1

      Do While (x < endpoint)
      
        num = Val(Mid(data, x + 1, 2))
        Sum = Sum + (num * (Weight))
        x = x + 2
        Weight = Weight + 1
      Loop

      '104 to Switch from C back to B
      CtoB = 100
      Sum = Sum + (CtoB * (Weight))
      Weight = Weight + 1

    
    Else
    
        If (Asc(Mid(data, x + 1, 1)) = 234) Then
        
            num = 102
            Sum = Sum + (num * (Weight))
        
        Else
        
            num = Asc(Mid(data, x + 1, 1))
            Sum = Sum + getUCCEANABValue(num) * (Weight)
        
        End If
        x = x + 1
        Weight = Weight + 1
    End If
  Loop

  result = Sum Mod 103
  strResult = getUCCEANABCharacter(result)

  generateCheckDigitABUCCEAN = strResult

End Function


Public Function generateCheckDigitCUCCEAN(ByVal data As String) As String

  datalength = 0
  Sum = 105
  num = 0
  result = -1
  strResult = ""

  datalength = Len(data)

  x = 0
  Weight = 1
  Skip = 0
  Do While (x < Len(data))
  
    Skip = 0
    If (Asc(Mid(data, x + 1, 1)) = 234) Then
        num = 102
        Sum = Sum + (num * (Weight))
        x = x + 1
        Weight = Weight + 1
        Skip = 1
        
    End If


            '''''''''''''''''''''''
            Dim barcodechar1 As Integer
            Dim barcodechar2 As Integer
            If (Skip = 0) Then
            
                '5.7
                barcodechar1 = 0
                barcodechar2 = 0
                barcodechar1 = Asc(Mid(data, x + 1, 1))
                If (x + 1 < Len(data)) Then
                    barcodechar2 = Asc(Mid(data, x + 2, 1))
                End If

                If (barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 >= Asc("0") And barcodechar2 <= Asc("9")) Then
                
                        
                        'Existing Code
                        num = Val(Mid(data, x + 1, 2)) 'Check its x+1 and not x
                        Sum = Sum + (num * (Weight))
                        x = x + 2
                        Weight = Weight + 1
            
                
                ElseIf ((barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 = 234) Or (barcodechar1 >= Asc("0") And barcodechar1 <= Asc("9") And barcodechar2 = 0)) Then
                                
                        Dim CtoB As Integer
                        Dim BtoC As Integer
                
                        'Swing to B
                        CtoB = 100
                        Sum = Sum + (CtoB * (Weight))
                        Weight = Weight + 1


                        'Single B number
                        num = Asc(Mid(data, x + 1, 1))
                        Sum = Sum + getUCCEANABValue(num) * (Weight)
                        Weight = Weight + 1
                        
                        
                                
                        'Swing back to C
                        BtoC = 99
                        Sum = Sum + (BtoC * (Weight))
                        Weight = Weight + 1
                        x = x + 1
                
                End If
            
            End If
            '''''''''''''''''''''''

  Loop

  result = Sum Mod 103
  strResult = getUCCEANCCharacter(result)

  generateCheckDigitCUCCEAN = strResult

End Function

Public Function getUCCEANCCharacter(ByVal inputvalue As Integer) As String


    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        'Mod 3.2
        'inputvalue = inputvalue + 32 + 101
      inputvalue = inputvalue + 32 + 100
    Else
        inputvalue = -1
    End If

    getUCCEANCCharacter = Chr(inputvalue)

End Function


Public Function getUCCEANABCharacter(ByVal inputvalue As Integer) As String

    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 100 + 32
    Else
        inputvalue = -1
     End If

    getUCCEANABCharacter = Chr(inputvalue)

End Function


Public Function getUCCEANABValue(ByVal inputchar As Integer) As Integer

    returnvalue = 0

    If (inputchar <= 31) And (inputchar >= 0) Then
        returnvalue = (inputchar + 64)
    ElseIf ((inputchar <= 127) And (inputchar >= 32)) Then
        returnvalue = (inputchar - 32)
    ElseIf (inputchar = 230) Then
        returnvalue = 98  'Shift
    Else
        returnvalue = -1
    End If

    getUCCEANABValue = returnvalue

End Function


Public Function filterInputUCCEAN(ByVal data As String) As String

  result = ""
  datalength = Len(data)

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = Asc(barcodechar)

    If ((barcodevalue <= 127) And (barcodevalue >= 0)) Then
        result = result + barcodechar
    End If
  
  Next x

  filterInputUCCEAN = result

End Function

Public Function OptimizeNumbersUCCEAN(ByVal data As String, x As Integer, ByVal strResult As String, ByVal num As Integer) As String


        '105 to Switch from B to C
        BtoC = Chr(231)
        strResult = strResult + BtoC
                    
        endpoint = x + num
        Do While (x < endpoint)
        
            twonum = Val(Mid(data, x + 1, 2))
            
            strResult = strResult + getUCCEANCCharacter(twonum)
            x = x + 2
        
        Loop

        '104 to Switch from C back to B
        CtoB = Chr(232)
        strResult = strResult + CtoB
        
        OptimizeNumbersUCCEAN = strResult

End Function



Public Function ScanAhead_8orMore_NumbersUCCEAN(ByVal data As String, ByVal x As Integer) As Integer

    numNumbers = 0
    exitx = 0
    Do While ((x < Len(data)) And (exitx = 0))
        barcodechar = Mid(data, x + 1, 1)
        barcodevalue = Asc(barcodechar)
        If ((barcodevalue >= Asc("0")) And (barcodevalue <= Asc("9"))) Then
            numNumbers = numNumbers + 1
        Else
            exitx = 1
        End If
        x = x + 1
    Loop

    'return even digits
    If (numNumbers > 8) Then
        If ((numNumbers Mod 2) = 1) Then
            numNumbers = numNumbers - 1
        End If
    End If
    ScanAhead_8orMore_NumbersUCCEAN = numNumbers

End Function

Function MOD_10(ByVal data As String) As String

    Dim result As String
    Dim multi As Integer
    Dim total As Integer
    Dim cv As Integer
    
    If (Len(data) = 0) Then
        result = ""
    Else
    cv = 0
    multi = 3
    total = 0
    result = ""
    
    For x = 1 To Len(data)
        If (Asc(Mid(data, x, 1)) - 48 <= 9 And Asc(Mid(data, x, 1)) - 48 >= 0) Then
            result = result + Mid(data, x, 1)
        End If
    Next x

    For x = 1 To Len(result)
        cv = Asc(Mid(result, x, 1)) - 48
        total = total + cv * multi
        If (multi = 3) Then
            multi = 1
        Else
            multi = 3
        End If
            
    Next x
    
    Dim modresult As Integer
    modresult = total Mod 10
    If (modresult <> 0) Then
        modresult = 10 - modresult
    End If
    
    result = CStr(modresult)
    End If
    
    MOD_10 = result

End Function
 
Function SSCC(ByVal data As String) As String
    SSCC = SSCC_PAD(data) + MOD_10(SSCC_PAD(data))
End Function

Function GTIN(ByVal data As String) As String
    GTIN = GTIN_PAD(data) + MOD_10(GTIN_PAD(data))
End Function

 
Function SSCC_PAD(ByVal data As String) As String
    Dim result As String
    For x = 1 To Len(data)
       If (Asc(Mid(data, x, 1)) - 48 <= 9 And Asc(Mid(data, x, 1)) - 48 >= 0) Then
           result = result + Mid(data, x, 1)
       End If
    Next x
    
    If (Len(result) = 0) Then
        result = ""
    Else
        If (Len(result) > 17) Then
            result = Left(result, 17)
        End If
        If (Len(result) < 17) Then
            For x = 1 To (17 - Len(result))
                result = "0" + result
            Next x
        End If
    End If
    SSCC_PAD = result
End Function

Function GTIN_PAD(ByVal data As String) As String
    Dim result As String
    For x = 1 To Len(data)
       If (Asc(Mid(data, x, 1)) - 48 <= 9 And Asc(Mid(data, x, 1)) - 48 >= 0) Then
           result = result + Mid(data, x, 1)
       End If
    Next x
    If (Len(result) = 0) Then
        result = ""
    Else
        If (Len(result) > 13) Then
            result = Left(result, 13)
        End If
        If (Len(result) < 13) Then
            For x = 1 To (13 - Len(result))
                result = "0" + result
            Next x
        End If
    End If
    GTIN_PAD = result
End Function

'==========================================================================
'Encode_ITF14
'==========================================================================

Public Function filterInput_ITF14(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
   
    barcodechar = ""
    For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
         Result = Result + barcodechar
    End If
    Next x
  
    filterInput_ITF14 = Result

End Function

Public Function getITF14Character(ByVal inputvalue As Integer) As String

    If (inputvalue <= 90) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 99) And (inputvalue >= 91) Then
        inputvalue = inputvalue + 100
    Else
        inputvalue = -1
    End If

    getITF14Character = Chr(inputvalue)

End Function

Public Function generateCheckDigit_ITF14(ByVal data As String) As String

  datalength = 0
  lastcharpos = 0
  Result = 0
  strResult = ""
  barcodechar = ""
  barcodevalue = 0
  toggle = 1
  sum = 0


  datalength = Len(data)
  lastcharpos = datalength - 1

  For x = lastcharpos To 0 Step -1
  
      barcodechar = Mid(data, x + 1, 1)
      barcodevalue = (AscW(barcodechar) - 48)
  
        
      If toggle = 1 Then
            sum = sum + (barcodevalue * 3)
            toggle = 0
      Else
            sum = sum + barcodevalue
            toggle = 1
      End If
  Next x

  If ((sum Mod 10) = 0) Then
        Result = AscW("0")
  Else
        Result = (10 - (sum Mod 10)) + AscW("0")
  End If

  strResult = Chr(Result)
  generateCheckDigit_ITF14 = strResult


End Function


Public Function Encode_ITF14(ByVal data As String, ByVal chk As Integer, ByVal itfrectangle As Integer) As String

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
          
    transformdata = ""
    filtereddata = filterInput_ITF14(data)
    filteredlength = Len(filtereddata)
    
    'Input String including check digit must be even digit numbers in ITF14
    If chk = 1 Then

        If filteredlength > 253 Then
            filtereddata = Left$(filtereddata, 253)
            
        End If

        If (Len(filtereddata) Mod 2 = 0) Then   'Make it odd number of digits
            filtereddata = "0" + filtereddata
        End If

        cd = generateCheckDigit_ITF14(filtereddata)  'Together with check digit, it is even number of digits
    
    Else
        
        If filteredlength > 254 Then
            filtereddata = Left$(filtereddata, 254)
        End If

        If (Len(filtereddata) Mod 2 = 1) Then 'Make it even number of digits
            filtereddata = "0" + filtereddata
         End If
    
    End If
    
    
    filtereddata = filtereddata + cd

    
    num = 0
    For x = 0 To Len(filtereddata) - 1 Step 2
    
        num = Val(Mid(filtereddata, x + 1, 2))
        Result = Result + getITF14Character(num)
    
    Next x
    
    'ITF14 
    If (itfrectangle = 1) Then
        
        startITF = Chr(124)
        stopITF = Chr(126)
        Result = startITF + Result + stopITF
    
    Else
        Result = "{" + Result + "}"
    End If
        
    Encode_ITF14 = Result

End Function

'======================================================================================================
'Encode_Code128Auto
'======================================================================================================

Public Function filterInput_Code128Auto(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
  
    barcodechar = ""
    For x = 0 To datalength - 1
  
        barcodechar = Mid(data, x + 1, 1)
        barcodevalue = Asc(barcodechar)
    
    If (barcodevalue <= 127) And (barcodevalue >= 0) Then
        Result = Result + barcodechar
    End If
    
    Next x
  
    filterInput_Code128Auto = Result

End Function



Public Function getCode128ABValueAuto(ByVal inputchar As Integer) As Integer


    returnvalue = 0

    If (inputchar <= 31) And (inputchar >= 0) Then
        returnvalue = (inputchar + 64)
    ElseIf (inputchar <= 127) And (inputchar >= 32) Then
        returnvalue = (inputchar - 32)
    ElseIf (inputchar = 230) Then
        returnvalue = 98 'Shift
    Else
        returnvalue = -1
    End If

    getCode128ABValueAuto = returnvalue
 
End Function


Public Function getCode128ABCharacterAuto(ByVal inputvalue As Integer) As String

    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 100 + 32
    Else
        inputvalue = -1
    End If

    getCode128ABCharacterAuto = Chr(inputvalue)


End Function


Public Function getCode128CCharacterAuto(ByVal inputvalue As Integer) As String


    If (inputvalue <= 94) And (inputvalue >= 0) Then
        inputvalue = inputvalue + 32
    ElseIf (inputvalue <= 106) And (inputvalue >= 95) Then
        inputvalue = inputvalue + 32 + 100
    Else
        inputvalue = -1
    End If
    
    getCode128CCharacterAuto = Chr(inputvalue)

End Function

Public Function generateCheckDigit_Code128ABAuto(ByVal data As String) As String
  
  datalength = 0
  Sum = 104
  Result = -1
  strResult = ""

  datalength = Len(data)
  
  num = 0
  Weight = 1
  
  x = 0
  Do While (x < Len(data))
  'For x = 0 To Len(data) - 1
  
    num = ScanAhead_8orMore_Numbers(data, x)
    If (num >= 8) Then
    
      endpoint = x + num

      '105 to Switch from B to C
      BtoC = 99
      Sum = Sum + (BtoC * (Weight))
      Weight = Weight + 1
      
      'For z = x To endpoint - 1 Step 2
      Do While (x < endpoint)
      
        num = Val(Mid(data, x + 1, 2))
        Sum = Sum + (num * (Weight))
        x = x + 2
        Weight = Weight + 1

      Loop
      'Next z
      'x = z

      '104 to Switch from C back to B
      CtoB = 100
      Sum = Sum + (CtoB * (Weight))
      Weight = Weight + 1
    
    
    Else
    
        num = Asc(Mid$(data, x + 1, 1))
        Sum = Sum + (getCode128ABValueAuto(num) * (Weight))
        x = x + 1
        Weight = Weight + 1
    
    End If
  
  'Next x
  Loop

  Result = Sum Mod 103
  strResult = getCode128ABCharacterAuto(Result)
  generateCheckDigit_Code128ABAuto = strResult
  

End Function



Public Function generateCheckDigit_Code128CAuto(ByVal data As String) As String
    
  datalength = 0
  Sum = 105
  Result = -1
  strResult = ""

  datalength = Len(data)

  
  num = 0
  Weight = 1
  
  For x = 0 To Len(data) - 1 Step 2
  
    num = Val(Mid$(data, x + 1, 2))
    Sum = Sum + (num * Weight)
    Weight = Weight + 1
  
  Next x

  Result = Sum Mod 103
  strResult = getCode128CCharacterAuto(Result)

  generateCheckDigit_Code128CAuto = strResult

End Function

Public Function getAutoSwitchingAB(ByVal data As String) As String


  datalength = 0
  strResult = ""
  shiftchar = Chr(230)

  datalength = Len(data)
  Dim barcodechar As String
  Dim x As Integer

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = Asc(barcodechar)

    If (barcodevalue = 31) Then
        
        barcodechar = Chr(Asc(barcodechar) + 96 + 100)
        strResult = strResult + barcodechar
    
    ElseIf (barcodevalue = 127) Then
    
        barcodechar = Chr(Asc(barcodechar) + 100)
        strResult = strResult + barcodechar
    
    Else
    
        num = ScanAhead_8orMore_Numbers(data, x)
        If (num >= 8) Then
            
            strResult = OptimizeNumbers(data, x, strResult, num)
            x = x - 1
        
        Else
            strResult = strResult + barcodechar
        End If
            
        
    End If
 
    
  Next x
    

  getAutoSwitchingAB = strResult

 End Function


Public Function detectAllNumbers(ByVal data As String) As Integer


  'all numbers and even digits
  Result = ""
  allnumbers = 1
  
  datalength = Len(data)

  If (datalength Mod 2 = 1) Then
     allnumbers = 0
  Else
    
        For x = 0 To datalength - 1
            barcodechar = Asc(Mid(data, x + 1, 1))
            If (barcodechar <= Asc("9")) And (barcodechar >= Asc("0")) Then
                'do nothing
            Else
                allnumbers = 0
            End If
        Next x
  End If

  detectAllNumbers = allnumbers

End Function


Public Function addShift(ByVal data As String) As String

  datalength = 0
  strResult = ""
  shiftchar = Chr(230)

  datalength = Len(data)
  
  For x = 0 To datalength - 1
      
    barcodechar = Mid(data, x + 1, 1)
    barcodevalue = Asc(barcodechar)

    'Code 128 A - 0..31 Add Shift
    If (barcodevalue <= 31) And (barcodevalue >= 0) Then
    
        
        strResult = strResult + shiftchar
        barcodechar = Chr(Asc(barcodechar) + 96)
        strResult = strResult + barcodechar
    
    Else
        strResult = strResult + barcodechar
    End If

    
  Next x
  
  addShift = strResult


End Function



Public Function Encode_Code128Auto(ByVal data As String) As String

 
    cd = ""
    Result = ""
    shiftdata = ""
    
    filtereddata = filterInput_Code128Auto(data)
    
    filteredlength = Len(filtereddata)
    If (filteredlength > 254) Then
        filtereddata = Left$(filtereddata, 254)
    End If
    
        
    If (detectAllNumbers(filtereddata) = 0) Then
            
        filtereddata = addShift(filtereddata)
        cd = generateCheckDigit_Code128ABAuto(filtereddata)
        'Convert Ascii 31 / Ascii 127 to 227
        filtereddata = getAutoSwitchingAB(filtereddata)

        
        'MsgBox Asc(cd)
        
        filtereddata = filtereddata + cd
        Result = filtereddata
        
        startc = 236
        stopc = 238
        Result = Chr(startc) + Result + Chr(stopc)
    
    Else
        
        
        cd = generateCheckDigit_Code128CAuto(filtereddata)
        lenFiltered = Len(filtereddata)
        
        For x = 0 To (lenFiltered - 1) Step 2
        
            tstr = Mid$(filtereddata, x + 1, 2)
            num = Val(tstr)
            Result = Result + getCode128CCharacterAuto(num)
        
        Next x
        
        
        Result = Result + cd
        startc = 237
        stopc = 238
        Result = Chr(startc) + Result + Chr(stopc)
        
    End If

    Encode_Code128Auto = Result

 End Function



Public Function OptimizeNumbers(ByVal data As String, x As Integer, ByVal strResult As String, ByVal num As Integer) As String

        '105 to Switch from B to C
        BtoC = Chr(231)
        strResult = strResult + BtoC
                    
        endpoint = x + num
        Do While (x < endpoint)
                
            twonum = Val(Mid(data, x + 1, 2))
            strResult = strResult + getCode128CCharacterAuto(twonum)
            x = x + 2
            
        Loop

        '104 to Switch from C back to B
        CtoB = Chr(232)
        strResult = strResult + CtoB
        
        OptimizeNumbers = strResult

End Function

Public Function ScanAhead_8orMore_Numbers(ByVal data As String, ByVal x As Integer) As Integer

    numNumbers = 0
    exitx = 0
    Do While ((x < Len(data)) And (exitx = 0))
    
        barcodechar = Mid(data, x + 1, 1)
        barcodevalue = Asc(barcodechar)
        If (barcodevalue >= Asc("0") And barcodevalue <= Asc("9")) Then
            numNumbers = numNumbers + 1
        Else
            exitx = 1
        End If
        x = x + 1
        
    Loop

    'return even digits
    If (numNumbers > 8) Then
        If (numNumbers Mod 2 = 1) Then
            numNumbers = numNumbers - 1
        End If
    End If
    ScanAhead_8orMore_Numbers = numNumbers

End Function

'======================================================================================================
'Industrial2of5
'======================================================================================================

Public Function Encode_Industrial2of5(ByVal data As String, Optional ByVal chk As Integer = 0) As String

    Dim Result As String
    Dim cd As String
    Dim filtereddata As String

    cd = ""
    Result = ""
    filtereddata = filterInput_Industrial2of5(data)
    filteredlength = Len(filtereddata)
    
    
    If chk = 1 Then
    
        If filteredlength > 254 Then
            filtereddata = Left$(filtereddata, 254)
        End If
        cd = generateCheckDigit_Industrial2of5(filtereddata)
    
    Else
    
        If filteredlength > 255 Then
            filtereddata = Left$(filtereddata, 255)
        End If
    
    End If

    filtereddata = filtereddata + cd
    Result = "{" + filtereddata + "}"
    

    Encode_Industrial2of5 = Result

End Function



Public Function filterInput_Industrial2of5(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
   
    barcodechar = ""
    For x = 0 To datalength - 1
  
        barcodechar = Mid(data, x + 1, 1)
        If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
             Result = Result + barcodechar
        End If
    Next x
  
    filterInput_Industrial2of5 = Result

End Function



Public Function generateCheckDigit_Industrial2of5(ByVal data As String) As String

  datalength = 0
  lastcharpos = 0
  Result = 0
  strResult = ""
  barcodechar = ""
  barcodevalue = 0
  toggle = 1
  Sum = 0


  datalength = Len(data)
  lastcharpos = datalength - 1

  For x = lastcharpos To 0 Step -1
  
      barcodechar = Mid(data, x + 1, 1)
      barcodevalue = (AscW(barcodechar) - 48)
  
        
      If toggle = 1 Then
            Sum = Sum + (barcodevalue * 3)
            toggle = 0
      Else
            Sum = Sum + barcodevalue
            toggle = 1
      End If
  Next x

  If ((Sum Mod 10) = 0) Then
        Result = AscW("0")
  Else
        Result = (10 - (Sum Mod 10)) + AscW("0")
  End If

  strResult = Chr(Result)
  generateCheckDigit_Industrial2of5 = strResult


End Function

'======================================================================================================
'ModifiedPlessy
'======================================================================================================

Public Function Encode_ModifiedPlessy(ByVal data As String, Optional ByVal chk As Integer = 0) As String


    Dim Result As String
    Dim cd As String
    Dim filtereddata As String

    cd = ""
    Result = ""
    filtereddata = filterInput_ModifiedPlessy(data)
    filteredlength = Len(filtereddata)
    
    
    If chk = 1 Then
    
        If filteredlength > 15 Then
            filtereddata = Left$(filtereddata, 15)
        End If
        cd = generateCheckDigit_ModifiedPlessy(filtereddata)
    
    Else
    
        If filteredlength > 16 Then
            filtereddata = Left$(filtereddata, 16)
        End If
    
    End If

    filtereddata = filtereddata + cd
    Result = "{" + filtereddata + "}"

    Encode_ModifiedPlessy = Result

End Function


Public Function generateCheckDigit_ModifiedPlessy(ByVal data As String) As String


  doublechar = ""
  doubleStr = ""
  doubleNumber = 0

  datalength = 0
  lastcharpos = 0
  Result = 0
  strResult = ""
  barcodechar = ""
  barcodevalue = 0
  toggle = 1
  Sum = 0


  datalength = Len(data)
  lastcharpos = datalength - 1

  '=================================

  For x = lastcharpos To 0 Step -1
  
      barcodechar = Mid(data, x + 1, 1)
      barcodevalue = (AscW(barcodechar) - 48)
  
        
      If toggle = 1 Then
            doubleStr = barcodechar + doubleStr
            toggle = 0
      Else
            Sum = Sum + barcodevalue
            toggle = 1
      End If
  Next x
  
  
  doubleNumber = Val(doubleStr)
  doubleNumber = doubleNumber * 2
  
  doubleStr = Str$(doubleNumber)
  doubleStr = Trim(doubleStr)
  
  For y = 0 To Len(doubleStr) - 1
  
    barcodechar = Mid(doubleStr, y + 1, 1)
    barcodevalue = (AscW(barcodechar) - 48)
    Sum = Sum + barcodevalue
    
    
  Next y
  
  
  '=================================

  If ((Sum Mod 10) = 0) Then
        Result = AscW("0")
  Else
        Result = (10 - (Sum Mod 10)) + AscW("0")
  End If

  strResult = Chr(Result)
  generateCheckDigit_ModifiedPlessy = strResult


End Function


Public Function filterInput_ModifiedPlessy(ByVal data As String) As String

    Result = ""
    datalength = Len(data)
   
    barcodechar = ""
    For x = 0 To datalength - 1
    
  
        barcodechar = Mid(data, x + 1, 1)
        If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
             Result = Result + barcodechar
        End If
    Next x
  
    filterInput_ModifiedPlessy = Result

End Function

'======================================================================================================
'Code93
'======================================================================================================
Public Function Encode_Code93(ByVal data As String, Optional ByVal chk As Integer = 1) As String

      
    Dim Result As String
    Dim cd As String
    Dim filtereddata As String
    Dim datalength As Integer
    Dim barcodevalue As Integer
    
    cd = ""
    Result = ""
    filtereddata = filterInput_Code93(data)
    filteredlength = Len(filtereddata)

    If chk = 1 Then
    
        If filteredlength > 254 Then
        
            filtereddata = Left$(filtereddata, 254)
            
        End If
        cd = generateCheckDigit_Code93(filtereddata)
    
    Else
    
        If filteredlength > 255 Then
            
            filtereddata = Left$(filtereddata, 255)
            
        End If
    
    End If
    
    
    datalength = 0
    datalength = Len(filtereddata)
    For x = 0 To datalength - 1
        
        barcodevalue = Asc(Mid(filtereddata, x + 1, 1))
        Result = Result + translate_Code93(barcodevalue)
    
    Next x
    

    Encode_Code93 = Chr(197) + Result + cd + Chr(198)
    
    

End Function




Public Function filterInput_Code93(ByVal data As String) As String

  
  Dim Result As String
  Dim barcodechar As Integer
  Result = ""
  datalength = Len(data)
  
  For x = 0 To datalength - 1
        barcodechar = Asc(Mid(data, x + 1, 1))
        If (barcodechar >= 0) And (barcodechar <= 127) Then
            Result = Result & Chr(barcodechar)
        End If
  Next x

  filterInput_Code93 = Result

End Function


Public Function translate_Code93(ByVal inputx As Integer) As String

    Result = ""
    Select Case (inputx)
    
        Case 0:
            Result = Result + Chr(194)
            Result = Result + Chr(85)
            
        Case 1:
            Result = Result + Chr(193)
            Result = Result + Chr(65)
            
        Case 2:
            Result = Result + Chr(193)
            Result = Result + Chr(66)
            
        Case 3:
            Result = Result + Chr(193)
            Result = Result + Chr(67)
            
        Case 4:
            Result = Result + Chr(193)
            Result = Result + Chr(68)
            
        Case 5:
            Result = Result + Chr(193)
            Result = Result + Chr(69)
            
        Case 6:
            Result = Result + Chr(193)
            Result = Result + Chr(70)
            
        Case 7:
            Result = Result + Chr(193)
            Result = Result + Chr(71)
            
        Case 8:
            Result = Result + Chr(193)
            Result = Result + Chr(72)
            
        Case 9:
            Result = Result + Chr(193)
            Result = Result + Chr(73)
            
        Case 10:
            Result = Result + Chr(193)
            Result = Result + Chr(74)
            
        Case 11:
            Result = Result + Chr(193)
            Result = Result + Chr(75)
            
        Case 12:
            Result = Result + Chr(193)
            Result = Result + Chr(76)
            
        Case 13:
            Result = Result + Chr(193)
            Result = Result + Chr(77)
            
        Case 14:
            Result = Result + Chr(193)
            Result = Result + Chr(78)
            
        Case 15:
            Result = Result + Chr(193)
            Result = Result + Chr(79)
            
        Case 16:
            Result = Result + Chr(193)
            Result = Result + Chr(80)
            
        Case 17:
            Result = Result + Chr(193)
            Result = Result + Chr(81)
            
        Case 18:
            Result = Result + Chr(193)
            Result = Result + Chr(82)
            
        Case 19:
            Result = Result + Chr(193)
            Result = Result + Chr(83)
            
        Case 20:
            Result = Result + Chr(193)
            Result = Result + Chr(84)
            
        Case 21:
            Result = Result + Chr(193)
            Result = Result + Chr(85)
            
        Case 22:
            Result = Result + Chr(193)
            Result = Result + Chr(86)
            
        Case 23:
            Result = Result + Chr(193)
            Result = Result + Chr(87)
            
        Case 24:
            Result = Result + Chr(193)
            Result = Result + Chr(88)
            
        Case 25:
            Result = Result + Chr(193)
            Result = Result + Chr(89)
            
        Case 26:
            Result = Result + Chr(193)
            Result = Result + Chr(90)
            
        Case 27:
            Result = Result + Chr(194)
            Result = Result + Chr(65)
            
        Case 28:
            Result = Result + Chr(194)
            Result = Result + Chr(66)
            
        Case 29:
            Result = Result + Chr(194)
            Result = Result + Chr(67)
            
        Case 30:
            Result = Result + Chr(194)
            Result = Result + Chr(68)
            
        Case 31:
            Result = Result + Chr(194)
            Result = Result + Chr(69)
            
        Case 32:
            Result = Result + Chr(32)
            
        Case 33:
            Result = Result + Chr(195)
            Result = Result + Chr(65)
            
        Case 34:
            Result = Result + Chr(195)
            Result = Result + Chr(66)
            
        Case 35:
            Result = Result + Chr(195)
            Result = Result + Chr(67)
            
        Case 36:
            Result = Result + Chr(36)
            
        Case 37:
            Result = Result + Chr(37)
            
        Case 38:
            Result = Result + Chr(195)
            Result = Result + Chr(70)
            
        Case 39:
            Result = Result + Chr(195)
            Result = Result + Chr(71)
            
        Case 40:
            Result = Result + Chr(195)
            Result = Result + Chr(72)
            
        Case 41:
            Result = Result + Chr(195)
            Result = Result + Chr(73)
            
        Case 42:
            Result = Result + Chr(195)
            Result = Result + Chr(74)
            
        Case 43:
            Result = Result + Chr(43)
            
        Case 44:
            Result = Result + Chr(195)
            Result = Result + Chr(76)
            
        Case 45:
            Result = Result + Chr(45)
            
        Case 46:
            Result = Result + Chr(46)
            
        Case 47:
            Result = Result + Chr(47)
            
        Case 48:
            Result = Result + Chr(48)
            
        Case 49:
            Result = Result + Chr(49)
            
        Case 50:
            Result = Result + Chr(50)
            
        Case 51:
            Result = Result + Chr(51)
            
        Case 52:
            Result = Result + Chr(52)
            
        Case 53:
            Result = Result + Chr(53)
            
        Case 54:
            Result = Result + Chr(54)
            
        Case 55:
            Result = Result + Chr(55)
            
        Case 56:
            Result = Result + Chr(56)
            
        Case 57:
            Result = Result + Chr(57)
            
        Case 58:
            Result = Result + Chr(195)
            Result = Result + Chr(90)
            
        Case 59:
            Result = Result + Chr(194)
            Result = Result + Chr(70)
            
        Case 60:
            Result = Result + Chr(194)
            Result = Result + Chr(71)
            
        Case 61:
            Result = Result + Chr(194)
            Result = Result + Chr(72)
            
        Case 62:
            Result = Result + Chr(194)
            Result = Result + Chr(73)
            
        Case 63:
            Result = Result + Chr(194)
            Result = Result + Chr(74)
            
        Case 64:
            Result = Result + Chr(194)
            Result = Result + Chr(86)
            
        Case 65:
            Result = Result + Chr(65)
            
        Case 66:
            Result = Result + Chr(66)
            
        Case 67:
            Result = Result + Chr(67)
            
        Case 68:
            Result = Result + Chr(68)
            
        Case 69:
            Result = Result + Chr(69)
            
        Case 70:
            Result = Result + Chr(70)
            
        Case 71:
            Result = Result + Chr(71)
            
        Case 72:
            Result = Result + Chr(72)
            
        Case 73:
            Result = Result + Chr(73)
            
        Case 74:
            Result = Result + Chr(74)
            
        Case 75:
            Result = Result + Chr(75)
            
        Case 76:
            Result = Result + Chr(76)
            
        Case 77:
            Result = Result + Chr(77)
            
        Case 78:
            Result = Result + Chr(78)
            
        Case 79:
            Result = Result + Chr(79)
            
        Case 80:
            Result = Result + Chr(80)
            
        Case 81:
            Result = Result + Chr(81)
            
        Case 82:
            Result = Result + Chr(82)
            
        Case 83:
            Result = Result + Chr(83)
            
        Case 84:
            Result = Result + Chr(84)
            
        Case 85:
            Result = Result + Chr(85)
            
        Case 86:
            Result = Result + Chr(86)
            
        Case 87:
            Result = Result + Chr(87)
            
        Case 88:
            Result = Result + Chr(88)
            
        Case 89:
            Result = Result + Chr(89)
            
        Case 90:
            Result = Result + Chr(90)
            
        Case 91:
            Result = Result + Chr(194)
            Result = Result + Chr(75)
            
        Case 92:
            Result = Result + Chr(194)
            Result = Result + Chr(76)
            
        Case 93:
            Result = Result + Chr(194)
            Result = Result + Chr(77)
            
        Case 94:
            Result = Result + Chr(194)
            Result = Result + Chr(78)
            
        Case 95:
            Result = Result + Chr(194)
            Result = Result + Chr(79)
            
        Case 96:
            Result = Result + Chr(194)
            Result = Result + Chr(87)
            
        Case 97:
            Result = Result + Chr(196)
            Result = Result + Chr(65)
            
        Case 98:
            Result = Result + Chr(196)
            Result = Result + Chr(66)
            
        Case 99:
            Result = Result + Chr(196)
            Result = Result + Chr(67)
            
        Case 100:
            Result = Result + Chr(196)
            Result = Result + Chr(68)
            
        Case 101:
            Result = Result + Chr(196)
            Result = Result + Chr(69)
            
        Case 102:
            Result = Result + Chr(196)
            Result = Result + Chr(70)
            
        Case 103:
            Result = Result + Chr(196)
            Result = Result + Chr(71)
            
        Case 104:
            Result = Result + Chr(196)
            Result = Result + Chr(72)
            
        Case 105:
            Result = Result + Chr(196)
            Result = Result + Chr(73)
            
        Case 106:
            Result = Result + Chr(196)
            Result = Result + Chr(74)
            
        Case 107:
            Result = Result + Chr(196)
            Result = Result + Chr(75)
            
        Case 108:
            Result = Result + Chr(196)
            Result = Result + Chr(76)
            
        Case 109:
            Result = Result + Chr(196)
            Result = Result + Chr(77)
            
        Case 110:
            Result = Result + Chr(196)
            Result = Result + Chr(78)
            
        Case 111:
            Result = Result + Chr(196)
            Result = Result + Chr(79)
            
        Case 112:
            Result = Result + Chr(196)
            Result = Result + Chr(80)
            
        Case 113:
            Result = Result + Chr(196)
            Result = Result + Chr(81)
            
        Case 114:
            Result = Result + Chr(196)
            Result = Result + Chr(82)
            
        Case 115:
            Result = Result + Chr(196)
            Result = Result + Chr(83)
            
        Case 116:
            Result = Result + Chr(196)
            Result = Result + Chr(84)
            
        Case 117:
            Result = Result + Chr(196)
            Result = Result + Chr(85)
            
        Case 118:
            Result = Result + Chr(196)
            Result = Result + Chr(86)
            
        Case 119:
            Result = Result + Chr(196)
            Result = Result + Chr(87)
            
        Case 120:
            Result = Result + Chr(196)
            Result = Result + Chr(88)
            
        Case 121:
            Result = Result + Chr(196)
            Result = Result + Chr(89)
            
        Case 122:
            Result = Result + Chr(196)
            Result = Result + Chr(90)
            
        Case 123:
            Result = Result + Chr(194)
            Result = Result + Chr(80)
            
        Case 124:
            Result = Result + Chr(194)
            Result = Result + Chr(81)
            
        Case 125:
            Result = Result + Chr(194)
            Result = Result + Chr(82)
            
        Case 126:
            Result = Result + Chr(194)
            Result = Result + Chr(83)
            
        Case 127:
            Result = Result + Chr(194)
            Result = Result + Chr(84)
            
    End Select
    translate_Code93 = Result

End Function



Public Function getCode93Value(ByVal inputx As Integer) As Integer

    If (inputx >= 193) And (inputx <= 196) Then
        inputx = inputx - 150
    ElseIf (inputx = 32) Then
        inputx = 38
    ElseIf (inputx = 36) Then
        inputx = 39
    ElseIf (inputx = 37) Then
        inputx = 42
    ElseIf (inputx = 43) Then
        inputx = 41
    ElseIf (inputx = 45) Then
        inputx = 36
    ElseIf (inputx = 46) Then
        inputx = 37
    ElseIf (inputx = 47) Then
        inputx = 40
    ElseIf (inputx >= 48) And (inputx <= 57) Then
        inputx = inputx - 48
    ElseIf (inputx >= 65) And (inputx <= 90) Then
        inputx = inputx - 55
    End If

    getCode93Value = inputx

End Function

Public Function getCode93Character(ByVal inputx As Integer) As Integer

    If (inputx >= 43) And (inputx <= 46) Then
        inputx = inputx + 150
    ElseIf (inputx = 38) Then
        inputx = 32
    ElseIf (inputx = 39) Then
        inputx = 36
    ElseIf (inputx = 42) Then
        inputx = 37
    ElseIf (inputx = 41) Then
        inputx = 43
    ElseIf (inputx = 36) Then
        inputx = 45
    ElseIf (inputx = 37) Then
        inputx = 46
    ElseIf (inputx = 40) Then
        inputx = 47
    ElseIf (inputx >= 0) And (inputx <= 9) Then
        inputx = inputx + 48
    ElseIf (inputx >= 10) And (inputx <= 35) Then
        inputx = inputx + 55
    End If

    getCode93Character = inputx

End Function


Public Function generateCheckDigit_Code93(ByVal data As String) As String

    Dim cchk As Integer
    Dim kchk As Integer
    Dim sumx As Integer
    Dim x As Integer
    Dim translatedStr As String
    Dim weight As Integer
    Dim code93value As Integer
    Dim barcodechar As String
    Dim forceReturn As Integer
    

       
    forceReturn = 0
    sumx = 0
    x = 0
    translatedStr = ""
    weight = 1
    code93value = 0
    
    x = Len(data) - 1
    Do While (x >= 0)
    
        barcodechar = Mid(data, x + 1, 1)
        translatedStr = translate_Code93(Asc(barcodechar))
        If (Len(translatedStr) = 2) Then
        
            'code93value=getCode93Value((unsigned char) translatedStr[1]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 1 + 1, 1)))
            
            'weight = (weight>20) ? 1 : weight
            If (weight > 20) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1

            'code93value=getCode93Value((unsigned char) translatedStr[0]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 0 + 1, 1)))
            If (weight > 20) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1
        
        ElseIf (Len(translatedStr) = 1) Then
        
            'code93value=getCode93Value((unsigned char) translatedStr[0]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 0 + 1, 1)))
            If (weight > 20) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1
        
        Else
            forceReturn = 1  'return "";
        End If

        x = x - 1
    
    Loop

    cchk = sumx Mod 47
    weight = 2
    sumx = sumx Mod 47
    x = Len(data) - 1
    Do While (x >= 0)
    
        barcodechar = Mid(data, x + 1, 1)
        translatedStr = translate_Code93(Asc(barcodechar))
        
        If (Len(translatedStr) = 2) Then
        
            'code93value=getCode93Value((unsigned char) translatedStr[1]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 1 + 1, 1)))
            If (weight > 15) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1

            'code93value=getCode93Value((unsigned char) translatedStr[0]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 0 + 1, 1)))
            If (weight > 15) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1
        
        ElseIf (Len(translatedStr) = 1) Then
        
            'code93value=getCode93Value((unsigned char) translatedStr[0]);
            code93value = getCode93Value(Asc(Mid(translatedStr, 0 + 1, 1)))
            If (weight > 15) Then
                weight = 1
            End If
            sumx = sumx + (weight * code93value)
            weight = weight + 1
        Else
            forceReturn = 1  'return "";
        End If

        x = x - 1
    
    Loop
    kchk = sumx Mod 47
    
    If (forceReturn = 1) Then
        generateCheckDigit_Code93 = ""
    Else
        generateCheckDigit_Code93 = Chr(getCode93Character(cchk)) + Chr(getCode93Character(kchk))
    End If

End Function

' ==========================================================
' CodeCodabar
' ==========================================================
Public Function Encode_CodeCodabar(ByVal data As String) As String

    cd = ""
    Result = ""
    filtereddata = filterInput_CodeCodabar(data)
    filteredlength = Len(filtereddata)

    If (filteredlength > 255) Then
        filtereddata = Left$(filtereddata, 255)
    End If

    Encode_CodeCodabar = filtereddata

End Function


Public Function getCodeCodabarValue(ByVal inputchar As String) As Integer

  'Dim CODECODABARMAP(43) As String
  CODECODABARMAP = Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "-", ".", "$", "/", "+", ":")
      
  returnVal = -1
  For x = 0 To 20 - 1
    
        If (CODECODABARMAP(x) = inputchar) Then
            returnVal = x
            Exit For
        End If
  Next x
  getCodeCodabarValue = returnVal
  
End Function

Public Function filterInput_CodeCodabar(ByVal data As String) As String

  Result = ""
  datalength = Len(data)

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    If (getCodeCodabarValue(barcodechar) <> -1) Then
        
        Result = Result + barcodechar
    End If
  
  Next x

  filterInput_CodeCodabar = Result

End Function

'======================================================================================================
'POSTNET
'======================================================================================================
Public Function Encode_POSTNET(ByVal data As String) As String

    cd = ""
    result = ""
    filtereddata = filterInput_POSTNET(data)
    filteredlength = Len(filtereddata)

    If (filteredlength > 11) Then
        filtereddata = Left$(filtereddata, 11)
    End If

    cd = generateCheckDigit_POSTNET(filtereddata)
    result = "{"+filtereddata + cd+"}"
    Encode_POSTNET = result

End Function



Public Function generateCheckDigit_POSTNET(ByVal data As String) As String

  datalength = 0
  Sumx = 0
  result = -1
  strResult = ""
  barcodechar = ""

  datalength = Len(data)
  For x = 0 To datalength - 1
        
        barcodechar = Mid(data, x + 1, 1)
        Sumx = Sumx + getPOSTNETValue(Asc(barcodechar))
  Next x

  result = Sumx Mod 10
  If (result <> 0) Then
    result = (10 - result)
  End If

  strResult = Chr(getPOSTNETCharacter(result))

  generateCheckDigit_POSTNET = strResult


End Function


Public Function getPOSTNETCharacter(ByVal inputdecimal As Integer) As Integer

    getPOSTNETCharacter = inputdecimal + 48

End Function


Public Function getPOSTNETValue(ByVal inputchar As Integer) As Integer

    getPOSTNETValue = inputchar - 48

End Function
    


Public Function filterInput_POSTNET(ByVal data As String) As String

  result = ""
  datalength = Len(data)

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    If (Asc(barcodechar) >= Asc("0") And Asc(barcodechar) <= Asc("9")) Then
         result = result + barcodechar
    End If
  Next x

 filterInput_POSTNET = result


End Function



'======================================================================================================
'Helper Functions for GS1 Databar
'======================================================================================================

Public Function filterInput_GS1Databar14(ByVal data As String) As String

    Dim datalength As Long

    result = ""
    datalength = Len(data)
    
    
    barcodechar = ""
    For x = 0 To datalength - 1
  
        barcodechar = Mid(data, x + 1, 1)
        If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
             result = result + barcodechar
        End If
    Next x
  
    filterInput_GS1Databar14 = result

End Function

Function GS1_MOD_10(ByVal data As String) As String

    Dim result As String
    Dim multi As Integer
    Dim total As Integer
    Dim cv As Integer
    
    If (Len(data) = 0) Then
        result = ""
    Else
    cv = 0
    multi = 3
    total = 0
    result = ""
    
    For x = 1 To Len(data)
        If (Asc(Mid(data, x, 1)) - 48 <= 9 And Asc(Mid(data, x, 1)) - 48 >= 0) Then
            result = result + Mid(data, x, 1)
        End If
    Next x

    For x = 1 To Len(result)
        cv = Asc(Mid(result, x, 1)) - 48
        total = total + cv * multi
        If (multi = 3) Then
            multi = 1
        Else
            multi = 3
        End If
            
    Next x
    
    Dim modresult As Integer
    modresult = total Mod 10
    If (modresult <> 0) Then
        modresult = 10 - modresult
    End If
    
    result = CStr(modresult)
    End If
    
    GS1_MOD_10 = result

End Function


Public Function combins__GS1Databar14(ByVal n As Long, ByVal r As Long) As Long

    Dim i, j As Long
    Dim maxDenom, minDenom As Long
    Dim val As Long
    
        If (n - r > r) Then
        
            minDenom = r
            maxDenom = n - r
        
        Else
            minDenom = n - r
            maxDenom = r
        End If
        
        
        val = 1
        j = 1
        For i = n To maxDenom + 1 Step -1
        
            val = val * i
            If (j <= minDenom) Then
                val = val / j
                j = j + 1
            End If
            
        Next i
        Do While (j <= minDenom)
            
            val = val / j
            j = j + 1
            
        Loop
            
        combins__GS1Databar14 = val

End Function

Public Function getGS1widths(ByVal val As Long, ByVal n As Long, ByVal elements As Long, ByVal maxWidth As Long, ByVal noNarrow As Long, ByRef widths() As Long) As Long

    Dim bar As Long
    Dim elmWidth As Long
    Dim i As Long
    Dim mxwElement As Long
    Dim subVal, lessVal As Long
    Dim narrowMask As Long
    Dim tempMask As Long
    
           
    
    narrowMask = 0
    For bar = 0 To (elements - 1 - 1)
    
        'for (elmWidth = 1, narrowMask |= (1<<bar);; elmWidth++, narrowMask &= ~(1<<bar))
        elmWidth = 1
        tempMask = 2 ^ bar
        narrowMask = narrowMask Or tempMask
            
        Do While (1 > 0)
        
                    ' get all combinations
                    subVal = combins__GS1Databar14(n - elmWidth - 1, elements - bar - 2)
                    ' less combinations with no single module element
                    'if ((!noNarrow) and (narrowMask==0) and
                    If ((noNarrow = 0) And (narrowMask = 0) And (n - elmWidth - (elements - bar - 1) >= elements - bar - 1)) Then
                        subVal = subVal - combins__GS1Databar14(n - elmWidth - (elements - bar), elements - bar - 2)
                    End If
                    ' less combinations with elements > maxval
                    If (elements - bar - 1 > 1) Then
                    
                        'for (mxwElement = n-elmWidth-(elements-bar-2);  mxwElement > maxWidth; mxwElement--)
                        lessVal = 0
                        mxwElement = n - elmWidth - (elements - bar - 2)
                        Do While (mxwElement > maxWidth)
                                                
                            lessVal = lessVal + combins__GS1Databar14(n - elmWidth - mxwElement - 1, elements - bar - 3)
                            mxwElement = mxwElement - 1
                        
                        Loop
                        subVal = subVal - (lessVal * (elements - 1 - bar))
                                            
                    ElseIf (n - elmWidth > maxWidth) Then
                    
                        subVal = subVal - 1
                        
                    End If
                    val = val - subVal
                    If (val < 0) Then
                        Exit Do
                    End If
                    
                    
                    elmWidth = elmWidth + 1
                    tempMask = 2 ^ bar
                    narrowMask = narrowMask And (Not (tempMask))
        Loop
            
        val = val + subVal
        n = n - elmWidth
        widths(bar) = elmWidth
        
    
    Next bar
    widths(bar) = n
    getGS1widths = 0

End Function


'======================================================================================================
'GS1 Databar-14
'======================================================================================================
Public Function Encode_GS1Databar14(ByVal data As String, Optional ByVal linkage As Integer = 0) As String

    Dim result As String
    Dim cd As String
    Dim filtereddata As String
    Dim addcharlength As Long
    Dim humanText As String
    Dim x As Long
    Dim leftstr, rightstr As String
    Dim valuez, leftz, rightz As Currency
    Dim tempasc As Long
    Dim left, right, data1, data2, data3, data4, sum, cleft, cright, ctemp, checksumval As Long
    Dim widths() As Variant
    Dim tempChar As String
    Dim bwresult As String
    Dim black As Long
    Dim retval As Long
    
    Dim checksum(4, 8) As Long
    Dim GS1DATABAR14FINDERS(9, 5) As Long
    
    Dim widthsodd(4) As Long
    Dim widthseven(4) As Long
    Dim results1odd(4) As Long
    Dim results2odd(4) As Long
    Dim results3odd(4) As Long
    Dim results4odd(4) As Long
    
    Dim results1even(4) As Long
    Dim results2even(4) As Long
    Dim results3even(4) As Long
    Dim results4even(4) As Long
    
    'CHECKSUM
    checksum(0, 0) = 1
    checksum(0, 1) = 3
    checksum(0, 2) = 9
    checksum(0, 3) = 27
    checksum(0, 4) = 2
    checksum(0, 5) = 6
    checksum(0, 6) = 18
    checksum(0, 7) = 54
    
    checksum(1, 0) = 4
    checksum(1, 1) = 12
    checksum(1, 2) = 36
    checksum(1, 3) = 29
    checksum(1, 4) = 8
    checksum(1, 5) = 24
    checksum(1, 6) = 72
    checksum(1, 7) = 58
    
    checksum(2, 0) = 16
    checksum(2, 1) = 48
    checksum(2, 2) = 65
    checksum(2, 3) = 37
    checksum(2, 4) = 32
    checksum(2, 5) = 17
    checksum(2, 6) = 51
    checksum(2, 7) = 74
    
    checksum(3, 0) = 64
    checksum(3, 1) = 34
    checksum(3, 2) = 23
    checksum(3, 3) = 69
    checksum(3, 4) = 49
    checksum(3, 5) = 68
    checksum(3, 6) = 46
    checksum(3, 7) = 59
    
    
    'GS1DATABAR14FINDERS
    GS1DATABAR14FINDERS(0, 0) = 3
    GS1DATABAR14FINDERS(0, 1) = 8
    GS1DATABAR14FINDERS(0, 2) = 2
    GS1DATABAR14FINDERS(0, 3) = 1
    GS1DATABAR14FINDERS(0, 4) = 1
    
    GS1DATABAR14FINDERS(1, 0) = 3
    GS1DATABAR14FINDERS(1, 1) = 5
    GS1DATABAR14FINDERS(1, 2) = 5
    GS1DATABAR14FINDERS(1, 3) = 1
    GS1DATABAR14FINDERS(1, 4) = 1
    
    GS1DATABAR14FINDERS(2, 0) = 3
    GS1DATABAR14FINDERS(2, 1) = 3
    GS1DATABAR14FINDERS(2, 2) = 7
    GS1DATABAR14FINDERS(2, 3) = 1
    GS1DATABAR14FINDERS(2, 4) = 1
        
    GS1DATABAR14FINDERS(3, 0) = 3
    GS1DATABAR14FINDERS(3, 1) = 1
    GS1DATABAR14FINDERS(3, 2) = 9
    GS1DATABAR14FINDERS(3, 3) = 1
    GS1DATABAR14FINDERS(3, 4) = 1
    
    GS1DATABAR14FINDERS(4, 0) = 2
    GS1DATABAR14FINDERS(4, 1) = 7
    GS1DATABAR14FINDERS(4, 2) = 4
    GS1DATABAR14FINDERS(4, 3) = 1
    GS1DATABAR14FINDERS(4, 4) = 1
    
    GS1DATABAR14FINDERS(5, 0) = 2
    GS1DATABAR14FINDERS(5, 1) = 5
    GS1DATABAR14FINDERS(5, 2) = 6
    GS1DATABAR14FINDERS(5, 3) = 1
    GS1DATABAR14FINDERS(5, 4) = 1
    
    GS1DATABAR14FINDERS(6, 0) = 2
    GS1DATABAR14FINDERS(6, 1) = 3
    GS1DATABAR14FINDERS(6, 2) = 8
    GS1DATABAR14FINDERS(6, 3) = 1
    GS1DATABAR14FINDERS(6, 4) = 1
    
    GS1DATABAR14FINDERS(7, 0) = 1
    GS1DATABAR14FINDERS(7, 1) = 5
    GS1DATABAR14FINDERS(7, 2) = 7
    GS1DATABAR14FINDERS(7, 3) = 1
    GS1DATABAR14FINDERS(7, 4) = 1
    
    GS1DATABAR14FINDERS(8, 0) = 1
    GS1DATABAR14FINDERS(8, 1) = 3
    GS1DATABAR14FINDERS(8, 2) = 9
    GS1DATABAR14FINDERS(8, 3) = 1
    GS1DATABAR14FINDERS(8, 4) = 1
    
             
    
    cd = ""
    result = ""
    filtereddata = filterInput_GS1Databar14(data)
    filteredlength = Len(filtereddata)

    If filteredlength > 14 Then
            filtereddata = VBA.left$(filtereddata, 14)
    End If
     
    If (filteredlength < 14) Then
        addcharlength = 14 - filteredlength -1
        For x = 0 To addcharlength - 1
            filtereddata = "0" + filtereddata
        Next x
	filtereddata=filtereddata+GS1_MOD_10(filtereddata)

    End If
    
       
    humanText = "(01)" + VBA.right$(filtereddata, 14)
    filtereddata = VBA.left$(filtereddata, 13) 'Exclude Check Digit
    
    'ver 1.1
    If (linkage = 1) Then
        filtereddata = "1" + filtereddata
    End If
    
    filteredlength = VBA.Len(filtereddata)
    
    valuez = 0
    For x = 0 To (filteredlength - 1)
        tempChar = Mid(filtereddata, x + 1, 1)
        tempasc = AscW(tempChar)
        valuez = tempasc - 48 + (valuez * 10)
    Next x
    
    
    sum = 0
    
    leftz = valuez / 4537077
    
    'Check
    left = Int(leftz)
    rightz = valuez - left * 4537077
    right = rightz
    
    data1 = Int(left / 1597)
    data2 = left Mod 1597
    data3 = Int(right / 1597)
    data4 = right Mod 1597
    
    'MsgBox left
    'MsgBox right
    'MsgBox data1
    'MsgBox data2
    'MsgBox data3
    'MsgBox data4
    
    retval = getGS1W(data1, 1, 16, widthsodd)
    retval = getGS1W(data1, 0, 16, widthseven)
  
    For x = 0 To 3
        
        
        results1odd(x) = widthsodd(x)
        results1even(x) = widthseven(x)
        sum = sum + checksum(0, (x * 2)) * widthsodd(x) + checksum(0, (x * 2) + 1) * widthseven(x)
        'teststr = teststr + Str(results1odd(x)) + "," + Str(results1even(x)) + ","
    
    Next x
    
    
    retval = getGS1W(data2, 1, 15, widthsodd)
    retval = getGS1W(data2, 0, 15, widthseven)
    For x = 0 To 3
        
        results2odd(x) = widthsodd(x)
        results2even(x) = widthseven(x)
        sum = sum + checksum(1, (x * 2)) * widthsodd(x) + checksum(1, (x * 2) + 1) * widthseven(x)
        'teststr = teststr + Str(results2odd(x)) + "," + Str(results2even(x)) + ","
        
    Next x
    
    
    retval = getGS1W(data3, 1, 16, widthsodd)
    retval = getGS1W(data3, 0, 16, widthseven)
    For x = 0 To 3
        
        
        results3odd(x) = widthsodd(x)
        results3even(x) = widthseven(x)
        sum = sum + checksum(2, (x * 2)) * widthsodd(x) + checksum(2, (x * 2) + 1) * widthseven(x)
        'teststr = teststr + Str(results3odd(x)) + "," + Str(results3even(x)) + ","
    Next x
    
        
    retval = getGS1W(data4, 1, 15, widthsodd)
    retval = getGS1W(data4, 0, 15, widthseven)
    For x = 0 To 3
        
        results4odd(x) = widthsodd(x)
        results4even(x) = widthseven(x)
        sum = sum + checksum(3, (x * 2)) * widthsodd(x) + checksum(3, (x * 2) + 1) * widthseven(x)
        'teststr = teststr + Str(results4odd(x)) + "," + Str(results4even(x)) + ","
        
    Next x
    
    
        
    checksumval = sum Mod 79
    
    '1031
    ctemp = checksumval
    If (ctemp >= 8) Then
        ctemp = ctemp + 1
    End If
        
    If (ctemp >= 72) Then
        ctemp = ctemp + 1
    End If


    cleft = Int(ctemp / 9)
    
    'MsgBox cleft
    cright = ctemp Mod 9
    
    
    result = "11" 'Left Guard
    
    For x = 0 To 3 'Data 1
        result = result + ChrW(results1odd(x) + 48) + ChrW(results1even(x) + 48)
    Next x
    
    For x = 0 To 4 'Left Check
        result = result + ChrW(GS1DATABAR14FINDERS(cleft, x) + 48)
    Next x
    
    For x = 3 To 0 Step -1 'Data 2
        result = result + ChrW(results2even(x) + 48) + ChrW(results2odd(x) + 48)
    Next x
    
    For x = 0 To 3 'Data 4
        result = result + ChrW(results4odd(x) + 48) + ChrW(results4even(x) + 48)
    Next x
        
    For x = 4 To 0 Step -1 'Right Check
        result = result + ChrW(GS1DATABAR14FINDERS(cright, x) + 48)
    Next x
    
    For x = 3 To 0 Step -1 'Data 3
        result = result + ChrW(results3even(x) + 48) + ChrW(results3odd(x) + 48)
    Next x
    result = result + "11" 'Right Guard
    
    
    
    'Convert to White Black White Black
    bwresult = ""
    black = 0
    For x = 0 To Len(result) - 1
    
        If (black = 0) Then
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 48)
            black = 1
        
        Else
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 16)
            black = 0
        
        End If

    
    Next x
    
    Encode_GS1Databar14 = bwresult

End Function


Public Function getGS1W(ByVal data As Long, ByVal oddeven As Long, ByVal modules As Long, ByRef widths() As Long) As Long

    Dim retval As Long
    Dim WIDTH16_4_0(5, 7) As Long
    Dim WIDTH16_4_1(5, 7) As Long
    Dim WIDTH15_4_0(4, 7) As Long
    Dim WIDTH15_4_1(4, 7) As Long
        
    '640
    WIDTH16_4_0(0, 0) = 0
    WIDTH16_4_0(0, 1) = 160
    WIDTH16_4_0(0, 2) = 1
    WIDTH16_4_0(0, 3) = 4
    WIDTH16_4_0(0, 4) = 4
    WIDTH16_4_0(0, 5) = 1
    WIDTH16_4_0(0, 6) = 0

    WIDTH16_4_0(1, 0) = 161
    WIDTH16_4_0(1, 1) = 960
    WIDTH16_4_0(1, 2) = 10
    WIDTH16_4_0(1, 3) = 6
    WIDTH16_4_0(1, 4) = 4
    WIDTH16_4_0(1, 5) = 3
    WIDTH16_4_0(1, 6) = 0
    
    WIDTH16_4_0(2, 0) = 961
    WIDTH16_4_0(2, 1) = 2014
    WIDTH16_4_0(2, 2) = 34
    WIDTH16_4_0(2, 3) = 8
    WIDTH16_4_0(2, 4) = 4
    WIDTH16_4_0(2, 5) = 5
    WIDTH16_4_0(2, 6) = 0
    
    WIDTH16_4_0(3, 0) = 2015
    WIDTH16_4_0(3, 1) = 2714
    WIDTH16_4_0(3, 2) = 70
    WIDTH16_4_0(3, 3) = 10
    WIDTH16_4_0(3, 4) = 4
    WIDTH16_4_0(3, 5) = 6
    WIDTH16_4_0(3, 6) = 0

    WIDTH16_4_0(4, 0) = 2715
    WIDTH16_4_0(4, 1) = 2840
    WIDTH16_4_0(4, 2) = 126
    WIDTH16_4_0(4, 3) = 12
    WIDTH16_4_0(4, 4) = 4
    WIDTH16_4_0(4, 5) = 8
    WIDTH16_4_0(4, 6) = 0
        

               
    '641
    WIDTH16_4_1(0, 0) = 0
    WIDTH16_4_1(0, 1) = 160
    WIDTH16_4_1(0, 2) = 1
    WIDTH16_4_1(0, 3) = 12
    WIDTH16_4_1(0, 4) = 4
    WIDTH16_4_1(0, 5) = 8
    WIDTH16_4_1(0, 6) = 1

    WIDTH16_4_1(1, 0) = 161
    WIDTH16_4_1(1, 1) = 960
    WIDTH16_4_1(1, 2) = 10
    WIDTH16_4_1(1, 3) = 10
    WIDTH16_4_1(1, 4) = 4
    WIDTH16_4_1(1, 5) = 6
    WIDTH16_4_1(1, 6) = 1

    WIDTH16_4_1(2, 0) = 961
    WIDTH16_4_1(2, 1) = 2014
    WIDTH16_4_1(2, 2) = 34
    WIDTH16_4_1(2, 3) = 8
    WIDTH16_4_1(2, 4) = 4
    WIDTH16_4_1(2, 5) = 4
    WIDTH16_4_1(2, 6) = 1

    WIDTH16_4_1(3, 0) = 2015
    WIDTH16_4_1(3, 1) = 2714
    WIDTH16_4_1(3, 2) = 70
    WIDTH16_4_1(3, 3) = 6
    WIDTH16_4_1(3, 4) = 4
    WIDTH16_4_1(3, 5) = 3
    WIDTH16_4_1(3, 6) = 1

    WIDTH16_4_1(4, 0) = 2715
    WIDTH16_4_1(4, 1) = 2840
    WIDTH16_4_1(4, 2) = 126
    WIDTH16_4_1(4, 3) = 4
    WIDTH16_4_1(4, 4) = 4
    WIDTH16_4_1(4, 5) = 1
    WIDTH16_4_1(4, 6) = 1
    
        
    '540
    WIDTH15_4_0(0, 0) = 0
    WIDTH15_4_0(0, 1) = 335
    WIDTH15_4_0(0, 2) = 4
    WIDTH15_4_0(0, 3) = 10
    WIDTH15_4_0(0, 4) = 4
    WIDTH15_4_0(0, 5) = 7
    WIDTH15_4_0(0, 6) = 1
    
    WIDTH15_4_0(1, 0) = 336
    WIDTH15_4_0(1, 1) = 1035
    WIDTH15_4_0(1, 2) = 20
    WIDTH15_4_0(1, 3) = 8
    WIDTH15_4_0(1, 4) = 4
    WIDTH15_4_0(1, 5) = 5
    WIDTH15_4_0(1, 6) = 1
    
    WIDTH15_4_0(2, 0) = 1036
    WIDTH15_4_0(2, 1) = 1515
    WIDTH15_4_0(2, 2) = 48
    WIDTH15_4_0(2, 3) = 6
    WIDTH15_4_0(2, 4) = 4
    WIDTH15_4_0(2, 5) = 3
    WIDTH15_4_0(2, 6) = 1
        
    WIDTH15_4_0(3, 0) = 1516
    WIDTH15_4_0(3, 1) = 1596
    WIDTH15_4_0(3, 2) = 81
    WIDTH15_4_0(3, 3) = 4
    WIDTH15_4_0(3, 4) = 4
    WIDTH15_4_0(3, 5) = 1
    WIDTH15_4_0(3, 6) = 1
    
    
    '541
    WIDTH15_4_1(0, 0) = 0
    WIDTH15_4_1(0, 1) = 335
    WIDTH15_4_1(0, 2) = 4
    WIDTH15_4_1(0, 3) = 5
    WIDTH15_4_1(0, 4) = 4
    WIDTH15_4_1(0, 5) = 2
    WIDTH15_4_1(0, 6) = 0
     
    WIDTH15_4_1(1, 0) = 336
    WIDTH15_4_1(1, 1) = 1035
    WIDTH15_4_1(1, 2) = 20
    WIDTH15_4_1(1, 3) = 7
    WIDTH15_4_1(1, 4) = 4
    WIDTH15_4_1(1, 5) = 4
    WIDTH15_4_1(1, 6) = 0
    
    WIDTH15_4_1(2, 0) = 1036
    WIDTH15_4_1(2, 1) = 1515
    WIDTH15_4_1(2, 2) = 48
    WIDTH15_4_1(2, 3) = 9
    WIDTH15_4_1(2, 4) = 4
    WIDTH15_4_1(2, 5) = 6
    WIDTH15_4_1(2, 6) = 0
    
    WIDTH15_4_1(3, 0) = 1516
    WIDTH15_4_1(3, 1) = 1596
    WIDTH15_4_1(3, 2) = 81
    WIDTH15_4_1(3, 3) = 11
    WIDTH15_4_1(3, 4) = 4
    WIDTH15_4_1(3, 5) = 8
    WIDTH15_4_1(3, 6) = 0

                        
    If (modules = 16) Then
    
         If (oddeven = 0) Then
        
            'for (int x=0;x<5;x++)
            For x = 0 To 4
                If (data >= WIDTH16_4_0(x, 0) And data <= WIDTH16_4_0(x, 1)) Then
                    'getGS1widths(((data-WIDTH16_4_0(x,0)) mod WIDTH16_4_0(x,2)),WIDTH16_4_0(x,3),WIDTH16_4_0(x,4),WIDTH16_4_0(x,5),WIDTH16_4_0(x,6))
                    retval = getGS1widths(Int((data - WIDTH16_4_0(x, 0)) Mod WIDTH16_4_0(x, 2)), WIDTH16_4_0(x, 3), WIDTH16_4_0(x, 4), WIDTH16_4_0(x, 5), WIDTH16_4_0(x, 6), widths)
                
                End If
            Next x
        
        Else
            
            
            For x = 0 To 4
                
                If (data >= WIDTH16_4_1(x, 0) And data <= WIDTH16_4_1(x, 1)) Then
                    'teststr = Str(data) + " " + Str(WIDTH16_4_1(x, 0)) + " " + Str(WIDTH16_4_1(x, 2)) + Str(((data - WIDTH16_4_1(x, 0)) / WIDTH16_4_1(x, 2)))
                    retval = getGS1widths(Int((data - WIDTH16_4_1(x, 0)) / WIDTH16_4_1(x, 2)), WIDTH16_4_1(x, 3), WIDTH16_4_1(x, 4), WIDTH16_4_1(x, 5), WIDTH16_4_1(x, 6), widths)
                End If
                
             Next x
             
        End If
    
    ElseIf (modules = 15) Then
    
        If (oddeven = 0) Then
        
            
            For x = 0 To 3
                If (data >= WIDTH15_4_0(x, 0) And data <= WIDTH15_4_0(x, 1)) Then
                    'teststr = Str(data) + " " + Str(WIDTH15_4_0(x, 0)) + " " + Str(WIDTH15_4_0(x, 2)) + Str((data - WIDTH15_4_0(x, 0)) / WIDTH15_4_0(x, 2))
                    retval = getGS1widths(Int((data - WIDTH15_4_0(x, 0)) / WIDTH15_4_0(x, 2)), WIDTH15_4_0(x, 3), WIDTH15_4_0(x, 4), WIDTH15_4_0(x, 5), WIDTH15_4_0(x, 6), widths)
                End If
            Next x
            
        
        Else
        
            
            For x = 0 To 3
                If (data >= WIDTH15_4_1(x, 0) And data <= WIDTH15_4_1(x, 1)) Then
                    retval = getGS1widths(Int((data - WIDTH15_4_1(x, 0)) Mod WIDTH15_4_1(x, 2)), WIDTH15_4_1(x, 3), WIDTH15_4_1(x, 4), WIDTH15_4_1(x, 5), WIDTH15_4_1(x, 6), widths)
                End If
            Next x
        
        End If
        
    End If
    
    getGS1W = 0

End Function

'======================================================================================================
'GS1 Databar Limited
'======================================================================================================
Public Function Encode_GS1DatabarLimited(ByVal data As String) As String

    Dim result As String
    Dim cd As String
    Dim filtereddata As String
    Dim addcharlength As Long
    Dim humanText As String
    Dim x As Long
    Dim leftstr, rightstr As String
    Dim valuez, leftz, rightz As Currency
    Dim tempasc As Long
    Dim left, right, data1, data2, data3, data4, sum, cleft, cright, ctemp, checksumval As Long
    Dim tempChar As String
    Dim bwresult As String
    Dim black As Long
    Dim retval As Long
    
    Dim widthsodd(7) As Long
    Dim widthseven(7) As Long
    Dim resultsleftodd(7), resultslefteven(7) As Long
    Dim resultsrightodd(7), resultsrighteven(7) As Long
    Dim CHECKSUMLIMITED(2, 14) As Long
    Dim GS1DATABARLIMITEDFINDERS(89) As String
    
    CHECKSUMLIMITED(0, 0) = 1
    CHECKSUMLIMITED(0, 1) = 3
    CHECKSUMLIMITED(0, 2) = 9
    CHECKSUMLIMITED(0, 3) = 27
    CHECKSUMLIMITED(0, 4) = 81
    CHECKSUMLIMITED(0, 5) = 65
    CHECKSUMLIMITED(0, 6) = 17
    CHECKSUMLIMITED(0, 7) = 51
    CHECKSUMLIMITED(0, 8) = 64
    CHECKSUMLIMITED(0, 9) = 14
    CHECKSUMLIMITED(0, 10) = 42
    CHECKSUMLIMITED(0, 11) = 37
    CHECKSUMLIMITED(0, 12) = 22
    CHECKSUMLIMITED(0, 13) = 66
    
    CHECKSUMLIMITED(1, 0) = 20
    CHECKSUMLIMITED(1, 1) = 60
    CHECKSUMLIMITED(1, 2) = 2
    CHECKSUMLIMITED(1, 3) = 6
    CHECKSUMLIMITED(1, 4) = 18
    CHECKSUMLIMITED(1, 5) = 54
    CHECKSUMLIMITED(1, 6) = 73
    CHECKSUMLIMITED(1, 7) = 41
    CHECKSUMLIMITED(1, 8) = 34
    CHECKSUMLIMITED(1, 9) = 13
    CHECKSUMLIMITED(1, 10) = 39
    CHECKSUMLIMITED(1, 11) = 28
    CHECKSUMLIMITED(1, 12) = 84
    CHECKSUMLIMITED(1, 13) = 74
    
    
    'GS1DATABARLIMITEDFINDERS
    GS1DATABARLIMITEDFINDERS(0) = "11111111113311"
    GS1DATABARLIMITEDFINDERS(1) = "11111111123211"
    GS1DATABARLIMITEDFINDERS(2) = "11111111133111"
    GS1DATABARLIMITEDFINDERS(3) = "11111112113211"
    GS1DATABARLIMITEDFINDERS(4) = "11111112123111"
    GS1DATABARLIMITEDFINDERS(5) = "11111113113111"
    GS1DATABARLIMITEDFINDERS(6) = "11111211113211"
    GS1DATABARLIMITEDFINDERS(7) = "11111211123111"
    GS1DATABARLIMITEDFINDERS(8) = "11111212113111"
    GS1DATABARLIMITEDFINDERS(9) = "11111311113111"
    GS1DATABARLIMITEDFINDERS(10) = "11121111113211"
    
    GS1DATABARLIMITEDFINDERS(11) = "11121111123111"
    GS1DATABARLIMITEDFINDERS(12) = "11121112113111"
    GS1DATABARLIMITEDFINDERS(13) = "11121211113111"
    GS1DATABARLIMITEDFINDERS(14) = "11131111113111"
    GS1DATABARLIMITEDFINDERS(15) = "12111111113211"
    GS1DATABARLIMITEDFINDERS(16) = "12111111123111"
    GS1DATABARLIMITEDFINDERS(17) = "12111112113111"
    GS1DATABARLIMITEDFINDERS(18) = "12111211113111"
    GS1DATABARLIMITEDFINDERS(19) = "12121111113111"
    GS1DATABARLIMITEDFINDERS(20) = "13111111113111"              'Done vetted
    
    GS1DATABARLIMITEDFINDERS(21) = "11111111212311"
    GS1DATABARLIMITEDFINDERS(22) = "11111111222211"
    GS1DATABARLIMITEDFINDERS(23) = "11111111232111"
    GS1DATABARLIMITEDFINDERS(24) = "11111112212211"
    GS1DATABARLIMITEDFINDERS(25) = "11111112222111"
    GS1DATABARLIMITEDFINDERS(26) = "11111113212111"
    GS1DATABARLIMITEDFINDERS(27) = "11111211212211"
    GS1DATABARLIMITEDFINDERS(28) = "11111211222111"
    GS1DATABARLIMITEDFINDERS(29) = "11111212212111"
    GS1DATABARLIMITEDFINDERS(30) = "11111311212111"              'Done vetted
    
    GS1DATABARLIMITEDFINDERS(31) = "11121111212211"
    GS1DATABARLIMITEDFINDERS(32) = "11121111222111"
    GS1DATABARLIMITEDFINDERS(33) = "11121112212111"
    GS1DATABARLIMITEDFINDERS(34) = "11121211212111"
    GS1DATABARLIMITEDFINDERS(35) = "11131111212111"
    GS1DATABARLIMITEDFINDERS(36) = "12111111212211"
    GS1DATABARLIMITEDFINDERS(37) = "12111111222111"
    GS1DATABARLIMITEDFINDERS(38) = "12111112212111"
    GS1DATABARLIMITEDFINDERS(39) = "12111211212111"
    GS1DATABARLIMITEDFINDERS(40) = "12121111212111"              'Done Vetted 40
                
    GS1DATABARLIMITEDFINDERS(41) = "13111111212111"
    GS1DATABARLIMITEDFINDERS(42) = "11111111311311"
    GS1DATABARLIMITEDFINDERS(43) = "11111111321211"
    GS1DATABARLIMITEDFINDERS(44) = "11111112311211"
    GS1DATABARLIMITEDFINDERS(45) = "11121111311211"
    GS1DATABARLIMITEDFINDERS(46) = "12111111311211"
    GS1DATABARLIMITEDFINDERS(47) = "11111121112311"
    GS1DATABARLIMITEDFINDERS(48) = "11111121122211"
    GS1DATABARLIMITEDFINDERS(49) = "11111121132111"
    GS1DATABARLIMITEDFINDERS(50) = "11111122112211"              'Done Vetted
                
    GS1DATABARLIMITEDFINDERS(51) = "11121121112211"
    GS1DATABARLIMITEDFINDERS(52) = "11121121122111"
    GS1DATABARLIMITEDFINDERS(53) = "11121122112111"
    GS1DATABARLIMITEDFINDERS(54) = "11121221112111"
    GS1DATABARLIMITEDFINDERS(55) = "11131121112111"
    GS1DATABARLIMITEDFINDERS(56) = "12111121112211"
    GS1DATABARLIMITEDFINDERS(57) = "12111121122111"
    GS1DATABARLIMITEDFINDERS(58) = "12121121112111"
    GS1DATABARLIMITEDFINDERS(59) = "11112111112311"
    GS1DATABARLIMITEDFINDERS(60) = "11112111122211"              'Done
    
    GS1DATABARLIMITEDFINDERS(61) = "11112111132111"
    GS1DATABARLIMITEDFINDERS(62) = "11112112112211"
    GS1DATABARLIMITEDFINDERS(63) = "11112112122111"
    GS1DATABARLIMITEDFINDERS(64) = "11112211112211"
    GS1DATABARLIMITEDFINDERS(65) = "12112111112211"
    GS1DATABARLIMITEDFINDERS(66) = "12112111122111"
    GS1DATABARLIMITEDFINDERS(67) = "12112112112111"
    GS1DATABARLIMITEDFINDERS(68) = "12112211112111"
    GS1DATABARLIMITEDFINDERS(69) = "12122111112111"
    GS1DATABARLIMITEDFINDERS(70) = "13112111112111"              'Done
                
    GS1DATABARLIMITEDFINDERS(71) = "11211111112311"
    GS1DATABARLIMITEDFINDERS(72) = "11211111122211"
    GS1DATABARLIMITEDFINDERS(73) = "11211111132111"
    GS1DATABARLIMITEDFINDERS(74) = "11211112112211"
    GS1DATABARLIMITEDFINDERS(75) = "11211112122111"
    GS1DATABARLIMITEDFINDERS(76) = "11211113112111"
    GS1DATABARLIMITEDFINDERS(77) = "11211211112211"
    GS1DATABARLIMITEDFINDERS(78) = "11211211122111"
    GS1DATABARLIMITEDFINDERS(79) = "11221111112211"
    GS1DATABARLIMITEDFINDERS(80) = "21111111122211"
    
    GS1DATABARLIMITEDFINDERS(81) = "21111111132111"
    GS1DATABARLIMITEDFINDERS(82) = "21111112112211"
    GS1DATABARLIMITEDFINDERS(83) = "21111112122111"
    GS1DATABARLIMITEDFINDERS(84) = "21111113112111"
    GS1DATABARLIMITEDFINDERS(85) = "21111211122111"
    GS1DATABARLIMITEDFINDERS(86) = "21111212112111"
    GS1DATABARLIMITEDFINDERS(87) = "21121111122111"
    GS1DATABARLIMITEDFINDERS(88) = "21111111221211"
    
    
    
    cd = ""
    result = ""
    filtereddata = filterInput_GS1Databar14(data)
    filteredlength = Len(filtereddata)

    If filteredlength > 14 Then
            filtereddata = VBA.left$(filtereddata, 14)
    End If
     
    If (filteredlength < 14) Then
        addcharlength = 14 - filteredlength -1
        For x = 0 To addcharlength - 1
            filtereddata = "0" + filtereddata
        Next x
	filtereddata=filtereddata+GS1_MOD_10(filtereddata)

    End If
    
       
    filtereddata = VBA.left$(filtereddata, 13) 'Exclude Check Digit
    humanText = "(01)" + filtereddata
    filteredlength = VBA.Len(filtereddata)
    
    valuez = 0
    For x = 0 To (filteredlength - 1)
        tempChar = Mid(filtereddata, x + 1, 1)
        tempasc = AscW(tempChar)
        valuez = tempasc - 48 + (valuez * 10)
    Next x
    
    sum = 0
    
    leftz = valuez / 2013571
    
    'Check
    left = Int(leftz)
    rightz = valuez - left * 2013571
    right = rightz
             
    retval = getGS1WLimited(left, 1, 26, widthsodd)
    retval = getGS1WLimited(left, 0, 26, widthseven)
    For x = 0 To 6
        
        resultsleftodd(x) = widthsodd(x)
        resultslefteven(x) = widthseven(x)
        sum = sum + CHECKSUMLIMITED(0, (x * 2)) * widthsodd(x) + CHECKSUMLIMITED(0, (x * 2) + 1) * widthseven(x)
        
    Next x
  
        
    retval = getGS1WLimited(right, 1, 26, widthsodd)
    retval = getGS1WLimited(right, 0, 26, widthseven)
    For x = 0 To 6
        
        resultsrightodd(x) = widthsodd(x)
        resultsrighteven(x) = widthseven(x)
        sum = sum + CHECKSUMLIMITED(1, (x * 2)) * widthsodd(x) + CHECKSUMLIMITED(1, (x * 2) + 1) * widthseven(x)
        
    Next x
    
    checksumval = sum Mod 89
    
  
    
    result = "11"  'Left Guard
    
    For x = 0 To 6 'Data Left
        result = result + ChrW(Int(resultsleftodd(x) + 48)) + ChrW(Int(resultslefteven(x) + 48))
    Next x
    
    result = result + GS1DATABARLIMITEDFINDERS(checksumval)

    For x = 0 To 6 'Data Right
        result = result + ChrW(Int(resultsrightodd(x) + 48)) + ChrW(Int(resultsrighteven(x) + 48))
    Next x
    result = result + "11" 'Right Guard
 
    
    
    'Convert to White Black White Black
    bwresult = ""
    black = 0
    For x = 0 To Len(result) - 1
    
        If (black = 0) Then
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 48)
            black = 1
        
        Else
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 16)
            black = 0
        
        End If

    
    Next x

    If ((valuez<0) Or (valuez>1999999999999)) Then

	 'errorFlag =1
	 bwresult = ""

    End if		

    
    Encode_GS1DatabarLimited = bwresult

End Function



Public Function getGS1WLimited(ByVal data As Long, ByVal oddeven As Long, ByVal modules As Long, ByRef widths() As Long) As Long

    Dim retval As Long
    Dim WIDTH26_7_0(7, 7) As Long
    Dim WIDTH26_7_1(7, 7) As Long
    
    '670
    WIDTH26_7_0(0, 0) = 0
    WIDTH26_7_0(0, 1) = 183063
    WIDTH26_7_0(0, 2) = 28
    WIDTH26_7_0(0, 3) = 9
    WIDTH26_7_0(0, 4) = 7
    WIDTH26_7_0(0, 5) = 3
    WIDTH26_7_0(0, 6) = 0
    
            
    WIDTH26_7_0(1, 0) = 183064
    WIDTH26_7_0(1, 1) = 820063
    WIDTH26_7_0(1, 2) = 728
    WIDTH26_7_0(1, 3) = 13
    WIDTH26_7_0(1, 4) = 7
    WIDTH26_7_0(1, 5) = 4
    WIDTH26_7_0(1, 6) = 0
    
    
    WIDTH26_7_0(2, 0) = 820064
    WIDTH26_7_0(2, 1) = 1000775
    WIDTH26_7_0(2, 2) = 6454
    WIDTH26_7_0(2, 3) = 17
    WIDTH26_7_0(2, 4) = 7
    WIDTH26_7_0(2, 5) = 6
    WIDTH26_7_0(2, 6) = 0
    
    WIDTH26_7_0(3, 0) = 1000776
    WIDTH26_7_0(3, 1) = 1491020
    WIDTH26_7_0(3, 2) = 203
    WIDTH26_7_0(3, 3) = 11
    WIDTH26_7_0(3, 4) = 7
    WIDTH26_7_0(3, 5) = 4
    WIDTH26_7_0(3, 6) = 0
    
    WIDTH26_7_0(4, 0) = 1491021
    WIDTH26_7_0(4, 1) = 1979844
    WIDTH26_7_0(4, 2) = 2408
    WIDTH26_7_0(4, 3) = 15
    WIDTH26_7_0(4, 4) = 7
    WIDTH26_7_0(4, 5) = 5
    WIDTH26_7_0(4, 6) = 0
    
    WIDTH26_7_0(5, 0) = 1979845
    WIDTH26_7_0(5, 1) = 1996938
    WIDTH26_7_0(5, 2) = 1
    WIDTH26_7_0(5, 3) = 7
    WIDTH26_7_0(5, 4) = 7
    WIDTH26_7_0(5, 5) = 1
    WIDTH26_7_0(5, 6) = 0
    
    WIDTH26_7_0(6, 0) = 1996939
    WIDTH26_7_0(6, 1) = 2013570
    WIDTH26_7_0(6, 2) = 16632
    WIDTH26_7_0(6, 3) = 19
    WIDTH26_7_0(6, 4) = 7
    WIDTH26_7_0(6, 5) = 8
    WIDTH26_7_0(6, 6) = 0
       
    
    '671
    WIDTH26_7_1(0, 0) = 0
    WIDTH26_7_1(0, 1) = 183063
    WIDTH26_7_1(0, 2) = 28
    WIDTH26_7_1(0, 3) = 17
    WIDTH26_7_1(0, 4) = 7
    WIDTH26_7_1(0, 5) = 6
    WIDTH26_7_1(0, 6) = 1
            
    WIDTH26_7_1(1, 0) = 183064
    WIDTH26_7_1(1, 1) = 820063
    WIDTH26_7_1(1, 2) = 728
    WIDTH26_7_1(1, 3) = 13
    WIDTH26_7_1(1, 4) = 7
    WIDTH26_7_1(1, 5) = 5
    WIDTH26_7_1(1, 6) = 1
            
    WIDTH26_7_1(2, 0) = 820064
    WIDTH26_7_1(2, 1) = 1000775
    WIDTH26_7_1(2, 2) = 6454
    WIDTH26_7_1(2, 3) = 9
    WIDTH26_7_1(2, 4) = 7
    WIDTH26_7_1(2, 5) = 3
    WIDTH26_7_1(2, 6) = 1
    
    WIDTH26_7_1(3, 0) = 1000776
    WIDTH26_7_1(3, 1) = 1491020
    WIDTH26_7_1(3, 2) = 203
    WIDTH26_7_1(3, 3) = 15
    WIDTH26_7_1(3, 4) = 7
    WIDTH26_7_1(3, 5) = 5
    WIDTH26_7_1(3, 6) = 1
            
    WIDTH26_7_1(4, 0) = 1491021
    WIDTH26_7_1(4, 1) = 1979844
    WIDTH26_7_1(4, 2) = 2408
    WIDTH26_7_1(4, 3) = 11
    WIDTH26_7_1(4, 4) = 7
    WIDTH26_7_1(4, 5) = 4
    WIDTH26_7_1(4, 6) = 1
    
    WIDTH26_7_1(5, 0) = 1979845
    WIDTH26_7_1(5, 1) = 1996938
    WIDTH26_7_1(5, 2) = 1
    WIDTH26_7_1(5, 3) = 19
    WIDTH26_7_1(5, 4) = 7
    WIDTH26_7_1(5, 5) = 8
    WIDTH26_7_1(5, 6) = 1
    
    WIDTH26_7_1(6, 0) = 1996939
    WIDTH26_7_1(6, 1) = 2013570
    WIDTH26_7_1(6, 2) = 16632
    WIDTH26_7_1(6, 3) = 7
    WIDTH26_7_1(6, 4) = 7
    WIDTH26_7_1(6, 5) = 1
    WIDTH26_7_1(6, 6) = 1
                        
    If (modules = 26) Then
    
        If (oddeven = 0) Then
        
            For x = 0 To 6
                If (data >= WIDTH26_7_0(x, 0) And data <= WIDTH26_7_0(x, 1)) Then
                    retval = getGS1widths(Int((data - WIDTH26_7_0(x, 0)) Mod WIDTH26_7_0(x, 2)), WIDTH26_7_0(x, 3), WIDTH26_7_0(x, 4), WIDTH26_7_0(x, 5), WIDTH26_7_0(x, 6), widths)
                End If
             Next x
        
        Else
        
            For x = 0 To 6
            
                If (data >= WIDTH26_7_1(x, 0) And data <= WIDTH26_7_1(x, 1)) Then
                    retval = getGS1widths(Int((data - WIDTH26_7_1(x, 0)) / WIDTH26_7_1(x, 2)), WIDTH26_7_1(x, 3), WIDTH26_7_1(x, 4), WIDTH26_7_1(x, 5), WIDTH26_7_1(x, 6), widths)
                             
                End If
            Next x
        End If
    
    End If
    
    getGS1WLimited = 0

End Function

'======================================================================================================
'GS1 Databar Expanded
'======================================================================================================
Public Function Encode_GS1DatabarExpanded(ByVal data As String, Optional ByVal alinkageFlag As Long = 0) As String

    'State Variables
    Dim compactionResult As String
    Dim encodationResult As String
    Dim errorMsg As String
    Dim linkageFlag As Long
    
    Dim widthsodd(22, 4), widthseven(22, 4) As Long
    Dim resultsodd(22, 4), resultseven(22, 4) As Long
    Dim checkwidthsodd(4), checkwidthseven(4) As Long
        
    Dim numData, numSegments As Long
    

    Dim datachar(22) As Long
    

    linkageFlag = alinkageFlag 'Save state for class use.
    errorMsg = ""

    Dim cd, result, filtereddata As String
    Dim retval As Long
    
    'or use currency ?
    Dim value As Long
    Dim sum, checksum As Long
    
    
    Dim CHECKSUMEXPANDED(23, 8) As Long
    
    CHECKSUMEXPANDED(0, 0) = 1
    CHECKSUMEXPANDED(0, 1) = 3
    CHECKSUMEXPANDED(0, 2) = 9
    CHECKSUMEXPANDED(0, 3) = 27
    CHECKSUMEXPANDED(0, 4) = 81
    CHECKSUMEXPANDED(0, 5) = 32
    CHECKSUMEXPANDED(0, 6) = 96
    CHECKSUMEXPANDED(0, 7) = 77
    
    CHECKSUMEXPANDED(1, 0) = 20
    CHECKSUMEXPANDED(1, 1) = 60
    CHECKSUMEXPANDED(1, 2) = 180
    CHECKSUMEXPANDED(1, 3) = 118
    CHECKSUMEXPANDED(1, 4) = 143
    CHECKSUMEXPANDED(1, 5) = 7
    CHECKSUMEXPANDED(1, 6) = 21
    CHECKSUMEXPANDED(1, 7) = 63
    
    CHECKSUMEXPANDED(2, 0) = 189
    CHECKSUMEXPANDED(2, 1) = 145
    CHECKSUMEXPANDED(2, 2) = 13
    CHECKSUMEXPANDED(2, 3) = 39
    CHECKSUMEXPANDED(2, 4) = 117
    CHECKSUMEXPANDED(2, 5) = 140
    CHECKSUMEXPANDED(2, 6) = 209
    CHECKSUMEXPANDED(2, 7) = 205
    
    CHECKSUMEXPANDED(3, 0) = 193
    CHECKSUMEXPANDED(3, 1) = 157
    CHECKSUMEXPANDED(3, 2) = 49
    CHECKSUMEXPANDED(3, 3) = 147
    CHECKSUMEXPANDED(3, 4) = 19
    CHECKSUMEXPANDED(3, 5) = 57
    CHECKSUMEXPANDED(3, 6) = 171
    CHECKSUMEXPANDED(3, 7) = 91
    
    CHECKSUMEXPANDED(4, 0) = 62
    CHECKSUMEXPANDED(4, 1) = 186
    CHECKSUMEXPANDED(4, 2) = 136
    CHECKSUMEXPANDED(4, 3) = 197
    CHECKSUMEXPANDED(4, 4) = 169
    CHECKSUMEXPANDED(4, 5) = 85
    CHECKSUMEXPANDED(4, 6) = 44
    CHECKSUMEXPANDED(4, 7) = 132
        
    CHECKSUMEXPANDED(5, 0) = 185
    CHECKSUMEXPANDED(5, 1) = 133
    CHECKSUMEXPANDED(5, 2) = 188
    CHECKSUMEXPANDED(5, 3) = 142
    CHECKSUMEXPANDED(5, 4) = 4
    CHECKSUMEXPANDED(5, 5) = 12
    CHECKSUMEXPANDED(5, 6) = 36
    CHECKSUMEXPANDED(5, 7) = 108
        
    CHECKSUMEXPANDED(6, 0) = 113
    CHECKSUMEXPANDED(6, 1) = 128
    CHECKSUMEXPANDED(6, 2) = 173
    CHECKSUMEXPANDED(6, 3) = 97
    CHECKSUMEXPANDED(6, 4) = 80
    CHECKSUMEXPANDED(6, 5) = 29
    CHECKSUMEXPANDED(6, 6) = 87
    CHECKSUMEXPANDED(6, 7) = 50
    
    CHECKSUMEXPANDED(7, 0) = 150
    CHECKSUMEXPANDED(7, 1) = 28
    CHECKSUMEXPANDED(7, 2) = 84
    CHECKSUMEXPANDED(7, 3) = 41
    CHECKSUMEXPANDED(7, 4) = 123
    CHECKSUMEXPANDED(7, 5) = 158
    CHECKSUMEXPANDED(7, 6) = 52
    CHECKSUMEXPANDED(7, 7) = 156
        
    CHECKSUMEXPANDED(8, 0) = 46
    CHECKSUMEXPANDED(8, 1) = 138
    CHECKSUMEXPANDED(8, 2) = 203
    CHECKSUMEXPANDED(8, 3) = 187
    CHECKSUMEXPANDED(8, 4) = 139
    CHECKSUMEXPANDED(8, 5) = 206
    CHECKSUMEXPANDED(8, 6) = 196
    CHECKSUMEXPANDED(8, 7) = 166
    
    CHECKSUMEXPANDED(9, 0) = 76
    CHECKSUMEXPANDED(9, 1) = 17
    CHECKSUMEXPANDED(9, 2) = 51
    CHECKSUMEXPANDED(9, 3) = 153
    CHECKSUMEXPANDED(9, 4) = 37
    CHECKSUMEXPANDED(9, 5) = 111
    CHECKSUMEXPANDED(9, 6) = 122
    CHECKSUMEXPANDED(9, 7) = 155
    
    CHECKSUMEXPANDED(10, 0) = 43
    CHECKSUMEXPANDED(10, 1) = 129
    CHECKSUMEXPANDED(10, 2) = 176
    CHECKSUMEXPANDED(10, 3) = 106
    CHECKSUMEXPANDED(10, 4) = 107
    CHECKSUMEXPANDED(10, 5) = 110
    CHECKSUMEXPANDED(10, 6) = 119
    CHECKSUMEXPANDED(10, 7) = 146
    
    CHECKSUMEXPANDED(11, 0) = 16
    CHECKSUMEXPANDED(11, 1) = 48
    CHECKSUMEXPANDED(11, 2) = 144
    CHECKSUMEXPANDED(11, 3) = 10
    CHECKSUMEXPANDED(11, 4) = 30
    CHECKSUMEXPANDED(11, 5) = 90
    CHECKSUMEXPANDED(11, 6) = 59
    CHECKSUMEXPANDED(11, 7) = 177
    
    CHECKSUMEXPANDED(12, 0) = 109
    CHECKSUMEXPANDED(12, 1) = 116
    CHECKSUMEXPANDED(12, 2) = 137
    CHECKSUMEXPANDED(12, 3) = 200
    CHECKSUMEXPANDED(12, 4) = 178
    CHECKSUMEXPANDED(12, 5) = 112
    CHECKSUMEXPANDED(12, 6) = 125
    CHECKSUMEXPANDED(12, 7) = 164
    
    CHECKSUMEXPANDED(13, 0) = 70
    CHECKSUMEXPANDED(13, 1) = 210
    CHECKSUMEXPANDED(13, 2) = 208
    CHECKSUMEXPANDED(13, 3) = 202
    CHECKSUMEXPANDED(13, 4) = 184
    CHECKSUMEXPANDED(13, 5) = 130
    CHECKSUMEXPANDED(13, 6) = 179
    CHECKSUMEXPANDED(13, 7) = 115
    
    CHECKSUMEXPANDED(14, 0) = 134
    CHECKSUMEXPANDED(14, 1) = 191
    CHECKSUMEXPANDED(14, 2) = 151
    CHECKSUMEXPANDED(14, 3) = 31
    CHECKSUMEXPANDED(14, 4) = 93
    CHECKSUMEXPANDED(14, 5) = 68
    CHECKSUMEXPANDED(14, 6) = 204
    CHECKSUMEXPANDED(14, 7) = 190
    
    CHECKSUMEXPANDED(15, 0) = 148
    CHECKSUMEXPANDED(15, 1) = 22
    CHECKSUMEXPANDED(15, 2) = 66
    CHECKSUMEXPANDED(15, 3) = 198
    CHECKSUMEXPANDED(15, 4) = 172
    CHECKSUMEXPANDED(15, 5) = 94
    CHECKSUMEXPANDED(15, 6) = 71
    CHECKSUMEXPANDED(15, 7) = 2
    
    CHECKSUMEXPANDED(16, 0) = 6
    CHECKSUMEXPANDED(16, 1) = 18
    CHECKSUMEXPANDED(16, 2) = 54
    CHECKSUMEXPANDED(16, 3) = 162
    CHECKSUMEXPANDED(16, 4) = 64
    CHECKSUMEXPANDED(16, 5) = 192
    CHECKSUMEXPANDED(16, 6) = 154
    CHECKSUMEXPANDED(16, 7) = 40
    
    CHECKSUMEXPANDED(17, 0) = 120
    CHECKSUMEXPANDED(17, 1) = 149
    CHECKSUMEXPANDED(17, 2) = 25
    CHECKSUMEXPANDED(17, 3) = 75
    CHECKSUMEXPANDED(17, 4) = 14
    CHECKSUMEXPANDED(17, 5) = 42
    CHECKSUMEXPANDED(17, 6) = 126
    CHECKSUMEXPANDED(17, 7) = 167
    
    CHECKSUMEXPANDED(18, 0) = 79
    CHECKSUMEXPANDED(18, 1) = 26
    CHECKSUMEXPANDED(18, 2) = 78
    CHECKSUMEXPANDED(18, 3) = 23
    CHECKSUMEXPANDED(18, 4) = 69
    CHECKSUMEXPANDED(18, 5) = 207
    CHECKSUMEXPANDED(18, 6) = 199
    CHECKSUMEXPANDED(18, 7) = 175
    
    CHECKSUMEXPANDED(19, 0) = 103
    CHECKSUMEXPANDED(19, 1) = 98
    CHECKSUMEXPANDED(19, 2) = 83
    CHECKSUMEXPANDED(19, 3) = 38
    CHECKSUMEXPANDED(19, 4) = 114
    CHECKSUMEXPANDED(19, 5) = 131
    CHECKSUMEXPANDED(19, 6) = 182
    CHECKSUMEXPANDED(19, 7) = 124
    
    CHECKSUMEXPANDED(20, 0) = 161
    CHECKSUMEXPANDED(20, 1) = 61
    CHECKSUMEXPANDED(20, 2) = 183
    CHECKSUMEXPANDED(20, 3) = 127
    CHECKSUMEXPANDED(20, 4) = 170
    CHECKSUMEXPANDED(20, 5) = 88
    CHECKSUMEXPANDED(20, 6) = 53
    CHECKSUMEXPANDED(20, 7) = 159
    
    CHECKSUMEXPANDED(21, 0) = 55
    CHECKSUMEXPANDED(21, 1) = 165
    CHECKSUMEXPANDED(21, 2) = 73
    CHECKSUMEXPANDED(21, 3) = 8
    CHECKSUMEXPANDED(21, 4) = 24
    CHECKSUMEXPANDED(21, 5) = 72
    CHECKSUMEXPANDED(21, 6) = 5
    CHECKSUMEXPANDED(21, 7) = 15
    
    CHECKSUMEXPANDED(22, 0) = 45
    CHECKSUMEXPANDED(22, 1) = 135
    CHECKSUMEXPANDED(22, 2) = 194
    CHECKSUMEXPANDED(22, 3) = 160
    CHECKSUMEXPANDED(22, 4) = 58
    CHECKSUMEXPANDED(22, 5) = 174
    CHECKSUMEXPANDED(22, 6) = 100
    CHECKSUMEXPANDED(22, 7) = 89

    
    Dim FINDERPATTERN(10, 11) As String

    FINDERPATTERN(0, 0) = "A1"
    FINDERPATTERN(0, 1) = "A2"
    FINDERPATTERN(0, 2) = ""
    FINDERPATTERN(0, 3) = ""
    FINDERPATTERN(0, 4) = ""
    FINDERPATTERN(0, 5) = ""
    FINDERPATTERN(0, 6) = ""
    FINDERPATTERN(0, 7) = ""
    FINDERPATTERN(0, 8) = ""
    FINDERPATTERN(0, 9) = ""
    FINDERPATTERN(0, 10) = ""
    
    FINDERPATTERN(1, 0) = "A1"
    FINDERPATTERN(1, 1) = "B2"
    FINDERPATTERN(1, 2) = "B1"
    FINDERPATTERN(1, 3) = ""
    FINDERPATTERN(1, 4) = ""
    FINDERPATTERN(1, 5) = ""
    FINDERPATTERN(1, 6) = ""
    FINDERPATTERN(1, 7) = ""
    FINDERPATTERN(1, 8) = ""
    FINDERPATTERN(1, 9) = ""
    FINDERPATTERN(1, 10) = ""
    
    FINDERPATTERN(2, 0) = "A1"
    FINDERPATTERN(2, 1) = "C2"
    FINDERPATTERN(2, 2) = "B1"
    FINDERPATTERN(2, 3) = "D2"
    FINDERPATTERN(2, 4) = ""
    FINDERPATTERN(2, 5) = ""
    FINDERPATTERN(2, 6) = ""
    FINDERPATTERN(2, 7) = ""
    FINDERPATTERN(2, 8) = ""
    FINDERPATTERN(2, 9) = ""
    FINDERPATTERN(2, 10) = ""
    
    
    FINDERPATTERN(3, 0) = "A1"
    FINDERPATTERN(3, 1) = "E2"
    FINDERPATTERN(3, 2) = "B1"
    FINDERPATTERN(3, 3) = "D2"
    FINDERPATTERN(3, 4) = "C1"
    FINDERPATTERN(3, 5) = ""
    FINDERPATTERN(3, 6) = ""
    FINDERPATTERN(3, 7) = ""
    FINDERPATTERN(3, 8) = ""
    FINDERPATTERN(3, 9) = ""
    FINDERPATTERN(3, 10) = ""
    
    FINDERPATTERN(4, 0) = "A1"
    FINDERPATTERN(4, 1) = "E2"
    FINDERPATTERN(4, 2) = "B1"
    FINDERPATTERN(4, 3) = "D2"
    FINDERPATTERN(4, 4) = "D1"
    FINDERPATTERN(4, 5) = "F2"
    FINDERPATTERN(4, 6) = ""
    FINDERPATTERN(4, 7) = ""
    FINDERPATTERN(4, 8) = ""
    FINDERPATTERN(4, 9) = ""
    FINDERPATTERN(4, 10) = ""
    
    FINDERPATTERN(5, 0) = "A1"
    FINDERPATTERN(5, 1) = "E2"
    FINDERPATTERN(5, 2) = "B1"
    FINDERPATTERN(5, 3) = "D2"
    FINDERPATTERN(5, 4) = "E1"
    FINDERPATTERN(5, 5) = "F2"
    FINDERPATTERN(5, 6) = "F1"
    FINDERPATTERN(5, 7) = ""
    FINDERPATTERN(5, 8) = ""
    FINDERPATTERN(5, 9) = ""
    FINDERPATTERN(5, 10) = ""
    
    FINDERPATTERN(6, 0) = "A1"
    FINDERPATTERN(6, 1) = "A2"
    FINDERPATTERN(6, 2) = "B1"
    FINDERPATTERN(6, 3) = "B2"
    FINDERPATTERN(6, 4) = "C1"
    FINDERPATTERN(6, 5) = "C2"
    FINDERPATTERN(6, 6) = "D1"
    FINDERPATTERN(6, 7) = "D2"
    FINDERPATTERN(6, 8) = ""
    FINDERPATTERN(6, 9) = ""
    FINDERPATTERN(6, 10) = ""
    
    FINDERPATTERN(7, 0) = "A1"
    FINDERPATTERN(7, 1) = "A2"
    FINDERPATTERN(7, 2) = "B1"
    FINDERPATTERN(7, 3) = "B2"
    FINDERPATTERN(7, 4) = "C1"
    FINDERPATTERN(7, 5) = "C2"
    FINDERPATTERN(7, 6) = "D1"
    FINDERPATTERN(7, 7) = "E2"
    FINDERPATTERN(7, 8) = "E1"
    FINDERPATTERN(7, 9) = ""
    FINDERPATTERN(7, 10) = ""
    
    FINDERPATTERN(8, 0) = "A1"
    FINDERPATTERN(8, 1) = "A2"
    FINDERPATTERN(8, 2) = "B1"
    FINDERPATTERN(8, 3) = "B2"
    FINDERPATTERN(8, 4) = "C1"
    FINDERPATTERN(8, 5) = "C2"
    FINDERPATTERN(8, 6) = "D1"
    FINDERPATTERN(8, 7) = "E2"
    FINDERPATTERN(8, 8) = "F1"
    FINDERPATTERN(8, 9) = "F2"
    FINDERPATTERN(8, 10) = ""
    
    FINDERPATTERN(9, 0) = "A1"
    FINDERPATTERN(9, 1) = "A2"
    FINDERPATTERN(9, 2) = "B1"
    FINDERPATTERN(9, 3) = "B2"
    FINDERPATTERN(9, 4) = "C1"
    FINDERPATTERN(9, 5) = "D2"
    FINDERPATTERN(9, 6) = "D1"
    FINDERPATTERN(9, 7) = "E2"
    FINDERPATTERN(9, 8) = "E1"
    FINDERPATTERN(9, 9) = "F2"
    FINDERPATTERN(9, 10) = "F1"
    
    
    Dim FINDERS1(6, 5) As Long
    Dim FINDERS2(6, 5) As Long

    'FINDERS1
    FINDERS1(0, 0) = 1
    FINDERS1(0, 1) = 8
    FINDERS1(0, 2) = 4
    FINDERS1(0, 3) = 1
    FINDERS1(0, 4) = 1
     
    FINDERS1(1, 0) = 3
    FINDERS1(1, 1) = 6
    FINDERS1(1, 2) = 4
    FINDERS1(1, 3) = 1
    FINDERS1(1, 4) = 1
      
    FINDERS1(2, 0) = 3
    FINDERS1(2, 1) = 4
    FINDERS1(2, 2) = 6
    FINDERS1(2, 3) = 1
    FINDERS1(2, 4) = 1
      
    FINDERS1(3, 0) = 3
    FINDERS1(3, 1) = 2
    FINDERS1(3, 2) = 8
    FINDERS1(3, 3) = 1
    FINDERS1(3, 4) = 1
     
    FINDERS1(4, 0) = 2
    FINDERS1(4, 1) = 6
    FINDERS1(4, 2) = 5
    FINDERS1(4, 3) = 1
    FINDERS1(4, 4) = 1
     
    FINDERS1(5, 0) = 2
    FINDERS1(5, 1) = 2
    FINDERS1(5, 2) = 9
    FINDERS1(5, 3) = 1
    FINDERS1(5, 4) = 1
     
    
    'FINDERS2
    FINDERS2(0, 0) = 1
    FINDERS2(0, 1) = 1
    FINDERS2(0, 2) = 4
    FINDERS2(0, 3) = 8
    FINDERS2(0, 4) = 1
     
    FINDERS2(1, 0) = 1
    FINDERS2(1, 1) = 1
    FINDERS2(1, 2) = 4
    FINDERS2(1, 3) = 6
    FINDERS2(1, 4) = 3
     
    FINDERS2(2, 0) = 1
    FINDERS2(2, 1) = 1
    FINDERS2(2, 2) = 6
    FINDERS2(2, 3) = 4
    FINDERS2(2, 4) = 3
     
    FINDERS2(3, 0) = 1
    FINDERS2(3, 1) = 1
    FINDERS2(3, 2) = 8
    FINDERS2(3, 3) = 2
    FINDERS2(3, 4) = 3
     
    FINDERS2(4, 0) = 1
    FINDERS2(4, 1) = 1
    FINDERS2(4, 2) = 5
    FINDERS2(4, 3) = 6
    FINDERS2(4, 4) = 2
     
    FINDERS2(5, 0) = 1
    FINDERS2(5, 1) = 1
    FINDERS2(5, 2) = 9
    FINDERS2(5, 3) = 2
    FINDERS2(5, 4) = 2

    
    cd = ""
    result = ""
    filtereddata = filterInput__GS1DatabarExpanded(data)
    
    Dim checkCharacter, numFinder, dataCounter, filteredlength As Long
    
    filteredlength = Len(filtereddata)
    
    If (filteredlength > 200) Then
        filtereddata = left(filtereddata, 200) 'This is max length input supported. the variable encodation will reject data that exceed the encodation length.
    End If

    
    
    Dim nx As Long
    filtereddata = encodationMethod(filtereddata, nx, numSegments, encodationResult, compactionResult, errorMsg, linkageFlag, datachar)
    numData = nx
    Debug.Print errorMsg
     
    
     
    humanText = filtereddata
    sum = 0
    
    If (errorMsg <> "") Then
    
        Encode_GS1DatabarExpanded = ""
        Exit Function
    
    End If

    Dim wwodd(4) As Long
    Dim wweven(4) As Long
    Dim z As Integer
        
    For x = 0 To numData - 1
        
        retval = getGS1WExpanded(datachar(x), 1, 17, wwodd)
        
        retval = getGS1WExpanded(datachar(x), 0, 17, wweven)
        
        For z = 0 To 3
            widthsodd(x, z) = wwodd(z)
            widthseven(x, z) = wweven(z)
        Next z
        
    
    Next x
    
    
    
    Dim sequenceIndex As Long
    Dim toggle As String
    Dim checksumptr As Long
    For x = 0 To numData - 1
    
        
        toggle = " Left"
        
        If (x = 0) Then
        
            sequenceIndex = x
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Right")
        
        
        ElseIf (x > 0 And (x Mod 2 = 0)) Then
        
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Right")
        
        ElseIf (x > 0 And (x Mod 2 = 1)) Then
        
            sequenceIndex = sequenceIndex + 1
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Left")
        
        End If

        
        'TRACE("Chechsum Weights\n");
        'For y = 0 To 3
            'TRACE("%d,%d,",checksumptr[(y*2)],checksumptr[(y*2)+1]);
        'Next y
        

        For y = 0 To 3
        
        'TRACE("%ld,%ld,",widthsodd[x][y],widthseven[x][y]);
            resultsodd(x, y) = widthsodd(x, y)
            resultseven(x, y) = widthseven(x, y)
            sum = sum + CHECKSUMEXPANDED(checksumptr, (y * 2)) * widthsodd(x, y) + CHECKSUMEXPANDED(checksumptr, ((y * 2) + 1)) * widthseven(x, y)
        
        Next y
        'TRACE("\nSum %ld\n",sum);
    
    Next x
    
    'TRACE("\n");

    checksum = sum Mod 211
    'TRACE("CheckSum %d\n",(sum % 211));
    'MsgBox "CheckSum " + Str(checksum)

    'checkCharacter = 211*(numSegments-4) + 98;
    checkCharacter = 211 * (numSegments - 4) + checksum
    
    'MsgBox checkCharacter
    
    'retval = getGS1WExpanded(checkCharacter, 1, 17, checkwidthsodd)
     retval = getGS1WExpanded(checkCharacter, 1, 17, wwodd)
    'TRACE("Check Character :");
     retval = getGS1WExpanded(checkCharacter, 0, 17, wweven)
    'retval = getGS1WExpanded(checkCharacter, 0, 17, checkwidthseven)
    For z = 0 To 3
            checkwidthsodd(z) = wwodd(z)
            checkwidthseven(z) = wweven(z)
    Next z
    

    result = "11"  'Left Guard
    For x = 0 To 3
    
        'TRACE("%ld,%ld,",checkwidthsodd[x],checkwidthseven[x]);
        
        result = result + ChrW(Int(checkwidthsodd(x) + 48)) + ChrW(Int(checkwidthseven(x) + 48))
        
    Next x
    
    

    Dim patternptr As String
    Dim patternsequenceptr As Long
    Dim findersnum As Long
    
    
    'patternptr = FINDERPATTERN(getFinderPatternIndex(numSegments))
    numFinder = getNumFinder(numSegments)
    dataCounter = 0
    For x = 0 To numFinder - 1
    
        'TRACE("%s,",patternptr[x]);
        'patternsequenceptr = getFinderPatterns(patternptr(x))
        patternsequenceptr = getFinderPatterns(FINDERPATTERN(getFinderPatternIndex(numSegments), x), findersnum)
        For y = 0 To 4
        
            If (findersnum = 1) Then
                result = result + ChrW(Int(FINDERS1(patternsequenceptr, y) + 48))
            Else
                result = result + ChrW(Int(FINDERS2(patternsequenceptr, y) + 48))
            End If
            'TRACE("%d,",patternsequenceptr[y]);
        
        Next y
        
        
        'Print two data
        If (dataCounter < numData) Then
        
            For y = 3 To 0 Step -1 'mirror
                result = result + ChrW(Int(widthseven(x * 2, y) + 48)) + ChrW(Int(widthsodd(x * 2, y) + 48))
            Next y
            dataCounter = dataCounter + 1
        
        End If
        
        If (dataCounter < numData) Then
        
            For y = 0 To 3
                result = result + ChrW(Int(widthsodd(x * 2 + 1, y) + 48)) + ChrW(Int(widthseven(x * 2 + 1, y) + 48))
            Next y
            dataCounter = dataCounter + 1
        End If
    
    Next x

    
    result = result + "11" 'Right Guard

    'Convert to White Black White Black
    bwresult = ""
    black = 0
    For x = 0 To Len(result) - 1
    
        If (black = 0) Then
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 48)
            black = 1
        
        Else
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 16)
            black = 0
        
        End If

    
    Next x

    
    
    Encode_GS1DatabarExpanded = bwresult
    
End Function


Public Function numericCompaction(ByVal data As String) As String


    Dim numericEncodationV(120 + 8) As String 'First 8, 0..7 are not used
    
    numericEncodationV(0) = ""
    numericEncodationV(1) = ""
    numericEncodationV(2) = ""
    numericEncodationV(3) = ""
    numericEncodationV(4) = ""
    numericEncodationV(5) = ""
    numericEncodationV(6) = ""
    numericEncodationV(7) = ""
    numericEncodationV(8) = "0001000"
    numericEncodationV(9) = "0001001"
    numericEncodationV(10) = "0001010"
    numericEncodationV(11) = "0001011"
    numericEncodationV(12) = "0001100"
    numericEncodationV(13) = "0001101"
    numericEncodationV(14) = "0001110"
    numericEncodationV(15) = "0001111"
    numericEncodationV(16) = "0010000"
    numericEncodationV(17) = "0010001"
    numericEncodationV(18) = "0010010"
    numericEncodationV(19) = "0010011"
    numericEncodationV(20) = "0010100"
    numericEncodationV(21) = "0010101"
    numericEncodationV(22) = "0010110"
    numericEncodationV(23) = "0010111"
    numericEncodationV(24) = "0011000"
    numericEncodationV(25) = "0011001"
    numericEncodationV(26) = "0011010"
    numericEncodationV(27) = "0011011"
    numericEncodationV(28) = "0011100"
    numericEncodationV(29) = "0011101"
    numericEncodationV(30) = "0011110"
    numericEncodationV(31) = "0011111"
    numericEncodationV(32) = "0100000"
    numericEncodationV(33) = "0100001"
    numericEncodationV(34) = "0100010"
    numericEncodationV(35) = "0100011"
    numericEncodationV(36) = "0100100"
    numericEncodationV(37) = "0100101"
    numericEncodationV(38) = "0100110"
    numericEncodationV(39) = "0100111"
    numericEncodationV(40) = "0101000"
    numericEncodationV(41) = "0101001"
    numericEncodationV(42) = "0101010"
    numericEncodationV(43) = "0101011"
    numericEncodationV(44) = "0101100"
    numericEncodationV(45) = "0101101"
    numericEncodationV(46) = "0101110"
    numericEncodationV(47) = "0101111"
    numericEncodationV(48) = "0110000"
    numericEncodationV(49) = "0110001"
    numericEncodationV(50) = "0110010"
    numericEncodationV(51) = "0110011"
    numericEncodationV(52) = "0110100"
    numericEncodationV(53) = "0110101"
    numericEncodationV(54) = "0110110"
    numericEncodationV(55) = "0110111"
    numericEncodationV(56) = "0111000"
    numericEncodationV(57) = "0111001"
    numericEncodationV(58) = "0111010"
    numericEncodationV(59) = "0111011"
    numericEncodationV(60) = "0111100"
    numericEncodationV(61) = "0111101"
    numericEncodationV(62) = "0111110"
    numericEncodationV(63) = "0111111"
    numericEncodationV(64) = "1000000"
    numericEncodationV(65) = "1000001"
    numericEncodationV(66) = "1000010"
    numericEncodationV(67) = "1000011"
    numericEncodationV(68) = "1000100"
    numericEncodationV(69) = "1000101"
    numericEncodationV(70) = "1000110"
    numericEncodationV(71) = "1000111"
    numericEncodationV(72) = "1001000"
    numericEncodationV(73) = "1001001"
    numericEncodationV(74) = "1001010"
    numericEncodationV(75) = "1001011"
    numericEncodationV(76) = "1001100"
    numericEncodationV(77) = "1001101"
    numericEncodationV(78) = "1001110"
    numericEncodationV(79) = "1001111"
    numericEncodationV(80) = "1010000"
    numericEncodationV(81) = "1010001"
    numericEncodationV(82) = "1010010"
    numericEncodationV(83) = "1010011"
    numericEncodationV(84) = "1010100"
    numericEncodationV(85) = "1010101"
    numericEncodationV(86) = "1010110"
    numericEncodationV(87) = "1010111"
    numericEncodationV(88) = "1011000"
    numericEncodationV(89) = "1011001"
    numericEncodationV(90) = "1011010"
    numericEncodationV(91) = "1011011"
    numericEncodationV(92) = "1011100"
    numericEncodationV(93) = "1011101"
    numericEncodationV(94) = "1011110"
    numericEncodationV(95) = "1011111"
    numericEncodationV(96) = "1100000"
    numericEncodationV(97) = "1100001"
    numericEncodationV(98) = "1100010"
    numericEncodationV(99) = "1100011"
    numericEncodationV(100) = "1100100"
    numericEncodationV(101) = "1100101"
    numericEncodationV(102) = "1100110"
    numericEncodationV(103) = "1100111"
    numericEncodationV(104) = "1101000"
    numericEncodationV(105) = "1101001"
    numericEncodationV(106) = "1101010"
    numericEncodationV(107) = "1101011"
    numericEncodationV(108) = "1101100"
    numericEncodationV(109) = "1101101"
    numericEncodationV(110) = "1101110"
    numericEncodationV(111) = "1101111"
    numericEncodationV(112) = "1110000"
    numericEncodationV(113) = "1110001"
    numericEncodationV(114) = "1110010"
    numericEncodationV(115) = "1110011"
    numericEncodationV(116) = "1110100"
    numericEncodationV(117) = "1110101"
    numericEncodationV(118) = "1110110"
    numericEncodationV(119) = "1110111"
    numericEncodationV(120) = "1111000"
    numericEncodationV(121) = "1111001"
    numericEncodationV(122) = "1111010"
    numericEncodationV(123) = "1111011"
    numericEncodationV(124) = "1111100"
    numericEncodationV(125) = "1111101"
    numericEncodationV(126) = "1111110"
    numericEncodationV(127) = "1111111"
    

    If (Len(data) <> 2) Then
        numericCompaction = ""
    Else
        
    Dim value1 As Long
    Dim value2 As Long
    Dim value As Long
    Dim barcodechar As String
    Dim barcodechar1 As String
    
    barcodechar = ""
    barcodechar1 = ""
    
  
    barcodechar = Mid(data, 0 + 1, 1)
    If AscW(barcodechar) <= AscW("9") And AscW(barcodechar) >= AscW("0") Then
            value1 = AscW(barcodechar) - 48
    ElseIf (barcodechar = "#") Then
            value1 = 10
    End If
    
    
    barcodechar1 = Mid(data, 1 + 1, 1)
    If AscW(barcodechar1) <= AscW("9") And AscW(barcodechar1) >= AscW("0") Then
            value2 = AscW(barcodechar1) - 48
    Else
            value2 = 10
    End If

    value = value1 * 11 + value2 + 8
    numericCompaction = numericEncodationV(value)
    
    End If

End Function



Public Function ISO646Compaction(ByVal alpha As Long) As String

    Dim returnstr As String

    returnstr = ""
    
    If (alpha = 48) Then
        returnstr = "00101"
    ElseIf (alpha = 49) Then
        returnstr = "00110"
    ElseIf (alpha = 50) Then
        returnstr = "00111"
    ElseIf (alpha = 51) Then
        returnstr = "01000"
    ElseIf (alpha = 52) Then
        returnstr = "01001"
    ElseIf (alpha = 53) Then
        returnstr = "01010"
    ElseIf (alpha = 54) Then
        returnstr = "01011"
    ElseIf (alpha = 55) Then
        returnstr = "01100"
    ElseIf (alpha = 56) Then
        returnstr = "01101"
    ElseIf (alpha = 57) Then
        returnstr = "01110"
    ElseIf (alpha = AscW("#")) Then 'FNC1
        returnstr = "01111"
    ElseIf (alpha = AscW("A")) Then
        returnstr = "1000000"
    ElseIf (alpha = AscW("B")) Then
        returnstr = "1000001"
    ElseIf (alpha = AscW("C")) Then
        returnstr = "1000010"
    ElseIf (alpha = AscW("D")) Then
        returnstr = "1000011"
    ElseIf (alpha = AscW("E")) Then
        returnstr = "1000100"
    ElseIf (alpha = AscW("F")) Then
        returnstr = "1000101"
    ElseIf (alpha = AscW("G")) Then
        returnstr = "1000110"
    ElseIf (alpha = AscW("H")) Then
        returnstr = "1000111"
    ElseIf (alpha = AscW("I")) Then
        returnstr = "1001000"
    ElseIf (alpha = AscW("J")) Then
        returnstr = "1001001"
    ElseIf (alpha = AscW("K")) Then
        returnstr = "1001010"
    ElseIf (alpha = AscW("L")) Then
        returnstr = "1001011"
    ElseIf (alpha = AscW("M")) Then
        returnstr = "1001100"
    ElseIf (alpha = AscW("N")) Then
        returnstr = "1001101"
    ElseIf (alpha = AscW("O")) Then
        returnstr = "1001110"
    ElseIf (alpha = AscW("P")) Then
        returnstr = "1001111"
    ElseIf (alpha = AscW("Q")) Then
        returnstr = "1010000;"
    ElseIf (alpha = AscW("R")) Then
        returnstr = "1010001"
    ElseIf (alpha = AscW("S")) Then
        returnstr = "1010010"
    ElseIf (alpha = AscW("T")) Then
        returnstr = "1010011"
    ElseIf (alpha = AscW("U")) Then
        returnstr = "1010100"
    ElseIf (alpha = AscW("V")) Then
        returnstr = "1010101"
    ElseIf (alpha = AscW("W")) Then
        returnstr = "1010110"
    ElseIf (alpha = AscW("X")) Then
        returnstr = "1010111"
    ElseIf (alpha = AscW("Y")) Then
        returnstr = "1011000"
    ElseIf (alpha = AscW("Z")) Then
        returnstr = "1011001"
    ElseIf (alpha = AscW("a")) Then
        returnstr = "1011010"
    ElseIf (alpha = AscW("b")) Then
        returnstr = "1011011"
    ElseIf (alpha = AscW("c")) Then
        returnstr = "1011100"
    ElseIf (alpha = AscW("d")) Then
        returnstr = "1011101"
    ElseIf (alpha = AscW("e")) Then
        returnstr = "1011110"
    ElseIf (alpha = AscW("f")) Then
        returnstr = "1011111"
    ElseIf (alpha = AscW("g")) Then
        returnstr = "1100000"
    ElseIf (alpha = AscW("h")) Then
        returnstr = "1100001"
    ElseIf (alpha = AscW("i")) Then
        returnstr = "1100010"
    ElseIf (alpha = AscW("j")) Then
        returnstr = "1100011"
    ElseIf (alpha = AscW("k")) Then
        returnstr = "1100100"
    ElseIf (alpha = AscW("l")) Then
        returnstr = "1100101"
    ElseIf (alpha = AscW("m")) Then
        returnstr = "1100110"
    ElseIf (alpha = AscW("n")) Then
        returnstr = "1100111"
    ElseIf (alpha = AscW("o")) Then
        returnstr = "1101000"
    ElseIf (alpha = AscW("p")) Then
        returnstr = "1101001"
    ElseIf (alpha = AscW("q")) Then
        returnstr = "1101010"
    ElseIf (alpha = AscW("r")) Then
        returnstr = "1101011"
    ElseIf (alpha = AscW("s")) Then
        returnstr = "1101100"
    ElseIf (alpha = AscW("t")) Then
        returnstr = "1101101"
    ElseIf (alpha = AscW("u")) Then
        returnstr = "1101110"
    ElseIf (alpha = AscW("v")) Then
        returnstr = "1101111"
    ElseIf (alpha = AscW("w")) Then
        returnstr = "1110000"
    ElseIf (alpha = AscW("x")) Then
        returnstr = "1110001"
    ElseIf (alpha = AscW("y")) Then
        returnstr = "1110010"
    ElseIf (alpha = AscW("z")) Then
        returnstr = "1110011"
    ElseIf (alpha = AscW("!")) Then
        returnstr = "11101000"
    ElseIf (alpha = 34) Then 'ascw(""")
        returnstr = "11101001"
    ElseIf (alpha = AscW("%")) Then
        returnstr = "11101010"
    ElseIf (alpha = AscW("&")) Then
        returnstr = "11101011"
    ElseIf (alpha = AscW("'")) Then
        returnstr = "11101100"
    ElseIf (alpha = AscW("{")) Then  'based on 80/20 rule. people will prefer the ( for the AI
        returnstr = "11101101"
    ElseIf (alpha = AscW("}")) Then  'and seldom need to encode actual brackets. To encode actual brackets they will use {} instead.
        returnstr = "11101110"
    ElseIf (alpha = AscW("*")) Then
        returnstr = "11101111"
    ElseIf (alpha = AscW("+")) Then
        returnstr = "11110000"
    ElseIf (alpha = AscW(",")) Then
        returnstr = "11110001"
    ElseIf (alpha = AscW("-")) Then
        returnstr = "11110010"
    ElseIf (alpha = AscW(".")) Then
        returnstr = "11110011"
    ElseIf (alpha = AscW("/")) Then
        returnstr = "11110100"
    ElseIf (alpha = AscW(":")) Then
        returnstr = "11110101"
    ElseIf (alpha = AscW(";")) Then
        returnstr = "11110110"
    ElseIf (alpha = AscW("<")) Then
        returnstr = "11110111"
    ElseIf (alpha = AscW("=")) Then
        returnstr = "11111000"
    ElseIf (alpha = AscW(">")) Then
        returnstr = "11111001"
    ElseIf (alpha = AscW("?")) Then
        returnstr = "11111010"
    ElseIf (alpha = AscW("_")) Then
        returnstr = "11111011"
    ElseIf (alpha = AscW(" ")) Then
        returnstr = "11111100"
    End If

    
    'MsgBox returnstr
    ISO646Compaction = returnstr
    
End Function


Public Function alphanumericCompaction(ByVal alpha As Long) As String

    Dim returnstr As String

    returnstr = ""
    
    
    If (alpha = 48) Then
        returnstr = "00101"
    ElseIf (alpha = 49) Then
        returnstr = "00110"
    ElseIf (alpha = 50) Then
        returnstr = "00111"
    ElseIf (alpha = 51) Then
        returnstr = "01000"
    ElseIf (alpha = 52) Then
        returnstr = "01001"
    ElseIf (alpha = 53) Then
        returnstr = "01010"
    ElseIf (alpha = 54) Then
        returnstr = "01011"
    ElseIf (alpha = 55) Then
        returnstr = "01100"
    ElseIf (alpha = 56) Then
        returnstr = "01101"
    ElseIf (alpha = 57) Then
        returnstr = "01110"
    ElseIf (alpha = AscW("#")) Then 'FNC1
        returnstr = "01111"
    ElseIf (alpha = AscW("A")) Then
        returnstr = "100000"
    ElseIf (alpha = AscW("B")) Then
        returnstr = "100001"
    ElseIf (alpha = AscW("C")) Then
        returnstr = "100010"
    ElseIf (alpha = AscW("D")) Then
        returnstr = "100011"
    ElseIf (alpha = AscW("E")) Then
        returnstr = "100100"
    ElseIf (alpha = AscW("F")) Then
        returnstr = "100101"
    ElseIf (alpha = AscW("G")) Then
        returnstr = "100110"
    ElseIf (alpha = AscW("H")) Then
        returnstr = "100111"
    ElseIf (alpha = AscW("I")) Then
        returnstr = "101000"
    ElseIf (alpha = AscW("J")) Then
        returnstr = "101001"
    ElseIf (alpha = AscW("K")) Then
        returnstr = "101010"
    ElseIf (alpha = AscW("L")) Then
        returnstr = "101011"
    ElseIf (alpha = AscW("M")) Then
        returnstr = "101100"
    ElseIf (alpha = AscW("N")) Then
        returnstr = "101101"
    ElseIf (alpha = AscW("O")) Then
        returnstr = "101110"
    ElseIf (alpha = AscW("P")) Then
        returnstr = "101111"
    ElseIf (alpha = AscW("Q")) Then
        returnstr = "110000"
    ElseIf (alpha = AscW("R")) Then
        returnstr = "110001"
    ElseIf (alpha = AscW("S")) Then
        returnstr = "110010"
    ElseIf (alpha = AscW("T")) Then
        returnstr = "110011"
    ElseIf (alpha = AscW("U")) Then
        returnstr = "110100"
    ElseIf (alpha = AscW("V")) Then
        returnstr = "110101"
    ElseIf (alpha = AscW("W")) Then
        returnstr = "110110"
    ElseIf (alpha = AscW("X")) Then
        returnstr = "110111"
    ElseIf (alpha = AscW("Y")) Then
        returnstr = "111000"
    ElseIf (alpha = AscW("Z")) Then
        returnstr = "111001"

    ElseIf (alpha = AscW("*")) Then
        returnstr = "111010"
    ElseIf (alpha = AscW(",")) Then
        returnstr = "111011"
    ElseIf (alpha = AscW("-")) Then
        returnstr = "111100"
    ElseIf (alpha = AscW(".")) Then
        returnstr = "111101"
    ElseIf (alpha = AscW("/")) Then
        returnstr = "111110"
    End If
    
        
    alphanumericCompaction = returnstr

End Function


Public Function NextTwoNumeric(ByVal x As Long, ByVal data As String) As Long


    Dim retval As Long
    retval = 0

    If (x + 1 = Len(data)) Then
        retval = 0
        NextTwoNumeric = retval
        Exit Function
    End If
    
    If (AscW(Mid(data, x + 1, 1)) >= AscW("0") And AscW(Mid(data, x + 1, 1)) <= AscW("9") And AscW(Mid(data, x + 1 + 1, 1)) >= AscW("0") And AscW(Mid(data, x + 1 + 1, 1)) <= AscW("9")) Then
        retval = 1
        NextTwoNumeric = retval
        Exit Function
    End If
        
    If (AscW(Mid(data, x + 1, 1)) >= AscW("0") And AscW(Mid(data, x + 1, 1)) <= AscW("9") And AscW(Mid(data, x + 1 + 1, 1)) = AscW("#")) Then
        retval = 1
        NextTwoNumeric = retval
        Exit Function
    End If
    
    If (AscW(Mid(data, x + 1, 1)) = AscW("#") And AscW(Mid(data, x + 1 + 1, 1)) >= AscW("0") And AscW(Mid(data, x + 1 + 1, 1)) <= AscW("9")) Then
        retval = 1
        NextTwoNumeric = retval
        Exit Function
    End If

    
    NextTwoNumeric = 0

End Function


'recheck
Public Function numericEncodation(ByRef x As Long, ByVal data As String, ByRef encodationResult As String, ByRef compactionResult As String, ByRef state As String) As String

    'TRACE("Numeric Encodation\n");
    'MsgBox "Numeric Encodation"

    Dim result As String
    result = ""
    Do While (x < Len(data))
    
        
        If (NextTwoNumeric(x, data)) Then
            
            result = result + numericCompaction(Mid(data, x + 1, 2))
            x = x + 2
        
        ElseIf (Len(data) - x >= 2) Then '2 or more characters left
        
           
            result = result + "0000"
            state = "Alpha"
            numericEncodation = result
            Exit Function
        
        ElseIf (Len(data) - x = 1 And (AscW(Mid(data, x + 1, 1)) < AscW("0") Or AscW(Mid(data, x + 1, 1)) > AscW("9"))) Then '1 character left
                       
                        
            result = result + "0000"
            state = "Alpha"
            numericEncodation = result
            Exit Function
        
        ElseIf (Len(data) - x = 1 And AscW(Mid(data, x + 1, 1)) >= AscW("0") And AscW(Mid(data, x + 1, 1)) <= AscW("9")) Then
        
        
            
            Dim symbolbitslength, nextFactor, numBitsLeft As Long
            symbolbitslength = Len(encodationResult) + Len(compactionResult) + Len(result)
            nextFactor = Int(symbolbitslength / 12) + 1
            numBitsLeft = nextFactor * 12 - symbolbitslength
            If (numBitsLeft >= 7) Then
            
                
                result = result + numericCompaction(Mid(data, x + 1, 1) + "#")
                x = x + 1
                numericEncodation = result

                Exit Function
            
            ElseIf (numBitsLeft >= 4 And numBitsLeft <= 6) Then
            
                Dim value As Long
                Dim digits As Long
                
                value = (AscW(Mid(data, x + 1, 1)) - AscW("0")) + 1
                'int digits=0x08; recheck
                digits = 8
                For y = 0 To 3
                
                    'if (value&digits) recheck
                    If ((value And digits) <> 0) Then
                        result = result + "1"
                    Else
                        result = result + "0"
                    End If
                    'digits>>=1;
                    digits = Int(digits / 2)
                Next y
                x = x + 1
                numericEncodation = result
                

                Exit Function
            
            Else
            
                result = result + numericCompaction(Mid(data, x + 1, 1) + "#")
                x = x + 1
                numericEncodation = result
                

                Exit Function
            
            End If
        End If
    Loop
    numericEncodation = result

End Function

Public Function alphaEncodation(ByRef x As Long, ByVal data As String, ByRef state As String) As String

    
    Dim result As String
    Dim lendata As Long
    lendata = Len(data)
    
    result = ""
    
    Do While (x < Len(data))
            
        If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "") Then
            
            result = result + alphanumericCompaction(AscW(Mid(data, x + 1, 1)))
            x = x + 1
        
        ElseIf (ISO646Compaction(AscW(Mid(data, x + 1, 1))) <> "") Then
            
            

            state = "ISO646"
            result = result + "00100"
            alphaEncodation = result
            Exit Function
            
        End If
        

        If (Len(data) >= x + 1 + 6) Then
          If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And NextTwoNumeric(x + 4, data)) Then
            

            state = "Numeric"
            result = result + "000"
            alphaEncodation = result
            Exit Function
           
          End If
        End If
        
        
        
        If (Len(data) = x + 1 + 4) Then
            If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data)) Then
            

                state = "Numeric"
                result = result + "000"
                alphaEncodation = result
                Exit Function
            
            End If
        End If


    Loop
    
    alphaEncodation = result
    
End Function

Public Function ISOSwitchToNumeric(ByRef x As Long, ByVal data As String) As Long



        'Careful the code depends on here to break and not to carry on the following.
        'find any char that can be in alpha
        If (Len(data) - x >= 1 + 14) Then
                
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "")) Then
                     
                    
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                End If
        End If
        
        If (Len(data) - x >= 1 + 13) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "")) Then
                     
                     
                    
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                End If
        End If
        
        
        If (Len(data) - x >= 1 + 12) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "")) Then
                     
                     
        
                    ISOSwitchToNumeric = 1
                    Exit Function
                 End If
         End If
        
        
        If (Len(data) - x >= 1 + 11) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "")) Then
                     
                     
                     
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If
        
        
        If (Len(data) - x >= 1 + 10) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "")) Then
                     
                     
                     
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If
        
        
        If (Len(data) - x >= 1 + 9) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "")) Then
                     
                     
                
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If
        
        If (Len(data) - x >= 1 + 8) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "")) Then
                     
                     
                     
                    ISOSwitchToNumeric = 1
                    Exit Function
                 End If
        End If
        
        If (Len(data) - x >= 1 + 7) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "")) Then
                     
                     
                
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If
        
        
        If (Len(data) - x >= 1 + 6) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "")) Then
                     
                     
                     
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If
        
        
        If (Len(data) - x >= 1 + 5) Then
                 If (NextTwoNumeric(x, data) And NextTwoNumeric(x + 2, data) And _
                    (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "")) Then
                    
                
                    ISOSwitchToNumeric = 1
                    Exit Function
                    
                 End If
        End If

        ISOSwitchToNumeric = 0
        
End Function

Public Function ISOSwitchToAlpha(ByRef x As Long, ByVal data As String) As Long


        If (Len(data) - x >= 1 + 15) Then
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 10, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 11, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 12, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 13, 1))) <> "" And _
                    alphanumericCompaction(AscW(Mid(data, x + 1 + 14, 1))) <> "") Then
                    
                    
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                End If
        End If
        
        
        If (Len(data) - x >= 1 + 14) Then
              If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 10, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 11, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 12, 1))) <> "" And _
                 alphanumericCompaction(AscW(Mid(data, x + 1 + 13, 1))) <> "") Then
                
                ISOSwitchToAlpha = 1
                Exit Function
                
              End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 13) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 10, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 11, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 12, 1))) <> "") Then
                    
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 12) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 10, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 11, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 11) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 10, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 10) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 9, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 9) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 8, 1))) <> "") Then
                     
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 8) Then
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 7, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 7) Then
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 6, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        If (Len(data) - x >= 1 + 6) Then
                 
                 If (alphanumericCompaction(AscW(Mid(data, x + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 1, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 2, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 3, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 4, 1))) <> "" And _
                     alphanumericCompaction(AscW(Mid(data, x + 1 + 5, 1))) <> "") Then
                    ISOSwitchToAlpha = 1
                    Exit Function
                    
                 End If
        End If
        
        
        
        ISOSwitchToAlpha = 0

End Function


Public Function ISO646Encodation(ByRef x As Long, ByVal data As String, ByRef state As String) As String

    
    Dim result As String
    result = ""
    Do While (x < Len(data))
    
        If (ISO646Compaction(AscW(Mid(data, x + 1, 1))) <> "") Then
        
            result = result + ISO646Compaction(AscW(Mid(data, x + 1, 1)))
            
            x = x + 1
        
        End If
        

        If (ISOSwitchToNumeric(x, data) <> 0) Then
        
            state = "Numeric"
            result = result + "000"
            ISO646Encodation = result
            Exit Function
        
        End If
        
        

        If (ISOSwitchToAlpha(x, data) <> 0) Then
        

            state = "Alpha"
            result = result + "00100"
            ISO646Encodation = result
            Exit Function
            
        End If
    
    Loop

    ISO646Encodation = result
            
End Function


Public Function pad(ByVal data As String, ByRef encodationResult As String, ByRef state As String) As String
    
    Dim result As String
    result = data
    
    Dim symbolbitslength, nextFactor, numBitsLeft As Long
    symbolbitslength = Len(encodationResult) + Len(data)

    If (symbolbitslength Mod 12 = 0) Then
        'TRACE("Fit Exactly\n");//Pad not Required

    Else
    
        nextFactor = Int(symbolbitslength / 12) + 1
        numBitsLeft = nextFactor * 12 - symbolbitslength
        result = data

        Do While (numBitsLeft > 0)
        
            If (state = "Numeric") Then
            
                If (numBitsLeft > 3) Then
                
                    result = result + "0000"
                    numBitsLeft = numBitsLeft - 4
                    state = "Alpha"
                
                ElseIf (numBitsLeft = 3) Then
                
                    result = result + "000"
                    numBitsLeft = numBitsLeft - 3
                    state = "Alpha"
                
                ElseIf (numBitsLeft = 2) Then
                
                    result = result + "00"
                    numBitsLeft = numBitsLeft - 2
                
                ElseIf (numBitsLeft = 1) Then
                
                    result = result + "0"
                    numBitsLeft = numBitsLeft - 1
                
                End If
            
            Else
            
                If (numBitsLeft >= 5) Then
                
                    result = result + "00100"
                    numBitsLeft = numBitsLeft - 5
                
                ElseIf (numBitsLeft = 4) Then
                
                    result = result + "0010"
                    numBitsLeft = numBitsLeft - 4
                
                ElseIf (numBitsLeft = 3) Then
                
                    result = result + "001"
                    numBitsLeft = numBitsLeft - 3
                
                ElseIf (numBitsLeft = 2) Then
                
                    result = result + "00"
                    numBitsLeft = numBitsLeft - 2
                
                ElseIf (numBitsLeft = 1) Then
                
                    result = result + "0"
                    numBitsLeft = numBitsLeft - 1
                    
                End If
                
                
            End If
        Loop 'while
    End If

    pad = result
    
End Function

Public Function dataCompaction(ByVal data As String, ByRef encodationResult As String, ByRef compactionResult As String, ByRef state As String) As String

    
    Dim x As Long
    
    
    x = 0
    
    state = "Numeric"
    compactionResult = ""
    Do While (x < Len(data))
    
        If (state = "Numeric") Then
            
            compactionResult = compactionResult + numericEncodation(x, data, encodationResult, compactionResult, state)
            
        ElseIf (state = "Alpha") Then
            
            compactionResult = compactionResult + alphaEncodation(x, data, state)
            
        ElseIf (state = "ISO646") Then
            
            compactionResult = compactionResult + ISO646Encodation(x, data, state)
        End If
    
    Loop
    
    
    compactionResult = pad(compactionResult, encodationResult, state)
    
    
    dataCompaction = compactionResult
    
End Function


   

Public Function findPatternData(ByVal data As String, ByRef patternCounter As Long, ByRef patterns() As String, ByRef patData() As String) As Long

    Dim x, y, z As Long
    x = 0
    y = 0
    z = 0
    
    patternCounter = 0
    For x = 0 To 29
    
        patterns(x) = ""
        patData(x) = ""
    
    Next x

    x = 0
    'TRACE("New %s %d\n",data,data.GetLength());
    Do While (x < Len(data))
    
        'TRACE("x is %d\n",x);
        If (Mid(data, x + 1, 1) = "(") Then
        
            patterns(patternCounter) = patterns(patternCounter) + Mid(data, x + 1, 1)
            y = x + 1
            x = x + 1
            Do While (y < Len(data) And Mid(data, y + 1, 1) <> ")")
            
                patterns(patternCounter) = patterns(patternCounter) + Mid(data, y + 1, 1)
                x = x + 1
                y = y + 1
                
                'inserted to prevent Mid overflow
                If (y >= Len(data)) Then
                    Exit Do
                End If
            
            Loop
            
            If (Mid(data, y + 1, 1) = ")") Then
                patterns(patternCounter) = patterns(patternCounter) + Mid(data, y + 1, 1)
            End If

            z = y + 1
            x = x + 1
            Do While (z < Len(data) And Mid(data, z + 1, 1) <> "(")
            
                patData(patternCounter) = patData(patternCounter) + Mid(data, z + 1, 1)
                x = x + 1
                z = z + 1
                
                'inserted to prevent Mid overflow
                If (z >= Len(data)) Then
                    Exit Do
                End If
            
            Loop

            
            patternCounter = patternCounter + 1
        
        Else
            x = x + 1
        End If
    
    Loop

    findPatternData = 0

End Function




Public Function fixLength8Encodation(ByVal data As String, ByVal encodationField As String, ByRef numData As Long, ByRef numSegments As Long, ByRef errorMsg As String, ByRef linkageFlag As Long, ByRef datachar() As Long, ByRef patterns() As String, ByRef patData() As String, ByRef patternCounter As Long) As String

        
        Dim patData0, patData1, patData2, tempString As String
        Dim addcharlength As Long
        Dim x As Long
        

        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
         
        
        ElseIf (Len(patData(0)) > 14) Then
        
            'patData(0).Delete(14,len(patData(0))-14);
            patData(0) = left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            fixLength8Encodation = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
        
            patData(1) = left(patData(1), 6)
        
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                patData(1) = "0" + patData(1)
            Next x
        End If

        patData(2) = onlyNumeric(patData(2))
        If (Len(patData(2)) > 6) Then
        
            patData(2) = left(patData(2), 6)
        
        End If

        If (Len(patData(2)) < 6) Then
        
            addcharlength = 6 - Len(patData(2))
            For x = 0 To addcharlength - 1
                patData(2) = "0" + patData(2)
            Next x
        End If

        Dim valueRange As Long
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 99999) Then
        
            errorMsg = "The weight field must be from 0 to 99999."
            fixLength8Encodation = ""
            Exit Function
            
        End If
        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12) 'Take out first Digit
        patData1 = Mid(patterns(1), 4 + 1, 1) + right(patData(1), 5)
        patData2 = patData(2)

        'TRACE("patData1 %s\n",patData1);

        'Setup for barcode encodation
        numData = 7
        numSegments = 8
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If

        'tempString=tempString+"0111000"; //Encodation Method Field
        tempString = tempString + encodationField 'Encodation Method Field
        
        Dim triplets, fStr As String
        triplets = ""
        fStr = ""
        Dim tripletsValue As Long
        Dim digits As Long
        
        
        For x = 0 To 11
        
           
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        Dim patData1Value As Long
        patData1Value = val(patData1)
        digits = 524288 '0x80000; //20 digits most significant 1
        For y = 0 To 19
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y

        Dim YY, MM, DD As Long
        
        YY = val(left(patData2, 2))
        MM = val(Mid(patData2, 2 + 1, 1) + Mid(patData2, 3 + 1, 1))
        DD = val(right(patData2, 2))
        'TRACE("YY %d, MM %d, DD %d\n",YY,MM,DD);

        Dim patData2Value As Long
        patData2Value = YY * 384 + (MM - 1) * 32 + DD
        If (patData2Value = 0) Then
            patData2Value = 38400
        End If

        'TRACE("patData2 %ld\n",patData2Value);

        digits = 32768 '20 digits most significant 1
        For y = 0 To 15
        
            If (patData2Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        Dim value12 As Long
        value12 = 0
        digits = 2048
        For x = 0 To 83
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits 'value12=value12+(long)digits;
                'TRACE("Interim : %d\n",value12);
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        Next x
        fixLength8Encodation = patterns(0) + patData(0) + patterns(1) + patData(1) + patterns(2) + patData(2)
        
        
End Function

Public Function matchAI(ByVal data As String, ByVal matchAIstr As String) As Long
    
    Dim x, match As Long
    x = 0
    match = 1

    Do While (x < Len(data))
    
        If (Mid(data, x + 1, 1) <> Mid(matchAIstr, x + 1, 1)) Then
        
            If (Mid(matchAIstr, x + 1, 1) = "x") Then
                 'do nothing
            Else
                match = 0
            End If
        
        End If
        x = x + 1
    
    Loop
    matchAI = match

End Function



Public Function encodationMethod(ByVal data As String, ByRef numData As Long, ByRef numSegments As Long, ByRef encodationResult As String, ByRef compactionResult As String, ByRef errorMsg As String, ByRef linkageFlag As Long, ByRef datachar() As Long) As String

    Dim result As String
    Dim retval As Long
    Dim addcharlength As Long
    Dim state As String 'Numeric Alpha, ISO646
    
    result = ""

    numData = 0
    numSegments = 0
    
    'state variables
    Dim patterns(30) As String
    Dim patData(30) As String
    Dim patternCounter As Long

    retval = findPatternData(data, patternCounter, patterns, patData)
    If (patternCounter < 1) Then
    
        errorMsg = "No Application Identifier specified."
        encodationMethod = ""
        Exit Function
    
    End If

    'TRACE("Here %d\n",patternCounter);
    If (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3103)") Then
    
       Dim patData0, patData1, tempString As String
       
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethod = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
        
            patData(1) = left(patData(1), 6)
        
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                patData(1) = "0" + patData(1)
             Next x
        
        End If
        
        Dim valueRange As Long
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 32767) Then
        
            errorMsg = "The weight field must be from 0 to 32767."
            encodationMethod = ""
            Exit Function
        
        End If

        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12)  'Take out first Digit
        patData1 = patData(1)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0100" 'Encodation Method Field
        
        Dim triplets As String
        Dim digits As Long
        triplets = ""
        fStr = ""
        Dim tripletsValue As Long
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                '10 digits most significant 1
                digits = 512
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        Dim patData1Value As Long
        patData1Value = val(patData1)
        
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        Dim value12 As Long
        value12 = 0
        digits = 2048
        For x = 0 To 59
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                '//TRACE("Interim : %d\n",value12);
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        encodationMethod = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
            
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3202)") Then
    
        'Dim patData0, patData1, tempString As String
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
            
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethod = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
        
            patData(1) = left(patData(1), 6)
        
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                
                patData(1) = "0" + patData(1)
                
            Next x
        End If
        
        'Dim valueRange As Long
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 9999) Then
        
            errorMsg = "The weight field must be from 0 to 9999."
            encodationMethod = ""
            Exit Function
        
        End If
        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12) 'Take out first Digit
        patData1 = right(patData(1), 4)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0101" 'Encodation Method Field
        
        
        fStr = ""
        triplets = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        
        patData1Value = val(patData1)
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        
        value12 = 0
        digits = 2048
        For x = 0 To 59

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        encodationMethod = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3203)") Then
    
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethod = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
            
            patData(1) = left(patData(1), 6)
            
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                patData(1) = "0" + patData(1)
            Next x
        
        End If
        
        
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 22767) Then
        
            errorMsg = "The weight field must be from 0 to 22767."
            encodationMethod = ""
            Exit Function
        
        End If
        
        
        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12) 'Take out first Digit
        patData1 = right(patData(1), 4)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0101" 'Encodation Method Field
        
        
        
        
        fStr = ""
        triplets = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        
        patData1Value = val(patData1) + 10000 'Add 10000 as compared to the previous
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        
        value12 = 0
        digits = 2048
        For x = 0 To 59
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
                        
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        encodationMethod = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
                           
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(11)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111000", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(11)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111001", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(13)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111010", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(13)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111011", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(15)") Then
    
        'TRACE("Inside\n");
        encodationMethod = fixLength8Encodation(data, "0111100", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(15)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111101", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(17)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111110", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(17)") Then
    
        encodationMethod = fixLength8Encodation(data, "0111111", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And matchAI(patterns(1), "(392x)")) Then
    
        'TRACE("Start of (392x)\n");
        encodationResult = ""
        Dim patData2 As String
        
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethod = ""
            Exit Function
        
        End If

        
        If (AscW(Mid(patterns(1), 4 + 1, 1)) < AscW("0") Or AscW(Mid(patterns(1), 4 + 1, 1)) > AscW("3")) Then
        
            
            errorMsg = "The decimal point digit must be from 0 to 3."
            encodationMethod = ""
            Exit Function
            
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 15) Then
        
            patData(1) = left(patData(1), 15)
        
        End If

        If (patData(1) = "") Then
        
            errorMsg = "The price digits cannot be empty."
            encodationMethod = ""
            Exit Function
        
        End If

        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12) 'Take out first Digit
        patData1 = Mid(patterns(1), 4 + 1, 1)
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        
        
        tempString = tempString + "01100" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field
        
        
        
        triplets = ""
        fStr = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                        
                    digits = Int(digits / 2)
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        
        patData1Value = val(patData1)
        If (patData1Value = 0) Then
            
            tempString = tempString + "00"
            
        ElseIf (patData1Value = 1) Then
            tempString = tempString + "01"
        ElseIf (patData1Value = 2) Then
            tempString = tempString + "10"
        ElseIf (patData1Value = 3) Then
            tempString = tempString + "11"
        End If

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        tempString = tempString + dataCompaction(patData(1), encodationResult, compactionResult, state)

        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

        'Setup the variable bits length field
        Dim tempChar As String
        Dim tempLeft, tempRight As String
        If (numSegments Mod 2 = 0) Then
            'tempChar = Mid(tempString, 6 + 1, 1)
            tempLeft = left(tempString, 6)
            tempRight = right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(6,'0');
        Else
            tempLeft = left(tempString, 6)
            tempRight = right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(6,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = left(tempString, 7)
            tempRight = right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(7,'0');
        Else
            tempLeft = left(tempString, 7)
            tempRight = right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(7,'1');
        End If


        'Possible place to do a length check does not exceed max length
                
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethod = ""
                    Exit Function
                                    
                End If
                datachar(Int(((x + 1) / 12) - 1)) = value12
                                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        encodationMethod = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function

    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And matchAI(patterns(1), "(393x)")) Then
    
        encodationResult = ""
                
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
            
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethod = ""
            Exit Function
        
        End If

        If (AscW(Mid(patterns(1), 4 + 1, 1)) < AscW("0") Or AscW(Mid(patterns(1), 4 + 1, 1)) > AscW("3")) Then
        
            errorMsg = "The decimal point digit must be from 0 to 3."
            encodationMethod = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 18) Then '3 ISO Currency + 15
        
            patData(1) = left(patData(1), 18)
        
        End If

        If (patData(1) = "") Then
        
            errorMsg = "The price digits cannot be empty."
            encodationMethod = ""
            Exit Function
        
        End If


        patData0 = left(patData(0), 13) 'Take out last Digit
        patData0 = right(patData0, 12) 'Take out first Digit
        patData1 = Mid(patterns(1), 4 + 1, 1)
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If

        
        tempString = tempString + "01101" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field
                
        
        
        triplets = ""
        fStr = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        
        patData1Value = Int(val(patData1))
        If (patData1Value = 0) Then
            tempString = tempString + "00"
        ElseIf (patData1Value = 1) Then
            tempString = tempString + "01"
        ElseIf (patData1Value = 2) Then
            tempString = tempString + "10"
        ElseIf (patData1Value = 3) Then
            tempString = tempString + "11"
        End If

        
        triplets = left(patData(1), 3)
        tripletsValue = val(triplets)
        digits = 512 '10 digits most significant 1
        For y = 0 To 9
        
            If (tripletsValue And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        Next y

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        tempString = tempString + dataCompaction(Mid(patData(1), 3 + 1), encodationResult, compactionResult, state)


        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1
        

        'Possible place to do a length check does not exceed max length
        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = left(tempString, 6)
            tempRight = right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(6,'0');
        Else
            tempLeft = left(tempString, 6)
            tempRight = right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(6,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = left(tempString, 7)
            tempRight = right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(7,'0')
        Else
            tempLeft = left(tempString, 7)
            tempRight = right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(7,'1');
        End If
        
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethod = ""
                    Exit Function
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        Next x
        
        encodationMethod = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
    
    ElseIf (patterns(0) = "(01)" And patternCounter >= 1) Then
    
        encodationResult = ""
        Dim temppatData As String
                        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = left(patData(0), 14)
        
        End If
        
        patData0 = left(patData(0), 13) 'Take out last Digit
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        

        tempString = tempString + "1" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field

        
        Dim singletValue As Long
        Dim smalldigit As Long
               
        
        triplets = ""
        fStr = ""
              
        singletValue = val(Mid(patData0, 0 + 1, 1))
        smalldigit = 8 '4 digits most significant 1
        For y = 0 To 3
        
            If (singletValue And smalldigit) Then
                fStr = fStr + "1"
            Else
                fStr = fStr + "0"
            End If
                
            smalldigit = Int(smalldigit / 2)
        
        Next y

        'TRACE("Singlet %s\n",fStr);
        tempString = tempString + fStr

        For x = 1 To 12
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1 - 1) Mod 3 = 0) Then 'Minus 1 as it starts from 1
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
            
        For x = 0 To patternCounter - 1
        
            If (x <> 0) Then
            
                'TRACE("patterns %s patData %s\n",patterns[x],patData[x]);
                temppatData = temppatData + stripBrackets(patterns(x)) + patData(x)
            
            End If
        
        Next x

    
        
        tempString = tempString + dataCompaction(temppatData, encodationResult, compactionResult, state)
        

        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = left(tempString, 2)
            tempRight = right(tempString, Len(tempString) - 3)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(2,'0');
        Else
            tempLeft = left(tempString, 2)
            tempRight = right(tempString, Len(tempString) - 3)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(2,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = left(tempString, 3)
            tempRight = right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(3,'0');
        Else
            tempLeft = left(tempString, 3)
            tempRight = right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(3,'1');
        End If


        'Possible place to do a length check does not exceed max length
        
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If

            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethod = ""
                    Exit Function
                
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12

                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        Dim combinationStr As String
        combinationStr = ""
        For x = 0 To patternCounter - 1
        
            combinationStr = combinationStr + patterns(x) + patData(x)
        
        Next x

        encodationMethod = combinationStr
        Exit Function
    
    Else
    
        'Could be any AI or AI(01) + other AI
        encodationResult = ""
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
            
        
        tempString = tempString + "00" 'Encodation Method Field
        tempString = tempString + "00" 'Variable Length Field

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        For x = 0 To patternCounter - 1
                    
            temppatData = temppatData + stripBrackets(patterns(x)) + patData(x)
        
        Next x
        
        tempString = tempString + dataCompaction(temppatData, encodationResult, compactionResult, state)
        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

	  '1031
	  If (numSegments<4) Then
		
			errorMsg = "The GS1 Expanded Specifications require the number of data segments to be at least 4."
		      encodationMethod = ""
		      Exit Function

	  End if
        
        'Possible place to do a length check does not exceed max length
        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = left(tempString, 3)
            tempRight = right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(3,'0');
        Else
            tempLeft = left(tempString, 3)
            tempRight = right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(3,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = left(tempString, 4)
            tempRight = right(tempString, Len(tempString) - 5)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(4,'0');
        Else
            tempLeft = left(tempString, 4)
            tempRight = right(tempString, Len(tempString) - 5)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(4,'1');
        End If

                
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethod = ""
                    Exit Function
                
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12
                                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        Next x

        
        combinationStr = ""
        For x = 0 To patternCounter - 1
        
            combinationStr = combinationStr + patterns(x) + patData(x)
        
        Next x

        encodationMethod = combinationStr
        Exit Function

    End If

    encodationMethod = result
    Exit Function
    
End Function

Public Function onlyNumeric(ByVal data As String) As String

    Dim result As String
    result = ""
    
    For x = 0 To Len(data) - 1
        If (AscW(Mid(data, x + 1, 1)) <= AscW("9") And AscW(Mid(data, x + 1, 1)) >= AscW("0")) Then
            result = result + Mid(data, x + 1, 1)
        End If
    Next x
            
    onlyNumeric = result

End Function

Public Function stripBrackets(ByVal data As String) As String

    Dim stripResult As String
    Dim x As Long
    stripResult = ""
    
    x = 0
    Do While (x < Len(data))
    
        If (AscW(Mid(data, x + 1, 1)) <= AscW("9") And AscW(Mid(data, x + 1, 1)) >= AscW("0")) Then
            stripResult = stripResult + Mid(data, x + 1, 1)
        End If
        x = x + 1
    
    Loop
    stripBrackets = stripResult

End Function




Public Function filterInput__GS1DatabarExpanded(ByVal data As String) As String
    
  Dim result As String
  Dim x, datalength, barcodeval As Long
  Dim barcodechar As String
    
  result = ""
  datalength = Len(data)

  For x = 0 To datalength - 1
  
    barcodechar = Mid(data, x + 1, 1)
    barcodeval = AscW(barcodechar)
    If ( _
        (barcodeval <= AscW("9") And barcodeval >= AscW("0")) Or _
        (barcodeval <= AscW("z") And barcodeval >= AscW("a")) Or _
        (barcodeval <= AscW("Z") And barcodeval >= AscW("A")) Or _
        (barcodechar = "!" Or barcodeval = 34 Or barcodechar = "%" _
         Or barcodechar = "&" Or barcodechar = "'" Or barcodechar = "(") _
         Or barcodechar = ")" Or barcodechar = "*" Or barcodechar = "+" _
         Or barcodechar = "," Or barcodechar = "-" Or barcodechar = "." _
         Or barcodechar = "/" Or barcodechar = ":" Or barcodechar = ";" Or barcodechar = "<" _
         Or barcodechar = "=" Or barcodechar = ">" Or barcodechar = "?" _
         Or barcodechar = "_" Or barcodechar = " " _
         Or barcodechar = "{" Or barcodechar = "}") Then
         
        result = result + barcodechar
        
     End If
  
  Next x

  filterInput__GS1DatabarExpanded = result
  
End Function



Public Function getGS1WExpanded(ByVal data As Long, ByVal oddeven As Long, ByVal modules As Long, ByRef widths() As Long) As Long

     Dim x As Long
    
     Dim WIDTH17_4_0(5, 7) As Long
     Dim WIDTH17_4_1(5, 7) As Long
        
     '740
     WIDTH17_4_0(0, 0) = 0
     WIDTH17_4_0(0, 1) = 347
     WIDTH17_4_0(0, 2) = 4
     WIDTH17_4_0(0, 3) = 5
     WIDTH17_4_0(0, 4) = 4
     WIDTH17_4_0(0, 5) = 2
     WIDTH17_4_0(0, 6) = 1
        
     WIDTH17_4_0(1, 0) = 348
     WIDTH17_4_0(1, 1) = 1387
     WIDTH17_4_0(1, 2) = 20
     WIDTH17_4_0(1, 3) = 7
     WIDTH17_4_0(1, 4) = 4
     WIDTH17_4_0(1, 5) = 4
     WIDTH17_4_0(1, 6) = 1
        
     WIDTH17_4_0(2, 0) = 1388
     WIDTH17_4_0(2, 1) = 2947
     WIDTH17_4_0(2, 2) = 52
     WIDTH17_4_0(2, 3) = 9
     WIDTH17_4_0(2, 4) = 4
     WIDTH17_4_0(2, 5) = 5
     WIDTH17_4_0(2, 6) = 1
    
     WIDTH17_4_0(3, 0) = 2948
     WIDTH17_4_0(3, 1) = 3987
     WIDTH17_4_0(3, 2) = 104
     WIDTH17_4_0(3, 3) = 11
     WIDTH17_4_0(3, 4) = 4
     WIDTH17_4_0(3, 5) = 6
     WIDTH17_4_0(3, 6) = 1
            
     WIDTH17_4_0(4, 0) = 3988
     WIDTH17_4_0(4, 1) = 4191
     WIDTH17_4_0(4, 2) = 204
     WIDTH17_4_0(4, 3) = 13
     WIDTH17_4_0(4, 4) = 4
     WIDTH17_4_0(4, 5) = 8
     WIDTH17_4_0(4, 6) = 1
    
    
     '741
     WIDTH17_4_1(0, 0) = 0
     WIDTH17_4_1(0, 1) = 347
     WIDTH17_4_1(0, 2) = 4
     WIDTH17_4_1(0, 3) = 12
     WIDTH17_4_1(0, 4) = 4
     WIDTH17_4_1(0, 5) = 7
     WIDTH17_4_1(0, 6) = 0
     
     
     WIDTH17_4_1(1, 0) = 348
     WIDTH17_4_1(1, 1) = 1387
     WIDTH17_4_1(1, 2) = 20
     WIDTH17_4_1(1, 3) = 10
     WIDTH17_4_1(1, 4) = 4
     WIDTH17_4_1(1, 5) = 5
     WIDTH17_4_1(1, 6) = 0
     
     
     WIDTH17_4_1(2, 0) = 1388
     WIDTH17_4_1(2, 1) = 2947
     WIDTH17_4_1(2, 2) = 52
     WIDTH17_4_1(2, 3) = 8
     WIDTH17_4_1(2, 4) = 4
     WIDTH17_4_1(2, 5) = 4
     WIDTH17_4_1(2, 6) = 0
     
     WIDTH17_4_1(3, 0) = 2948
     WIDTH17_4_1(3, 1) = 3987
     WIDTH17_4_1(3, 2) = 104
     WIDTH17_4_1(3, 3) = 6
     WIDTH17_4_1(3, 4) = 4
     WIDTH17_4_1(3, 5) = 3
     WIDTH17_4_1(3, 6) = 0
     
     WIDTH17_4_1(4, 0) = 3988
     WIDTH17_4_1(4, 1) = 4191
     WIDTH17_4_1(4, 2) = 204
     WIDTH17_4_1(4, 3) = 4
     WIDTH17_4_1(4, 4) = 4
     WIDTH17_4_1(4, 5) = 1
     WIDTH17_4_1(4, 6) = 0
    
     If (modules = 17) Then
    
        If (oddeven = 0) Then
        
            For x = 0 To 4
                If (data >= WIDTH17_4_0(x, 0) And data <= WIDTH17_4_0(x, 1)) Then
                                        
                    retval = getGS1widths(Int((data - WIDTH17_4_0(x, 0)) Mod WIDTH17_4_0(x, 2)), WIDTH17_4_0(x, 3), WIDTH17_4_0(x, 4), WIDTH17_4_0(x, 5), WIDTH17_4_0(x, 6), widths)
                
                End If
             Next x
        
        Else
        
            For x = 0 To 4
                If (data >= WIDTH17_4_1(x, 0) And data <= WIDTH17_4_1(x, 1)) Then
                
                    retval = getGS1widths(Int((data - WIDTH17_4_1(x, 0)) / WIDTH17_4_1(x, 2)), WIDTH17_4_1(x, 3), WIDTH17_4_1(x, 4), WIDTH17_4_1(x, 5), WIDTH17_4_1(x, 6), widths)
                
                End If
            Next x
        
        End If
    
     End If

     getGS1WExpanded = 0

End Function


Public Function getCheckSumWeights(ByVal scr As String) As Long

    Dim retval As Long
    retval = 0
    
        
    If (scr = "A1 Right") Then
        retval = 0
    ElseIf (scr = "A2 Left") Then
        retval = 1
    ElseIf (scr = "A2 Right") Then
        retval = 2
    ElseIf (scr = "B1 Left") Then
        retval = 3
    ElseIf (scr = "B1 Right") Then
        retval = 4
    ElseIf (scr = "B2 Left") Then
        retval = 5
    ElseIf (scr = "B2 Right") Then
        retval = 6
    ElseIf (scr = "C1 Left") Then
        retval = 7
    ElseIf (scr = "C1 Right") Then
        retval = 8
    ElseIf (scr = "C2 Left") Then
        retval = 9
    ElseIf (scr = "C2 Right") Then
        retval = 10
    ElseIf (scr = "D1 Left") Then
        retval = 11
    ElseIf (scr = "D1 Right") Then
        retval = 12
    ElseIf (scr = "D2 Left") Then
        retval = 13
    ElseIf (scr = "D2 Right") Then
        retval = 14
    ElseIf (scr = "E1 Left") Then
        retval = 15
    ElseIf (scr = "E1 Right") Then
        retval = 16
    ElseIf (scr = "E2 Left") Then
        retval = 17
    ElseIf (scr = "E2 Right") Then
        retval = 18
    ElseIf (scr = "F1 Left") Then
        retval = 19
    ElseIf (scr = "F1 Right") Then
        retval = 20
    ElseIf (scr = "F2 Left") Then
        retval = 21
    ElseIf (scr = "F2 Right") Then
        retval = 22
    End If

    getCheckSumWeights = retval

End Function


Public Function getFinderPatterns(ByVal patternName As String, ByRef fd As Long) As Long

    Dim retval As Long
    retval = 0
    fd = 0

    
    If (patternName = "A1") Then
        fd = 1
        retval = 0
    ElseIf (patternName = "B1") Then
        fd = 1
        retval = 1
    ElseIf (patternName = "C1") Then
        fd = 1
        retval = 2
    ElseIf (patternName = "D1") Then
        fd = 1
        retval = 3
    ElseIf (patternName = "E1") Then
        fd = 1
        retval = 4
    ElseIf (patternName = "F1") Then
        fd = 1
        retval = 5
    ElseIf (patternName = "A2") Then
        fd = 2
        retval = 0
    ElseIf (patternName = "B2") Then
        fd = 2
        retval = 1
    ElseIf (patternName = "C2") Then
        fd = 2
        retval = 2
    ElseIf (patternName = "D2") Then
        fd = 2
        retval = 3
    ElseIf (patternName = "E2") Then
        fd = 2
        retval = 4
    ElseIf (patternName = "F2") Then
        fd = 2
        retval = 5
    End If
        
    getFinderPatterns = retval

End Function

Public Function getNumFinder(ByVal numSegments As Long) As Long

    Dim retval As Long
    retval = 0

    If (numSegments = 4) Then
        retval = 2
    ElseIf (numSegments = 5 Or numSegments = 6) Then
        retval = 3
    ElseIf (numSegments = 7 Or numSegments = 8) Then
        retval = 4
    ElseIf (numSegments = 9 Or numSegments = 10) Then
        retval = 5
    ElseIf (numSegments = 11 Or numSegments = 12) Then
        retval = 6
    ElseIf (numSegments = 13 Or numSegments = 14) Then
        retval = 7
    ElseIf (numSegments = 15 Or numSegments = 16) Then
        retval = 8
    ElseIf (numSegments = 17 Or numSegments = 18) Then
        retval = 9
    ElseIf (numSegments = 19 Or numSegments = 20) Then
        retval = 10
    ElseIf (numSegments = 21 Or numSegments = 22) Then
        retval = 11
    End If
    
    getNumFinder = retval

End Function

Public Function getFinderPatternIndex(ByVal numSegments As Long) As Long

    Dim retval As Long
    retval = 0
    
    If (numSegments = 4) Then
        retval = 0
    ElseIf (numSegments = 5 Or numSegments = 6) Then
        retval = 1
    ElseIf (numSegments = 7 Or numSegments = 8) Then
        retval = 2
    ElseIf (numSegments = 9 Or numSegments = 10) Then
        retval = 3
    ElseIf (numSegments = 11 Or numSegments = 12) Then
        retval = 4
    ElseIf (numSegments = 13 Or numSegments = 14) Then
        retval = 5
    ElseIf (numSegments = 15 Or numSegments = 16) Then
        retval = 6
    ElseIf (numSegments = 17 Or numSegments = 18) Then
        retval = 7
    ElseIf (numSegments = 19 Or numSegments = 20) Then
        retval = 8
    ElseIf (numSegments = 21 Or numSegments = 22) Then
        retval = 9
    End If

    getFinderPatternIndex = retval

End Function


'======================================================================================================
'GS1 Databar Truncated
'======================================================================================================
Public Function Encode_GS1DatabarTruncated(ByVal data As String, Optional ByVal linkage As Integer = 0) As String

	Encode_GS1DatabarTruncated = Encode_GS1Databar14(data,linkage)

End Function


'======================================================================================================
'GS1 Databar-14 Stacked
'======================================================================================================
Public Function Encode_GS1DatabarStacked(ByVal data As String) As String

    Dim retString As String
    retString = Encode_GS1Databar14(data, 0)
    retString = ConvertToStacked(retString)
    
    Encode_GS1DatabarStacked = retString
        
End Function



Public Function ConvertToStacked(ByVal data As String)


        Dim singleDigits As String
        Dim singleDigitTop As String
        Dim singleDigitBottom As String
        Dim counter As Integer
        Dim x As Integer
        
        counter = 0
        Do While (counter < Len(data))
        

                If (Mid(data, counter + 1, 1) = "A") Then
                        singleDigits = singleDigits + "A"
                ElseIf (Mid(data, counter + 1, 1) = "B") Then
                        singleDigits = singleDigits + "AA"
                ElseIf (Mid(data, counter + 1, 1) = "C") Then
                        singleDigits = singleDigits + "AAA"
                ElseIf (Mid(data, counter + 1, 1) = "D") Then
                        singleDigits = singleDigits + "AAAA"
                ElseIf (Mid(data, counter + 1, 1) = "E") Then
                        singleDigits = singleDigits + "AAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "F") Then
                        singleDigits = singleDigits + "AAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "G") Then
                        singleDigits = singleDigits + "AAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "H") Then
                        singleDigits = singleDigits + "AAAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "I") Then
                        singleDigits = singleDigits + "AAAAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "a") Then
                        singleDigits = singleDigits + "a"
                ElseIf (Mid(data, counter + 1, 1) = "b") Then
                        singleDigits = singleDigits + "aa"
                ElseIf (Mid(data, counter + 1, 1) = "c") Then
                        singleDigits = singleDigits + "aaa"
                ElseIf (Mid(data, counter + 1, 1) = "d") Then
                        singleDigits = singleDigits + "aaaa"
                ElseIf (Mid(data, counter + 1, 1) = "e") Then
                        singleDigits = singleDigits + "aaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "f") Then
                        singleDigits = singleDigits + "aaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "g") Then
                        singleDigits = singleDigits + "aaaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "h") Then
                        singleDigits = singleDigits + "aaaaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "i") Then
                        singleDigits = singleDigits + "aaaaaaaaa"
                End If
                
                counter = counter + 1
        Loop
        counter = 0
        
        
        For x = 0 To 48 - 1
                singleDigitTop = singleDigitTop + Mid(singleDigits, x + 1, 1)
        Next x

        For x = 48 To 96 - 1
                singleDigitBottom = singleDigitBottom + Mid(singleDigits, x + 1, 1)
        Next x
        
        Dim result0 As String
        Dim result1 As String
        Dim result2 As String
        
        
        result0 = ""
        For y = 0 To 48 - 1
                result0 = result0 + Mid(singleDigitTop, y + 1, 1)
        Next y
        result0 = result0 + "Aa"
        

        result2 = "Aa"
        For y = 0 To 48 - 1
                result2 = result2 + Mid(singleDigitBottom, y + 1, 1)
        Next y

        
        'int row=1;
        result1 = "aaaa"
        For y = 4 To 46 - 1
        
                If ((Mid(result0, y + 1, 1) = Mid(result2, y + 1, 1)) And (Mid(result0, y + 1, 1) = "A")) Then
                        result1 = result1 + "a"
                ElseIf ((Mid(result0, y + 1, 1) = Mid(result2, y + 1, 1)) And (Mid(result0, y + 1, 1) = "a")) Then
                        result1 = result1 + "A"
                Else
                
                        If (Mid(result1, y - 1 + 1, 1) = "a") Then
                                result1 = result1 + "A"
                        ElseIf (Mid(result1, y - 1 + 1, 1) = "A") Then
                                result1 = result1 + "a"
                        End If
                
                End If
        
        Next y
        result1 = result1 + "aaaa"

        resultValue = 48
        Dim returnStr As String
        returnStr = ""
        
        For y = 0 To 50 - 1 Step 2
        
                If (Mid(result0, y + 1, 1) = "A") Then
                        resultValue = resultValue + 32
                End If
                        
                If (Mid(result0, y + 1 + 1, 1) = "A") Then
                         resultValue = resultValue + 16
                End If
                
                If (Mid(result1, y + 1, 1) = "A") Then
                        resultValue = resultValue + 8
                End If
                        
                If (Mid(result1, y + 1 + 1, 1) = "A") Then
                         resultValue = resultValue + 4
                End If
                                
                                
                If (Mid(result2, y + 1, 1) = "A") Then
                        resultValue = resultValue + 2
                End If
                        
                If (Mid(result2, y + 1 + 1, 1) = "A") Then
                         resultValue = resultValue + 1
                End If
                                
                       
                returnStr = returnStr + ChrW(resultValue)
                resultValue = 48 'reset
        
        Next y


        ConvertToStacked = returnStr
        
        


End Function



'======================================================================================================
'GS1 Databar-14 Stacked Omni
'======================================================================================================
Public Function Encode_GS1DatabarStackedOmni(ByVal data As String) As String

    Dim retString As String
    retString = Encode_GS1Databar14(data, 0)
    retString = ConvertToStackedOmni(retString)
    
    Encode_GS1DatabarStackedOmni = retString
        
End Function


Public Function ConvertToStackedOmni(ByVal data As String)


        Dim singleDigits As String
        Dim singleDigitTop As String
        Dim singleDigitBottom As String
        Dim counter As Integer
        Dim x As Integer
        
        counter = 0
        Do While (counter < Len(data))
        

                If (Mid(data, counter + 1, 1) = "A") Then
                        singleDigits = singleDigits + "A"
                ElseIf (Mid(data, counter + 1, 1) = "B") Then
                        singleDigits = singleDigits + "AA"
                ElseIf (Mid(data, counter + 1, 1) = "C") Then
                        singleDigits = singleDigits + "AAA"
                ElseIf (Mid(data, counter + 1, 1) = "D") Then
                        singleDigits = singleDigits + "AAAA"
                ElseIf (Mid(data, counter + 1, 1) = "E") Then
                        singleDigits = singleDigits + "AAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "F") Then
                        singleDigits = singleDigits + "AAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "G") Then
                        singleDigits = singleDigits + "AAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "H") Then
                        singleDigits = singleDigits + "AAAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "I") Then
                        singleDigits = singleDigits + "AAAAAAAAA"
                ElseIf (Mid(data, counter + 1, 1) = "a") Then
                        singleDigits = singleDigits + "a"
                ElseIf (Mid(data, counter + 1, 1) = "b") Then
                        singleDigits = singleDigits + "aa"
                ElseIf (Mid(data, counter + 1, 1) = "c") Then
                        singleDigits = singleDigits + "aaa"
                ElseIf (Mid(data, counter + 1, 1) = "d") Then
                        singleDigits = singleDigits + "aaaa"
                ElseIf (Mid(data, counter + 1, 1) = "e") Then
                        singleDigits = singleDigits + "aaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "f") Then
                        singleDigits = singleDigits + "aaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "g") Then
                        singleDigits = singleDigits + "aaaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "h") Then
                        singleDigits = singleDigits + "aaaaaaaa"
                ElseIf (Mid(data, counter + 1, 1) = "i") Then
                        singleDigits = singleDigits + "aaaaaaaaa"
                End If
                
                counter = counter + 1
        Loop
        counter = 0
        
        



        
        
        For x = 0 To 48 - 1
                singleDigitTop = singleDigitTop + Mid(singleDigits, x + 1, 1)
        Next x

        For x = 48 To 96 - 1
                singleDigitBottom = singleDigitBottom + Mid(singleDigits, x + 1, 1)
        Next x
        
    
        
        Dim result0 As String
        Dim result1 As String
        Dim result2 As String
        Dim result3 As String
        Dim result4 As String
        Dim previous As String
        
        
        result0 = ""
        For y = 0 To 48 - 1
                result0 = result0 + Mid(singleDigitTop, y + 1, 1)
        Next y
        result0 = result0 + "Aa"
        
        

        result4 = "Aa"
        For y = 0 To 48 - 1
                result4 = result4 + Mid(singleDigitBottom, y + 1, 1)
        Next y
        
        
        
        'int row=1;
        result1 = "aaaa"
        previous = "A"
        For y = 4 To 46 - 1
        
        
            If ((y >= 18) And (y <= 30)) Then
        
                If (AscW(Mid(result0, y + 1, 1)) = AscW("A")) Then
                
                    previous = "A"
                    result1 = result1 + "a"
                
                ElseIf (AscW(Mid(result0, y + 1, 1)) = AscW("a")) Then
                
                    result1 = result1 + previous
                    If (previous = "A") Then
                        previous = "a"
                    Else
                        previous = "A"
                    End If
                
                End If
        
            Else
        
                If (AscW(Mid(result0, y + 1, 1)) = AscW("A")) Then
                    result1 = result1 + "a"
                ElseIf (AscW(Mid(result0, y + 1, 1)) = AscW("a")) Then
                    result1 = result1 + "A"
                End If
        
            End If
        
        Next y
        result1 = result1 + "aaaa"
        
       
        result2 = "aaaaaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaAaaaa"

        Dim findervalue3 As Integer
        Dim findervalue3arr() As Variant
        Dim specialShiftArr() As Variant
        
       'row=3;
        findervalue3 = 1 'true
        findervalue3arr = Array(AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("A"), AscW("a"), AscW("A"), AscW("A"), AscW("A"))
        
        For y = 19 To 32 - 1
        
            If (AscW(Mid(result4, y + 1, 1)) <> findervalue3arr(y - 19)) Then
            
                findervalue3 = 0 'false
                Exit For
            
            End If
        
        Next y
        result3 = "aaaa"
        
        
        
        Dim swing As String
    
        swing = "A"
        For y = 4 To 46 - 1
        
            If ((y >= 4) And (y <= 16)) Then
            
                If (Mid(result4, y + 1, 1) = "a") Then
                    result3 = result3 + "A"
                Else
                    result3 = result3 + "a"
                End If
            
            End If
            
            If ((y >= 17) And (y <= 18)) Then
            
                If (Mid(result4, y + 1, 1) = "a") Then
                    result3 = result3 + "A"
                Else
                    result3 = result3 + "a"
                End If
            
            End If
    

    
            If ((y >= 19) And (y <= 31)) Then
            
                If (findervalue3 = 0) Then 'false
                
                    If (Mid(result4, y + 1, 1) = "a") Then 'space alt dark light
                    
                        result3 = result3 + swing
                        If (swing = "A") Then
                            swing = "a"
                        Else
                            swing = "A"
                        End If
                    
                    Else  'bars
                    
                        swing = "A" 'reset
                        result3 = result3 + "a"
                    
                    End If
                
                Else
                    
                    specialShiftArr = Array(AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("a"), AscW("A"), AscW("a"), AscW("a"))
                    result3 = result3 + Chr(specialShiftArr(y - 19))
                
                End If
                
            End If
    
            If ((y >= 32) And (y <= 45)) Then
            
                If (Mid(result4, y + 1, 1) = "a") Then
                    result3 = result3 + "A"
                Else
                    result3 = result3 + "a"
                End If
            
            End If
    
        Next y
        result3 = result3 + "aaaa"


        resultValue = 48
        Dim returnStr As String
        Dim debugStr As String
        returnStr = ""
        
        For y = 0 To 50 - 1
        
                If (Mid(result0, y + 1, 1) = "A") Then
                        resultValue = resultValue + 16
                End If
                                
                If (Mid(result1, y + 1, 1) = "A") Then
                        resultValue = resultValue + 8
                End If
                        
                If (Mid(result2, y + 1, 1) = "A") Then
                        resultValue = resultValue + 4
                End If
                
                If (Mid(result3, y + 1, 1) = "A") Then
                        resultValue = resultValue + 2
                End If

                If (Mid(result4, y + 1, 1) = "A") Then
                        resultValue = resultValue + 1
                End If
                       
                returnStr = returnStr + Chr(resultValue)
                resultValue = 48 'reset
        
        Next y

        ConvertToStackedOmni = returnStr

End Function


'===============================================================================================================
'GS1 Databar 14 Expanded Stacked
'===============================================================================================================
'Limitations :- Because this is a Stacked (Multiline) font, the results produced by this formula cannot be used 
'directly in  Excel. The results have to be copied to MS Word or Wordpad for printing. The recommended font size
'for the Expanded Stacked Font (CCodeGS1DEST) is 48, however, you may reduce it down to 28 if necessary.
'===============================================================================================================

Public Function Encode_GS1DatabarExpandedStacked(ByVal data As String, Optional ByVal numSegmentsPerRow As Integer = 4, Optional ByVal alinkageFlag As Long = 0) As String

    'State Variables
    Dim compactionResult As String
    Dim encodationResult As String
    Dim errorMsg As String
    Dim linkageFlag As Long
    
    Dim widthsodd(22, 4), widthseven(22, 4) As Long
    Dim resultsodd(22, 4), resultseven(22, 4) As Long
    Dim checkwidthsodd(4), checkwidthseven(4) As Long
        
    Dim numData, numSegments As Long
    

    Dim datachar(22) As Long
    

    linkageFlag = alinkageFlag 'Save state for class use.
    errorMsg = ""

    Dim cd, result, filtereddata As String
    Dim retval As Long
    
    'or use currency ?
    Dim value As Long
    Dim sum, checksum As Long
    
    
    Dim CHECKSUMEXPANDED(23, 8) As Long
    
    CHECKSUMEXPANDED(0, 0) = 1
    CHECKSUMEXPANDED(0, 1) = 3
    CHECKSUMEXPANDED(0, 2) = 9
    CHECKSUMEXPANDED(0, 3) = 27
    CHECKSUMEXPANDED(0, 4) = 81
    CHECKSUMEXPANDED(0, 5) = 32
    CHECKSUMEXPANDED(0, 6) = 96
    CHECKSUMEXPANDED(0, 7) = 77
    
    CHECKSUMEXPANDED(1, 0) = 20
    CHECKSUMEXPANDED(1, 1) = 60
    CHECKSUMEXPANDED(1, 2) = 180
    CHECKSUMEXPANDED(1, 3) = 118
    CHECKSUMEXPANDED(1, 4) = 143
    CHECKSUMEXPANDED(1, 5) = 7
    CHECKSUMEXPANDED(1, 6) = 21
    CHECKSUMEXPANDED(1, 7) = 63
    
    CHECKSUMEXPANDED(2, 0) = 189
    CHECKSUMEXPANDED(2, 1) = 145
    CHECKSUMEXPANDED(2, 2) = 13
    CHECKSUMEXPANDED(2, 3) = 39
    CHECKSUMEXPANDED(2, 4) = 117
    CHECKSUMEXPANDED(2, 5) = 140
    CHECKSUMEXPANDED(2, 6) = 209
    CHECKSUMEXPANDED(2, 7) = 205
    
    CHECKSUMEXPANDED(3, 0) = 193
    CHECKSUMEXPANDED(3, 1) = 157
    CHECKSUMEXPANDED(3, 2) = 49
    CHECKSUMEXPANDED(3, 3) = 147
    CHECKSUMEXPANDED(3, 4) = 19
    CHECKSUMEXPANDED(3, 5) = 57
    CHECKSUMEXPANDED(3, 6) = 171
    CHECKSUMEXPANDED(3, 7) = 91
    
    CHECKSUMEXPANDED(4, 0) = 62
    CHECKSUMEXPANDED(4, 1) = 186
    CHECKSUMEXPANDED(4, 2) = 136
    CHECKSUMEXPANDED(4, 3) = 197
    CHECKSUMEXPANDED(4, 4) = 169
    CHECKSUMEXPANDED(4, 5) = 85
    CHECKSUMEXPANDED(4, 6) = 44
    CHECKSUMEXPANDED(4, 7) = 132
        
    CHECKSUMEXPANDED(5, 0) = 185
    CHECKSUMEXPANDED(5, 1) = 133
    CHECKSUMEXPANDED(5, 2) = 188
    CHECKSUMEXPANDED(5, 3) = 142
    CHECKSUMEXPANDED(5, 4) = 4
    CHECKSUMEXPANDED(5, 5) = 12
    CHECKSUMEXPANDED(5, 6) = 36
    CHECKSUMEXPANDED(5, 7) = 108
        
    CHECKSUMEXPANDED(6, 0) = 113
    CHECKSUMEXPANDED(6, 1) = 128
    CHECKSUMEXPANDED(6, 2) = 173
    CHECKSUMEXPANDED(6, 3) = 97
    CHECKSUMEXPANDED(6, 4) = 80
    CHECKSUMEXPANDED(6, 5) = 29
    CHECKSUMEXPANDED(6, 6) = 87
    CHECKSUMEXPANDED(6, 7) = 50
    
    CHECKSUMEXPANDED(7, 0) = 150
    CHECKSUMEXPANDED(7, 1) = 28
    CHECKSUMEXPANDED(7, 2) = 84
    CHECKSUMEXPANDED(7, 3) = 41
    CHECKSUMEXPANDED(7, 4) = 123
    CHECKSUMEXPANDED(7, 5) = 158
    CHECKSUMEXPANDED(7, 6) = 52
    CHECKSUMEXPANDED(7, 7) = 156
        
    CHECKSUMEXPANDED(8, 0) = 46
    CHECKSUMEXPANDED(8, 1) = 138
    CHECKSUMEXPANDED(8, 2) = 203
    CHECKSUMEXPANDED(8, 3) = 187
    CHECKSUMEXPANDED(8, 4) = 139
    CHECKSUMEXPANDED(8, 5) = 206
    CHECKSUMEXPANDED(8, 6) = 196
    CHECKSUMEXPANDED(8, 7) = 166
    
    CHECKSUMEXPANDED(9, 0) = 76
    CHECKSUMEXPANDED(9, 1) = 17
    CHECKSUMEXPANDED(9, 2) = 51
    CHECKSUMEXPANDED(9, 3) = 153
    CHECKSUMEXPANDED(9, 4) = 37
    CHECKSUMEXPANDED(9, 5) = 111
    CHECKSUMEXPANDED(9, 6) = 122
    CHECKSUMEXPANDED(9, 7) = 155
    
    CHECKSUMEXPANDED(10, 0) = 43
    CHECKSUMEXPANDED(10, 1) = 129
    CHECKSUMEXPANDED(10, 2) = 176
    CHECKSUMEXPANDED(10, 3) = 106
    CHECKSUMEXPANDED(10, 4) = 107
    CHECKSUMEXPANDED(10, 5) = 110
    CHECKSUMEXPANDED(10, 6) = 119
    CHECKSUMEXPANDED(10, 7) = 146
    
    CHECKSUMEXPANDED(11, 0) = 16
    CHECKSUMEXPANDED(11, 1) = 48
    CHECKSUMEXPANDED(11, 2) = 144
    CHECKSUMEXPANDED(11, 3) = 10
    CHECKSUMEXPANDED(11, 4) = 30
    CHECKSUMEXPANDED(11, 5) = 90
    CHECKSUMEXPANDED(11, 6) = 59
    CHECKSUMEXPANDED(11, 7) = 177
    
    CHECKSUMEXPANDED(12, 0) = 109
    CHECKSUMEXPANDED(12, 1) = 116
    CHECKSUMEXPANDED(12, 2) = 137
    CHECKSUMEXPANDED(12, 3) = 200
    CHECKSUMEXPANDED(12, 4) = 178
    CHECKSUMEXPANDED(12, 5) = 112
    CHECKSUMEXPANDED(12, 6) = 125
    CHECKSUMEXPANDED(12, 7) = 164
    
    CHECKSUMEXPANDED(13, 0) = 70
    CHECKSUMEXPANDED(13, 1) = 210
    CHECKSUMEXPANDED(13, 2) = 208
    CHECKSUMEXPANDED(13, 3) = 202
    CHECKSUMEXPANDED(13, 4) = 184
    CHECKSUMEXPANDED(13, 5) = 130
    CHECKSUMEXPANDED(13, 6) = 179
    CHECKSUMEXPANDED(13, 7) = 115
    
    CHECKSUMEXPANDED(14, 0) = 134
    CHECKSUMEXPANDED(14, 1) = 191
    CHECKSUMEXPANDED(14, 2) = 151
    CHECKSUMEXPANDED(14, 3) = 31
    CHECKSUMEXPANDED(14, 4) = 93
    CHECKSUMEXPANDED(14, 5) = 68
    CHECKSUMEXPANDED(14, 6) = 204
    CHECKSUMEXPANDED(14, 7) = 190
    
    CHECKSUMEXPANDED(15, 0) = 148
    CHECKSUMEXPANDED(15, 1) = 22
    CHECKSUMEXPANDED(15, 2) = 66
    CHECKSUMEXPANDED(15, 3) = 198
    CHECKSUMEXPANDED(15, 4) = 172
    CHECKSUMEXPANDED(15, 5) = 94
    CHECKSUMEXPANDED(15, 6) = 71
    CHECKSUMEXPANDED(15, 7) = 2
    
    CHECKSUMEXPANDED(16, 0) = 6
    CHECKSUMEXPANDED(16, 1) = 18
    CHECKSUMEXPANDED(16, 2) = 54
    CHECKSUMEXPANDED(16, 3) = 162
    CHECKSUMEXPANDED(16, 4) = 64
    CHECKSUMEXPANDED(16, 5) = 192
    CHECKSUMEXPANDED(16, 6) = 154
    CHECKSUMEXPANDED(16, 7) = 40
    
    CHECKSUMEXPANDED(17, 0) = 120
    CHECKSUMEXPANDED(17, 1) = 149
    CHECKSUMEXPANDED(17, 2) = 25
    CHECKSUMEXPANDED(17, 3) = 75
    CHECKSUMEXPANDED(17, 4) = 14
    CHECKSUMEXPANDED(17, 5) = 42
    CHECKSUMEXPANDED(17, 6) = 126
    CHECKSUMEXPANDED(17, 7) = 167
    
    CHECKSUMEXPANDED(18, 0) = 79
    CHECKSUMEXPANDED(18, 1) = 26
    CHECKSUMEXPANDED(18, 2) = 78
    CHECKSUMEXPANDED(18, 3) = 23
    CHECKSUMEXPANDED(18, 4) = 69
    CHECKSUMEXPANDED(18, 5) = 207
    CHECKSUMEXPANDED(18, 6) = 199
    CHECKSUMEXPANDED(18, 7) = 175
    
    CHECKSUMEXPANDED(19, 0) = 103
    CHECKSUMEXPANDED(19, 1) = 98
    CHECKSUMEXPANDED(19, 2) = 83
    CHECKSUMEXPANDED(19, 3) = 38
    CHECKSUMEXPANDED(19, 4) = 114
    CHECKSUMEXPANDED(19, 5) = 131
    CHECKSUMEXPANDED(19, 6) = 182
    CHECKSUMEXPANDED(19, 7) = 124
    
    CHECKSUMEXPANDED(20, 0) = 161
    CHECKSUMEXPANDED(20, 1) = 61
    CHECKSUMEXPANDED(20, 2) = 183
    CHECKSUMEXPANDED(20, 3) = 127
    CHECKSUMEXPANDED(20, 4) = 170
    CHECKSUMEXPANDED(20, 5) = 88
    CHECKSUMEXPANDED(20, 6) = 53
    CHECKSUMEXPANDED(20, 7) = 159
    
    CHECKSUMEXPANDED(21, 0) = 55
    CHECKSUMEXPANDED(21, 1) = 165
    CHECKSUMEXPANDED(21, 2) = 73
    CHECKSUMEXPANDED(21, 3) = 8
    CHECKSUMEXPANDED(21, 4) = 24
    CHECKSUMEXPANDED(21, 5) = 72
    CHECKSUMEXPANDED(21, 6) = 5
    CHECKSUMEXPANDED(21, 7) = 15
    
    CHECKSUMEXPANDED(22, 0) = 45
    CHECKSUMEXPANDED(22, 1) = 135
    CHECKSUMEXPANDED(22, 2) = 194
    CHECKSUMEXPANDED(22, 3) = 160
    CHECKSUMEXPANDED(22, 4) = 58
    CHECKSUMEXPANDED(22, 5) = 174
    CHECKSUMEXPANDED(22, 6) = 100
    CHECKSUMEXPANDED(22, 7) = 89

    
    Dim FINDERPATTERN(10, 11) As String

    FINDERPATTERN(0, 0) = "A1"
    FINDERPATTERN(0, 1) = "A2"
    FINDERPATTERN(0, 2) = ""
    FINDERPATTERN(0, 3) = ""
    FINDERPATTERN(0, 4) = ""
    FINDERPATTERN(0, 5) = ""
    FINDERPATTERN(0, 6) = ""
    FINDERPATTERN(0, 7) = ""
    FINDERPATTERN(0, 8) = ""
    FINDERPATTERN(0, 9) = ""
    FINDERPATTERN(0, 10) = ""
    
    FINDERPATTERN(1, 0) = "A1"
    FINDERPATTERN(1, 1) = "B2"
    FINDERPATTERN(1, 2) = "B1"
    FINDERPATTERN(1, 3) = ""
    FINDERPATTERN(1, 4) = ""
    FINDERPATTERN(1, 5) = ""
    FINDERPATTERN(1, 6) = ""
    FINDERPATTERN(1, 7) = ""
    FINDERPATTERN(1, 8) = ""
    FINDERPATTERN(1, 9) = ""
    FINDERPATTERN(1, 10) = ""
    
    FINDERPATTERN(2, 0) = "A1"
    FINDERPATTERN(2, 1) = "C2"
    FINDERPATTERN(2, 2) = "B1"
    FINDERPATTERN(2, 3) = "D2"
    FINDERPATTERN(2, 4) = ""
    FINDERPATTERN(2, 5) = ""
    FINDERPATTERN(2, 6) = ""
    FINDERPATTERN(2, 7) = ""
    FINDERPATTERN(2, 8) = ""
    FINDERPATTERN(2, 9) = ""
    FINDERPATTERN(2, 10) = ""
    
    
    FINDERPATTERN(3, 0) = "A1"
    FINDERPATTERN(3, 1) = "E2"
    FINDERPATTERN(3, 2) = "B1"
    FINDERPATTERN(3, 3) = "D2"
    FINDERPATTERN(3, 4) = "C1"
    FINDERPATTERN(3, 5) = ""
    FINDERPATTERN(3, 6) = ""
    FINDERPATTERN(3, 7) = ""
    FINDERPATTERN(3, 8) = ""
    FINDERPATTERN(3, 9) = ""
    FINDERPATTERN(3, 10) = ""
    
    FINDERPATTERN(4, 0) = "A1"
    FINDERPATTERN(4, 1) = "E2"
    FINDERPATTERN(4, 2) = "B1"
    FINDERPATTERN(4, 3) = "D2"
    FINDERPATTERN(4, 4) = "D1"
    FINDERPATTERN(4, 5) = "F2"
    FINDERPATTERN(4, 6) = ""
    FINDERPATTERN(4, 7) = ""
    FINDERPATTERN(4, 8) = ""
    FINDERPATTERN(4, 9) = ""
    FINDERPATTERN(4, 10) = ""
    
    FINDERPATTERN(5, 0) = "A1"
    FINDERPATTERN(5, 1) = "E2"
    FINDERPATTERN(5, 2) = "B1"
    FINDERPATTERN(5, 3) = "D2"
    FINDERPATTERN(5, 4) = "E1"
    FINDERPATTERN(5, 5) = "F2"
    FINDERPATTERN(5, 6) = "F1"
    FINDERPATTERN(5, 7) = ""
    FINDERPATTERN(5, 8) = ""
    FINDERPATTERN(5, 9) = ""
    FINDERPATTERN(5, 10) = ""
    
    FINDERPATTERN(6, 0) = "A1"
    FINDERPATTERN(6, 1) = "A2"
    FINDERPATTERN(6, 2) = "B1"
    FINDERPATTERN(6, 3) = "B2"
    FINDERPATTERN(6, 4) = "C1"
    FINDERPATTERN(6, 5) = "C2"
    FINDERPATTERN(6, 6) = "D1"
    FINDERPATTERN(6, 7) = "D2"
    FINDERPATTERN(6, 8) = ""
    FINDERPATTERN(6, 9) = ""
    FINDERPATTERN(6, 10) = ""
    
    FINDERPATTERN(7, 0) = "A1"
    FINDERPATTERN(7, 1) = "A2"
    FINDERPATTERN(7, 2) = "B1"
    FINDERPATTERN(7, 3) = "B2"
    FINDERPATTERN(7, 4) = "C1"
    FINDERPATTERN(7, 5) = "C2"
    FINDERPATTERN(7, 6) = "D1"
    FINDERPATTERN(7, 7) = "E2"
    FINDERPATTERN(7, 8) = "E1"
    FINDERPATTERN(7, 9) = ""
    FINDERPATTERN(7, 10) = ""
    
    FINDERPATTERN(8, 0) = "A1"
    FINDERPATTERN(8, 1) = "A2"
    FINDERPATTERN(8, 2) = "B1"
    FINDERPATTERN(8, 3) = "B2"
    FINDERPATTERN(8, 4) = "C1"
    FINDERPATTERN(8, 5) = "C2"
    FINDERPATTERN(8, 6) = "D1"
    FINDERPATTERN(8, 7) = "E2"
    FINDERPATTERN(8, 8) = "F1"
    FINDERPATTERN(8, 9) = "F2"
    FINDERPATTERN(8, 10) = ""
    
    FINDERPATTERN(9, 0) = "A1"
    FINDERPATTERN(9, 1) = "A2"
    FINDERPATTERN(9, 2) = "B1"
    FINDERPATTERN(9, 3) = "B2"
    FINDERPATTERN(9, 4) = "C1"
    FINDERPATTERN(9, 5) = "D2"
    FINDERPATTERN(9, 6) = "D1"
    FINDERPATTERN(9, 7) = "E2"
    FINDERPATTERN(9, 8) = "E1"
    FINDERPATTERN(9, 9) = "F2"
    FINDERPATTERN(9, 10) = "F1"
    
    
    Dim FINDERS1(6, 5) As Long
    Dim FINDERS2(6, 5) As Long

    'FINDERS1
    FINDERS1(0, 0) = 1
    FINDERS1(0, 1) = 8
    FINDERS1(0, 2) = 4
    FINDERS1(0, 3) = 1
    FINDERS1(0, 4) = 1
     
    FINDERS1(1, 0) = 3
    FINDERS1(1, 1) = 6
    FINDERS1(1, 2) = 4
    FINDERS1(1, 3) = 1
    FINDERS1(1, 4) = 1
      
    FINDERS1(2, 0) = 3
    FINDERS1(2, 1) = 4
    FINDERS1(2, 2) = 6
    FINDERS1(2, 3) = 1
    FINDERS1(2, 4) = 1
      
    FINDERS1(3, 0) = 3
    FINDERS1(3, 1) = 2
    FINDERS1(3, 2) = 8
    FINDERS1(3, 3) = 1
    FINDERS1(3, 4) = 1
     
    FINDERS1(4, 0) = 2
    FINDERS1(4, 1) = 6
    FINDERS1(4, 2) = 5
    FINDERS1(4, 3) = 1
    FINDERS1(4, 4) = 1
     
    FINDERS1(5, 0) = 2
    FINDERS1(5, 1) = 2
    FINDERS1(5, 2) = 9
    FINDERS1(5, 3) = 1
    FINDERS1(5, 4) = 1
     
    
    'FINDERS2
    FINDERS2(0, 0) = 1
    FINDERS2(0, 1) = 1
    FINDERS2(0, 2) = 4
    FINDERS2(0, 3) = 8
    FINDERS2(0, 4) = 1
     
    FINDERS2(1, 0) = 1
    FINDERS2(1, 1) = 1
    FINDERS2(1, 2) = 4
    FINDERS2(1, 3) = 6
    FINDERS2(1, 4) = 3
     
    FINDERS2(2, 0) = 1
    FINDERS2(2, 1) = 1
    FINDERS2(2, 2) = 6
    FINDERS2(2, 3) = 4
    FINDERS2(2, 4) = 3
     
    FINDERS2(3, 0) = 1
    FINDERS2(3, 1) = 1
    FINDERS2(3, 2) = 8
    FINDERS2(3, 3) = 2
    FINDERS2(3, 4) = 3
     
    FINDERS2(4, 0) = 1
    FINDERS2(4, 1) = 1
    FINDERS2(4, 2) = 5
    FINDERS2(4, 3) = 6
    FINDERS2(4, 4) = 2
     
    FINDERS2(5, 0) = 1
    FINDERS2(5, 1) = 1
    FINDERS2(5, 2) = 9
    FINDERS2(5, 3) = 2
    FINDERS2(5, 4) = 2

    
    cd = ""
    result = ""
    filtereddata = filterInput__GS1DatabarExpanded(data)
    
    Dim checkCharacter, numFinder, dataCounter, filteredlength As Long
    
    filteredlength = Len(filtereddata)
    
    If (filteredlength > 200) Then
        filtereddata = Left(filtereddata, 200) 'This is max length input supported. the variable encodation will reject data that exceed the encodation length.
    End If

       
    
    Dim nx As Long
    filtereddata = encodationMethodStacked(filtereddata, nx, numSegments, encodationResult, compactionResult, errorMsg, linkageFlag, datachar, numSegmentsPerRow)
    numData = nx
    Debug.Print errorMsg
     
    
     
    humanText = filtereddata
    sum = 0
    
    If (errorMsg <> "") Then
    
        Encode_GS1DatabarExpandedStacked = ""
        Exit Function
    
    End If

    Dim wwodd(4) As Long
    Dim wweven(4) As Long
    Dim z As Integer
        
    For x = 0 To numData - 1
        
        retval = getGS1WExpanded(datachar(x), 1, 17, wwodd)
        
        retval = getGS1WExpanded(datachar(x), 0, 17, wweven)
        
        For z = 0 To 3
            widthsodd(x, z) = wwodd(z)
            widthseven(x, z) = wweven(z)
        Next z
        
    
    Next x
    
    
    
    Dim sequenceIndex As Long
    Dim toggle As String
    Dim checksumptr As Long
    For x = 0 To numData - 1
    
        
        toggle = " Left"
        
        If (x = 0) Then
        
            sequenceIndex = x
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Right")
        
        
        ElseIf (x > 0 And (x Mod 2 = 0)) Then
        
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Right")
        
        ElseIf (x > 0 And (x Mod 2 = 1)) Then
        
            sequenceIndex = sequenceIndex + 1
            checksumptr = getCheckSumWeights(FINDERPATTERN(getFinderPatternIndex(numSegments), sequenceIndex) + " Left")
        
        End If

        
        'TRACE("Chechsum Weights\n");
        'For y = 0 To 3
            'TRACE("%d,%d,",checksumptr[(y*2)],checksumptr[(y*2)+1]);
        'Next y
        

        For y = 0 To 3
        
        'TRACE("%ld,%ld,",widthsodd[x][y],widthseven[x][y]);
            resultsodd(x, y) = widthsodd(x, y)
            resultseven(x, y) = widthseven(x, y)
            sum = sum + CHECKSUMEXPANDED(checksumptr, (y * 2)) * widthsodd(x, y) + CHECKSUMEXPANDED(checksumptr, ((y * 2) + 1)) * widthseven(x, y)
        
        Next y
        'TRACE("\nSum %ld\n",sum);
    
    Next x
    
    'TRACE("\n");

    checksum = sum Mod 211
    'TRACE("CheckSum %d\n",(sum % 211));
    'MsgBox "CheckSum " + Str(checksum)

    'checkCharacter = 211*(numSegments-4) + 98;
    checkCharacter = 211 * (numSegments - 4) + checksum
    
    'MsgBox checkCharacter
    
    'retval = getGS1WExpanded(checkCharacter, 1, 17, checkwidthsodd)
     retval = getGS1WExpanded(checkCharacter, 1, 17, wwodd)
    'TRACE("Check Character :");
     retval = getGS1WExpanded(checkCharacter, 0, 17, wweven)
    'retval = getGS1WExpanded(checkCharacter, 0, 17, checkwidthseven)
    For z = 0 To 3
            checkwidthsodd(z) = wwodd(z)
            checkwidthseven(z) = wweven(z)
    Next z
    

    result = "11"  'Left Guard
    For x = 0 To 3
    
        'TRACE("%ld,%ld,",checkwidthsodd[x],checkwidthseven[x]);
        
        result = result + ChrW(Int(checkwidthsodd(x) + 48)) + ChrW(Int(checkwidthseven(x) + 48))
        
    Next x
    
    

    Dim patternptr As String
    Dim patternsequenceptr As Long
    Dim findersnum As Long
    
    
    'patternptr = FINDERPATTERN(getFinderPatternIndex(numSegments))
    numFinder = getNumFinder(numSegments)
    dataCounter = 0
    For x = 0 To numFinder - 1
    
        'TRACE("%s,",patternptr[x]);
        'patternsequenceptr = getFinderPatterns(patternptr(x))
        patternsequenceptr = getFinderPatterns(FINDERPATTERN(getFinderPatternIndex(numSegments), x), findersnum)
        For y = 0 To 4
        
            If (findersnum = 1) Then
                result = result + ChrW(Int(FINDERS1(patternsequenceptr, y) + 48))
            Else
                result = result + ChrW(Int(FINDERS2(patternsequenceptr, y) + 48))
            End If
            'TRACE("%d,",patternsequenceptr[y]);
        
        Next y
        
        
        'Print two data
        If (dataCounter < numData) Then
        
            For y = 3 To 0 Step -1 'mirror
                result = result + ChrW(Int(widthseven(x * 2, y) + 48)) + ChrW(Int(widthsodd(x * 2, y) + 48))
            Next y
            dataCounter = dataCounter + 1
        
        End If
        
        If (dataCounter < numData) Then
        
            For y = 0 To 3
                result = result + ChrW(Int(widthsodd(x * 2 + 1, y) + 48)) + ChrW(Int(widthseven(x * 2 + 1, y) + 48))
            Next y
            dataCounter = dataCounter + 1
        End If
    
    Next x

    
    result = result + "11" 'Right Guard
    
    

    'Convert to White Black White Black
    bwresult = ""
    black = 0
    For x = 0 To Len(result) - 1
    
        If (black = 0) Then
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 48)
            black = 1
        
        Else
        
            bwresult = bwresult + ChrW(AscW(Mid(result, x + 1, 1)) + 16)
            black = 0
        
        End If

    
    Next x
    
    'Debug.Print "BWResult : " + bwresult
       
    Dim stackedString As String
    stackedString = convertExpandedToStacked(bwresult, numSegmentsPerRow, numSegments)
    Encode_GS1DatabarExpandedStacked = stackedString
    
    
End Function


Public Function padStacked(ByVal data As String, ByRef encodationResult As String, ByRef state As String, ByVal numSegmentsPerRow As Integer) As String

        'Debug.Print "Padding Started"
        'Debug.Print "data : " + data
        'Debug.Print "ed : " + encodationResult
        'Debug.Print "state : " + state
    
        Dim result As String
        result = data
        
        Dim symbolbitslength, nextFactor, numBitsLeft As Integer
        symbolbitslength = Len(encodationResult) + Len(data)
    
        Dim tempNumSegments As Long
        
        If (symbolbitslength Mod 12 = 0) Then
        
            'Debug.Print "Fit Exactly" 'Pad not Required
            tempNumSegments = (symbolbitslength / 12) + 1 '1 for check char
    
            If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
            
                    result = data
                    If (state = "Numeric") Then
                        result = result + "000000100001"
                    Else
                        result = result + "001000010000"
                    End If
            
            End If
        
        Else
        
            nextFactor = Int(symbolbitslength / 12) + 1
            numBitsLeft = nextFactor * 12 - symbolbitslength
            result = data

            tempNumSegments = Int(symbolbitslength / 12) + 1 + 1 '1 for check char, 1 for next factor

            Do While (numBitsLeft > 0)
            
            If (state = "Numeric") Then
            
                'Debug.Print "numBitsLeft " + Str(numBitsLeft) 'Pad not Required
                'Debug.Print "symbolbitslength " + " " + Str(symbolbitslength) + " " + Str(Len(encodationResult)) + " " + Str(Len(data)) 'Pad not Required
                
                If (numBitsLeft > 3) Then
                
                    result = result + "0000"
                    numBitsLeft = numBitsLeft - 4
                    state = "Alpha"
                    If (numBitsLeft = 0) And (tempNumSegments Mod numSegmentsPerRow = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "001000010000"
                    End If
                
                
                ElseIf (numBitsLeft = 3) Then
                
                    result = result + "000"
                    numBitsLeft = numBitsLeft - 3
                    state = "Alpha"
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "000100001000"
                    End If
                    
                                
                ElseIf (numBitsLeft = 2) Then
                
                    result = result + "00"
                    numBitsLeft = numBitsLeft - 2
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "000010000100"
                    End If
                
                ElseIf (numBitsLeft = 1) Then
                
                    result = result + "0"
                    numBitsLeft = numBitsLeft - 1
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "000001000010"
                    End If
                
                End If
            
            Else
            
                If (numBitsLeft >= 5) Then
                
                    result = result + "00100"
                    numBitsLeft = numBitsLeft - 5
                    If ((numBitsLeft = 0) And ((tempNumSegments Mod numSegmentsPerRow) = 1)) Then 'Leftover of 1 segments need to add 1
                        result = result + "001000010000"
                    End If
                
                ElseIf (numBitsLeft = 4) Then
                
                    result = result + "0010"
                    numBitsLeft = numBitsLeft - 4
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "000100001000"
                    End If
                
                ElseIf (numBitsLeft = 3) Then
                
                    result = result + "001"
                    numBitsLeft = numBitsLeft - 3
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "000010000100"
                    End If
                
                ElseIf (numBitsLeft = 2) Then
                
                    result = result + "00"
                    numBitsLeft = numBitsLeft - 2
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "100001000010"
                    End If
                
                ElseIf (numBitsLeft = 1) Then
                
                    result = result + "0"
                    numBitsLeft = numBitsLeft - 1
                    If ((tempNumSegments Mod numSegmentsPerRow) = 1) Then 'Leftover of 1 segments need to add 1
                        result = result + "010000100001"
                    End If
                
                End If
                
            End If
            Loop 'While
        
        End If
        'Stacked 090108 End
        'Stacked 090108 End
        'Stacked 090108 End
    
    padStacked = result
    
End Function




Public Function ReverseAlternating(ByRef stackedResultSingle() As Variant, ByVal row As Long)

    Dim alternating As String
    Dim location As Long
    Dim x As Long
    alternating = "A"
    location = -10
    For x = Len(stackedResultSingle(row)) - 1 To 0 Step -1
    
        If (Mid(stackedResultSingle(row), x + 1, 1) = "z") Then
        
            If (location = x + 1) Then
            
                
                'stackedResultSingle(row).SetAt(x,alternating)
                stackedResultSingle(row) = Application.WorksheetFunction.Replace(stackedResultSingle(row), x + 1, 1, alternating)
                location = x
                If (alternating = "A") Then
                    alternating = "a"
                Else
                    alternating = "A"
                End If
            
            Else
            
                alternating = "A" 'reset
                location = x
                'stackedResultSingle(row).SetAt(x,alternating)
                stackedResultSingle(row) = Application.WorksheetFunction.Replace(stackedResultSingle(row), x + 1, 1, alternating)
                alternating = "a"
            
            End If
        
        End If
    
    Next x
    
End Function


Public Function performReverseUpperSeparator(ByRef stackedResultSingle() As Variant, ByVal z As Long, ByVal a As Long, ByRef doubleSeventeenCounter As Long, ByRef foundVersion As Long, ByRef alternating As String, ByRef previous As Long)

                Dim foundFinder As String
                If (doubleSeventeenCounter = 34) Then 'Detect only at first point
                                            
                        foundFinder = Mid(stackedResultSingle(z * 4), a + 1, 15)
                        'Reverse Images
                        If (foundFinder = "aAaaaaAAAAAAAAa" Or _
                            foundFinder = "aAaaaaAAAAAAaaa" Or _
                            foundFinder = "aAaaaaaaAAAAaaa" Or _
                            foundFinder = "aAaaaaaaaaAAaaa" Or _
                            foundFinder = "aAaaaaaAAAAAAaa" Or _
                            foundFinder = "aAaaaaaaaaaAAaa") Then
                            foundVersion = 1
                        End If
                        If (foundFinder = "AaaaaaaaaAAAAaA" Or _
                            foundFinder = "AAAaaaaaaAAAAaA" Or _
                            foundFinder = "AAAaaaaAAAAAAaA" Or _
                            foundFinder = "AAAaaAAAAAAAAaA" Or _
                            foundFinder = "AAaaaaaaAAAAAaA" Or _
                            foundFinder = "AAaaAAAAAAAAAaA") Then
                            foundVersion = 2
                         End If

                        alternating = "A"
                End If

                    If (foundVersion = 1) Then
                    
                        'First 13 modules after reversal becomes last 13
                        If ((doubleSeventeenCounter >= 36) And (doubleSeventeenCounter <= 48)) Then
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "z"
                            End If
                            
                        
                        Else
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "A"
                            End If
                        
                        End If
                    
                    ElseIf (foundVersion = 2) Then
                    
                        'Last 13 modules becomes first 13 after reversal
                        If ((doubleSeventeenCounter >= 34) And (doubleSeventeenCounter <= 46)) Then
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "z"
                            End If
                        
                        Else
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "A"
                            End If
                        
                        End If
                    
                    End If
End Function

Public Function performReverseLowerSeparator(ByRef stackedResultSingle() As Variant, ByVal z As Long, ByVal a As Long, ByRef doubleSeventeenCounter As Long, ByRef foundVersion As Long, ByRef alternating As String, ByRef previous As Long)

                    
                    Dim foundFinder As String
                    If (doubleSeventeenCounter = 34) Then 'Detect only at first point
                    
                        foundFinder = Mid(stackedResultSingle((z * 4) + 4), a + 1, 15)
                        If (foundFinder = "aAaaaaAAAAAAAAa" Or _
                            foundFinder = "aAaaaaAAAAAAaaa" Or _
                            foundFinder = "aAaaaaaaAAAAaaa" Or _
                            foundFinder = "aAaaaaaaaaAAaaa" Or _
                            foundFinder = "aAaaaaaAAAAAAaa" Or _
                            foundFinder = "aAaaaaaaaaaAAaa") Then
                            foundVersion = 1
                        End If
                        If (foundFinder = "AaaaaaaaaAAAAaA" Or _
                            foundFinder = "AAAaaaaaaAAAAaA" Or _
                            foundFinder = "AAAaaaaAAAAAAaA" Or _
                            foundFinder = "AAAaaAAAAAAAAaA" Or _
                            foundFinder = "AAaaaaaaAAAAAaA" Or _
                            foundFinder = "AAaaAAAAAAAAAaA") Then
                            foundVersion = 2
                        End If

                        alternating = "A"
                    
                    End If

                    
                    If (foundVersion = 1) Then
                    
                        'First 13 modules reversal
                        If (doubleSeventeenCounter >= 36) And (doubleSeventeenCounter <= 48) Then
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "z"
                            End If
                        
                        Else
                        
                            
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                            End If
                            
                        
                        End If
                    
                    ElseIf (foundVersion = 2) Then
                    
                        'Last 13 modules
                        If (doubleSeventeenCounter >= 34) And (doubleSeventeenCounter <= 46) Then
                        
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "z"
                            End If
                            
                        
                        Else
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                            End If
                        
                        End If
                    
                    End If
                    
End Function



Public Function performForwardUpperSeparator(ByRef stackedResultSingle() As Variant, ByVal z As Long, ByVal a As Long, ByRef doubleSeventeenCounter As Long, ByRef foundVersion As Long, ByRef alternating As String, ByRef previous As Long)

                  Dim foundFinder As String
                  If (doubleSeventeenCounter = 34) Then 'Detect only at first point
                    
                        foundFinder = Mid(stackedResultSingle(z * 4), a + 1, 15)
                        If (foundFinder = "aAAAAAAAAaaaaAa" Or _
                            foundFinder = "aaaAAAAAAaaaaAa" Or _
                            foundFinder = "aaaAAAAaaaaaaAa" Or _
                            foundFinder = "aaaAAaaaaaaaaAa" Or _
                            foundFinder = "aaAAAAAAaaaaaAa" Or _
                            foundFinder = "aaAAaaaaaaaaaAa") Then
                            foundVersion = 1
                        End If
                        If (foundFinder = "AaAAAAaaaaaaaaA" Or _
                            foundFinder = "AaAAAAaaaaaaAAA" Or _
                            foundFinder = "AaAAAAAAaaaaAAA" Or _
                            foundFinder = "AaAAAAAAAAaaAAA" Or _
                            foundFinder = "AaAAAAAaaaaaaAA" Or _
                            foundFinder = "AaAAAAAAAAAaaAA") Then
                            foundVersion = 2
                         End If

                        alternating = "A"
                    End If

                    If (foundVersion = 1) Then
                    
                        'First 13 modules
                        If (doubleSeventeenCounter >= 34) And (doubleSeventeenCounter <= 46) Then
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                
                                If (a - previous <> 1) Then 'non continuous. reset
                                    alternating = "A"
                                End If
                                    

                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + alternating
                                If (alternating = "A") Then
                                    alternating = "a"
                                Else
                                    alternating = "A"
                                End If
                                previous = a
                                
                                
                            End If

                        
                        Else
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "A"
                            End If
                        
                        End If
                    
                    ElseIf (foundVersion = 2) Then
                    
                        'Last 13 modules
                        If (doubleSeventeenCounter >= 36) And (doubleSeventeenCounter <= 48) Then
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                            
                                If (a - previous <> 1) Then 'non continuos. reset
                                    alternating = "A"
                                End If

                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + alternating
                                If (alternating = "A") Then
                                    alternating = "a"
                                Else
                                    alternating = "A"
                                End If

                                previous = a
                            
                            End If
                        
                        Else
                        
                            If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                            Else
                                stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "A"
                            End If
                        
                        End If
                    
                    End If
End Function

Public Function performForwardLowerSeparator(ByRef stackedResultSingle() As Variant, ByVal z As Long, ByVal a As Long, ByRef doubleSeventeenCounter As Long, ByRef foundVersion As Long, ByRef alternating As String, ByRef previous As Long, ByVal shifted As Long)


                    Dim foundFinder As String
                    If (doubleSeventeenCounter = 34 + shifted) Then 'Detect only at first point
                    
                        foundFinder = Mid(stackedResultSingle((z * 4) + 4), a + 1, 15)
                        If (foundFinder = "aAAAAAAAAaaaaAa" Or _
                            foundFinder = "aaaAAAAAAaaaaAa" Or _
                            foundFinder = "aaaAAAAaaaaaaAa" Or _
                            foundFinder = "aaaAAaaaaaaaaAa" Or _
                            foundFinder = "aaAAAAAAaaaaaAa" Or _
                            foundFinder = "aaAAaaaaaaaaaAa") Then
                            foundVersion = 1
                        End If
                        If (foundFinder = "AaAAAAaaaaaaaaA" Or _
                            foundFinder = "AaAAAAaaaaaaAAA" Or _
                            foundFinder = "AaAAAAAAaaaaAAA" Or _
                            foundFinder = "AaAAAAAAAAaaAAA" Or _
                            foundFinder = "AaAAAAAaaaaaaAA" Or _
                            foundFinder = "AaAAAAAAAAAaaAA") Then
                            foundVersion = 2
                         End If

                        alternating = "A"
                    
                    End If
                    
                    If (foundVersion = 1) Then
                    
                        'First 13 modules
                        If (doubleSeventeenCounter >= 34 + shifted) And (doubleSeventeenCounter <= 46 + shifted) Then
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                            
                                If (a - previous <> 1) Then 'non continuos. reset
                                    alternating = "A"
                                End If

                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + alternating
                                If (alternating = "A") Then
                                    alternating = "a"
                                Else
                                    alternating = "A"
                                End If
                                previous = a
                            
                            End If
                        
                        Else
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                            End If
                        End If
                    
                    ElseIf (foundVersion = 2) Then
                    
                        'Last 13 modules
                        If (doubleSeventeenCounter >= 36 + shifted) And (doubleSeventeenCounter <= 48 + shifted) Then
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                            
                                If (a - previous <> 1) Then 'non continuos. reset
                                    alternating = "A"
                                End If

                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + alternating
                                If (alternating = "A") Then
                                    alternating = "a"
                                Else
                                    alternating = "A"
                                End If

                                previous = a
                            
                            End If
                        
                        Else
                        
                            If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                            Else
                                stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                            End If
                        
                        End If
                    End If

End Function



Public Function dataCompactionStacked(ByVal data As String, ByRef encodationResult As String, ByRef compactionResult As String, ByRef state As String, ByVal numSegmentsPerRow As Integer) As String

   
    
    Dim x As Long
    
    
    x = 0
    
    state = "Numeric"
    compactionResult = ""
    Do While (x < Len(data))
    
        If (state = "Numeric") Then
    
            compactionResult = compactionResult + numericEncodation(x, data, encodationResult, compactionResult, state)
    
            
        ElseIf (state = "Alpha") Then
            
    
            compactionResult = compactionResult + alphaEncodation(x, data, state)
    
            
        ElseIf (state = "ISO646") Then
            
    
            compactionResult = compactionResult + ISO646Encodation(x, data, state)
    
        End If
    
    Loop
    
        
    compactionResult = padStacked(compactionResult, encodationResult, state, numSegmentsPerRow)
    
    'Debug.Print "compactionResult " + compactionResult
        
    dataCompactionStacked = compactionResult
    
End Function


Public Function encodationMethodStacked(ByVal data As String, ByRef numData As Long, ByRef numSegments As Long, ByRef encodationResult As String, ByRef compactionResult As String, ByRef errorMsg As String, ByRef linkageFlag As Long, ByRef datachar() As Long, ByVal numSegmentsPerRow As Integer) As String

    Dim result As String
    Dim retval As Long
    Dim addcharlength As Long
    Dim state As String 'Numeric Alpha, ISO646
    
    result = ""

    numData = 0
    numSegments = 0
    
    'state variables
    Dim patterns(30) As String
    Dim patData(30) As String
    Dim patternCounter As Long

    retval = findPatternData(data, patternCounter, patterns, patData)
    
    
    
    If (patternCounter < 1) Then
    
        errorMsg = "No Application Identifier specified."
        encodationMethodStacked = ""
        Exit Function
    
    End If

    'TRACE("Here %d\n",patternCounter);
    If (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3103)") Then
    
       Dim patData0, patData1, tempString As String
       
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
        
            patData(1) = Left(patData(1), 6)
        
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                patData(1) = "0" + patData(1)
             Next x
        
        End If
        
        Dim valueRange As Long
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 32767) Then
        
            errorMsg = "The weight field must be from 0 to 32767."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData0 = Left(patData(0), 13) 'Take out last Digit
        patData0 = Right(patData0, 12)  'Take out first Digit
        patData1 = patData(1)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0100" 'Encodation Method Field
        
        Dim triplets As String
        Dim digits As Long
        triplets = ""
        fStr = ""
        Dim tripletsValue As Long
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                '10 digits most significant 1
                digits = 512
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        Dim patData1Value As Long
        patData1Value = val(patData1)
        
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        Dim value12 As Long
        value12 = 0
        digits = 2048
        For x = 0 To 59
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                '//TRACE("Interim : %d\n",value12);
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        encodationMethodStacked = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
            
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3202)") Then
    
        'Dim patData0, patData1, tempString As String
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
            
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
        
            patData(1) = Left(patData(1), 6)
        
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                
                patData(1) = "0" + patData(1)
                
            Next x
        End If
        
        'Dim valueRange As Long
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 9999) Then
        
            errorMsg = "The weight field must be from 0 to 9999."
            encodationMethodStacked = ""
            Exit Function
        
        End If
        patData0 = Left(patData(0), 13) 'Take out last Digit
        patData0 = Right(patData0, 12) 'Take out first Digit
        patData1 = Right(patData(1), 4)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0101" 'Encodation Method Field
        
        
        fStr = ""
        triplets = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        
        patData1Value = val(patData1)
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        
        value12 = 0
        digits = 2048
        For x = 0 To 59

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        encodationMethodStacked = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And patterns(1) = "(3203)") Then
    
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 6) Then
            
            patData(1) = Left(patData(1), 6)
            
        End If

        If (Len(patData(1)) < 6) Then
        
            addcharlength = 6 - Len(patData(1))
            For x = 0 To addcharlength - 1
                patData(1) = "0" + patData(1)
            Next x
        
        End If
        
        
        valueRange = val(patData(1))
        If (valueRange < 0 Or valueRange > 22767) Then
        
            errorMsg = "The weight field must be from 0 to 22767."
            encodationMethodStacked = ""
            Exit Function
        
        End If
        
        
        patData0 = Left(patData(0), 13) 'Take out last Digit
        patData0 = Right(patData0, 12) 'Take out first Digit
        patData1 = Right(patData(1), 4)

        'Setup for barcode encodation
        numData = 5
        numSegments = 6
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        tempString = tempString + "0101" 'Encodation Method Field
        
        
        
        
        fStr = ""
        triplets = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x

        
        patData1Value = val(patData1) + 10000 'Add 10000 as compared to the previous
        digits = 16384 '15 digits most significant 1
        For y = 0 To 14
        
            If (patData1Value And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        
        Next y
        
        
        value12 = 0
        digits = 2048
        For x = 0 To 59
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
                        
            If ((x + 1) Mod 12 = 0) Then
            
                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        encodationMethodStacked = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
                           
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(11)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111000", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(11)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111001", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(13)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111010", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(13)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111011", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(15)") Then
    
        'TRACE("Inside\n");
        encodationMethodStacked = fixLength8Encodation(data, "0111100", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(15)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111101", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(310x)") And patterns(2) = "(17)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111110", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 3 And patterns(0) = "(01)" And matchAI(patterns(1), "(320x)") And patterns(2) = "(17)") Then
    
        encodationMethodStacked = fixLength8Encodation(data, "0111111", numData, numSegments, errorMsg, linkageFlag, datachar, patterns, patData, patternCounter)
        Exit Function
    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And matchAI(patterns(1), "(392x)")) Then
    
        'TRACE("Start of (392x)\n");
        encodationResult = ""
        Dim patData2 As String
        
        
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
        
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        
        If (AscW(Mid(patterns(1), 4 + 1, 1)) < AscW("0") Or AscW(Mid(patterns(1), 4 + 1, 1)) > AscW("3")) Then
        
            
            errorMsg = "The decimal point digit must be from 0 to 3."
            encodationMethodStacked = ""
            Exit Function
            
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 15) Then
        
            patData(1) = Left(patData(1), 15)
        
        End If

        If (patData(1) = "") Then
        
            errorMsg = "The price digits cannot be empty."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData0 = Left(patData(0), 13) 'Take out last Digit
        patData0 = Right(patData0, 12) 'Take out first Digit
        patData1 = Mid(patterns(1), 4 + 1, 1)
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        
        
        tempString = tempString + "01100" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field
        
        
        
        triplets = ""
        fStr = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                        
                    digits = Int(digits / 2)
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        
        patData1Value = val(patData1)
        If (patData1Value = 0) Then
            
            tempString = tempString + "00"
            
        ElseIf (patData1Value = 1) Then
            tempString = tempString + "01"
        ElseIf (patData1Value = 2) Then
            tempString = tempString + "10"
        ElseIf (patData1Value = 3) Then
            tempString = tempString + "11"
        End If

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        tempString = tempString + dataCompactionStacked(patData(1), encodationResult, compactionResult, state, numSegmentsPerRow)

        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

        'Setup the variable bits length field
        Dim tempChar As String
        Dim tempLeft, tempRight As String
        If (numSegments Mod 2 = 0) Then
            'tempChar = Mid(tempString, 6 + 1, 1)
            tempLeft = Left(tempString, 6)
            tempRight = Right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(6,'0');
        Else
            tempLeft = Left(tempString, 6)
            tempRight = Right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(6,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = Left(tempString, 7)
            tempRight = Right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(7,'0');
        Else
            tempLeft = Left(tempString, 7)
            tempRight = Right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(7,'1');
        End If


        'Possible place to do a length check does not exceed max length
                
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethodStacked = ""
                    Exit Function
                                    
                End If
                datachar(Int(((x + 1) / 12) - 1)) = value12
                                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        encodationMethodStacked = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function

    
    ElseIf (patternCounter = 2 And patterns(0) = "(01)" And matchAI(patterns(1), "(393x)")) Then
    
        encodationResult = ""
                
        patData(0) = onlyNumeric(patData(0))
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
            
        End If

        If (Mid(patData(0), 0 + 1, 1) <> "9") Then
        
            errorMsg = "9 must be the first digit for the data in AI (01) in this specific Expanded encoding."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        If (AscW(Mid(patterns(1), 4 + 1, 1)) < AscW("0") Or AscW(Mid(patterns(1), 4 + 1, 1)) > AscW("3")) Then
        
            errorMsg = "The decimal point digit must be from 0 to 3."
            encodationMethodStacked = ""
            Exit Function
        
        End If

        patData(1) = onlyNumeric(patData(1))
        If (Len(patData(1)) > 18) Then '3 ISO Currency + 15
        
            patData(1) = Left(patData(1), 18)
        
        End If

        If (patData(1) = "") Then
        
            errorMsg = "The price digits cannot be empty."
            encodationMethodStacked = ""
            Exit Function
        
        End If


        patData0 = Left(patData(0), 13) 'Take out last Digit
        patData0 = Right(patData0, 12) 'Take out first Digit
        patData1 = Mid(patterns(1), 4 + 1, 1)
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If

        
        tempString = tempString + "01101" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field
                
        
        
        triplets = ""
        fStr = ""
        For x = 0 To 11
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1) Mod 3 = 0) Then
            
                tripletsValue = val(triplets)
                                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        
        patData1Value = Int(val(patData1))
        If (patData1Value = 0) Then
            tempString = tempString + "00"
        ElseIf (patData1Value = 1) Then
            tempString = tempString + "01"
        ElseIf (patData1Value = 2) Then
            tempString = tempString + "10"
        ElseIf (patData1Value = 3) Then
            tempString = tempString + "11"
        End If

        
        triplets = Left(patData(1), 3)
        tripletsValue = val(triplets)
        digits = 512 '10 digits most significant 1
        For y = 0 To 9
        
            If (tripletsValue And digits) Then
                tempString = tempString + "1"
            Else
                tempString = tempString + "0"
            End If
            digits = Int(digits / 2)
        Next y

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        tempString = tempString + dataCompactionStacked(Mid(patData(1), 3 + 1), encodationResult, compactionResult, state, numSegmentsPerRow)


        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1
        

        'Possible place to do a length check does not exceed max length
        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = Left(tempString, 6)
            tempRight = Right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(6,'0');
        Else
            tempLeft = Left(tempString, 6)
            tempRight = Right(tempString, Len(tempString) - 7)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(6,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = Left(tempString, 7)
            tempRight = Right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(7,'0')
        Else
            tempLeft = Left(tempString, 7)
            tempRight = Right(tempString, Len(tempString) - 8)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(7,'1');
        End If
        
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethodStacked = ""
                    Exit Function
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12
                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        Next x
        
        encodationMethodStacked = patterns(0) + patData(0) + patterns(1) + patData(1)
        Exit Function
    
    ElseIf (patterns(0) = "(01)" And patternCounter >= 1) Then
    
    
        
    
        encodationResult = ""
        Dim temppatData As String
                        
        patData(0) = onlyNumeric(patData(0))
        
        If (Len(patData(0)) < 14) Then
        
            addcharlength = 14 - Len(patData(0))
            For x = 0 To addcharlength - 1
                patData(0) = "0" + patData(0)
            Next x
        
        ElseIf (Len(patData(0)) > 14) Then
        
            patData(0) = Left(patData(0), 14)
        
        End If
        
        patData0 = Left(patData(0), 13) 'Take out last Digit
        
        
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
        

        tempString = tempString + "1" 'Encodation Method Field
        tempString = tempString + "00" 'Initialize with variable length field

        
        Dim singletValue As Long
        Dim smalldigit As Long
               
        
        triplets = ""
        fStr = ""
              
        singletValue = val(Mid(patData0, 0 + 1, 1))
        smalldigit = 8 '4 digits most significant 1
        For y = 0 To 3
        
            If (singletValue And smalldigit) Then
                fStr = fStr + "1"
            Else
                fStr = fStr + "0"
            End If
                
            smalldigit = Int(smalldigit / 2)
        
        Next y

        'TRACE("Singlet %s\n",fStr);
        tempString = tempString + fStr
        
        

        For x = 1 To 12
        
            fStr = ""
            triplets = triplets + Mid(patData0, x + 1, 1)
            If ((x + 1 - 1) Mod 3 = 0) Then 'Minus 1 as it starts from 1
            
                tripletsValue = val(triplets)
                
                digits = 512 '10 digits most significant 1
                For y = 0 To 9
                
                    If (tripletsValue And digits) Then
                        fStr = fStr + "1"
                    Else
                        fStr = fStr + "0"
                    End If
                    digits = Int(digits / 2)
                
                Next y
                tempString = tempString + fStr
                triplets = ""
            
            End If
        
        Next x
        
        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
            
        For x = 0 To patternCounter - 1
        
            If (x <> 0) Then
            
                'TRACE("patterns %s patData %s\n",patterns[x],patData[x]);
                temppatData = temppatData + stripBrackets(patterns(x)) + patData(x)
            
            End If
        
        Next x
    
        'MsgBox temppatData
        tempString = tempString + dataCompactionStacked(temppatData, encodationResult, compactionResult, state, numSegmentsPerRow)
        

        
        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = Left(tempString, 2)
            tempRight = Right(tempString, Len(tempString) - 3)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(2,'0');
        Else
            tempLeft = Left(tempString, 2)
            tempRight = Right(tempString, Len(tempString) - 3)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(2,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = Left(tempString, 3)
            tempRight = Right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(3,'0');
        Else
            tempLeft = Left(tempString, 3)
            tempRight = Right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(3,'1');
        End If


        'Possible place to do a length check does not exceed max length
        
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1
        

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If

            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethodStacked = ""
                    Exit Function
                
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12

                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        
        Next x
        
        Dim combinationStr As String
        combinationStr = ""
        For x = 0 To patternCounter - 1
        
            combinationStr = combinationStr + patterns(x) + patData(x)
        
        Next x

        encodationMethodStacked = combinationStr
        Exit Function
    
    Else
    
        'Could be any AI or AI(01) + other AI
        encodationResult = ""
        
        'Setup for barcode encodation
        If (linkageFlag = 1) Then
            tempString = "1"
        Else
            tempString = "0" 'Linkage
        End If
            
        
        tempString = tempString + "00" 'Encodation Method Field
        tempString = tempString + "00" 'Variable Length Field

        encodationResult = tempString 'setup encodation result for calculation of length in dataCompaction
        
        For x = 0 To patternCounter - 1
                    
            temppatData = temppatData + stripBrackets(patterns(x)) + patData(x)
        
        Next x
        
        tempString = tempString + dataCompactionStacked(temppatData, encodationResult, compactionResult, state, numSegmentsPerRow)
        numData = Int(Len(tempString) / 12)
        numSegments = numData + 1

          '1031
          If (numSegments < 4) Then
                
                        errorMsg = "The GS1 Expanded Specifications require the number of data segments to be at least 4."
                      encodationMethodStacked = ""
                      Exit Function

          End If
        
        'Possible place to do a length check does not exceed max length
        'Setup the variable bits length field
        If (numSegments Mod 2 = 0) Then
            tempLeft = Left(tempString, 3)
            tempRight = Right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(3,'0');
        Else
            tempLeft = Left(tempString, 3)
            tempRight = Right(tempString, Len(tempString) - 4)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(3,'1');
        End If

        If (numSegments <= 14) Then
            tempLeft = Left(tempString, 4)
            tempRight = Right(tempString, Len(tempString) - 5)
            tempString = tempLeft + "0" + tempRight
            'tempString.SetAt(4,'0');
        Else
            tempLeft = Left(tempString, 4)
            tempRight = Right(tempString, Len(tempString) - 5)
            tempString = tempLeft + "1" + tempRight
            'tempString.SetAt(4,'1');
        End If

                
        value12 = 0
        digits = 2048
        For x = 0 To Len(tempString) - 1

            If (Mid(tempString, x + 1, 1) = "1") Then
            
                value12 = value12 + digits
                'TRACE("Interim : %d\n",value12);
            
            End If
            
            
            If ((x + 1) Mod 12 = 0) Then
            
                If (Int(((x + 1) / 12) - 1) > 21) Then
                
                    'TRACE("Max Length Exceed");
                    errorMsg = "There are too many characters in the data to be encoded."
                    encodationMethodStacked = ""
                    Exit Function
                
                End If

                datachar(Int(((x + 1) / 12) - 1)) = value12
                                
                value12 = 0
                digits = 2048
            
            Else
                digits = Int(digits / 2)
            End If
        Next x

        
        combinationStr = ""
        For x = 0 To patternCounter - 1
        
            combinationStr = combinationStr + patterns(x) + patData(x)
        
        Next x

        encodationMethodStacked = combinationStr
        Exit Function

    End If

    encodationMethodStacked = result
    Exit Function
    
End Function



Public Function convertExpandedToStacked(ByVal data As String, ByVal numSegmentsPerRow As Integer, ByVal numSegments As Integer) As String

    Dim numberOfSegmentsPerRow As Integer
    Dim row As Integer
    Dim i As Integer
    Dim stackResult As String
    Dim shifted As Integer
         
    'Debug.Print numSegments
    
    numberOfSegmentsPerRow = numSegmentsPerRow
    row = 0
    stackResult = ""
    shifted = 0
    
    Dim stackedResult(11) As Variant
    Dim stackedResultSingle(41) As Variant
    
    For i = 0 To 11 - 1
        stackedResult(i) = ""
    Next i
    
    For i = 0 To 41 - 1
        stackedResultSingle(i) = ""
    Next i
        
    Dim bwLen As Integer
    Dim numUsed As Integer
    Dim Reverse As Integer
    Dim location As Integer
    Dim y As Integer
    If (numSegments > numberOfSegmentsPerRow) Then
    
        bwLen = Len(data)
        For y = 0 To bwLen - 1
        
            If (y = 0) Or (y = 1) Then
                'Skip
            End If
                
            If (y = 9) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 14) Then
                'A1
            End If
                

            If (y = 22) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 30) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 35) Then
                'A2
            End If

            If (y = 43) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 51) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 56) Then
                'B1
            End If
                

            If (y = 64) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 72) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 77) Then
                'B2
            End If

            If (y = 85) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 93) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 98) Then
                'C1
            End If

            If (y = 106) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 114) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 119) Then
                'D2
            End If

            If (y = 127) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 135) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 140) Then
                'D1
            End If

            If (y = 148) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 156) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 161) Then
                'E2
            End If

            If (y = 169) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 177) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 182) Then
                'E1
            End If
                
            If (y = 190) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 198) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 203) Then
                'F2
            End If

            If (y = 211) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 219) Then
                numUsed = numUsed + 1
            End If
                
            If (y = 224) Then
                'F1
            End If

            If (y = 232) Then
                numUsed = numUsed + 1
            End If
            
            If (y = 240) Then
                numUsed = numUsed + 1
            End If
                            
            If (Reverse = 0) Then
                stackedResult(row) = stackedResult(row) + Mid(data, y + 1, 1)
            Else
                stackedResult(row) = Mid(data, y + 1, 1) + stackedResult(row)
            End If
            
            

            If (numUsed = numberOfSegmentsPerRow) Then
                            
                If (y + 2 < bwLen - 1) Then 'y+2 guard bars is the end already
                
                    numUsed = 0

                    If ((numberOfSegmentsPerRow = 4) Or _
                        (numberOfSegmentsPerRow = 8) Or _
                        (numberOfSegmentsPerRow = 12) Or _
                        (numberOfSegmentsPerRow = 16) Or _
                        numberOfSegmentsPerRow = 20) Then
                    
                        If (Reverse = 0) Then
                        
                            Reverse = 1
                            stackedResult(row) = stackedResult(row) + "aA"
                            stackedResult(row + 1) = stackedResult(row + 1) + "Aa"
                        
                        Else
                        
                            Reverse = 0
                            stackedResult(row) = "Aa" + stackedResult(row)
                            stackedResult(row + 1) = "Aa" + stackedResult(row + 1)
                        
                        End If
                    
                    Else
                    
                        stackedResult(row) = stackedResult(row) + "aA"
                        stackedResult(row + 1) = "Aa" + stackedResult(row + 1)
                    
                    End If

                    row = row + 1
                
                End If
            
            End If
        Next y
        
        
        Dim numberOfFinders As Integer
        If (numberOfSegmentsPerRow = 4) Or (numberOfSegmentsPerRow = 8) Or (numberOfSegmentsPerRow = 12) Or (numberOfSegmentsPerRow = 16) Or (numberOfSegmentsPerRow = 20) Then
        
        'Last row is partial length also need to be reverse then be considered
        If (row > 0) And (row = 1 Or row = 3 Or row = 5) And (Len(stackedResult(row)) < Len(stackedResult(row - 1))) Then
                
        
            numberOfFinders = 0
            For y = 0 To Len(stackedResult(row)) - 1
                                     
                If ((y = 14) Or (y = 35) Or (y = 56) Or (y = 77) Or (y = 98) Or (y = 119) Or (y = 140) Or (y = 161) Or (y = 183) Or (y = 204) Or (y = 225)) Then
                    numberOfFinders = numberOfFinders + 1
                End If
                
            Next y
            
                
            If (numberOfFinders Mod 2 = 1) Then
                
                    'Reverse the Row Reversal and Do Right Shift
                    Dim revStr As String
                    revStr = "aaA"
                    For m = Len(stackedResult(row)) - 1 - 2 To 0 Step -1 'minus 2 bcoz the above code add another 2 a
                        revStr = revStr + Mid(stackedResult(row), m + 1, 1)
                    Next m
                    
                    stackedResult(row) = revStr
                    shifted = 1
                
            End If
            
        
        End If
        End If
    
    Else
    
        'Do Nothing
        row = 0
        stackedResult(row) = data
    
    End If
    
    

    Dim numRows As Integer
    numRows = row + 1
    For z = 0 To numRows - 1
    
        'Debug.Print "Stacked Result - " + stackedResult(z)

        Dim counter As Integer
        counter = 0
        Do While (counter < Len(stackedResult(z)))
        
            If (Mid(stackedResult(z), counter + 1, 1) = "A") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "A"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "B") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "C") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "D") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "E") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "F") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "G") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAAAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "H") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAAAAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "I") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "AAAAAAAAA"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "a") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "a"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "b") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "c") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "d") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "e") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "f") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaaaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "g") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaaaaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "h") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaaaaaa"
            ElseIf (Mid(stackedResult(z), counter + 1, 1) = "i") Then
                stackedResultSingle(z * 4) = stackedResultSingle(z * 4) + "aaaaaaaaa"
            End If

        counter = counter + 1
        Loop
    Next z

    'The first loop above is for calculating the expanded version of the symbols
    'This loop here is for calculating the separators
    For z = 0 To numRows - 1
    

        If (z = numRows - 1) Then
            'Do Nothing as it is last row
        Else
        
        'Upper Separator
        '17,15,17,17,15,17,17,15......
        
            Dim symStrLen As Long
            symStrLen = Len(stackedResultSingle(z * 4))
         
            Dim doubleSeventeenCounter As Long
            Dim foundVersion As Long
            doubleSeventeenCounter = 17
            foundVersion = 0
            
            Dim alternating As String
            alternating = "A"
            
            Dim previous As Long
            previous = -1
            
            stackedResultSingle((z * 4) + 1) = "aaaa"
            For a = 0 To symStrLen - 1
        
            If ((a >= 0 And a <= 3) Or (a >= (symStrLen - 1 - 3) And a <= (symStrLen - 1))) Then
                'First and Last 4 Do Nothing
            Else
            
                If (doubleSeventeenCounter >= 34 And doubleSeventeenCounter <= 48) Then
                
                    If (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) Then
                    
                        If (z = 1 Or z = 3 Or z = 5) Then
                            returnResults = performReverseUpperSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous)
                        Else
                            returnResults = performForwardUpperSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous)
                        End If
                    
                    Else
                        returnResults = performForwardUpperSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous)
                    End If
                
                Else
                
                    If (Mid(stackedResultSingle(z * 4), a + 1, 1) = "A") Then
                        stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "a"
                    Else
                        stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "A"
                    End If
                
                End If
            
            End If
            
            If (doubleSeventeenCounter = 48) Then
            
                doubleSeventeenCounter = 0
                foundVersion = 0 'FailSafe
            
            Else
            
                If (a = 0) Or (a = 1) Then
                    'Skip Guard Bars
                Else
                    doubleSeventeenCounter = doubleSeventeenCounter + 1
                End If
            
            End If
        
           Next a
        
        
        
        stackedResultSingle((z * 4) + 1) = stackedResultSingle((z * 4) + 1) + "aaaa"
        If (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) Then
        
            If (z = 1 Or z = 3 Or z = 5) Then
                returnResults = ReverseAlternating(stackedResultSingle, (z * 4) + 1)
            End If
        
        End If

        'Middle Separator
        symStrLen = Len(stackedResultSingle(z * 4))
        stackedResultSingle((z * 4) + 2) = "aaaa"
        For a = 0 To (symStrLen - 8) - 1
        
            If (a Mod 2 = 0) Then
                stackedResultSingle((z * 4) + 2) = stackedResultSingle((z * 4) + 2) + "a"
            Else
                stackedResultSingle((z * 4) + 2) = stackedResultSingle((z * 4) + 2) + "A"
            End If
        
        Next a
        stackedResultSingle((z * 4) + 2) = stackedResultSingle((z * 4) + 2) + "aaaa"

        'Lower Separator
        Dim firstIsFinder As Integer
        symStrLen = Len(stackedResultSingle((z * 4) + 4))
        doubleSeventeenCounter = 17
        firstIsFinder = 0
        'In the last row, during reversal, it is possible that the first segment is the finder pattern
        If (z + 1 = numRows - 1) Then
        
            If (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) Then
                
                If ((z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) And (numSegments Mod 2 = 1)) Then 'during reverse row
                
                    doubleSeventeenCounter = 34
                    firstIsFinder = 1
                
                End If
            
            End If
        
        End If

        foundVersion = 0
        alternating = "A"
        previous = -1
        stackedResultSingle((z * 4) + 3) = "aaaa"
        For a = 0 To symStrLen - 1
        
            If ((a >= 0 And a <= 3 And firstIsFinder = 0) Or (a >= (symStrLen - 1 - 3) And a <= (symStrLen - 1)) Or (a >= 0 And a <= 1 And firstIsFinder = 1)) Then
                'First and Last 4 Do Nothing
            Else

                'Last row of Shifted
                If (z + 1 = numRows - 1 And _
                    shifted = 1 And _
                    doubleSeventeenCounter >= 34 + shifted And _
                    doubleSeventeenCounter <= 48 + shifted And _
                    (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) And _
                    (z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) _
                    ) Then
                
                    returnResults = performForwardLowerSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous, shifted)
                
                'Last row of Shifted ,34 is a special case
                ElseIf (z + 1 = numRows - 1 And _
                    shifted = 1 And _
                    doubleSeventeenCounter = 34 And _
                    (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) And _
                    (z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) _
                    ) Then
                
                    If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                        stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                    Else
                        stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                    End If
                
                ElseIf (doubleSeventeenCounter >= 34 And doubleSeventeenCounter <= 48) Then 'all the rest of the cases between 34 to 48
                
                    If ( _
                        (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) And _
                        (z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) _
                        ) Then
                        returnResults = performReverseLowerSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous)
                    Else
                        returnResults = performForwardLowerSeparator(stackedResultSingle, z, a, doubleSeventeenCounter, foundVersion, alternating, previous, 0)
                    End If
                
                Else 'Complements if not 34-48
                
                    If (Mid(stackedResultSingle((z * 4) + 4), a + 1, 1) = "A") Then
                        stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "a"
                    Else
                        stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "A"
                    End If
                
                End If


            
            End If

            'Last row of Shifted
            If (z + 1 = numRows - 1) And _
                (shifted = 1) And _
                (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) And (z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) Then
                
                            
                If (doubleSeventeenCounter = 48 + shifted) Then
                
                    doubleSeventeenCounter = 0
                    foundVersion = 0 'FailSafe
                
                Else
                
                    If (a = 0 Or a = 1) Then
                        'Skip Guard Bars
                    Else
                        doubleSeventeenCounter = doubleSeventeenCounter + 1
                    End If
                
                End If
            
            Else
                If (doubleSeventeenCounter = 48) Then
                
                    doubleSeventeenCounter = 0
                    foundVersion = 0 'FailSafe
                
                Else
                
                    If (a = 0 Or a = 1) Then
                        'Skip Guard Bars
                    Else
                        doubleSeventeenCounter = doubleSeventeenCounter + 1
                    End If
                
                End If
            
            End If


        
        Next a
        stackedResultSingle((z * 4) + 3) = stackedResultSingle((z * 4) + 3) + "aaaa"
        If (firstIsFinder = 1) Then
        
            'stackedResultSingle((z*4)+3).Delete(2,2);
            stackedResultSingle((z * 4) + 3) = Application.WorksheetFunction.Replace(stackedResultSingle((z * 4) + 3), 2 + 1, 2, "")
            'stackedResultSingle((z*4)+3).SetAt(2,'a');
            stackedResultSingle((z * 4) + 3) = Application.WorksheetFunction.Replace(stackedResultSingle((z * 4) + 3), 2 + 1, 1, "a")
            'stackedResultSingle((z*4)+3).SetAt(3,'a');
            stackedResultSingle((z * 4) + 3) = Application.WorksheetFunction.Replace(stackedResultSingle((z * 4) + 3), 3 + 1, 1, "a")
        
        End If

        'Even in Special Shifted case allows it to do reverse alternating. As there will be no z and thus is harmless.
        
        If (numberOfSegmentsPerRow = 4 Or numberOfSegmentsPerRow = 8 Or numberOfSegmentsPerRow = 12 Or numberOfSegmentsPerRow = 16 Or numberOfSegmentsPerRow = 20) Then
        
            If (z + 1 = 1 Or z + 1 = 3 Or z + 1 = 5) Then 'z+1 as using
                returnResults = ReverseAlternating(stackedResultSingle, (z * 4) + 3)
            End If
        
        End If
        
    End If
    Next z
    'else not last row

    'For z = 0 To 41 - 1
        'TRACE("Stacked Result Single- %s\n",stackedResultSingle[z]);
        'Debug.Print "Stacked Result Single - " + stackedResultSingle(z)
    'Next z
    
    Dim resultValue As Integer
    resultValue = 48 + 32 + 17
    Dim returnStr As String
    returnStr = ""
    For z = 0 To numRows - 1
    
        If (stackedResultSingle(z * 4) <> "") Then
                                    
            'Dim symStrLen As Integer
            symStrLen = Len(stackedResultSingle(0))
            For y = 0 To symStrLen - 1
            
                If (z <> 0) Then
                
                    If (stackedResultSingle((z * 4) - 1) <> "") Then

                        If (y < Len(stackedResultSingle((z * 4)))) Then
                    
                            If (Mid(stackedResultSingle((z * 4) - 1), y + 1, 1) = "A") Then
                                resultValue = resultValue + 8
                            End If
                        
                        End If
                    End If
                End If

                If (y < Len(stackedResultSingle((z * 4)))) Then
                                
                    If (Mid(stackedResultSingle((z * 4) + 0), y + 1, 1) = "A") Then
                        resultValue = resultValue + 4
                    End If
                
                End If

                If (z <> numRows - 1) Then
                
                    'TRACE("Three\n");
                    If (Mid(stackedResultSingle((z * 4) + 1), y + 1, 1) = "A") Then
                            resultValue = resultValue + 2
                    End If
                    
                    If (Mid(stackedResultSingle((z * 4) + 2), y + 1, 1) = "A") Then
                            resultValue = resultValue + 1
                    
                    End If
                    'TRACE("y-%d z-%d\n",y,z);
                    
                End If
                
                returnStr = returnStr + ChrW(resultValue)
                resultValue = 48 + 32 + 17 'reset
                
            Next y
        
        End If
        
        returnStr = returnStr + Chr(10)
    
    Next z

    convertExpandedToStacked = returnStr

End Function