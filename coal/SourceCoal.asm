INCLUDE Irvine32.inc

.data
prompt        BYTE "Enter a string: ", 0
inputStr      BYTE 100 DUP(0)
frequency     DWORD 256 DUP(0)
resultMsg     BYTE "Non-repeating characters: ", 0
newline       BYTE 0Dh, 0Ah, 0

.code
main PROC

    mov edx, OFFSET prompt
    call WriteString

    mov edx, OFFSET inputStr
    mov ecx, SIZEOF inputStr
    call ReadString

    mov esi, OFFSET inputStr
countLoop:
    mov al, [esi]
    cmp al, 0
    je checkUnique

    cmp al, ' '
    je skipCount

    cmp al, 'A'
    jb storeFreq
    cmp al, 'Z'
    ja storeFreq
    add al, 32  

storeFreq:
    movzx ebx, al
    inc frequency[ebx*4]

skipCount:
    inc esi
    jmp countLoop

checkUnique:
    call Crlf
    mov edx, OFFSET resultMsg
    call WriteString

    mov esi, OFFSET inputStr
printLoop:
    mov al, [esi]
    cmp al, 0
    je finish

    cmp al, ' '
    je skipPrint

    mov ah, al
    cmp ah, 'A'
    jb checkFreq
    cmp ah, 'Z'
    ja checkFreq
    add ah, 32

checkFreq:
    movzx ebx, ah
    cmp frequency[ebx*4], 1
    jne skipPrint

    mov dl, al
    call WriteChar

skipPrint:
    inc esi
    jmp printLoop

finish:
    call Crlf
    exit
main ENDP
END main



































































 
