/****************************************************************************
*                        ETICON - Etiquetas Conesteel                       *
*        Programa feito por Maurício Fernandes Raphael em 23/10/98          *
*                    Conesteel Conexões de Aço Ltda.                        *
****************************************************************************/

Local nMenu , nLin

Set Century On
Set Date To British
Set Device to Screen
Set Message To 24 Center
Set Confirm On
Set Wrap On
SetColor("GR+/B,B/W+")

Use EMPRESAS
Index On EMPRESAS->CLIENTE To EMPRESAS
dbCloseAll()

While .T.
      MontaTela()
      SetColor("B+/N+,GR+/G+")
      @ 24,0 clear to 24,80
      @ 24,0 Say "Mensagem :"
      @  6,33 Say "MENU PRINCIPAL"
      @  9,19 Prompt "          Imprimir todas etiquetas         " message "Seleciona todas etiquetas para imprimir"
      @ 11,19 Prompt "Selecionar empresas para imprimir etiquetas" message "Imprime Etiquetas Selecionadas"
      @ 13,19 Prompt "        Imprimir apenas uma etiqueta       " message "Imprime Apenas uma Etiqueta"
      @ 15,19 Prompt "      Imprimir etiquetas da Conesteel      " message "Imprime Etiquetas da Conesteel"
      @ 17,19 Prompt " Imprimir etiquetas Conesteel para Cheques " message "Imprime Etiquetas da Conesteel para cheques"
      @ 19,19 Prompt "        Configura‡äes Dados Empresas       " message "Dados da Etiqueta dos Clientes"
      @ 21,19 Prompt "               Sair do Sistema             " message "Sai do sistema"
      Menu To nMenu
      If nMenu = 1
         ITodas()
      ElseIf nMenu = 2
         SelEtiqueta()
      ElseIf nMenu = 3
         PrintUma()
      ElseIf nMenu = 4
         ITConesteel()
      ElseIf nMenu = 5
         ITCheques()
      ElseIf nMenu = 6
         CfgDados()
      Else
         SetColor("W/N")
         Cls         
         Exit
      EndIf
End 

Cls
Clear Typeahead
Return

