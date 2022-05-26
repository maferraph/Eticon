/****************************************************************************
*                        ETICON - Etiquetas Conesteel                       *
*        Programa feito por Maurício Fernandes Raphael em 23/10/98          *
*                    Conesteel Conexões de Aço Ltda.                        *
*                              FUNCOES.PRG                                  *
****************************************************************************/

#include "Inkey.ch"
#include "Achoice.ch"

Memvar AAA
PUBLIC AAA := 0

*******************************
Function ITConesteel()
*******************************
Local nN , nLin , nNum := 0 , GetList := {} , cAtt := space(25)

Tela("R/W,W+/R",10,20,15,64)
SetColor("R/W,W+/R")
@ 10,21 Say "Quantas etiquetas da Conesteel vocˆ quer"
@ 11,21 Say "  imprimir na impressora Epson LX-300 ? "
@ 12,39 Get nNum picture "@9 9999"
Read

Tela("R/W,W+/R",10,20,15,64)
SetColor("R/W,W+/R")
@ 10,22 Say " Imprimir as etiquetas da Coneteel aos  "
@ 11,22 Say "      cuidados de quem ? ( Att: )       "
@ 12,28 Get cAtt picture "@!"
Read

While TestaImpressora() <> "OK"
      inkey(00)
End

Set Device To Print
nLin:= 0
nN := 1

@ nLin , 0 Say CHR(27) + CHR(77) // Modo condensado
While nN <= nNum
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin   ,  0 Say "CONESTEEL CONEXOES DE A€O LTDA."
      @ nLin++ , 43 Say "CONESTEEL CONEXOES DE A€O LTDA."
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo negrito
      If cAtt <> space(25)
         @ nLin   ,  0 Say "Att.: " + cAtt
         @ nLin++ , 43 Say "Att.: " + cAtt
      Else
         nLin++
      EndIf
      @ nLin   ,  0 Say "AV. MONTEMAGNO, 2454"
      @ nLin++ , 43 Say "AV. MONTEMAGNO, 2454"
      @ nLin   ,  0 Say "VILA FORMOSA - SAO PAULO - (SP)"
      @ nLin++ , 43 Say "VILA FORMOSA - SAO PAULO - (SP)"
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin , 0 Say CHR(27) + CHR(52) // Modo it lico
      @ nLin   ,  0 Say "CEP: 03371-001"
      @ nLin   , 43 Say "CEP: 03371-001"
      @ nLin , 0 Say CHR(27) + CHR(53) // Cancela Modo It lico
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo Negrito
      nLin := nLin + 5
      nN := nN + 2
End
Eject
Set Device To Screen

Return NIL




**************************
Function MontaTela()
**************************
Local nLin := 1

Cls
SetColor("GR+/G+,B/W+")
@ 0,0 clear to 0,80
@ 0,24 Say "Conesteel Conexäes de A‡o Ltda."
@ 24,0 clear to 24,80
@ 24,0 Say "Mensagem :"
SetColor("W+/N+")
@ 2,0 CLEAR TO 2,80
DispBox(1,0,3,79,2)
@ 2,25 Say "ETICON - Etiquetas Conesteel"
SetColor("B/N")
nLin := 1
For nLin = 4 To 23
    @ nLin,0 Say Replicate ("²±",40)
Next
SetColor("B/N,B/W+")
DispBox(5,4,22,75,2)
@  6,5  CLEAR TO 21,74
@  7,4  Say "Ì"
@  7,5  Say Replicate("Í",70)
@  7,75 Say "¹"

Return NIL


**************************
Function TestaImpressora()
**************************

Local lTeste , cTela

Tone(500,2) ; Tone(10,2) ; Tone(500,2)
cTela := SaveScreen(9,20,18,64) 
Tela("R/W,W+/R",10,20,18,64)
SetColor("R/W,W+/R")
@ 10,21 Say "Esse programa de certificado de qualidade"
@ 11,21 Say "   foi desenvolvido para ser usado com   "
@ 12,21 Say "         impressoras Epson LX-300        "
@ 14,27 Say "Testando impressora: "
If IsPrinter()
   lTeste := "OK"
Else
   lTeste := "ERRO!"
EndIf
   @ 14,53 Say lTeste color "W+/R"
If lTeste = "OK"
   @ 16,21 Say "Pressione qualquer tecla para imprimir..." color "W+/R"
   SetCursor(0)
   inkey(00)
   SetCursor(1)
Else
   @ 16,21 Say "Verifique se a impressora esta pronta !!!" color "W+/R"
   SetCursor(0)
   inkey(00)
   SetCursor(1)
EndIf
SetColor("GR+/B,B/W+")
RestScreen(9,20,18,64,cTela) 
Return lTeste


*****************************************************
Function Tela(cColor,nLinIni,nColIni,nLinFin,nColFin)
*****************************************************

Local nLI,nCI,nLF,nCF,nL_I,nL_F,nC_I,nC_F,nI,cCor , cTela

