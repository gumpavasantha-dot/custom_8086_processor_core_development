; SYSCON SOFT RESET TESTCASE
;.ORG 0000

CLI
MOV AX, 0002
MOV CR0, AX

; Clear power-on flags
MOV AX, 0008
MOV [8080], AX
MOV [9080], AX
MOV [A080], AX

; Start peripherals
TRIG_IP1
TRIG_IP2
TRIG_IP3

; Soft reset IP1
MOV AX, 0001
MOV [5000], AX

; Global soft reset
MOV AX, 0007
MOV [5000], AX

; Acknowledge soft resets
MOV AX, 0008
MOV [8080], AX
MOV [9080], AX
MOV [A080], AX

; Restart IP1
TRIG_IP1
HLT
