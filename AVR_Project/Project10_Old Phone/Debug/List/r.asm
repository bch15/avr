
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega16
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R5
	.DEF __lcd_y=R4
	.DEF __lcd_maxx=R7

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 12/14/2020
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;// Alphanumeric LCD functions
;#include <alcd.h>
;
;// Declare your global variables here
;
;void main(void)
; 0000 0020 {

	.CSEG
_main:
; .FSTART _main
; 0000 0021 // Declare your local variables here
; 0000 0022 char op;
; 0000 0023 int i;
; 0000 0024 // Input/Output Ports initialization
; 0000 0025 // Port A initialization
; 0000 0026 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0027 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
;	op -> R17
;	i -> R18,R19
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0028 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0029 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 002A 
; 0000 002B // Port B initialization
; 0000 002C // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 002D DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 002E // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 002F PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0030 
; 0000 0031 // Port C initialization
; 0000 0032 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0033 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0034 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0035 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 0036 
; 0000 0037 // Port D initialization
; 0000 0038 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0039 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 003A // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 003B PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 003C 
; 0000 003D // Alphanumeric LCD initialization
; 0000 003E // Connections are specified in the
; 0000 003F // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 0040 // RS - PORTA Bit 0
; 0000 0041 // RD - PORTA Bit 1
; 0000 0042 // EN - PORTA Bit 2
; 0000 0043 // D4 - PORTA Bit 4
; 0000 0044 // D5 - PORTA Bit 5
; 0000 0045 // D6 - PORTA Bit 6
; 0000 0046 // D7 - PORTA Bit 7
; 0000 0047 // Characters/line: 8
; 0000 0048 lcd_init(20);
	LDI  R26,LOW(20)
	RCALL _lcd_init
; 0000 0049 DDRC=0x0f;
	LDI  R30,LOW(15)
	OUT  0x14,R30
; 0000 004A PORTC=0x70;
	LDI  R30,LOW(112)
	OUT  0x15,R30
; 0000 004B while (1)
_0x3:
; 0000 004C       {
; 0000 004D        PORTC.0=0;
	RCALL SUBOPT_0x0
; 0000 004E        PORTC.1=1;
; 0000 004F        PORTC.2=1;
; 0000 0050        PORTC.3=1;
; 0000 0051        if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0xE
; 0000 0052        {
; 0000 0053         while(PINC.4==0)
_0xF:
	SBIC 0x13,4
	RJMP _0x11
; 0000 0054         {
; 0000 0055          lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0056          if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0x12
; 0000 0057          {
; 0000 0058           op='1';
	LDI  R17,LOW(49)
; 0000 0059           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 005A           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 005B           delay_ms(50);
; 0000 005C          }
; 0000 005D          delay_ms(100);
_0x12:
	RCALL SUBOPT_0x3
; 0000 005E          i++;
; 0000 005F         }
	RJMP _0xF
_0x11:
; 0000 0060        }
; 0000 0061        PORTC.0=0;
_0xE:
	RCALL SUBOPT_0x0
; 0000 0062        PORTC.1=1;
; 0000 0063        PORTC.2=1;
; 0000 0064        PORTC.3=1;
; 0000 0065        if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x1B
; 0000 0066        {
; 0000 0067         while(PINC.5==0)
_0x1C:
	SBIC 0x13,5
	RJMP _0x1E
; 0000 0068         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0069          if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x1F
; 0000 006A          {
; 0000 006B           op='2';
	LDI  R17,LOW(50)
; 0000 006C           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 006D           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 006E           delay_ms(50);
; 0000 006F          }
; 0000 0070          if(PINC.5==0)
_0x1F:
	SBIC 0x13,5
	RJMP _0x20
; 0000 0071          {
; 0000 0072           op='a';
	LDI  R17,LOW(97)
; 0000 0073           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0074           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0075           delay_ms(50);
; 0000 0076          }
; 0000 0077         if(PINC.5==0)
_0x20:
	SBIC 0x13,5
	RJMP _0x21
; 0000 0078          {
; 0000 0079           op='b';
	LDI  R17,LOW(98)
; 0000 007A           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 007B           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 007C           delay_ms(50);
; 0000 007D          }
; 0000 007E          if(PINC.5==0)
_0x21:
	SBIC 0x13,5
	RJMP _0x22
; 0000 007F          {
; 0000 0080           op='c';
	LDI  R17,LOW(99)
; 0000 0081           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0082           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0083           delay_ms(50);
; 0000 0084          }
; 0000 0085          delay_ms(100);
_0x22:
	RCALL SUBOPT_0x3
; 0000 0086          i++;
; 0000 0087         }
	RJMP _0x1C
_0x1E:
; 0000 0088        }
; 0000 0089        PORTC.0=0;
_0x1B:
	RCALL SUBOPT_0x0
; 0000 008A        PORTC.1=1;
; 0000 008B        PORTC.2=1;
; 0000 008C        PORTC.3=1;
; 0000 008D        if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x2B
; 0000 008E        {
; 0000 008F         while(PINC.6==0)
_0x2C:
	SBIC 0x13,6
	RJMP _0x2E
; 0000 0090         {
; 0000 0091          lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0092          if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x2F
; 0000 0093          {
; 0000 0094           op='3';
	LDI  R17,LOW(51)
; 0000 0095           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0096           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0097           delay_ms(50);
; 0000 0098          }
; 0000 0099          if(PINC.6==0)
_0x2F:
	SBIC 0x13,6
	RJMP _0x30
; 0000 009A          {
; 0000 009B           op='d';
	LDI  R17,LOW(100)
; 0000 009C           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 009D           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 009E           delay_ms(50);
; 0000 009F          }
; 0000 00A0          if(PINC.6==0)
_0x30:
	SBIC 0x13,6
	RJMP _0x31
; 0000 00A1          {
; 0000 00A2           op='e';
	LDI  R17,LOW(101)
; 0000 00A3           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00A4           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00A5           delay_ms(50);
; 0000 00A6          }
; 0000 00A7          if(PINC.6==0)
_0x31:
	SBIC 0x13,6
	RJMP _0x32
; 0000 00A8          {
; 0000 00A9           op='f';
	LDI  R17,LOW(102)
; 0000 00AA           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00AB           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00AC           delay_ms(50);
; 0000 00AD          }
; 0000 00AE          if(PINC.6==0)
_0x32:
	SBIC 0x13,6
	RJMP _0x33
; 0000 00AF          {
; 0000 00B0           op='g';
	LDI  R17,LOW(103)
; 0000 00B1           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00B2           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00B3           delay_ms(50);
; 0000 00B4          }
; 0000 00B5          delay_ms(100);
_0x33:
	RCALL SUBOPT_0x3
; 0000 00B6          i++;
; 0000 00B7         }
	RJMP _0x2C
_0x2E:
; 0000 00B8        }
; 0000 00B9        PORTC.0=1;
_0x2B:
	RCALL SUBOPT_0x4
; 0000 00BA        PORTC.1=0;
; 0000 00BB        PORTC.2=1;
; 0000 00BC        PORTC.3=1;
; 0000 00BD        if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0x3C
; 0000 00BE        {
; 0000 00BF         while(PINC.4==0)
_0x3D:
	SBIC 0x13,4
	RJMP _0x3F
; 0000 00C0         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00C1          if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0x40
; 0000 00C2          {
; 0000 00C3           op='4';
	LDI  R17,LOW(52)
; 0000 00C4           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00C5           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00C6           delay_ms(50);
; 0000 00C7          }
; 0000 00C8          if(PINC.4==0)
_0x40:
	SBIC 0x13,4
	RJMP _0x41
; 0000 00C9          {
; 0000 00CA           op='h';
	LDI  R17,LOW(104)
; 0000 00CB           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00CC           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00CD           delay_ms(50);
; 0000 00CE          }
; 0000 00CF          if(PINC.4==0)
_0x41:
	SBIC 0x13,4
	RJMP _0x42
; 0000 00D0          {
; 0000 00D1           op='i';
	LDI  R17,LOW(105)
; 0000 00D2           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00D3           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00D4           delay_ms(50);
; 0000 00D5          }
; 0000 00D6          if(PINC.4==0)
_0x42:
	SBIC 0x13,4
	RJMP _0x43
; 0000 00D7          {
; 0000 00D8           op='j';
	LDI  R17,LOW(106)
; 0000 00D9           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00DA           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00DB           delay_ms(50);
; 0000 00DC          }
; 0000 00DD          if(PINC.4==0)
_0x43:
	SBIC 0x13,4
	RJMP _0x44
; 0000 00DE          {
; 0000 00DF           op='k';
	LDI  R17,LOW(107)
; 0000 00E0           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00E1           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00E2           delay_ms(50);
; 0000 00E3          }
; 0000 00E4          delay_ms(100);
_0x44:
	RCALL SUBOPT_0x3
; 0000 00E5          i++;
; 0000 00E6         }
	RJMP _0x3D
_0x3F:
; 0000 00E7        }
; 0000 00E8        PORTC.0=1;
_0x3C:
	RCALL SUBOPT_0x4