cCor := SetColor()
nLI := nLinIni
nCI := nColIni
nLF := nLinFin
nCF := nColFin
nL_I := nLinIni + ( ABS(nLinFin - nLinIni) / 2 ) - 1
nL_F := nLinFin - ( ABS(nLinFin - nLinIni) / 2 ) - 1
nC_I := nColIni + ( ABS(nColFin - nColIni) / 2 ) - 1
nC_F := nColFin - ( ABS(nColFin - nColIni) / 2 ) - 1
nI := 1

SetColor(cColor)
While nL_I >= nLinIni .and. nL_F <= nLinFin
      For nI = 1 to 10000
      Next
      dispBox(nL_I--,nC_I,nL_F++,nC_F)
End
nI := 1
While nC_I >= nColIni .and. nC_F <= nColFin
      scroll(nL_I,nC_I,nL_F,nC_F)
      dispBox(nL_I,nC_I--,nL_F,nC_F++)
      For nI = 1 to 10000
      Next
End   

SetColor(cCor)

Return NIL


**********************
Function SelEtiqueta()
**********************
Local aCliente , aDisp , nN , nOp , cRet , cTela , nMenu , cAtt2 , nLin ,aTemp
Local cTemp1 , cTemp2 , GetList := {} 

cAtt2 := space(15)
cRet := NIL
Use EMPRESAS Index EMPRESAS

cTela := SaveScreen(9,16,18,68)
Tela("R/W,W+/R",10,16,18,68)
SetColor("R/W,W+/R")
@ 11,19 Say "  Na etiqueta no campo Att (Aos cuidados de)  "
@ 12,19 Say "        vocˆ pretende imprimir o que ?        "
@ 14,19 Prompt "     Nao Imprimir nada (linha em branco)      "
@ 15,19 Prompt "  Imprimir o que esta gravado (Ex: SR.LUIZ)   "
@ 16,19 Prompt "Imprimir o mesmo para todos (Ex: DEPTO.VENDAS)"
Menu To nMenu
RestScreen(9,16,18,68,cTela)
If nMenu == 3
   cTela := SaveScreen(9,20,15,64)
   Tela("R/W,W+/R",10,20,15,64)
   SetColor("R/W,W+/R")
   @ 10,22 Say " Imprimir as etiquetas da Coneteel aos  "
   @ 11,22 Say "      cuidados de quem ? ( Att: )       "
   @ 12,28 Get cAtt2 picture "@!"
   Read
   RestScreen(9,20,15,64,cTela)
EndIf   

cTela := SaveScreen(8,6,22,75)
Tela("R/W,W+/R",9,6,22,75)
SetColor("R/W,W+/R")
@  9,16 Say "Selecione as Empresas para ImpressÆo das Etiquetas"
@ 10, 6 Say "Ã" + Replicate("Ä",65) + "´"
@ 11,25 Say "Clientes:           Imprimir:"
@ 18, 6 Say "Ã" + Replicate("Ä",65) + "´"
@ 19, 9 Say "<Enter> Marca/Desmarca   -   <F5> Imprime etiquetas marcadas"

aCliente := aDisp := {}
dbGoTop()
While ! EOF()
      Aadd( aCliente , EMPRESAS->CLIENTE )
      EMPRESAS->IMPRIMIR := .F.
      dbSkip()
End
nN := 1
aDisp := {}
While nN <= Len( aCliente )
      Aadd( aDisp , .t. )
      nN++
End
nN := 1
While .T.
      nOp := Achoice ( 13 , 25 , 17 , 53 , aCliente , aDisp , 'AuxAchDB' , nN )

      If nOp = -20
         exit
      ElseIf nOp = AC_ABORT
         cRet := "OK"
         exit
      Else
         If SUBSTR( aCliente[ nOp ] , -1 ) = CHR(158)
            dbSeek( LEFT( aCliente[ nOp ] , 12 ) )
            EMPRESAS->IMPRIMIR = .F.
            aCliente[ nOp ] := LEFT( aCliente[ nOp ] ,12 ) + Replicate(" ",13)
         ElseIf Lastkey() <> K_ESC .and. Lastkey() <> K_END
            dbSeek( LEFT( aCliente[ nOp ] , 12 ) )
            EMPRESAS->IMPRIMIR = .T.
            aCliente[ nOp ] := LEFT( aCliente[ nOp ] ,12 ) + Replicate(" ",12) + CHR(158)
         EndIf
         nN := nOp
      EndIf
End

RestScreen(8,6,22,75,cTela)

While TestaImpressora() <> "OK"
      inkey(00)
End

Set Device To Print
nLin:= 0

@ nLin , 0 Say CHR(27) + CHR(77) // Modo condensado
dbGoTop()
nN := RecNo()
aTemp := {}
While ! EOF()
      If EMPRESAS->IMPRIMIR = .T.
         Aadd( aTemp , RecNo() )
      EndIf
      dbSkip()
