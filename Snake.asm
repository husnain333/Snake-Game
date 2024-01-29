[org 0x0100]
jmp start
count1: dw 0

  sym: db '='
  sym2: db '|'
  food_location: dw 1950
  intial_snake_length : dw 5
  snake: db 02,'*','*','*','*'
  score1: db 'Score '
  score2:db 'HUSNAIN"s PROJECT'
  score:dw 0
  snake_endlocatoin: dw 0
  count: dw 0
  count2: dw 0
  check:db 0
  Welcome:db '*****WELCOME TO SNAKE GAME*****'
  wellen: dw 31
  Name1:db 'NAME : M HUSNAIN AFZAL'
  name1L:dw 22
  rollNo:db '21F-9165'
  rollNoLen:dw 8
  note: db '*****Press 1 To Play Game*****'
  notel:dw 30
  menu1: db '*****Menu*****'
  menu1L: dw 14
  menu2: db '***RULES***'
  menu2L:dw 11
  menu3: db 'Move Left Press : <-'
  menu3L: dw 20
  menu4: db 'Move right Press : ->'
  menu4L: dw 21
  menu5: db 'Move down Press : '
  menu5L:dw 18
  menu6: db 'Move Up Press : '
  menu6L:dw 16
  menu7: db 'Death IF SELF TOUCH OR TOUCH WITH BOUNDARY'
  menu7L: dw 42
  forNext: db 'Enter 1 For Next'
  forNextL: dw 16
  over: db 'SNAKE DIED'
  overLength: dw 10
;code to clear the screen
clrscr:
    push es
    push ax
    push di
    push cx
    mov ax,0xb800 ; video memory address
    mov es,ax
    mov ax,0x0720 ; color code and space ASCII
    mov di,0
    nextchar:
        mov [es:di],ax
        add di,2
        cmp di,4000
        jne nextchar

    ;popping all values
    pop cx
    pop di
    pop ax
    pop es
    ret
random:
push ax
push bx
push cx
push dx
push bp
mov bp,sp
sub sp,4
mov word[bp-2],0
mov word[bp-4],0
ag:
   MOV AH, 00h  ; interrupts to get system time        
   INT 0x1A     ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 22   
   div  cx       
   add dx,2 ; here dx contains the remainder of the division - from 1 to 24
   mov word[bp-2],dx
   MOV AH, 00h  ; interrupts to get system time        
   INT 0x1A     ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 78   
   div  cx       
   add dx,1 ; here dx contains the remainder of the division - from 1 to 79
   mov word[bp-4],dx
   mov al, 80 ; load al with columns per row
mul byte [bp-2] ; multiply with y position
add ax, word[bp-4] ; add x position
shl ax, 1
mov dx,ax
	push ax 
	push bx
	push cx
	push dx
	mov bx,snake_locations
	mov cx,[intial_snake_length]
	checkagain:
		cmp dx,[bx]
		je again1
		add bx,2
		loop checkagain
	pop dx
	pop cx
	pop bx
	pop ax
ret1:
mov [food_location],dx
mov sp,bp
pop bp
pop dx
pop cx
pop bx
pop ax
ret   
again1:
	pop dx
	pop cx
	pop bx
	pop ax
	jmp ag
display_food:
    push bp
    mov bp, sp
    push ax
    push di
    push es

    mov ax, 0xb800
    mov es, ax
    mov di, [bp + 4]        ;food location
    mov ax, 0x0309 ;9, 3
    mov [es:di], ax

    pop es
    pop di
    pop ax
    pop bp
    ret 2
endloc:
push ax
push bx
mov ax,[snake_locations]
mov bx,[intial_snake_length]
shl bx,1
sub bx,2
add ax,bx
mov [snake_endlocatoin],ax	
pop bx
pop ax
ret
print_space:
    push bp
    mov bp, sp
    push ax
    push es
    push di
    push cx 

    mov ax, 0xb800
    mov es, ax
    mov di, [bp+4]
    mov cx, 5

    mov word [es:di], 0x0720

    pop cx
    pop di
    pop es
    pop ax
    pop bp
    ret 2