; 0000 00E9        PORTC.1=0;
; 0000 00EA        PORTC.2=1;
; 0000 00EB        PORTC.3=1;
; 0000 00EC        if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x4D
; 0000 00ED        {
; 0000 00EE         while(PINC.5==0)
_0x4E:
	SBIC 0x13,5
	RJMP _0x50
; 0000 00EF         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00F0          if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x51
; 0000 00F1          {
; 0000 00F2           op='5';
	LDI  R17,LOW(53)
; 0000 00F3           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00F4           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00F5           delay_ms(50);
; 0000 00F6          }
; 0000 00F7          if(PINC.5==0)
_0x51:
	SBIC 0x13,5
	RJMP _0x52
; 0000 00F8          {
; 0000 00F9           op='l';
	LDI  R17,LOW(108)
; 0000 00FA           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 00FB           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 00FC           delay_ms(50);
; 0000 00FD          }
; 0000 00FE          if(PINC.5==0)
_0x52:
	SBIC 0x13,5
	RJMP _0x53
; 0000 00FF          {
; 0000 0100           op='m';
	LDI  R17,LOW(109)
; 0000 0101           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0102           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0103           delay_ms(50);
; 0000 0104          }
; 0000 0105          if(PINC.5==0)
_0x53:
	SBIC 0x13,5
	RJMP _0x54
; 0000 0106          {
; 0000 0107           op='n';
	LDI  R17,LOW(110)
; 0000 0108           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0109           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 010A           delay_ms(50);
; 0000 010B          }
; 0000 010C          if(PINC.5==0)
_0x54:
	SBIC 0x13,5
	RJMP _0x55
; 0000 010D          {
; 0000 010E           op='o';
	LDI  R17,LOW(111)
; 0000 010F           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0110           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0111           delay_ms(50);
; 0000 0112          }
; 0000 0113          delay_ms(100);
_0x55:
	RCALL SUBOPT_0x3
; 0000 0114          i++;
; 0000 0115         }
	RJMP _0x4E
