;
; ***********************************
; * (Add program task here)         *
; * (Add AVR type and version here) *
; * (C)2021 by Gerhard Schmidt      *
; ***********************************
;
.nolist
.include "m328pdef.inc" ; Define device ATmega328P
.list

ldi r16,low(RAMEND) ; RAMEND address 0x08ff
 out SPL,r16        ; Stack Pointer Low SPL at i/o address 0x3d
 ldi r16,high(RAMEND)
 out SPH,r16

ldi r16,0b11111110
out DDRD,r16           ; pins D1 - D7 are set as output

ldi r16,0b00110000
out DDRB,r16

ldi r16, 0b00000101    ;  the last 3 bits define the prescaler, 101 => division by 1024
out TCCR0B, r16

ldi r18,0b00000000
out PortD,r18
ldi r25,0x0f

rcall save_value

ldi r20, 0x10

loop:
    dec r20
    rcall DISPNUM
    brmi save_value

    rcall BITSEP

    or r21,r22           ; (A+B).(C+D)
    or r23,r24
    and r21,r23          ; final result in r21
    lsl r21
    lsl r21
    lsl r21
    lsl r21
    lsl r21

    rcall NOR1           ; NOR Equivalent
    rcall NOR2
    rcall NOR3           ; final result in r11
    lsl r11
    lsl r11
    lsl r11
    lsl r11


    or r21,r11
    out PortB,r21

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
    ld r17, Z+
    out PortD,r17

ret


BITSEP:
    mov r21, r25     ;A LSB
    sub r21,r20
    andi r21,0x01
    mov r11,r21

    mov r22, r25     ;B
    sub r22,r20
    andi r22,0x02
    lsr r22
    mov r12,r22

    mov r23, r25     ;C
    sub r23,r20
    andi r23,0x04
    lsr r23
    lsr r23
    mov r13,r23

    mov r24, r25     ;D MSB
    sub r24,r20
    andi r24,0x08
    lsr r24
    lsr r24
    lsr r24
    mov r14,r24

    ret

NOR1:
or r11,r12
com r11
ret

NOR2:
or r13,r14
com r13
ret

NOR3:
or r11,r13
com r11
ret

save_value:
ldi Zl, 0x00
ldi Zh, 0x02

ldi r19, 0x02
st Z+, r19
ldi r19, 0x9e
st Z+, r19
ldi r19, 0x24
st Z+, r19
ldi r19, 0x0c
st Z+, r19
ldi r19, 0x98
st Z+, r19
ldi r19, 0x48
st Z+, r19
ldi r19, 0x40
st Z+, r19
ldi r19, 0x1e
st Z+, r19
ldi r19, 0x00
st Z+, r19
ldi r19, 0x08
st Z+, r19
ldi r19, 0x10
st Z+, r19
ldi r19, 0xc0
st Z+, r19
ldi r19, 0x62
st Z+, r19
ldi r19, 0x84
st Z+, r19
ldi r19, 0x60
st Z+, r19
ldi r19, 0x70
st Z+, r19

ldi Zl, 0x00
ldi Zh, 0x02
ret