delay:
    mov dword[count2],30000
n:
	dec dword[count2]
	cmp dword[count2],0
	jne  n
    ret	
draw_snake:
    push bp
    mov bp, sp
    push ax
    push bx
    push si
    push cx
    push dx

    mov si, [bp + 6]        ;snake
    mov cx, [bp + 8]        ;length of snake
  		;location
    mov ax, 0xb800
    mov es, ax

    mov bx, [bp+4]
	  mov di, [bx]	
    mov ah, 0x09
    snake_next_part:
        mov al, [si]
        mov [es:di], ax
        mov [bx], di
        inc si
        add bx, 2

        add di, 2
        loop snake_next_part

    pop dx
    pop cx
    pop si
    pop bx
    pop ax
    pop bp
    ret 6
recover:
    push bp
    mov bp, sp
    push ax
    push es
    push di
    push cx 

    mov ax, 0xb800
    mov es, ax
    mov di, [bp+4]
    mov cx, 5
	mov si,sym2
	mov ah,0x04
	mov al,[si]
    mov word [es:di], ax

    pop cx
    pop di
    pop es
    pop ax
    pop bp
    ret 2
checkcollideUp:
		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push si
		mov  ax,[bp+4]
		cmp ax,318
		jl l12
		mov byte[check],0
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	l12:
		mov byte[check],1
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2	
checkcollideRight:
		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push si
		mov  ax,[bp+4]
		xor  dx, dx
		mov  cx, 160   
		div  cx
		mov dx,ax
		mov al, 80 ; load al with columns per row
		mul dx ; multiply with y position
		add ax, 79 ; add x position
		shl ax, 1
		cmp ax,[bp+4]
		je l13
		mov byte[check],0
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	l13:
		mov byte[check],1
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
				
checkcollideLeft:
		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push si
		mov  ax,[bp+4]
		xor  dx, dx
		mov  cx, 160   
		div  cx
		mov dx,ax
		mov al, 80 ; load al with columns per row
		mul dx ; multiply with y position
		add ax, 0 ; add x position
		shl ax, 1
		cmp ax,[bp+4]
		je l1
		mov byte[check],0
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	l1:
		mov byte[check],1
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
checkcollideDown:
		push bp
		mov bp,sp
		push ax
		push bx
		push cx
		push dx
		push si
		mov  ax,[bp+4]
		cmp ax,3840
		jge l11
		mov byte[check],0
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
	l11:
		mov byte[check],1
		pop si
		pop dx
		pop cx
		pop bx
		pop ax
		pop bp
		ret 2
				
;end11:
;push ax
;mov word[snake_locations],308
;mov ax,168
;l21:
;push ax
;call print_space
;sub ax,2
;cmp ax,162
;jnl l21
;mov ax,160
;push ax
;call recover
;pop ax
;ret	
;end12:
;push ax
;mov ax,[snake_locations]
;sub ax,2
;mov [snake_locations],ax
;pop ax
;ret
movsnake:
push ax
push bx
push cx
push dx
push si
call random
push word [food_location]
    call display_food	
    repeat:
    mov ah,0
    int 0x16
    ; AH = BIOS scan code
    cmp ah,0x48
    je up
    cmp ah,0x4B
    je left
    cmp ah,0x4D
    je right
    cmp ah,0x50
    je down
    cmp ah,1
    jne repeat      ; loop until Esc is pressed
    ;Escape check
    mov ah,0x4c
    int 0x21
	