_0x50:
; 0000 0116        }
; 0000 0117        PORTC.0=1;
_0x4D:
	RCALL SUBOPT_0x4
; 0000 0118        PORTC.1=0;
; 0000 0119        PORTC.2=1;
; 0000 011A        PORTC.3=1;
; 0000 011B        if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x5E
; 0000 011C        {
; 0000 011D         while(PINC.6==0)
_0x5F:
	SBIC 0x13,6
	RJMP _0x61
; 0000 011E         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 011F          if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x62
; 0000 0120          {
; 0000 0121           op='6';
	LDI  R17,LOW(54)
; 0000 0122           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0123           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0124           delay_ms(50);
; 0000 0125          }
; 0000 0126          if(PINC.6==0)
_0x62:
	SBIC 0x13,6
	RJMP _0x63
; 0000 0127          {
; 0000 0128           op='p';
	LDI  R17,LOW(112)
; 0000 0129           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 012A           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 012B           delay_ms(50);
; 0000 012C          }
; 0000 012D          if(PINC.6==0)
_0x63:
	SBIC 0x13,6
	RJMP _0x64
; 0000 012E          {
; 0000 012F           op='q';
	LDI  R17,LOW(113)
; 0000 0130           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0131           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0132           delay_ms(50);
; 0000 0133          }
; 0000 0134          if(PINC.6==0)
_0x64:
	SBIC 0x13,6
	RJMP _0x65
; 0000 0135          {
; 0000 0136           op='r';
	LDI  R17,LOW(114)
; 0000 0137           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0138           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0139           delay_ms(50);
; 0000 013A          }
; 0000 013B          delay_ms(100);
_0x65:
	RCALL SUBOPT_0x3
; 0000 013C          i++;
; 0000 013D         }
	RJMP _0x5F
_0x61:
; 0000 013E        }
; 0000 013F        PORTC.0=1;
_0x5E:
	RCALL SUBOPT_0x5
