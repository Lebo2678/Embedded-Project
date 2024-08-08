
_main:

;Project.c,9 :: 		void main() {
;Project.c,10 :: 		ADCON1 = 7;
	MOVLW      7
	MOVWF      ADCON1+0
;Project.c,11 :: 		trisA.B0 = 1;
	BSF        TRISA+0, 0
;Project.c,12 :: 		trisA.B1 = 1;
	BSF        TRISA+0, 1
;Project.c,13 :: 		trisA.B2 = 1;
	BSF        TRISA+0, 2
;Project.c,14 :: 		trisB = 0;
	CLRF       TRISB+0
;Project.c,15 :: 		portB = 0;
	CLRF       PORTB+0
;Project.c,16 :: 		trisC = 0;
	CLRF       TRISC+0
;Project.c,17 :: 		portC = 0;
	CLRF       PORTC+0
;Project.c,18 :: 		trisD = 0;
	CLRF       TRISD+0
;Project.c,19 :: 		portD = 0;
	CLRF       PORTD+0
;Project.c,21 :: 		while(1) {
L_main0:
;Project.c,22 :: 		if (portA.B0 == 0) {
	BTFSC      PORTA+0, 0
	GOTO       L_main2
;Project.c,23 :: 		portd.B7 = 1;
	BSF        PORTD+0, 7
;Project.c,24 :: 		if (portA.B1 == 1) {
	BTFSS      PORTA+0, 1
	GOTO       L_main3
;Project.c,25 :: 		Automatic();
	CALL       _Automatic+0
;Project.c,26 :: 		}
	GOTO       L_main4
L_main3:
;Project.c,28 :: 		Manual();
	CALL       _manual+0
;Project.c,29 :: 		}
L_main4:
;Project.c,30 :: 		}
	GOTO       L_main5
L_main2:
;Project.c,33 :: 		portB = 0;
	CLRF       PORTB+0
;Project.c,34 :: 		portC = 0xff;
	MOVLW      255
	MOVWF      PORTC+0
;Project.c,35 :: 		portD = 0;
	CLRF       PORTD+0
;Project.c,36 :: 		}
L_main5:
;Project.c,37 :: 		}
	GOTO       L_main0
;Project.c,38 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_Automatic:

;Project.c,40 :: 		void Automatic()
;Project.c,42 :: 		w_count = 23;
	MOVLW      23
	MOVWF      _w_count+0
	MOVLW      0
	MOVWF      _w_count+1
;Project.c,43 :: 		s_count = 15;
	MOVLW      15
	MOVWF      _s_count+0
	MOVLW      0
	MOVWF      _s_count+1
