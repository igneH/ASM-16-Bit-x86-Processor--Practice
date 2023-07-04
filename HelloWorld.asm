.model small          ; allowes access to memory range of 64KB, where code and data reside
.stack 100H           ; reserves 256 bytes (100H in hex)
.data                 ; defines the data area, where variables and constant values are stored
  hello db "Servus!$" ; hello: variable name
                      ; db (define byte): allocate memory and define one or more specific values
                      ; "Servus!$": datatype, the $ means end of string
.code                 ; section which contains the executable code of the program

start:                ; label, that marks the beginning of the main program
  mov ax,@data        ; loads the segment value of the .data section into the ax register
  mov ds,ax           ; ax is loaded into the segment register ds. Ds is used to access memory area of the .data section 
  mov dx, offsett dgroup:hello  ; loads the offset address of hello into the dx register
                                ; dgroup is a special section name that represents the current data segment
  mov ah, 09H         ; loads the value 09H (represents function for outputting a string using DOS services) in the register ah
  int 21H             ; invokes DOS service with interrupt number 21H to output the string
  mov ah, 4CH         ; loads 4CH (function code for program termination) into the ah register
  int 21H             ; invokes DOS service w/ interrupt numb 21H to terminate the program
end start             ; marks the end of the main program