/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 12/14/2020
Author  : 
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/

#include <mega16.h>
#include <delay.h>
// Alphanumeric LCD functions
#include <alcd.h>

// Declare your global variables here

void main(void)
{
// Declare your local variables here
char op;
int i;
// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

// Alphanumeric LCD initialization
// Connections are specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 0
// RD - PORTA Bit 1
// EN - PORTA Bit 2
// D4 - PORTA Bit 4
// D5 - PORTA Bit 5
// D6 - PORTA Bit 6
// D7 - PORTA Bit 7
// Characters/line: 8
lcd_init(20);
DDRC=0x0f;
PORTC=0x70;
while (1)
      {        
       PORTC.0=0;
       PORTC.1=1;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.4==0)
       {
        while(PINC.4==0)
        {
         lcd_gotoxy(i,0);
         if(PINC.4==0)
         {
          op='1';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=0;
       PORTC.1=1;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.5==0)
       {
        while(PINC.5==0)
        {
        lcd_gotoxy(i,0);
         if(PINC.5==0)
         {
          op='2';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='a';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
        if(PINC.5==0)
         {
          op='b';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='c';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=0;
       PORTC.1=1;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.6==0)
       {
        while(PINC.6==0)
        {
         lcd_gotoxy(i,0);
         if(PINC.6==0)
         {             
          op='3';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='d';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='e';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='f';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='g';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        } 
       } 
       PORTC.0=1;
       PORTC.1=0;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.4==0)
       {
        while(PINC.4==0)
        {lcd_gotoxy(i,0);
         if(PINC.4==0)
         {
          op='4';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='h';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='i';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='j';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='k';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=0;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.5==0)
       {
        while(PINC.5==0)
        {lcd_gotoxy(i,0);
         if(PINC.5==0)
         {
          op='5';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='l';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='m';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='n';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='o';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=0;
       PORTC.2=1;
       PORTC.3=1;
       if(PINC.6==0)
       {
        while(PINC.6==0)
        {lcd_gotoxy(i,0);
         if(PINC.6==0)
         {
          op='6';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='p';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='q';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.6==0)
         {
          op='r';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=1;
       PORTC.2=0;
       PORTC.3=1;
       if(PINC.4==0)
       {
        while(PINC.4==0)
        {lcd_gotoxy(i,0);
         if(PINC.4==0)
         {
          op='7';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='s';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='t';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='u';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.4==0)
         {
          op='v';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=1;
       PORTC.2=0;
       PORTC.3=1;
       if(PINC.5==0)
       {
        while(PINC.5==0)
        {lcd_gotoxy(i,0);
         if(PINC.5==0)
         {
          op='8';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='w';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='x';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='y';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         if(PINC.5==0)
         {
          op='z';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=1;
       PORTC.2=0;
       PORTC.3=1;
       if(PINC.6==0)
       {
        while(PINC.6==0)
        {
         lcd_gotoxy(i,0);
         if(PINC.6==0)
         {
          op='9';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=1;
       PORTC.2=1;
       PORTC.3=0;
       if(PINC.5==0)
       {
        while(PINC.5==0)
        {
         lcd_gotoxy(i,0);
         if(PINC.5==0)
         {
          op='0';
          lcd_gotoxy(i,0);
          lcd_putchar(op);
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
       PORTC.0=1;
       PORTC.1=1;
       PORTC.2=1;
       PORTC.3=0;
       if(PINC.6==0)
       {
        while(PINC.6==0)
        {
         lcd_gotoxy(i,0);
         if(PINC.6==0)
         {
          lcd_clear();
          delay_ms(50);
         }
         delay_ms(100);
         i++;
        }
       }
      }               
} 

