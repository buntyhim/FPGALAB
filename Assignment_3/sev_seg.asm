
;hello
;using assembly language for turning LED on

.nolist
.include "m328pdef.inc" ; Define device ATmega328P
.list

ldi r16,low(RAMEND) ;// RAMEND address 0x08ff
 out SPL,r16 ;// Stack Pointer Low SPL at i/o address 0x3d
 ldi r16,high(RAMEND)
 out SPH,r16

ldi r16,0b11111110
out DDRD,r16           ; pins D1 - D7 are set as output

ldi r16, 0b00000101 ;  the last 3 bits define the prescaler, 101 => division by 1024
out TCCR0B, r16

ldi r18,0b00000000
out PortD,r18

load_table:
ldi r20, 0x10
ldi ZL, low(sev_seg<<1)
ldi ZH, high(sev_seg<<1)
loop:

rcall DISPNUM

    dec r20
    breq load_table

    ;ldi r19, $32
    ;rcall DELAY

    rjmp loop

DELAY:         ;this is delay (function)
               ;times to run the loop = 64 for 1 second delay
    lp2:
        IN r16, TIFR0        ;tifr is timer interupt flag (8 bit timer runs 256 times)
        ldi r17, 0b00000010
        AND r16, r17         ;need second bit
        BREQ DELAY
        OUT TIFR0, r17       ;set tifr flag high
        dec r19
        brne lp2
    ret

DISPNUM:
    lpm r17, Z+
    out PortD,r17


ret

sev_seg: .DB  0x02, 0x9e, 0x24, 0x0c, 0x98, 0x48, 0x40, 0x1e, 0x00, 0x08, 0x10, 0xc0, 0x62, 0x84, 0x60, 0x70


