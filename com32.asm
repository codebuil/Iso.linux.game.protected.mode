bits 32
org 101000h
mov eax,21cd4cffh
call check
mov edi,0b8000h
mov ax,0
mov ds,ax
mov ah,17h
mov esi,msg
call copys
mov ebx,msg4
call inputs
ret
ret
check:
	push bx
	mov bx,ax
	in ax,60h
	and al,128
	mov ah,bh
	pop bx
	ret
key:
	push bx
	mov bx,ax
	in ax,60h
	mov ah,bh
	pop bx
	ret
enterkey:
	push eax
	push ecx
	push edx
	push esi
	push ebx
	mov esi,eax
	mov eax,edi
	sub eax,0b8000h	
	mov edx,0
	mov ecx,0
	mov ebx,80
	clc
	idiv ebx
	inc eax
	mov edx,0
	mov ecx,0
	mov ebx,80
	clc
	imul ebx
	clc
	add eax,0b8000h	
	pop ebx
	mov edi,eax
	mov eax,esi
	call onrestart
	mov ebx,msg4
	pop esi
	pop edx
	pop ecx
	pop eax
	enterkey1:
ret
copys:
	push eax
	push ebx
	push ecx
	push edx
	push esi
	copys1:
		ds
		mov al,[esi]
		ds
		mov [edi],ax
		inc esi
		inc edi
		inc edi
		cmp al,0
		jnz copys1
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
inputs:
	call check
	cmp al,0
	jnz inputs
inputs2:
	mov esi,kemap
	call key
	mov edx,0
	mov dl,al
	add esi,edx
	ds	
	mov al,[esi] 
	cmp al,8
	jnz inputs18
	dec edi
	dec edi
	dec ebx
	push eax
	mov eax,msg4
	cmp ebx,eax
	jge inputs20
	mov ebx,eax
inputs20:
	pop eax	
	ds
	mov byte [ebx],'0'
	mov al,'0'
	ds
	mov [edi],ax
	jmp input7
inputs18:
	cmp al,27
	jz inputs5
	cmp al,13
	jnz input8
	call enterkey
	jmp input7
	input8:	
	ds
	mov [edi],ax
	ds
	mov [ebx],al
	inc ebx
	inc edi
	inc edi
input7:
	call check
	cmp al,0
	jz input7
	jmp inputs
inputs5:
ret
VAL32:                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          mov edi,0
          mov ebp,100000000
          VAL321:
		    ds                
                    mov al,[esi]
                    mov ah,'0'
                    clc                
                    sub al,ah
                    and eax,0ffh
                    mov ebx,ebp
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    mul ebx                
                    clc                
                    add eax,edi
                    mov edi,eax
                    mov eax,ebp
                    mov ebx,10
                    xor edx,edx
                    xor ecx,ecx
                    clc                
                    div ebx                
                    mov ebp,eax
                    inc esi                
                    cmp ebp,0
                    JNZ VAL321
          mov eax,edi
                          
                          
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          ret                
onrestart:
	push eax
	push ebx
	push ecx
	push edx
	push esi

		;sub ebx,9
		;mov esi,ebx
		;push edi
		;push esi
		;mov edi,0b8000h
		
		;call copys
		;pop esi		
		;pop edi

		sub ebx,9
		mov esi,ebx
		mov ebx,eax
		call VAL32
		;push edi
		;mov edi,0b8000h		
		;call STR32
		;pop edi
		cmp eax,50
		jnz onrestart1
		mov esi,msg2
		mov eax,ebx
		call copys
		jmp onrestart10
onrestart1:
		cmp eax,50
		jg onrestart2
		mov esi,msg20
		mov eax,ebx
		call copys
		jmp onrestart10
onrestart2:
		cmp eax,50
		jl onrestart10
		mov esi,msg21
		mov eax,ebx
		call copys
		jmp onrestart10

onrestart10:
	pop esi
	pop edx
	pop ecx
	pop ebx
	pop eax
ret
STR32:                
          push eax                
          push ebx                
          push ecx                
          push edx                
          push edi                
          push esi                
          push ebp                
          mov ebp,1000000000
          STR321:                
                    xor edx,edx
                    xor ecx,ecx
                    mov ebx,ebp
                    clc                 
                    div ebx                
                    mov esi,edx
                    mov ah,'0'
                    clc                
                    add al,ah
                    ds
                    mov [edi],al
                    inc edi
                    mov al,17h                
                    mov [edi],al
                    inc edi                
                    mov eax,ebp
                    xor edx,edx
                    xor ecx,ecx
                    mov ebx,10
                    clc                
                    div ebx                
                    mov ebp,eax
                    mov eax,esi
                    cmp ebp,0
                    jnz STR321
                          
          pop ebp                
          pop esi                
          pop edi                
          pop edx                
          pop ecx                
          pop ebx                
          pop eax                
          ret                
	ret

	
kemap db 0,27,"1234567890-=",8,7,"qwertyuiop'[",13,"Casdfghjklç~S\zxcvbnm,.;/CA CDEFGHIJKLMN",0
msg db "guess a number 0 to 100?",0
msg2 db "you win....",0
msg20 db "less....",0
msg21 db "big....",0
msg3 db "00000000000000000000000000000000"
msg4 db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0