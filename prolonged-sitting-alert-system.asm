; ========================================
; PROLONGED SITTING ALERT SYSTEM - 8051
; Displays TIME OUT and alerts user via LED and Buzzer
; ========================================

        org 0000h

; Initialization
        clr     a
        mov     r4, #00h
        mov     r5, #00h
        mov     r6, #00h

        mov     p0, #00000001b    ; P0.0 as input (sensor)
        clr     p1.1              ; LED OFF
        clr     p1.2              ; Buzzer OFF
        acall   timer             ; Initial delay

main:
; LCD Setup
        mov     p2, #38h
        acall   command
        mov     p2, #0Ch
        acall   command
        mov     p2, #06h
        acall   command
        mov     p2, #01h
        acall   command
        mov     p2, #80h
        acall   command

; Display "TIME OUT: "
        mov     p2, #'T'
        lcall   lcddata
        mov     p2, #'I'
        lcall   lcddata
        mov     p2, #'M'
        lcall   lcddata
        mov     p2, #'E'
        lcall   lcddata
        mov     p2, #' '
        lcall   lcddata
        mov     p2, #'O'
        lcall   lcddata
        mov     p2, #'U'
        lcall   lcddata
        mov     p2, #'T'
        lcall   lcddata
        mov     p2, #' '
        lcall   lcddata
        mov     p2, #':'
        lcall   lcddata
        mov     p2, #' '
        lcall   lcddata

; Show time from r4 and r5
        mov     p2, r4
        lcall   lcddata
        mov     p2, r5
        lcall   lcddata

start:
        jb      p0.0, ledoff      ; If sensor high, user present
        setb    p1.1              ; LED ON
        clr     p1.2              ; Buzzer OFF
        mov     r6, #00h          ; Reset timer
        sjmp    start

ledoff:
        sjmp    now
        sjmp    start

now:
        lcall   increment
        lcall   timer

        mov     a, r6
        mov     b, #10
        div     ab
        add     a, #30h
        mov     r4, a
        mov     a, b
        add     a, #30h
        mov     r5, a

        cjne    r6, #10, ledlight
        clr     p1.1              ; LED ON
        setb    p1.2              ; Buzzer ON
        mov     r6, #00h
        ljmp    main

ledlight:
        ljmp    main

; LCD Command Subroutine
command:
        clr     p3.0
        setb    p3.1
        acall   delay
        clr     p3.1
        ret

; LCD Data Subroutine
lcddata:
        setb    p3.0
        setb    p3.1
        acall   delay
        clr     p3.1
        ret

; Short Delay
delay:
        mov     r0, #10h
wait1:  mov     r1, #0FFh
wait:   djnz    r1, wait
        djnz    r0, wait1
        ret

; 1-Second Timer (100 x 10ms)
timer:
        mov     r7, #100d
back:   mov     tmod, #01h
        mov     th0, #0DBh
        mov     tl0, #0FFh
        setb    tcon.4
L1:     jnb     tcon.5, L1
        clr     tcon.4
        clr     tcon.5
        djnz    r7, back
        ret

; Increment counter
increment:
        inc     r6
        ret

        end