; 0000 0140        PORTC.1=1;
; 0000 0141        PORTC.2=0;
; 0000 0142        PORTC.3=1;
; 0000 0143        if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0x6E
; 0000 0144        {
; 0000 0145         while(PINC.4==0)
_0x6F:
	SBIC 0x13,4
	RJMP _0x71
; 0000 0146         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0147          if(PINC.4==0)
	SBIC 0x13,4
	RJMP _0x72
; 0000 0148          {
; 0000 0149           op='7';
	LDI  R17,LOW(55)
; 0000 014A           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 014B           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 014C           delay_ms(50);
; 0000 014D          }
; 0000 014E          if(PINC.4==0)
_0x72:
	SBIC 0x13,4
	RJMP _0x73
; 0000 014F          {
; 0000 0150           op='s';
	LDI  R17,LOW(115)
; 0000 0151           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0152           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0153           delay_ms(50);
; 0000 0154          }
; 0000 0155          if(PINC.4==0)
_0x73:
	SBIC 0x13,4
	RJMP _0x74
; 0000 0156          {
; 0000 0157           op='t';
	LDI  R17,LOW(116)
; 0000 0158           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0159           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 015A           delay_ms(50);
; 0000 015B          }
; 0000 015C          if(PINC.4==0)
_0x74:
	SBIC 0x13,4
	RJMP _0x75
; 0000 015D          {
; 0000 015E           op='u';
	LDI  R17,LOW(117)
; 0000 015F           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0160           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0161           delay_ms(50);
; 0000 0162          }
; 0000 0163          if(PINC.4==0)
_0x75:
	SBIC 0x13,4
	RJMP _0x76
; 0000 0164          {
; 0000 0165           op='v';
	LDI  R17,LOW(118)
; 0000 0166           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0167           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0168           delay_ms(50);
; 0000 0169          }
; 0000 016A          delay_ms(100);
_0x76:
	RCALL SUBOPT_0x3
; 0000 016B          i++;
; 0000 016C         }
	RJMP _0x6F
_0x71:
; 0000 016D        }
; 0000 016E        PORTC.0=1;
_0x6E:
	RCALL SUBOPT_0x5
; 0000 016F        PORTC.1=1;
; 0000 0170        PORTC.2=0;
; 0000 0171        PORTC.3=1;
; 0000 0172        if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x7F
; 0000 0173        {
; 0000 0174         while(PINC.5==0)
_0x80:
	SBIC 0x13,5
	RJMP _0x82
; 0000 0175         {lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0176          if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x83
; 0000 0177          {
; 0000 0178           op='8';
	LDI  R17,LOW(56)
; 0000 0179           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 017A           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 017B           delay_ms(50);
; 0000 017C          }
; 0000 017D          if(PINC.5==0)
_0x83:
	SBIC 0x13,5
	RJMP _0x84
; 0000 017E          {
; 0000 017F           op='w';
	LDI  R17,LOW(119)
; 0000 0180           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0181           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0182           delay_ms(50);
; 0000 0183          }
; 0000 0184          if(PINC.5==0)
_0x84:
	SBIC 0x13,5
	RJMP _0x85
; 0000 0185          {
; 0000 0186           op='x';
	LDI  R17,LOW(120)
; 0000 0187           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0188           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0189           delay_ms(50);
; 0000 018A          }
; 0000 018B          if(PINC.5==0)
_0x85:
	SBIC 0x13,5
	RJMP _0x86
; 0000 018C          {
; 0000 018D           op='y';
	LDI  R17,LOW(121)
; 0000 018E           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 018F           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0190           delay_ms(50);
; 0000 0191          }
; 0000 0192          if(PINC.5==0)
_0x86:
	SBIC 0x13,5
	RJMP _0x87
; 0000 0193          {
; 0000 0194           op='z';
	LDI  R17,LOW(122)
; 0000 0195           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 0196           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 0197           delay_ms(50);
; 0000 0198          }
; 0000 0199          delay_ms(100);
_0x87:
	RCALL SUBOPT_0x3
; 0000 019A          i++;
; 0000 019B         }
	RJMP _0x80
_0x82:
; 0000 019C        }
; 0000 019D        PORTC.0=1;
_0x7F:
	RCALL SUBOPT_0x5
; 0000 019E        PORTC.1=1;
; 0000 019F        PORTC.2=0;
; 0000 01A0        PORTC.3=1;
; 0000 01A1        if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x90
; 0000 01A2        {
; 0000 01A3         while(PINC.6==0)
_0x91:
	SBIC 0x13,6
	RJMP _0x93
; 0000 01A4         {
; 0000 01A5          lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 01A6          if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0x94
; 0000 01A7          {
; 0000 01A8           op='9';
	LDI  R17,LOW(57)
; 0000 01A9           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 01AA           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 01AB           delay_ms(50);
; 0000 01AC          }
; 0000 01AD          delay_ms(100);
_0x94:
	RCALL SUBOPT_0x3
; 0000 01AE          i++;
; 0000 01AF         }
	RJMP _0x91
_0x93:
; 0000 01B0        }
; 0000 01B1        PORTC.0=1;
_0x90:
	SBI  0x15,0