;Project.c,44 :: 		while(portA.B0 != 1) {
L_Automatic6:
	BTFSC      PORTA+0, 0
	GOTO       L_Automatic7
;Project.c,45 :: 		if (str == 'w') {
	MOVF       _str+0, 0
	XORLW      119
	BTFSS      STATUS+0, 2
	GOTO       L_Automatic8
;Project.c,46 :: 		if (w_count > 3) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _w_count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Automatic36
	MOVF       _w_count+0, 0
	SUBLW      3
L__Automatic36:
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic9
;Project.c,47 :: 		portd = 0b10001100;
	MOVLW      140
	MOVWF      PORTD+0
;Project.c,48 :: 		portb = ((w_count % 10) << 4) + ((w_count - 3) % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _w_count+0, 0
	MOVWF      R0+0
	MOVF       _w_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Automatic+0
	MOVF       R2+0, 0
L__Automatic37:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic38
	RLF        FLOC__Automatic+0, 1
	BCF        FLOC__Automatic+0, 0
	ADDLW      255
	GOTO       L__Automatic37
L__Automatic38:
	MOVLW      3
	SUBWF      _w_count+0, 0
	MOVWF      FLOC__Automatic+1
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _w_count+1, 0
	MOVWF      FLOC__Automatic+2
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Automatic+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Automatic+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      FLOC__Automatic+0, 0
	MOVWF      PORTB+0
;Project.c,49 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,50 :: 		portb = ((w_count / 10) << 4) + ((w_count - 3) / 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _w_count+0, 0
	MOVWF      R0+0
	MOVF       _w_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Automatic+0
	MOVF       R2+0, 0
L__Automatic39:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic40
	RLF        FLOC__Automatic+0, 1
	BCF        FLOC__Automatic+0, 0
	ADDLW      255
	GOTO       L__Automatic39
L__Automatic40:
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Automatic+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Automatic+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDWF      FLOC__Automatic+0, 0
	MOVWF      PORTB+0
;Project.c,51 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,52 :: 		}
	GOTO       L_Automatic10
L_Automatic9:
;Project.c,54 :: 		portd = 0b10001010;
	MOVLW      138
	MOVWF      PORTD+0
;Project.c,55 :: 		portb = ((w_count % 10) << 4) + ((w_count) % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _w_count+0, 0
	MOVWF      R0+0
	MOVF       _w_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__Automatic41:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic42
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__Automatic41
L__Automatic42:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTB+0
;Project.c,56 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,57 :: 		portb = ((w_count / 10) << 4) + ((w_count) / 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _w_count+0, 0
	MOVWF      R0+0
	MOVF       _w_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__Automatic43:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic44
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__Automatic43
L__Automatic44:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTB+0
;Project.c,58 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,59 :: 		}
L_Automatic10:
;Project.c,60 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Automatic11:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic11
	DECFSZ     R12+0, 1
	GOTO       L_Automatic11
	DECFSZ     R11+0, 1
	GOTO       L_Automatic11
	NOP
	NOP
;Project.c,61 :: 		w_count--;
	MOVLW      1
	SUBWF      _w_count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _w_count+1, 1
;Project.c,62 :: 		if (w_count == 0) {
	MOVLW      0
	XORWF      _w_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Automatic45
	MOVLW      0
	XORWF      _w_count+0, 0
L__Automatic45:
	BTFSS      STATUS+0, 2
	GOTO       L_Automatic12
;Project.c,63 :: 		w_count = 23;
	MOVLW      23
	MOVWF      _w_count+0
	MOVLW      0
	MOVWF      _w_count+1
;Project.c,64 :: 		str = 's';
	MOVLW      115
	MOVWF      _str+0
;Project.c,65 :: 		}
L_Automatic12:
;Project.c,66 :: 		}
	GOTO       L_Automatic13
L_Automatic8:
;Project.c,68 :: 		if (s_count > 3) {
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      _s_count+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Automatic46
	MOVF       _s_count+0, 0
	SUBLW      3
L__Automatic46:
	BTFSC      STATUS+0, 0
	GOTO       L_Automatic14
;Project.c,69 :: 		portd = 0b10100001;
	MOVLW      161
	MOVWF      PORTD+0
;Project.c,70 :: 		portb = (((s_count - 3) % 10) << 4) + (s_count % 10);
	MOVLW      3
	SUBWF      _s_count+0, 0
	MOVWF      FLOC__Automatic+1
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _s_count+1, 0
	MOVWF      FLOC__Automatic+2
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Automatic+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Automatic+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Automatic+0
	MOVF       R2+0, 0
L__Automatic47:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic48
	RLF        FLOC__Automatic+0, 1
	BCF        FLOC__Automatic+0, 0
	ADDLW      255
	GOTO       L__Automatic47
L__Automatic48:
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _s_count+0, 0
	MOVWF      R0+0
	MOVF       _s_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	ADDWF      FLOC__Automatic+0, 0
	MOVWF      PORTB+0
;Project.c,71 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,72 :: 		portb = (((s_count - 3) / 10) << 4) + (s_count / 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FLOC__Automatic+1, 0
	MOVWF      R0+0
	MOVF       FLOC__Automatic+2, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      4
	MOVWF      R2+0
	MOVF       R0+0, 0
	MOVWF      FLOC__Automatic+0
	MOVF       R2+0, 0
L__Automatic49:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic50
	RLF        FLOC__Automatic+0, 1
	BCF        FLOC__Automatic+0, 0
	ADDLW      255
	GOTO       L__Automatic49
L__Automatic50:
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _s_count+0, 0
	MOVWF      R0+0
	MOVF       _s_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	ADDWF      FLOC__Automatic+0, 0
	MOVWF      PORTB+0
;Project.c,73 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,74 :: 		}
	GOTO       L_Automatic15
L_Automatic14:
;Project.c,76 :: 		portd = 0b10010001;
	MOVLW      145
	MOVWF      PORTD+0
;Project.c,77 :: 		portb = ((s_count % 10) << 4) + ((s_count) % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _s_count+0, 0
	MOVWF      R0+0
	MOVF       _s_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__Automatic51:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic52
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__Automatic51
L__Automatic52:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTB+0
;Project.c,78 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,79 :: 		portb = ((s_count / 10) << 4) + ((s_count) / 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       _s_count+0, 0
	MOVWF      R0+0
	MOVF       _s_count+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__Automatic53:
	BTFSC      STATUS+0, 2
	GOTO       L__Automatic54
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__Automatic53
L__Automatic54:
	MOVF       R0+0, 0
	ADDWF      R2+0, 0
	MOVWF      PORTB+0
;Project.c,80 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,81 :: 		}
L_Automatic15:
;Project.c,82 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_Automatic16:
	DECFSZ     R13+0, 1
	GOTO       L_Automatic16
	DECFSZ     R12+0, 1
	GOTO       L_Automatic16
	DECFSZ     R11+0, 1
	GOTO       L_Automatic16
	NOP
	NOP
;Project.c,83 :: 		s_count--;
	MOVLW      1
	SUBWF      _s_count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _s_count+1, 1
;Project.c,84 :: 		if (s_count == 0) {
	MOVLW      0
	XORWF      _s_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Automatic55
	MOVLW      0
	XORWF      _s_count+0, 0
L__Automatic55:
	BTFSS      STATUS+0, 2
	GOTO       L_Automatic17
;Project.c,85 :: 		s_count = 23;
	MOVLW      23
	MOVWF      _s_count+0
	MOVLW      0
	MOVWF      _s_count+1
;Project.c,86 :: 		str = 'w';
	MOVLW      119
	MOVWF      _str+0
;Project.c,87 :: 		}
L_Automatic17:
;Project.c,88 :: 		}
L_Automatic13:
;Project.c,89 :: 		if (portA.B1 != 1) {
	BTFSC      PORTA+0, 1
	GOTO       L_Automatic18
;Project.c,90 :: 		break;
	GOTO       L_Automatic7
;Project.c,91 :: 		}
L_Automatic18:
;Project.c,92 :: 		}
	GOTO       L_Automatic6
L_Automatic7:
;Project.c,93 :: 		}
L_end_Automatic:
	RETURN
; end of _Automatic

_Manual:

;Project.c,95 :: 		void Manual()
;Project.c,97 :: 		y_count = 3;
	MOVLW      3
	MOVWF      _y_count+0
	MOVLW      0
	MOVWF      _y_count+1
;Project.c,98 :: 		while(portA.B0 != 1) {
L_Manual19:
	BTFSC      PORTA+0, 0
	GOTO       L_Manual20
;Project.c,99 :: 		if (str == 'w') {
	MOVF       _str+0, 0
	XORLW      119
	BTFSS      STATUS+0, 2
	GOTO       L_Manual21
;Project.c,100 :: 		if (portA.B2 == 1) {
	BTFSS      PORTA+0, 2
	GOTO       L_Manual22
;Project.c,101 :: 		portd = 0b10001100;
	MOVLW      140
	MOVWF      PORTD+0
;Project.c,102 :: 		portb = 0;
	CLRF       PORTB+0
;Project.c,103 :: 		portc = 0b00001111; portc = 0;
	MOVLW      15
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,104 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Manual23:
	DECFSZ     R13+0, 1
	GOTO       L_Manual23
	DECFSZ     R12+0, 1
	GOTO       L_Manual23
	DECFSZ     R11+0, 1
	GOTO       L_Manual23
	NOP
;Project.c,105 :: 		}
	GOTO       L_Manual24
L_Manual22:
;Project.c,107 :: 		portd = 0b10001010;
	MOVLW      138
	MOVWF      PORTD+0
;Project.c,108 :: 		portb = y_count + (y_count << 4);
	MOVLW      4
	MOVWF      R1+0
	MOVF       _y_count+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Manual57:
	BTFSC      STATUS+0, 2
	GOTO       L__Manual58
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Manual57
L__Manual58:
	MOVF       R0+0, 0
	ADDWF      _y_count+0, 0
	MOVWF      PORTB+0
;Project.c,109 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,110 :: 		portb = 0;
	CLRF       PORTB+0
;Project.c,111 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,112 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Manual25:
	DECFSZ     R13+0, 1
	GOTO       L_Manual25
	DECFSZ     R12+0, 1
	GOTO       L_Manual25
	DECFSZ     R11+0, 1
	GOTO       L_Manual25
	NOP
	NOP
;Project.c,113 :: 		y_count--;
	MOVLW      1
	SUBWF      _y_count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _y_count+1, 1
;Project.c,114 :: 		if (y_count == 0) {
	MOVLW      0
	XORWF      _y_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Manual59
	MOVLW      0
	XORWF      _y_count+0, 0
L__Manual59:
	BTFSS      STATUS+0, 2
	GOTO       L_Manual26
;Project.c,115 :: 		y_count = 3;
	MOVLW      3
	MOVWF      _y_count+0
	MOVLW      0
	MOVWF      _y_count+1
;Project.c,116 :: 		str = 's';
	MOVLW      115
	MOVWF      _str+0
;Project.c,117 :: 		}
L_Manual26:
;Project.c,118 :: 		}
L_Manual24:
;Project.c,119 :: 		}
	GOTO       L_Manual27
L_Manual21:
;Project.c,121 :: 		if (portA.B2 != 1) {
	BTFSC      PORTA+0, 2
	GOTO       L_Manual28
;Project.c,122 :: 		portd = 0b10100001;
	MOVLW      161
	MOVWF      PORTD+0
;Project.c,123 :: 		portb = 0;
	CLRF       PORTB+0
;Project.c,124 :: 		portc = 0b00001111; portc = 0;
	MOVLW      15
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,125 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_Manual29:
	DECFSZ     R13+0, 1
	GOTO       L_Manual29
	DECFSZ     R12+0, 1
	GOTO       L_Manual29
	DECFSZ     R11+0, 1
	GOTO       L_Manual29
	NOP
;Project.c,126 :: 		}
	GOTO       L_Manual30
L_Manual28:
;Project.c,128 :: 		portd = 0b10010001;
	MOVLW      145
	MOVWF      PORTD+0
;Project.c,129 :: 		portb = y_count + (y_count << 4);
	MOVLW      4
	MOVWF      R1+0
	MOVF       _y_count+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
L__Manual60:
	BTFSC      STATUS+0, 2
	GOTO       L__Manual61
	RLF        R0+0, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__Manual60
L__Manual61:
	MOVF       R0+0, 0
	ADDWF      _y_count+0, 0
	MOVWF      PORTB+0
;Project.c,130 :: 		portc = 0b00000101; portc = 0;
	MOVLW      5
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,131 :: 		portb = 0;
	CLRF       PORTB+0
;Project.c,132 :: 		portc = 0b00001010; portc = 0;
	MOVLW      10
	MOVWF      PORTC+0
	CLRF       PORTC+0
;Project.c,133 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_Manual31:
	DECFSZ     R13+0, 1
	GOTO       L_Manual31
	DECFSZ     R12+0, 1
	GOTO       L_Manual31
	DECFSZ     R11+0, 1
	GOTO       L_Manual31
	NOP
	NOP
;Project.c,134 :: 		y_count--;
	MOVLW      1
	SUBWF      _y_count+0, 1
	BTFSS      STATUS+0, 0
	DECF       _y_count+1, 1
;Project.c,135 :: 		if (y_count == 0) {
	MOVLW      0
	XORWF      _y_count+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__Manual62
	MOVLW      0
	XORWF      _y_count+0, 0
L__Manual62:
	BTFSS      STATUS+0, 2
	GOTO       L_Manual32
;Project.c,136 :: 		y_count = 3;
	MOVLW      3
	MOVWF      _y_count+0
	MOVLW      0
	MOVWF      _y_count+1
;Project.c,137 :: 		str = 'w';
	MOVLW      119
	MOVWF      _str+0
;Project.c,138 :: 		}
L_Manual32:
;Project.c,139 :: 		}
L_Manual30:
;Project.c,140 :: 		}
L_Manual27:
;Project.c,141 :: 		if (portA.B1 == 1) {
	BTFSS      PORTA+0, 1
	GOTO       L_Manual33
;Project.c,142 :: 		break;
	GOTO       L_Manual20
;Project.c,143 :: 		}
L_Manual33:
;Project.c,144 :: 		}
	GOTO       L_Manual19
L_Manual20:
;Project.c,145 :: 		}
L_end_Manual:
	RETURN
; end of _Manual