End
nN := 1
While nN <= Len( aTemp )
      dbGoTo( aTemp[nN] ) ; cTemp1 := EMPRESAS->EMPRESA
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTemp )
         dbGoTo( aTemp[nN + 1] ) ; cTemp2 := EMPRESAS->EMPRESA
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo negrito

      If nMenu = 1
         cTemp1 := cTemp2 := space(15)
         @ nLin   ,  0 Say cTemp1
         @ nLin++ , 43 Say cTemp2
      ElseIf nMenu = 2
         dbGoTo( aTemp[nN] ) ; cTemp1 := "ATT.: " + EMPRESAS->ATT
         If EMPRESAS->ATT = space(15)
            cTemp1 := space(15)
         EndIf
         @ nLin   ,  0 Say cTemp1
         If nN + 1 <= Len( aTemp )
            dbGoTo( aTemp[nN +1] ) ; cTemp2 := "ATT.: " + EMPRESAS->ATT
            If EMPRESAS->ATT = space(15)
               cTemp2 := space(15)
            EndIf
            @ nLin++ , 43 Say cTemp2
         Else
            nLin++
         EndIf
      ElseIf nMenu = 3
         cTemp1 := cTemp2 := cAtt2
         @ nLin   ,  0 Say cTemp1
         @ nLin++ , 43 Say cTemp2
      EndIf
           
      dbGoTo( aTemp[nN] ) ; cTemp1 := EMPRESAS->ENDERECO
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTemp )
         dbGoTo( aTemp[nN + 1] ) ; cTemp2 := EMPRESAS->ENDERECO
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      dbGoTo( aTemp[nN] ) ; cTemp1 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      If EMPRESAS->BAIRRO == space(15)
         cTemp1 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      EndIf
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTemp )
         dbGoTo( aTemp[nN+ 1] ) ; cTemp2 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         If EMPRESAS->BAIRRO == space(15)
            cTemp2 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         EndIf
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin , 0 Say CHR(27) + CHR(52) // Modo it lico
      dbGoTo( aTemp[nN] ) ; cTemp1 := "CEP: " + EMPRESAS->CEP 
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTemp )
         dbGoTo( aTemp[nN + 1] ) ; cTemp2 := "CEP: " + EMPRESAS->CEP
         @ nLin   , 43 Say cTemp2
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(53) // Cancela Modo It lico
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo Negrito
      nLin := nLin + 5
      nN := nN + 2
End

Eject
Set Device To Screen

Return cRet
   

***********************************
Function AuxAchDB(nModo,nElto,nPos)
***********************************

Local nRt:=AC_CONT , nTecla := Lastkey()

If nTecla = K_ESC
   nRt := -20
ElseIf nTecla = K_ENTER
   nRt := AC_SELECT
ElseIf nTecla = K_F5
   nRt := AC_ABORT
ElseIf nModo = 1
   Keyboard Chr( K_CTRL_PGDN )
ElseIf nModo = 2
   Keyboard Chr( K_CTRL_PGUP )
End

Return nRt

          


*******************************
Function ITodas()
*******************************
Local cTipo, nN , nLin := 1 , cTela , aTipo, nMenu , cAtt := space(15)
Local cAtt2, cTemp1, cTemp2, GetList := {}

Use EMPRESAS Index EMPRESAS

cTela := SaveScreen(9,16,18,68)
Tela("R/W,W+/R",10,16,18,68)
SetColor("R/W,W+/R")
@ 11,19 Say "Escolha qual dos itens voce pretende imprimir:"
@ 13,19 Prompt "                Todos Clientes                "
@ 14,19 Prompt "              Todos Fornecedores              "
@ 15,19 Prompt "         Todas Empresas de MalaDireta         "
@ 16,19 Prompt "          Todas Empresas Cadastradas          "
Menu To nMenu
RestScreen(9,16,18,68,cTela)
If nMenu == 1
   cTipo := "C"
ElseIf nMenu == 2
   cTipo := "F"
ElseIf nMenu == 3
   cTipo := "M"
ElseIf nMenu == 4
   cTipo := "T"
EndIf

cTela := SaveScreen(9,16,18,68)
Tela("R/W,W+/R",10,16,18,68)
SetColor("R/W,W+/R")
@ 11,19 Say "  Na etiqueta no campo Att (Aos cuidados de)  "
@ 12,19 Say "        vocˆ pretende imprimir o que ?        "
@ 14,19 Prompt "     Nao Imprimir nada (linha em branco)      "
@ 15,19 Prompt "  Imprimir o que esta gravado (Ex: SR.LUIZ)   "
@ 16,19 Prompt "Imprimir o mesmo para todos (Ex: DEPTO.VENDAS)"
Menu To nMenu
RestScreen(9,16,18,68,cTela)
If nMenu == 1
   cAtt := space(15)
ElseIf nMenu == 3
   cAtt2 := space(15)
   cTela := SaveScreen(9,20,15,64)
   Tela("R/W,W+/R",10,20,15,64)
   SetColor("R/W,W+/R")
   @ 10,22 Say " Imprimir as etiquetas da Coneteel aos  "
   @ 11,22 Say "      cuidados de quem ? ( Att: )       "
   @ 12,28 Get cAtt2 picture "@!"
   Read
   RestScreen(9,20,15,64,cTela)