; 0000 01B2        PORTC.1=1;
	SBI  0x15,1
; 0000 01B3        PORTC.2=1;
	SBI  0x15,2
; 0000 01B4        PORTC.3=0;
	CBI  0x15,3
; 0000 01B5        if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0x9D
; 0000 01B6        {
; 0000 01B7         while(PINC.5==0)
_0x9E:
	SBIC 0x13,5
	RJMP _0xA0
; 0000 01B8         {
; 0000 01B9          lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 01BA          if(PINC.5==0)
	SBIC 0x13,5
	RJMP _0xA1
; 0000 01BB          {
; 0000 01BC           op='0';
	LDI  R17,LOW(48)
; 0000 01BD           lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 01BE           lcd_putchar(op);
	RCALL SUBOPT_0x2
; 0000 01BF           delay_ms(50);
; 0000 01C0          }
; 0000 01C1          delay_ms(100);
_0xA1:
	RCALL SUBOPT_0x3
; 0000 01C2          i++;
; 0000 01C3         }
	RJMP _0x9E
_0xA0:
; 0000 01C4        }
; 0000 01C5        PORTC.0=1;
_0x9D:
	SBI  0x15,0
; 0000 01C6        PORTC.1=1;
	SBI  0x15,1
; 0000 01C7        PORTC.2=1;
	SBI  0x15,2
; 0000 01C8        PORTC.3=0;
	CBI  0x15,3
; 0000 01C9        if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0xAA
; 0000 01CA        {
; 0000 01CB         while(PINC.6==0)
_0xAB:
	SBIC 0x13,6
	RJMP _0xAD
; 0000 01CC         {
; 0000 01CD          lcd_gotoxy(i,0);
	RCALL SUBOPT_0x1
; 0000 01CE          if(PINC.6==0)
	SBIC 0x13,6
	RJMP _0xAE
; 0000 01CF          {
; 0000 01D0           lcd_clear();
	RCALL _lcd_clear
; 0000 01D1           delay_ms(50);
	LDI  R26,LOW(50)
	LDI  R27,0
	CALL _delay_ms
; 0000 01D2          }
; 0000 01D3          delay_ms(100);
_0xAE:
	RCALL SUBOPT_0x3
; 0000 01D4          i++;
; 0000 01D5         }
	RJMP _0xAB
_0xAD:
; 0000 01D6        }
; 0000 01D7       }
_0xAA:
	RJMP _0x3
; 0000 01D8 }
_0xAF:
	RJMP _0xAF
; .FEND
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,2
	__DELAY_USB 13
	CBI  0x1B,2
	__DELAY_USB 13
	RJMP _0x2020001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2020001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R5,Y+1
	LDD  R4,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x6
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x6
	LDI  R30,LOW(0)
	MOV  R4,R30
	MOV  R5,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R5,R7
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R4
	MOV  R26,R4
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020001
_0x2000004:
	INC  R5
	SBI  0x1B,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,0
	RJMP _0x2020001
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,2
	SBI  0x1A,0
	SBI  0x1A,1
	CBI  0x1B,2
	CBI  0x1B,0
	CBI  0x1B,1
	LDD  R7,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x7
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2020001:
	ADIW R28,1
	RET
; .FEND

	.DSEG
__base_y_G100:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	CBI  0x15,0
	SBI  0x15,1
	SBI  0x15,2
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 47 TIMES, CODE SIZE REDUCTION:89 WORDS
SUBOPT_0x1:
	ST   -Y,R18
	LDI  R26,LOW(0)
	RJMP _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 36 TIMES, CODE SIZE REDUCTION:172 WORDS
SUBOPT_0x2:
	MOV  R26,R17
	RCALL _lcd_putchar
	LDI  R26,LOW(50)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:37 WORDS
SUBOPT_0x3:
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
	__ADDWRN 18,19,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	SBI  0x15,0
	CBI  0x15,1
	SBI  0x15,2
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	SBI  0x15,0
	SBI  0x15,1
	CBI  0x15,2
	SBI  0x15,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x7:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
