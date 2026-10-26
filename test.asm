; ==================================================
; SYSTEM INITIALIZATION
; ==================================================
MOV AX, 0003    ; Enable Cache and TLB
MOV CR0, AX     

MOV AX, 0007    ; Unmask IP1, IP2, IP3
MOV [7002], AX  

MOV AX, 0001    ; Global PIC Enable
MOV [7006], AX  

STI             ; Listen for hardware interrupts

; ==================================================
; TEST 1: BURST & INTERRUPT VERIFICATION
; ==================================================
TRIG_IP1        ; Start the 64-word burst!

; DELAY LOOP: We must give the IP Controller time to write 64 words.
; The CPU will fetch these NOPs while the IP Controller writes to memory.
; Halfway through these NOPs, the interrupt will fire!
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP

; ==================================================
; TEST 2: OUT OF RANGE BOUNDARY FAULT VERIFICATION
; ==================================================
; After returning from the ISR, the CPU reaches this line.
; The IP buffer is now FULL (64 words).
TRIG_IP2        ; Triggering it again causes an immediate Overflow Fault!
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP

TRIG_IP3       ; Triggering it again causes an immediate Overflow Fault!
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP

          ; The CPU will crash before reaching this

TRIG_IP3
NOP
TRIG_IP2
NOP
TRIG_IP1



; ==================================================
; INTERRUPT SERVICE ROUTINE (ISR)
; ==================================================
.ORG 0200       ; Script multiplies by 2 -> Placed at byte address 0x0100

MOV AX, [7000]  ; Read PIC Status
MOV [7004], AX  ; ACK the interrupt

MOV AX, [0400]  ; Read the first payload word from IP1 memory
IRET            ; Return to the NOPs in the main program
