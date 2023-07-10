.model small
.stack 100H
.data
    TimePrompt              db "Is it after 12 noon (Y/N)?$"
    GoodMorningMessage      db 13, 10, "Good morning, world!", 13, 10, "$"
    GoodAfternoonMessage    db 13, 10, "Good afternoon, world!", 13, 10, "$"
    DefaultMessage          db 13, 10, "Good day, world", 10, 13, "$"
.code
start:
    mov ax, @data
    mov ds, ax                      ; set DS to point to the data segment
    mov dx, offset TimePrompt       ; point to the time promt
    mov ah, 09H                     ; DOS: print string
    int 21H                         ; display the time promt
    mov ah, 01H                     ; DOS: get character
    int 21H                         ; get a single-character response            
    or al, 20H                      ; force character to lower case

    cmp al, "y"                     ; typed Y for afternoon?
    je IsAfternoon                  
    cmp al, "n"                     ; typed N for morning?
    je IsMorning

    mov dx, offset DefaultMessage   ; default greeting
    jmp DisplayGreeting

    IsAfternoon:
        mov dx, offset GoodAfternoonMessage ; afternoon greeting
        jmp DisplayGreeting

    IsMorning:
        mov dx, offset GoodMorningMessage   ; before noon greeting
        jmp DisplayGreeting

    DisplayGreeting:                
        mov ah, 09H                 ; DOS: print string
        int 21H                     ; display the appropriate greeting
        mov ah, 4CH                 ; DOS: terminate program
        mov al, 0H                  ; return code will be 0
        int 21H                     ; terminate the program
end start