down:
	movdown:
	push ax
	mov ax,word[snake_locations]
	 push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_down
		cmp ax,word[snake_locations]
		je colli
		pop ax
		call delay
		
   jmp repeat
   up:
   movUp:
   push ax
	mov ax,word[snake_locations]
	 push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_up
		cmp ax,word[snake_locations]
		je colli
		pop ax
		call delay
		
   jmp repeat
   left:
    push ax
	mov ax,word[snake_locations]
	 push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_left
		cmp ax,word[snake_locations]
		je colli
		pop ax
		call delay
    jmp repeat
   right:
    push ax
	mov ax,word[snake_locations]
	 push word [intial_snake_length]
        mov bx, snake
        push bx
        mov bx, snake_locations
        push bx
        call move_snake_right
		cmp ax,word[snake_locations]
		je colli
		pop ax
		call delay
    jmp repeat
   colli:
   pop ax
   jmp end1
   end1:
     call GameOver
   pop si
   pop dx
   pop cx
   pop bx
   pop ax
   ret 


move_snake_right:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
    ;snake_parts colision detection
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]

    mov cx, [bp + 8]
    add dx, 2
	mov ax,dx
	push ax
	call checkcollideRight
	cmp word[check],1
	je no_right_movement
    check_right_colision:
        cmp dx, [bx]
        je no_right_movement
        add bx, 2
        loop check_right_colision

    right_movement:
    mov si, [bp + 6]            ;snake 
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]
    add dx, 2
    mov di, dx

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x09
    mov al, [si]
    mov [es:di], ax             ;snake head placed

    mov cx, [bp + 8]            ;snake length
    mov di, [bx]
    inc si
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax
    right_location_sort:
        mov ax, [bx]
        mov [bx], dx
        mov dx, ax
        add bx, 2
        
        loop right_location_sort
   	mov cx,word[snake_locations]
	cmp cx,word[food_location]
	je addscore
	jmp nad
	addscore:
		 mov di, dx
		mov ax, 0x092a
		mov [es:di], ax
		add word[intial_snake_length],1
		mov cx,word[score]
		inc cx
		mov word[score],cx
		call Print_Score
		call random
		push word [food_location]
		call display_food
	nad:
	 mov di, dx
		mov ax, 0x0920
		mov [es:di], ax
    no_right_movement:
    pop si
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 6
move_snake_left:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
    ;snake_parts colision detection
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]

    mov cx, [bp + 8]
    sub dx, 2
	mov ax,dx
	push ax
	call checkcollideLeft
	cmp word[check],1
	je no_left_movement
    check_left_colision:
        cmp dx, [bx]
        je no_left_movement
        add bx, 2
        loop check_left_colision
    left_movement:
    mov si, [bp + 6]            ;snake 
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]
    sub dx, 2
    mov di, dx

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax             ;snake head placed

    mov cx, [bp + 8]
    mov di, [bx]
    inc si
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax
    left_location_sort:
        mov ax, [bx]
        mov [bx], dx
        mov dx, ax
        add bx, 2
        
        loop left_location_sort
   
	mov cx,word[snake_locations]
	cmp cx,word[food_location]
	je addscore2
	jmp nad2
	addscore2:
		 mov di, dx
		mov ax, 0x092a
		mov [es:di], ax
		add word[intial_snake_length],1
		mov cx,word[score]
		inc cx
		mov word[score],cx
		call Print_Score
		call random
		push word [food_location]
		call display_food
	nad2:
	 mov di, dx
		mov ax, 0x0920
		mov [es:di], ax
    no_left_movement:
    pop si
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 6		
	;SubRoutine for Up movement