EndIf   

aTipo := {}
dbGoTop()

If cTipo == "C"
   While ! EOF()
         If EMPRESAS->TIPO = "C"
            Aadd( aTipo , RecNo() )
         EndIf
         dbSkip()
   End
ElseIf cTipo == "F"
   While ! EOF()
         If EMPRESAS->TIPO = "F"
            Aadd( aTipo , RecNo() )
         EndIf
         dbSkip()
   End
ElseIf cTipo == "M"
   While ! EOF()
         If EMPRESAS->TIPO = "M"
            Aadd( aTipo , RecNo() )
         EndIf
         dbSkip()
   End
ElseIf cTipo == "T"
   While ! EOF()
         Aadd( aTipo , RecNo() )
         dbSkip()
   End
EndIf

While TestaImpressora() <> "OK"
      inkey(00)
End

Set Device To Print
nN := 1
nLin:= 0
@ nLin , 0 Say CHR(27) + CHR(77) // Modo condensado

While nN <= Len( aTipo )
      dbGoTo( aTipo[ nN ] ) ; cTemp1 := EMPRESAS->EMPRESA
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTipo )
         dbGoTo( aTipo[nN + 1] ) ; cTemp2 := EMPRESAS->EMPRESA
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo negrito
      If nMenu = 1
         cTemp1 := cTemp2 := space(15)
         @ nLin   ,  0 Say cTemp1
         @ nLin++ , 43 Say cTemp2
      ElseIf nMenu = 2
         dbGoTo( aTipo[nN] ) ; cTemp1 := "ATT.: " + EMPRESAS->ATT
         If EMPRESAS->ATT = space(15)
            cTemp1 := space(15)
         EndIf
         @ nLin   ,  0 Say cTemp1
         If nN + 1 <= Len( aTipo )
            dbGoTo( aTipo[nN +1] ) ; cTemp2 := "ATT.: " + EMPRESAS->ATT
            If EMPRESAS->ATT = space(15)
               cTemp2 := space(15)
            EndIf
            @ nLin++ , 43 Say cTemp2
         Else
            nLin++
         EndIf
      ElseIf nMenu == 3
         cTemp1 := cTemp2 := "ATT.: " + cAtt2
         @ nLin   ,  0 Say cTemp1
         @ nLin++ , 43 Say cTemp2
      EndIf
      dbGoTo( aTipo[nN] ) ; cTemp1 := EMPRESAS->ENDERECO
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTipo )
         dbGoTo( aTipo[nN + 1] ) ; cTemp2 := EMPRESAS->ENDERECO
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      dbGoTo( aTipo[nN] ) ; cTemp1 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      If EMPRESAS->BAIRRO == space(15)
         cTemp1 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      EndIf
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTipo )
         dbGoTo( aTipo[nN+ 1] ) ; cTemp2 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         If EMPRESAS->BAIRRO == space(15)
            cTemp2 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         EndIf
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin , 0 Say CHR(27) + CHR(52) // Modo it lico
      dbGoTo( aTipo[nN] ) ; cTemp1 := "CEP: " + EMPRESAS->CEP 
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aTipo )
         dbGoTo( aTipo[nN + 1] ) ; cTemp2 := "CEP: " + EMPRESAS->CEP
         @ nLin   , 43 Say cTemp2
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(53) // Cancela Modo It lico
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo Negrito
      nLin := nLin + 5
      nN := nN + 2
End
Eject
Set Device To Screen

dbCloseAll()
Return NIL



*******************
Function CfgDados()
*******************
Local aDisp , nN , nOp , cBairro , cCidade , cEstado , cCep , GetList := {}
Local cCliente , cTipo , cImprimir , cEmpresa , cCGC , cInscEsta , cEndereco
Local aEmpresas , cNovo , cAtt , cTela

Use EMPRESAS Index EMPRESAS

cCliente := cNovo := space(12)
cTipo := space(1)
cImprimir := .F.
cEmpresa := space(35)
cCGC := space(18)
cInscEsta := space(15)
cEndereco := space(35)
cBairro := cCidade := cAtt := space(15)
cEstado := space(2)
cCep := space(9)

aEmpresas := aDisp := {}
aEmpresas := { "Novo" }
dbGoTop()
While ! EOF()
      Aadd( aEmpresas , EMPRESAS->CLIENTE )
      dbSkip()
End
nN := 1
aDisp := {}
While nN <= Len( aEmpresas )
      Aadd( aDisp , .t. )
      nN++
End

MontaTela()
SetColor("B+/N+,GR+/G+")
@ 24,0  clear to 24,80
@ 24,0  Say "Mensagem :"
@  6,33 Say "DADOS EMPRESAS"
SetColor("B/N,B/W+")
@ 20, 4 Say "Ì" + Replicate("Í",70) + "¹"
@  7,18 Say "Ë"
For nN = 8 To 19
    @ nN , 18 Say "º"
