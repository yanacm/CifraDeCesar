;Yana Costa Moura - 2123684
;Prof. Marcio Maciel
;Arquitetura de Computadores
;Cifra de Cesar 

;transformando tudo em inteiro     

mov dx, offset K
mov ah, 0Ah
int 21h
mov dx, offset NEWLINE
mov ah, 9
int 21h		           
xor cx,cx
mov [K],cl 
mov bx, 1
mov cl, [K+1]
primeiro_loop: 
    mov si,cx
    mov al,[K+1+si]
    sub al,"0" 
    xor dx,dx
    mul bx
    add [K],al         
    mov bx,10    
    loop primeiro_loop    
                       
  
;abrindo o arquivo     
xor al, al
mov dx, offset input
mov ah, 3dh
int 21h 
    
push ax
    
;lendo o arquivo    
mov bx, ax
mov dx, offset inputMsg
mov cx, 100
mov ah, 3fh
int 21h
	
push ax  

mov si, ax    
mov [inputMsg + si], '$' 
      	
mov dx, offset NEWLINE
mov ah, 9
int 21h    

;escrevendo a string
xor ax, ax
mov dx, offset inputMsg
mov ah, 9
pop cx
int 21h
    
;fechando o arquivo         
pop bx  
mov ah, 3eh
int 21h
push cx                 

;criptografando a mensagem
 
xor si, si 
segundo_loop:                       
    xor ax,ax
    mov al,[inputMsg + si]
    cmp al, 'A'
    jl saida
    cmp al, 'Z'
    jg saida
    
    
    sub ax, 'A'
    add al, [K]
    mov bl, 26
    div bl
    
    add dx, 'A'
    mov [mensagemCrip + si], dl
    inc si
jmp segundo_loop

                             
saida:                             
                                                          
;criando arquivo                             
mov ah, 3ch
xor cx, cx
mov dx, offset output
int 21h  
push ax  

;escrevendo mensagem
pop bx   
push bx  
mov dx, offset mensagemCrip
mov ah, 40h
pop cx
int 21h
   
;fechando o arquivo
pop bx  
mov ah, 3eh
int 21h
push cx  
 
ret                           

NEWLINE db 10,13,'$'          
               
input db "C:/input.txt",0
inputMsg db 30,?,30 dup(?) 

K db 10,?,10 dup(?)        

mensagemCrip db 30,?,30 dup(?)

output db "C:/outp.txt",0                            