move_snake_up:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
     ;snake_parts colision detection
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]

    mov cx, [bp + 8]
    sub dx, 160
	mov ax,dx
	push ax
	call checkcollideUp
	cmp word[check],1
	je no_up_movement
    check_up_colision:
        cmp dx, [bx]
        je no_up_movement
        add bx, 2
        loop check_up_colision
    upward_movement:
    mov si, [bp + 6]            ;snake 
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]
    sub dx, 160
    mov di, dx

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax             ;snake head placed

    mov cx, [bp + 8]
    mov di, [bx]
    inc si
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax
    up_location_sort:
        mov ax, [bx]
        mov [bx], dx
        mov dx, ax
        add bx, 2
        
        loop up_location_sort
   	mov cx,word[snake_locations]
	cmp cx,word[food_location]
	je addscore3
	jmp nad3
	addscore3:
		 mov di, dx
		mov ax, 0x092a
		mov [es:di], ax
		add word[intial_snake_length],1
		mov cx,word[score]
		inc cx
		mov word[score],cx
		call Print_Score
		call random
		push word [food_location]
		call display_food
	nad3:
	 mov di, dx
		mov ax, 0x0920
		mov [es:di], ax
    no_up_movement:
    pop si
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 6
move_snake_down:
    push bp
    mov bp, sp
    push ax
    push bx
    push cx
    push dx
    push es
    push di
    push si
     ;snake_parts colision detection
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]

    mov cx, [bp + 8]
    add dx, 160
	mov ax,dx
	push ax
	call checkcollideDown
	cmp word[check],1
	je no_down_movement
    check_down_colision:
        cmp dx, [bx]
        je no_down_movement
        add bx, 2
        loop check_down_colision

    downward_movement:
    mov si, [bp + 6]            ;snake 
    mov bx, [bp + 4]            ;snake location
    mov dx, [bx]
    add dx, 160
    mov di, dx

    mov ax, 0xb800
    mov es, ax
    mov ah, 0x09
    mov al, [si]
    mov [es:di], ax             ;snake head placed

    mov cx, [bp + 8]            ;snake length
    mov di, [bx]
    inc si
    mov ah, 0x09
    mov al, [si]
    mov [es:di],ax
    down_location_sort:
        mov ax, [bx]
        mov [bx], dx
        mov dx, ax
        add bx, 2
        loop down_location_sort
   	mov cx,word[snake_locations]
	cmp cx,word[food_location]
	je addscore4
	jmp nad4
	addscore4:
		 mov di, dx
		mov ax, 0x092a
		mov [es:di], ax
		add word[intial_snake_length],1
		mov cx,word[score]
		inc cx
		mov word[score],cx
		call Print_Score
		call random
		push word [food_location]
		call display_food
	nad4:
	 mov di, dx
		mov ax, 0x0920
		mov [es:di], ax
    no_down_movement:
    pop si
    pop di
    pop es
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret 6
border:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 162             


    mov si, [bp + 4]
    mov cx, 78
    mov ah, 0x04 ; only need to do this once 
	
    print: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2

        loop print 
	mov ax,62
	push ax
	mov ax,score2
	push ax
	mov ax,17
	push ax
	call printName

    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 2
BottomBorder:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 3840              


    mov si, [bp + 4]
    mov cx, 78
    mov ah, 0x04 ; only need to do this once 


    print3: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2

        loop print3
;   // Displaying Score
    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 2


Hborder:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    mov di, 160              


    mov si, [bp + 4]
    mov cx, 23
    mov ah, 0x04 ; only need to do this once 
	

    print2: 
        mov al,[si]
        mov [es:di], ax 
        add di, 158
        mov [es:di], ax 
        add di, 2

        loop print2 


    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 2
	
	printName:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax 
    
    mov di, [bp + 8]
    mov si, [bp + 6]
    mov cx, [bp + 4]
    mov ah, 0x02 ; only need to do this once 

    nextchar1: 
        mov al, [si]
        mov [es:di], ax 
        add di, 2 
        add si, 1 
        

        loop nextchar1


    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 6 
GameOver:
push cx
push dx
push ax
push bx
push si
push di

    call clrscr
    mov dx, 1994
    push dx
    mov dx, over 
    push dx 
    push word [overLength]
    call printName

pop di
pop si
pop bx
pop ax
pop dx
pop cx
mov ax, 0x4c00
int 0x21
ret 