Next
@ 20,18 Say "Ê"
SetColor("B+/N+,GR+/G+")
@  8,22 Say "Razao Social:"
@  8,59 Say "Aos cuidados de:"
@ 11,22 Say "CGC:"
@ 11,44 Say "Insc.Est.:"
@ 11,62 Say "Tipo(C,F,M):"
@ 14,22 Say "Endere‡o:"
@ 17,22 Say "Bairro:"
@ 17,39 Say "Cidade:"
@ 17,56 Say "Estado:"
@ 17,64 Say "CEP:"
@ 21, 6 Say "<Enter>Seleciona   <Esc> Volta Menu Principal"

nN := 1
While .T.
      @  8,5 Say "EMPRESA:"
      nOp := Achoice ( 10 , 5 , 19 , 17 , aEmpresas , aDisp , 'AuxAchCFG' , nN )

      If nOp = AC_ABORT   // Apertou Esc 
         exit
      ElseIf nOp = 1 // Selecionou Novo
         cCliente := cNovo := space(12)
         cTipo := space(1)
         cImprimir := .F.
         cEmpresa := space(35)
         cCGC := space(18)
         cInscEsta := space(15)
         cEndereco := space(35)
         cBairro := cCidade := cAtt := space(15)
         cEstado := space(2)
         cCep := space(9)
         cTela := SaveScreen(9,30,14,56)
         Tela("R/W,W+/R",10,30,14,56)
         SetColor("R/W,W+/R")
         @ 10,31 Say "Digite o apelido dessa"
         @ 11,31 Say "nova Empresa :"
         @ 12,31 Get cNovo picture "@!"
         Read
         SetColor("B+/N+,GR+/G+")
         dbSeek( cNovo )
         RestScreen(9,30,14,56,cTela)
         If Found()
            Tone( 200 , 4 )
            @ 24,10 Say "Empresa j  existe !!!"
            inkey(00)

            cCliente  := EMPRESAS->CLIENTE
            cTipo     := EMPRESAS->TIPO
            cImprimir := EMPRESAS->IMPRIMIR
            cEmpresa  := EMPRESAS->EMPRESA
            cAtt      := EMPRESAS->ATT
            cCGC      := EMPRESAS->CGC
            cInscEsta := EMPRESAS->INSCESTA
            cEndereco := EMPRESAS->ENDERECO
            cBairro   := EMPRESAS->BAIRRO
            cCidade   := EMPRESAS->CIDADE
            cEstado   := EMPRESAS->ESTADO
            cCep      := EMPRESAS->CEP
            @  9,22 Get cEmpresa Picture "@!"
            @  9,59 Get cAtt Picture "@!"
            @ 12,22 Get cCGC Picture "@9 99.999.999/9999-99"
            @ 12,44 Get cInscEsta Picture "@9 999.999.999.999"
            @ 12,62 Get cTipo Picture "@!" valid cTipo $ "CFM"
            @ 15,22 Get cEndereco Picture "@!"
            @ 18,22 Get cBairro Picture "@!"
            @ 18,39 Get cCidade Picture "@!"
            @ 18,56 Get cEstado Picture "@!"
            @ 18,64 Get cCep Picture "@9 99999-999"
            Read
            EMPRESAS->CLIENTE  := cCliente
            EMPRESAS->TIPO     := cTipo
            EMPRESAS->IMPRIMIR := .F.
            EMPRESAS->EMPRESA  := cEmpresa
            EMPRESAS->ATT      := cAtt
            EMPRESAS->CGC      := cCGC
            EMPRESAS->INSCESTA := cInscEsta
            EMPRESAS->ENDERECO := cEndereco
            EMPRESAS->BAIRRO   := cBairro 
            EMPRESAS->CIDADE   := cCidade
            EMPRESAS->ESTADO   := cEstado
            EMPRESAS->CEP      := cCep
            @  9,22 Say space(35)
            @  9,59 Say space(15)
            @ 12,22 Say space(18)
            @ 12,44 Say space(15)
            @ 12,62 Say space(1)
            @ 15,22 Say space(35)
            @ 18,22 Say space(15)
            @ 18,39 Say space(15)
            @ 18,56 Say space(2)
            @ 18,64 Say space(9)
         Else
            @  9,22 Get cEmpresa Picture "@!"
            @  9,59 Get cAtt Picture "@!"
            @ 12,22 Get cCGC Picture "@9 99.999.999/9999-99"
            @ 12,44 Get cInscEsta Picture "@9 999.999.999.999"
            @ 12,62 Get cTipo Picture "@!" valid cTipo $ "CFM"
            @ 15,22 Get cEndereco Picture "@!"
            @ 18,22 Get cBairro Picture "@!"
            @ 18,39 Get cCidade Picture "@!"
            @ 18,56 Get cEstado Picture "@!"
            @ 18,64 Get cCep Picture "@9 99999-999"
            Read
            dbAppend()
            EMPRESAS->CLIENTE  := cNovo
            EMPRESAS->TIPO     := cTipo
            EMPRESAS->IMPRIMIR := .F.
            EMPRESAS->EMPRESA  := cEmpresa
            EMPRESAS->ATT      := cAtt
            EMPRESAS->CGC      := cCGC
            EMPRESAS->INSCESTA := cInscEsta
            EMPRESAS->ENDERECO := cEndereco
            EMPRESAS->BAIRRO   := cBairro 
            EMPRESAS->CIDADE   := cCidade
            EMPRESAS->ESTADO   := cEstado
            EMPRESAS->CEP      := cCep
            @  9,22 Say space(35)
            @  9,59 Say space(15)
            @ 12,22 Say space(18)
            @ 12,44 Say space(15)
            @ 12,62 Say space(1)
            @ 15,22 Say space(35)
            @ 18,22 Say space(15)
            @ 18,39 Say space(15)
            @ 18,56 Say space(2)
            @ 18,64 Say space(9)
         EndIf
      Else
         SetColor("B+/N+,GR+/G+")
         dbSeek( aEmpresas[ nOp ] )
         If Found()
            Tone(300,3)
         EndIf
         cCliente  := EMPRESAS->CLIENTE
         cTipo     := EMPRESAS->TIPO
         cImprimir := EMPRESAS->IMPRIMIR
         cEmpresa  := EMPRESAS->EMPRESA
         cAtt      := EMPRESAS->ATT
         cCGC      := EMPRESAS->CGC
         cInscEsta := EMPRESAS->INSCESTA
         cEndereco := EMPRESAS->ENDERECO
         cBairro   := EMPRESAS->BAIRRO
         cCidade   := EMPRESAS->CIDADE
         cEstado   := EMPRESAS->ESTADO
         cCep      := EMPRESAS->CEP
         @  9,22 Get cEmpresa Picture "@!"
         @  9,59 Get cAtt Picture "@!"
         @ 12,22 Get cCGC Picture "@9 99.999.999/9999-99"
         @ 12,44 Get cInscEsta Picture "@9 999.999.999.999"
         @ 12,62 Get cTipo Picture "@!" valid cTipo $ "CFM"
         @ 15,22 Get cEndereco Picture "@!"
         @ 18,22 Get cBairro Picture "@!"
         @ 18,39 Get cCidade Picture "@!"
         @ 18,56 Get cEstado Picture "@!"
         @ 18,64 Get cCep Picture "@9 99999-999"
         Read

         EMPRESAS->CLIENTE  := cCliente
         EMPRESAS->TIPO     := cTipo
         EMPRESAS->IMPRIMIR := .F.
         EMPRESAS->EMPRESA  := cEmpresa
         EMPRESAS->ATT      := cAtt
         EMPRESAS->CGC      := cCGC
         EMPRESAS->INSCESTA := cInscEsta
         EMPRESAS->ENDERECO := cEndereco
         EMPRESAS->BAIRRO   := cBairro 
         EMPRESAS->CIDADE   := cCidade
         EMPRESAS->ESTADO   := cEstado
         EMPRESAS->CEP      := cCep

         @  9,22 Say space(35)
         @  9,59 Say space(15)
         @ 12,22 Say space(18)
         @ 12,44 Say space(15)
         @ 12,62 Say space(1)
         @ 15,22 Say space(35)
         @ 18,22 Say space(15)
         @ 18,39 Say space(15)
         @ 18,56 Say space(2)
         @ 18,64 Say space(9)
         nN := nOp
      EndIf
