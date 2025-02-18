      *====================================================             00010000
       IDENTIFICATION                            DIVISION.              00020000
      *====================================================             00030000
       PROGRAM-ID. FR16DB01.                                            00040000
      *====================================================             00061000
      *             T R E I N A M E N T O                 *             00062000
      *====================================================             00063000
      * PROGRAMA......: FR16DB01.                         *             00064000
      *---------------------------------------------------*             00066000
      * PROGRAMADOR...: LUCIANO GUIMARAES.                *             00067000
      * DATA..........: 07/06/2022                        *             00068000
      * EMPRESA.......: FOURSYS                           *             00069000
      * INSTRUTOR.....: IVAN SANCHES                      *             00069100
      *---------------------------------------------------*             00069200
      * OBJETIVO......: ACESSAR A TABELA DB2 FUNC E LER   *             00069302
      *                 UM REGISTRO.                      *             00069402
      *                                                   *             00070000
      *----------------------------------------------------             00080000
      *====================================================             00110000
       ENVIRONMENT                               DIVISION.              00120000
      *====================================================             00130000
       CONFIGURATION                             SECTION.               00131000
       SPECIAL-NAMES.                                                   00132000
           DECIMAL-POINT  IS COMMA.                                     00133000
                                                                        00134000
      *====================================================             00135000
       DATA                                      DIVISION.              00136000
      *====================================================             00137000
       WORKING-STORAGE                           SECTION.               00138001
      *----------------------------------------------------             00138101
                                                                        00138201
           EXEC SQL                                                     00139001
              INCLUDE #BKFUNC                                           00139101
           END-EXEC.                                                    00139201
                                                                        00139301
           EXEC SQL                                                     00139401
              INCLUDE SQLCA                                             00139501
           END-EXEC.                                                    00139601
                                                                        00139701
      *----------------VARIAVEIS DE APOIO------------------             00139803
       77 WRK-ID              PIC 9(05) VALUE ZEROS.                    00139903
       77 WRK-SQLCODE         PIC -999.                                 00140003
       77 WRK-NULL-EMAIL      PIC S9(4) COMP.                           00150003
                                                                        00151003
      *====================================================             00153000
       PROCEDURE                                 DIVISION.              00154000
      *====================================================             00155000
      *****************************************************             00155100
      *          R O T I N A   P R I N C I P A L          *             00155200
      *****************************************************             00155300
      *----------------------------------------------------             00156000
       0000-PRINCIPAL                            SECTION.               00157000
      *----------------------------------------------------             00157100
                                                                        00157200
            PERFORM 1000-INICIALIZAR.                                   00157302
            PERFORM 2000-PROCESSAR.                                     00157506
            PERFORM 3000-FINALIZAR.                                     00157806
               GOBACK.                                                  00157902
                                                                        00158000
      *----------------------------------------------------             00158100
       0000-99-FIM.                               EXIT.                 00158200
      *----------------------------------------------------             00158300
      *****************************************************             00158400
      *             I N I C I A L I Z A R                 *             00158500
      *****************************************************             00158600
      *----------------------------------------------------             00158700
       1000-INICIALIZAR                           SECTION.              00158800
      *----------------------------------------------------             00158900
                                                                        00159000
            ACCEPT WRK-ID FROM SYSIN.                                   00159102
                                                                        00159200
      *----------------------------------------------------             00159800
       1000-99-FIM.                                 EXIT.               00159900
      *----------------------------------------------------             00160000
      *****************************************************             00160100
      *               P R O C E S S A R                   *             00160200
      *****************************************************             00160300
      *----------------------------------------------------             00160400
       2000-PROCESSAR                             SECTION.              00160500
      *----------------------------------------------------             00160600
            MOVE WRK-ID TO DB2-ID.                                      00160702
                                                                        00160802
            EXEC SQL                                                    00160902
            SELECT ID,NOME,SETOR,SALARIO,DATAADM,EMAIL                  00161002
              INTO :DB2-ID,                                             00161102
                   :DB2-NOME,                                           00161202
                   :DB2-SETOR,                                          00161302
                   :DB2-SALARIO,                                        00161402
                   :DB2-DATAADM,                                        00161502
                   :DB2-EMAIL    :WRK-NULL-EMAIL                        00161602
               FROM  IVAN.FUNC                                          00161702
              WHERE ID = :DB2-ID                                        00161802
            END-EXEC.                                                   00161902
                                                                        00162002
            EVALUATE SQLCODE                                            00162102
             WHEN 0                                                     00162202
                DISPLAY '.............................'.                00162304
                DISPLAY 'ID      : ' DB2-ID.                            00162404
                DISPLAY 'NOME    : ' DB2-NOME.                          00162504
                DISPLAY 'SETOR   : ' DB2-SETOR.                         00162604
                DISPLAY 'SALARIO : ' DB2-SALARIO.                       00162704
                DISPLAY 'DATAADM : ' DB2-DATAADM.                       00162804
                IF WRK-NULL-EMAIL = 0                                   00163002
                   DISPLAY 'EMAIL  : ' DB2-EMAIL                        00163102
                ELSE                                                    00163202
                   DISPLAY 'EMAIL NULO'                                 00163302
                END-IF                                                  00163402
             WHEN 100                                                   00163502
                DISPLAY 'NAO ENCONTRADO' DB2-ID                         00163602
             WHEN OTHER                                                 00163702
                MOVE SQLCODE TO  WRK-SQLCODE                            00163802
                DISPLAY 'ERRO NA LEITURA' WRK-SQLCODE                   00163902
            END-EVALUATE.                                               00164002
                                                                        00164100
                                                                        00164200
      *----------------------------------------------------             00164300
       2000-99-FIM.                                EXIT.                00164400
      *----------------------------------------------------             00164500
      *****************************************************             00164600
      *               F I N A L I Z A R                   *             00164700
      *****************************************************             00164800
      *----------------------------------------------------             00164900
       3000-FINALIZAR                             SECTION.              00165000
      *----------------------------------------------------             00165100
                                                                        00165200
            DISPLAY ' '.                                                00165302
            DISPLAY '-FIM DO PROGRAMA-'.                                00165402
                                                                        00165500
      *----------------------------------------------------             00165600
       3000-99-FIM.                                  EXIT.              00165700
      *----------------------------------------------------             00166000