printNum: 
    push bp 
    mov  bp, sp
    push es 
    push ax 
    push bx 
    push cx 
    push dx 
    push di 

   

    mov ax, [bp+4]   
    mov bx, 10       
    mov cx, 0        

    nextdigit: 
        mov dx, 0    
        div bx       
        add dl, 0x30 
        push dx      
        inc cx       
        cmp ax, 0    
        jnz nextdigit 

    

    mov ax, 0xb800 
    mov es, ax 

    mov di, [bp + 6]
    nextpos: 
        pop dx          
        mov dh, 0x03    
        mov [es:di], dx 
        add di, 2 
        loop nextpos    

    pop di 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    pop es
    pop bp 
    ret 4 
Print_Score:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

   mov ax,136
   push ax
   mov ax,score1
   push ax
   mov ax,5
   push ax
   call printName
   mov ax,148
   push ax
   mov ax,word[score]
   push ax
   call printNum

    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret  
welcome1:
	push ax
	push bx
	push cx
	push dx
	push si
	push di
	mov ax,1324
	push ax
	mov ax,Welcome
	push ax
	mov ax,word[wellen]
	push ax
	call printName
	mov ax,1494
	push ax
	mov ax,Name1
	push ax
	mov ax,word[name1L]
	push ax
	call printName
	mov ax,1668
	push ax
	mov ax,rollNo
	push ax
	mov ax,word[rollNoLen]
	push ax
	call printName
	mov ax,1804
	push ax
	mov ax,note
	push ax
	mov ax,word[notel]
	push ax
	call printName
	pop di
	pop si
	pop dx
	pop cx
	pop bx
	pop ax
ret	
PrintMenu:
	push ax 
	push bx
	mov ax,1324
	push ax
	mov ax,menu1
	push ax
	mov ax,word[menu1L]
	push ax
	call printName
	mov ax,1484
	push ax
	mov ax,menu2
	push ax
	mov ax,word[menu2L]
	push ax
	call printName
	mov ax,1644
	push ax
	mov ax,menu3
	push ax
	mov ax,word[menu3L]
	push ax
	call printName
	mov ax,1804
	push ax
	mov ax,menu4
	push ax
	mov ax,word[menu4L]
	push ax	
	call printName
	mov ax,1964
	push ax
	mov ax,menu5
	push ax
	mov ax,word[menu5L]
	push ax	
	call printName
	mov ax, 0xb800 
    mov es, ax 
    
    mov di,2000
    mov ah, 0x02 ; only need to do this once
	mov al,0x19
    mov [es:di], ax
	
	mov ax,2124
	push ax
	mov ax,menu6
	push ax
	mov ax,word[menu6L]
	push ax	
	call printName
	 mov di,2156
    mov ah, 0x02 ; only need to do this once
	mov al,0x18
    mov [es:di], ax
	mov ax,2284
	push ax
	mov ax,menu7
	push ax
	mov ax,word[menu7L]
	push ax	
	call printName
	mov ax,2444
	push ax
	mov ax,forNext
	push ax
	mov ax,word[forNextL]
	push ax	
	call printName
	pop bx
	pop ax
	ret
start:
call clrscr
call welcome1
 again121
	 mov ah, 0
    int 0x16
	cmp ah,0x02
	jne again121
	call clrscr
	call PrintMenu
	again1211
	 mov ah, 0
    int 0x16
	cmp ah,0x02
	jne again1211
	call clrscr
call Print_Score
 mov ax, sym
    push ax
    call border
	mov ax, sym
    push ax
    call BottomBorder
	mov ax, sym2
    push ax
    call Hborder
 push word [intial_snake_length]
    mov bx, snake
    push bx
    mov bx, snake_locations
    push bx
    call draw_snake

	
	call delay
	call movsnake
mov ax,0x4c00
int 0x21
  snake_locations: dw 1146