End

dbCloseAll()
Return NIL



************************************
Function AuxAchCFG(nModo,nElto,nPos)
************************************
Local nRt := AC_CONT , nTecla := Lastkey()
MEMVAR AAA

If nTecla = K_ENTER
   nRt := AC_SELECT
ElseIf nTecla = K_ESC
   nRt := AC_ABORT
ElseIf nModo = 1
   Keyboard Chr( K_CTRL_PGDN )
ElseIf nModo = 2
   Keyboard Chr( K_CTRL_PGUP )
ElseIf nTecla = K_CTRL_PGUP
   Keyboard Chr( K_CTRL_PGUP )
End

Return nRt



*******************
Function PrintUma()
*******************
Local aDisp , nN , nOp , cBairro , cCidade , cEstado , cCep , GetList := {}
Local cCliente , cTipo , lImprimir , cEmpresa , cCGC , cInscEsta , cEndereco
Local aEmpresas , cTemp1 , cTemp2 , nLin , cAtt

Use EMPRESAS Index EMPRESAS
Index On EMPRESAS->CLIENTES To EMPRESAS

cEmpresa := space(35)
cCGC := space(18)
cInscEsta := cCliente := space(15)
cEndereco := space(35)
cBairro := cCidade := cAtt := space(15)
cEstado := space(2)
cCep := space(9)
cTipo := space(1)
lImprimir := .f.

MontaTela()
SetColor("B+/N+,GR+/G+")
@ 24,0  clear to 24,80
@ 24,0  Say "Mensagem :"
@  6,12 Say "Digite os Dados das Empresas para ImpressÆo SEM ACENTOS !" color "B+*/N"
SetColor("B/N,B/W+")
@ 20, 4 Say "Ì" + Replicate("Í",70) + "¹"
SetColor("B+/N+,GR+/G+")

aEmpresas:={}
While LastKey() <> K_ESC
      cEmpresa := space(35)
      cCGC := space(18)
      cInscEsta := cAtt := space(15)
      cEndereco := space(35)
      cBairro := cCidade := space(15)
      cEstado := space(2)
      cCep := space(9)
      @  8,10 clear to 18,72
      @  8,12 Say "Razao Social:"
      @  9,12 Get cEmpresa Picture "@!" valid cEmpresa <> space(35)
      Read
      dbGoTop()
      dbSeek( cEmpresa )
      If Found()
         cEmpresa  := EMPRESAS->EMPRESA
         cAtt      := EMPRESAS->ATT
         cCGC      := EMPRESAS->CGC      
         cInscEsta := EMPRESAS->INSCESTA 
         cEndereco := EMPRESAS->ENDERECO 
         cBairro   := EMPRESAS->BAIRRO   
         cCidade   := EMPRESAS->CIDADE   
         cEstado   := EMPRESAS->ESTADO   
         cCep      := EMPRESAS->CEP
         @  9,12 Get cEmpresa Picture "@!"
         @  8,50 Say "Aos cuidados de:"
         @  9,50 Get cAtt Picture "@!"
         @ 11,12 Say "CGC:"
         @ 12,12 Get cCGC Picture "@9 99.999.999/9999-99"
         @ 11,54 Say "Insc.Est.:"
         @ 12,54 Get cInscEsta Picture "@9 999.999.999.999"
         @ 14,12 Say "Endere‡o:"
         @ 15,12 Get cEndereco Picture "@!"
         @ 17,12 Say "Bairro:"
         @ 18,12 Get cBairro Picture "@!"
         @ 17,32 Say "Cidade:"
         @ 18,32 Get cCidade Picture "@!"
         @ 17,53 Say "Estado:"
         @ 18,53 Get cEstado Picture "@!"
         @ 17,64 Say "CEP:"
         @ 18,64 Get cCep Picture "@9 99999-999"
         @ 21,12 Say "<Enter> Seleciona   <Esc> Imprime e Volta Menu Principal"
         If LastKey() = K_ESC
            exit
         EndIf
         Read
         EMPRESAS->EMPRESA  := cEmpresa
         EMPRESAS->ATT      := cAtt
         EMPRESAS->CGC      := cCGC
         EMPRESAS->INSCESTA := cInscEsta
         EMPRESAS->ENDERECO := cEndereco
         EMPRESAS->BAIRRO   := cBairro
         EMPRESAS->CIDADE   := cCidade
         EMPRESAS->ESTADO   := cEstado
         EMPRESAS->CEP      := cCep
      Else
         @  8,50 Say "Aos cuidados de:"
         @  9,50 Get cAtt Picture "@!"
         @ 11,12 Say "CGC:"
         @ 12,12 Get cCGC Picture "@9 99.999.999/9999-99"
         @ 11,54 Say "Insc.Est.:"
         @ 12,54 Get cInscEsta Picture "@9 999.999.999.999"
         @ 14,12 Say "Endere‡o:"
         @ 15,12 Get cEndereco Picture "@!"
         @ 17,12 Say "Bairro:"
         @ 18,12 Get cBairro Picture "@!"
         @ 17,32 Say "Cidade:"
         @ 18,32 Get cCidade Picture "@!"
         @ 17,53 Say "Estado:"
         @ 18,53 Get cEstado Picture "@!"
         @ 17,64 Say "CEP:"
         @ 18,64 Get cCep Picture "@9 99999-999"
         @ 21,12 Say "<Enter> Seleciona   <Esc> Imprime e Volta Menu Principal"
         If LastKey() = K_ESC
            exit
         EndIf
         Read
         dbAppend()
         EMPRESAS->EMPRESA  := cEmpresa
         EMPRESAS->ATT      := cAtt
         EMPRESAS->CGC      := cCGC
         EMPRESAS->INSCESTA := cInscEsta
         EMPRESAS->ENDERECO := cEndereco
         EMPRESAS->BAIRRO   := cBairro
         EMPRESAS->CIDADE   := cCidade
         EMPRESAS->ESTADO   := cEstado
         EMPRESAS->CEP      := cCep
      End
      Aadd( aEmpresas , RecNo() )
End

While TestaImpressora() <> "OK"
      inkey(00)
End

Set Device To Print
nLin:= 0
nN := 1

@ nLin , 0 Say CHR(27) + CHR(77) // Modo condensado
While nN <= Len( aEmpresas )
      dbGoTo( aEmpresas[ nN ] ) ; cTemp1 := EMPRESAS->EMPRESA
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aEmpresas )
         dbGoTo( aEmpresas[ nN + 1 ] ) ; cTemp2 := EMPRESAS->EMPRESA
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo negrito

      dbGoTo( aEmpresas[ nN ] ) ; cTemp1 := "ATT.: " + EMPRESAS->ATT
      If EMPRESAS->ATT = space(15)
         cTemp1 := space(15)
      EndIf
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aEmpresas )
         dbGoTo( aEmpresas[ nN + 1 ] ) ; cTemp2 := "ATT.: " + EMPRESAS->ATT
         If EMPRESAS->ATT = space(15)
            cTemp2 := space(15)
         EndIf
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf

      dbGoTo( aEmpresas[ nN ] ) ; cTemp1 := EMPRESAS->ENDERECO
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aEmpresas )
         dbGoTo( aEmpresas[ nN + 1 ] ) ; cTemp2 := EMPRESAS->ENDERECO
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      dbGoTo( aEmpresas[ nN ] ) ; cTemp1 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      If EMPRESAS->BAIRRO == space(15)
         cTemp1 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
      EndIf
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aEmpresas )
         dbGoTo( aEmpresas[ nN + 1 ] ) ; cTemp2 := RTRIM( EMPRESAS->BAIRRO ) + " - " + RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         If EMPRESAS->BAIRRO == space(15)
            cTemp2 := RTRIM( EMPRESAS->CIDADE ) + " - (" + EMPRESAS->ESTADO + ")"
         EndIf
         @ nLin++ , 43 Say cTemp2
      Else
         nLin++
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin , 0 Say CHR(27) + CHR(52) // Modo it lico
      dbGoTo( aEmpresas[ nN ] ) ; cTemp1 := "CEP: " + EMPRESAS->CEP 
      @ nLin   ,  0 Say cTemp1
      If nN + 1 <= Len( aEmpresas )
         dbGoTo( aEmpresas[ nN + 1 ] ) ; cTemp2 := "CEP: " + EMPRESAS->CEP
         @ nLin   , 43 Say cTemp2
      EndIf
      @ nLin , 0 Say CHR(27) + CHR(53) // Cancela Modo It lico
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo Negrito
      nLin := nLin + 5
      nN := nN + 2
End

Eject
Set Device To Screen

Return NIL



*******************************
Function ITCheques()
*******************************
Local nN , nLin , nNum := 0 , GetList := {} , cAtt := space(25)

Tela("R/W,W+/R",10,20,15,64)
SetColor("R/W,W+/R")
@ 10,21 Say "Quantas etiquetas da Conesteel vocˆ quer"
@ 11,21 Say "  imprimir na impressora Epson LX-300 ? "
@ 12,39 Get nNum picture "@9 9999"
Read

While TestaImpressora() <> "OK"
      inkey(00)
End

Set Device To Print
nLin:= 0
nN := 1

@ nLin , 0 Say CHR(27) + CHR(77) // Modo condensado
While nN <= nNum
      @ nLin , 0 Say CHR(27) + CHR(69) // Modo negrito
      @ nLin   ,  1 Say "CONESTEEL CONEXOES DE A€O LTDA."
      @ nLin++ , 44 Say "CONESTEEL CONEXOES DE A€O LTDA."
      @ nLin , 0 Say CHR(27) + CHR(70) // Cancela Modo negrito
      @ nLin   ,  1 Say "C.G.C.(M.F.) 55.783.427/0001-03"
      @ nLin++ , 44 Say "C.G.C.(M.F.) 55.783.427/0001-03"
      @ nLin   ,  1 Say "AV. MONTEMAGNO, 2454 - V.FORMOSA"
      @ nLin++ , 44 Say "AV. MONTEMAGNO, 2454 - V.FORMOSA"
      @ nLin   ,  1 Say "SAO PAULO - (SP) - CEP 03371-001"
      @ nLin++ , 44 Say "SAO PAULO - (SP) - CEP 03371-001"
      @ nLin   ,  1 Say "Fone: 6910-1444 - Fax: 6910-5701"
      @ nLin++ , 44 Say "Fone: 6910-1444 - Fax: 6910-5701"
      nLin := nLin + 4
      nN := nN + 2
End
Eject
Set Device To Screen

Return NIL

 
*****************************************************************************
// FUN€OES AUXILIARES DAS FUNCOES CQVAL() E CQCON()
*****************************************************************************

*****************************
Function FontePequena( nLin )
*****************************
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(050)+CHR(048)+CHR(072)
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(051)+CHR(084)
Return NIL

*****************************
Function FonteGrande( nLin )
*****************************
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(053)+CHR(072)
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(051)+CHR(084)
Return NIL

*****************************
Function FonteNormal( nLin )
*****************************
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(049)+CHR(048)+CHR(072)
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(051)+CHR(084)
Return NIL

*****************************
Function FonteNegrito( nLin )
*****************************
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(051)+CHR(066)
Return NIL

***************************
Function FonteClara( nLin )
***************************
@ nLin,0 Say CHR(027)+CHR(040)+CHR(115)+CHR(048)+CHR(066)
Return NIL


