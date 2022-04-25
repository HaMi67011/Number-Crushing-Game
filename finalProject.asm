INCLUDE Irvine32.inc

.data
tablew DWORD 10 DUP(?)
rowsize = ($-tablew) 
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	DWORD 10 DUP(?)
	colsize = type tablew

	
	game struct
		
		Usr_Name BYTE 30 DUP('$')
		Usr_Score byte 0h
		Usr_Moves byte 0h
		
	game ENDS
	
textcolor Dword 5


input_name BYTE "ENTER YOUR NAME ",0
name_dis BYTE "NAME ",0
score_dis BYTE "SCORE ",0
move_dis BYTE "MOVES ",0
space BYTE "  ",0
score byte 0
move byte 0

input_row BYTE "ENTER THE ROW ",0
input_col BYTE "ENTER THE COLUMN ",0
input_choice BYTE "ENTER MOVE ",0

promptd byte "DOWN SWAP",0
promptu byte "UP SWAP",0
promptr byte "RIGHT SWAP",0
promptl byte "LEFT SWAP",0
inputRow DWORD 0
inputcol DWORD 0


bombSymbl BYTE 'B'

promptinput BYTE "INCORRECT INPUT BETWEEN(0,10)",0

helpswap DWORD 0
helpswap2 DWORD 0

helpswapi DWORD 0
helpswap2i DWORD 0

i DWORD 0
j DWORD 0

Count DWORD 0


stringinput byte "enter the index of the array ",0
		strting byte " , ",0
		string5  byte "enter the row offset the array=  ", 0
		string6 byte "enter the column of the array = " , 0
		string9 byte "Enter the choice = " , 0
		row  dword ?
		col dword ?
		row1  dword ?
		col1 dword ?
		numb1 word ?
		numb2 word ?
		choice byte ?
		
		errorMsg byte "WRONG INPUT ",0


obj game<>

.code
main PROC



;taking input of user name

mov edx,offset input_name
call WriteString
mov edx, offset obj.Usr_Name
mov ecx,sizeof obj.Usr_Name
call ReadString


;for entering the values of the 2darray



call input_martix

call crlf

call input_data_display

;for displaying 

;call slash

call crlf

call clrscr

call display

back:
	
	call combokiller
	
	
	call combochecker
	
	
	call swapping
	;call horizontal

	;call hori
	;call vert

	call clrscr

	call display

	call combochecker

	call combokiller

	;call check


	call crlf

	call clrscr
	
	mov eax,800
	
	call delay

	call display
	
	cmp move,1
	
	jne back
	
	call clrscr
	
	mov move,0
	
	call displayLVL2
	
	call clrscr
	
	mov move,0
	
	call input_martixLVL3
	
	call displayLVL3
	
	back2:
		
		call swapping
		;call horizontal
	
		;call hori
		;call vert
	
	
		;mov eax,score
		;call writedec
		;call crlf
	
		call clrscr
	
		call displayLVL3
	
		call combokiller
	
		call combochecker
	
		;call check
	
	
		call crlf
	
		call clrscr
		
		mov eax,800
		
		call delay
	
		call displayLVL3
		
		cmp move,15
		jne back2
	
	

 exit
main ENDP


check proc
mov ecx,10
mov esi,0
loopi:
call horii
add esi,40

loop loopi

ret
check endp

combochecker proc

mov ecx ,10
 
mov esi,0
 loop1:
	push ecx
	mov ecx , 10
	loop2:
		mov eax,tablew[esi]
		cmp eax,tablew[esi+4]
		jne labelout
		cmp eax ,tablew[esi+8]
		jne labelout
		add score,3
		mov edx, 0


		mov tablew[esi],edx
		mov tablew[esi+4],edx
		mov tablew[esi+8],edx
		jmp labelpopx

		labelpopx:
		cmp eax,tablew[esi+12]
		je labelpop1
		cmp eax,tablew[esi+16]
		je labelpop2
		jmp labelout

		labelpop1:
		mov tablew[esi+12],edx

		jmp labelout

		labelpop2:
		mov tablew[esi+16],edx

		jmp labelout

		labelout:
		add ebx ,type tablew
				
	loop loop2
	pop ecx
loop loop1



ret

blockMsg:
	mov edx,offset errorMsg
	call writestring
	ret


combochecker endp


displayLVL2 PROC



call input_data_display

call crlf


call crlf

mov ebx ,offset tablew
mov ecx ,9
 
 L1:
	push ecx
	mov ecx , 9
	
	call symbol
	
	l2:	
		
		cmp ecx,6
		ja blank
		
		cmp ecx,4
		jb blank		
		
		
		back1:
		mov eax,textcolor
		inc eax
		call Settextcolor
		mov textcolor,eax
		
		mov al , [ebx]
		
		cmp al,5
		je bomb
		
		call writedec
		
		call symbol

		back:

		add ebx ,type tablew
		
		
	loop L2
	
	add Count,1
	
	mov eax,6
	
	call randomrange
	
	mov textcolor,eax
	
	call slash
	
	CALL crlf
	
	pop ecx
	
	
loop L1

call waitmsg

ret

bomb:	
	
	mov al,'B'
	call writechar
	call symbol
	jmp back
	


blank:
	
	cmp Count,5
	ja last    
	
	cmp Count,2
	ja back1
	
	cmp Count,5
	jb back2		       
	
	back2:
	mov al,' ' 
	call writechar
	jmp back

last:
	mov al,' ' 
	call writechar
	jmp back
       


displayLVL2 ENDP



symbol PROC

	mov al, "|" 
	call writechar
	
	ret

symbol ENDP

slash PROC

	
	mov cx,10
	
	call crlf
	
	lo:
		
		mov al," "
		call writechar
		
		mov al,"-"
		call writechar	
		
	loop lo
	
	ret

slash ENDP

input_martixLVL2 PROC

mov ebx ,offset tablew
 
 
 mov ecx,9
 
 call random32
 
 loop1:
	push ecx
	mov ecx , 9
	loop2:	
		mov eax,6h	
		call RandomRange
		mov [ebx] , ax
		add ebx ,type tablew
	loop Loop2
	inc eax
	pop ecx
loop Loop1

ret

input_martixLVL2 ENDP


input_martixLVL3 PROC

 mov ebx ,offset tablew
 
 mov ecx ,10
 
 xor eax,eax
 
 call random32
 loop1:
	push ecx
	mov ecx , 10	
	loop2:
		mov eax,8h	
		call RandomRange
		mov [ebx] , ax
		add ebx ,type tablew	
	loop Loop2
	inc eax
	pop ecx
loop Loop1

ret

input_martixLVL3 ENDP



displayLVL3 PROC


call input_data_display

call crlf


mov ebx ,offset tablew
mov ecx ,10
 
 
 L1:
	push ecx
	mov ecx , 10
	
	call symbol
	
	l2:
		mov eax,textcolor
		inc eax
		call Settextcolor
		mov textcolor,eax
		
		mov al , [ebx]
		
		cmp al,6
		je bomb
		
		cmp al,7
		je block
		
		call writedec
		
		back:
		call symbol
		   
		add ebx ,type tablew
		
	loop L2
	
	mov eax,6
	
	call randomrange
	
	mov textcolor,eax
	
	call slash
	
	CALL crlf
	
	
	pop ecx
loop L1

ret

bomb:	
	mov al,'B'
	call writechar
	jmp back
	
block:
	mov al,'X'
	call writechar
	jmp back




displayLVL3 ENDP

combokiller proc
 
 mov ebx,0
 mov ecx ,10
 
 xor eax,eax
 
 
 loop1:
	push ecx
	mov ecx , 10
	loop2:
		cmp tablew[ebx],0
		je l1
		jmp labelout
		l1:
			mov eax,5h	
			call RandomRange
			inc eax
			mov tablew[ebx] , eax
			
			jmp labelout
			labelout:
			add ebx ,type tablew
				
	loop loop2
	inc eax
	pop ecx
loop loop1

ret


combokiller endp

hori proc 

	mov esi,120
	mov i ,0

	loopi:
	mov eax,tablew[esi]
	cmp eax,tablew[esi+4]
	jne labelout
	cmp eax ,tablew[esi+8]
	jne labelout
	add score,3
	mov edx, 0


	mov tablew[esi],edx
	mov tablew[esi+4],edx
	mov tablew[esi+8],edx
	jmp labelpopx

	labelpopx:
	cmp eax,tablew[esi+12]
	je labelpop1
	cmp eax,tablew[esi+16]
	je labelpop2
	jmp labelout

	labelpop1:
	mov tablew[esi+12],edx

	jmp labelout

	labelpop2:
	mov tablew[esi+16],edx

	jmp labelout

	labelout:
	add esi,4
	inc i
	cmp i,10
	jne loopi





	ret
	hori endp

	horii proc 


	mov i ,0

	loopi:
	mov eax,tablew[esi]
	cmp eax,tablew[esi+4]
	jne labelout
	cmp eax ,tablew[esi+8]
	jne labelout
	add score,3
	mov edx, 0


	mov tablew[esi],edx
	mov tablew[esi+4],edx
	mov tablew[esi+8],edx
	jmp labelpopx

	labelpopx:
	cmp eax,tablew[esi+12]
	je labelpop1
	cmp eax,tablew[esi+16]
	je labelpop2
	jmp labelout

	labelpop1:
	mov tablew[esi+12],edx

	jmp labelout

	labelpop2:
	mov tablew[esi+16],edx

	jmp labelout

	labelout:
	add esi,4
	inc i
	cmp i,10
	jne loopi




ret
horii endp
horineg proc 
	mov esi,0
	add esi,helpswapi

	mov eax,tablew[esi]
	cmp eax,tablew[esi-4]
	call writedec
	call crlf

	jne labelout
	cmp eax ,tablew[esi-8]
	call writedec
	call crlf

	jne labelout


	add score,3
	mov edx, 0


	mov tablew[esi],edx
	mov tablew[esi-4],edx
	mov tablew[esi-8],edx
	jmp labelpopx

	labelpopx:
	cmp eax,tablew[esi-12]
	je labelpop1
	cmp eax,tablew[esi-16]
	je labelpop2
	jmp labelout

	labelpop1:
	mov tablew[esi-12],edx

	jmp labelout

	labelpop2:
	mov tablew[esi-16],edx

	jmp labelout

	labelout:
ret
horineg endp

vert proc 

	mov esi,12
	mov i ,0

	loopi:
	mov eax,tablew[esi]
	cmp eax,tablew[esi+40]
	jne labelout
	cmp eax ,tablew[esi+80]
	jne labelout
	add score,3
	mov edx, 0
	mov tablew[esi],edx
	mov tablew[esi+40],edx
	mov tablew[esi+80],edx

	jmp labelpopx

	labelpopx:
	cmp eax,tablew[esi+120]
	je labelpop1
	cmp eax,tablew[esi+160]
	je labelpop2
	jmp labelout

	labelpop1:
	mov tablew[esi+120],edx

	jmp labelout

	labelpop2:
	mov tablew[esi+160],edx

	jmp labelout


	labelout:
	add esi,40
	inc i
	cmp i,10
	jne loopi

ret
vert endp

vertneg proc 

	mov esi,0
	mov esi,helpswapi

	mov eax,tablew[esi]
	cmp eax,tablew[esi-40]
	jne labelout
	cmp eax ,tablew[esi-80]
	jne labelout
	add score,3
	mov edx, 0
	mov tablew[esi],edx
	mov tablew[esi-40],edx
	mov tablew[esi-80],edx

	jmp labelpopx

	labelpopx:
	cmp eax,tablew[esi-120]
	je labelpop1
	cmp eax,tablew[esi-160]
	je labelpop2
	jmp labelout

	labelpop1:
	mov tablew[esi-120],edx

	jmp labelout

	labelpop2:
	mov tablew[esi-160],edx

	jmp labelout


labelout:
ret

vertneg endp


input_data_display PROC

mov edx,offset name_dis
call writestring

mov edx,offset obj.Usr_Name
call writestring 


mov edx,offset space
call writestring

mov edx,offset score_dis
call writeString

mov eax,0

mov al,score
call writeint

mov edx,offset space
call writestring

mov edx,offset move_dis
call writestring

mov eax,0

mov al,move
call writeint

ret

input_data_display ENDP



input_martix PROC

 mov ebx ,offset tablew
 
 mov ecx ,10
 
 xor eax,eax
 
 
 
 loop1:
	push ecx
	mov ecx , 10
	call random32
	loop2:
		call random32
		mov eax,7h	
		call RandomRange
		mov [ebx] , eax
		add ebx ,type tablew	
	loop loop2
	
	inc eax
	pop ecx
loop loop1

ret

input_martix ENDP


display PROC

call input_data_display

call crlf

mov ebx ,offset tablew
mov ecx ,10
  
 L1:
 	push ecx
 	mov ecx , 10
 	
 	call symbol
 	
 	l2:
 		mov eax,textcolor
 		inc eax
 		call Settextcolor
 		mov textcolor,eax
 		
 		mov al , [ebx]
 		
 		cmp al,6
 		je bomb
 		
 		call writedec
 		
 		back:
 		call symbol
 		   
 		add ebx ,type tablew
 		
 	loop L2

 	mov eax,6
 	
 	call randomrange
 	
 	mov textcolor,eax
 	
 	call slash
 	
 	CALL crlf
 	
 	
 	pop ecx
 loop L1

 

ret

bomb:
	mov al,'B'
	call writechar
	jmp back

display ENDP


		;call printwhite
		mov edx,offset space
		call writestring
Swapping proc

caseWrongInput:
mov edx , offset string5
call writestring
mov eax , 0 
call readint
mov row ,eax
mov edx , offset string6
call writestring
mov eax , 0 
call readint
mov col ,eax

cmp row,0
jb caseWrongInput

cmp row,9
ja caseWrongInput

cmp col,0
jb caseWrongInput

cmp col,9
ja caseWrongInput

mov eax , 0
mov ebx ,offset tablew
mov ecx, 0 
mov eax , rowsize
mul row
add ebx , eax
mov esi ,col
mov ax,[ebx+esi*type tablew]
call crlf
mov numb1 , ax
cmp numb1,7
je Xblock
;swapping

mov eax , 0
mov ebx ,offset tablew
mov ecx, 0 
mov eax , rowsize
mul row
add ebx , eax
mov esi ,col
mov ax,[ebx+esi*type tablew]
call crlf
mov numb1 , ax
cmp numb1,7
je Xblock
mov edx ,offset string9
call writestring
;switch

input:

call readchar
mov choice,al
mov bl , 'r'
cmp bl,choice
je right
mov bl , 'l'
cmp bl,choice
je left
mov bl , 'u'
cmp bl,choice
je up
mov bl , 'd'
cmp bl,choice
je down

mov edx,offset errorMsg
call writestring
jmp input


Xblock:
mov edx,offset errorMsg
call writestring
jmp caseWrongInput


;swapping


	right:
		cmp col,0
		jb caseWrongInput
		cmp col,9
		ja caseWrongInput
		mov eax , 0
		mov ebx ,offset tablew
		mov ecx, 0 
		mov eax , rowsize
		mul row
		add ebx , eax
		mov edx,col
		inc edx
		mov col1,edx
		mov esi ,col1
		mov ax,[ebx+esi*type tablew]
		call writedec
		mov numb2 ,ax
		cmp numb2,7
		je Xblock
		mov ax, numb1
		mov [ebx+esi*type tablew] ,ax
		call writedec
		call crlf
		jmp swapp
	
	left:
		
		cmp col,0
		jb caseWrongInput
		
		cmp col,9
		ja caseWrongInput
	
		mov eax , 0
		mov ebx ,offset tablew
		mov ecx, 0 
		mov eax , rowsize
		mul row
		add ebx , eax
		mov edx,col
		dec edx
		mov col1,edx
		mov esi ,col1
		mov ax,[ebx+esi*type tablew]
		mov numb2 ,ax
		cmp numb2,7
		je Xblock
		mov ax, numb1
		mov [ebx+esi*type tablew] ,ax
		call crlf
		jmp swapp


	up:
	
	cmp row,0
	jb caseWrongInput
	
	mov eax , 0
	mov ebx ,offset tablew
	mov ecx, 0 
	mov eax , rowsize
	mov edx ,row
	dec edx
	mov row1,edx
	mul row1
	add ebx , eax
	mov esi ,col
	mov ax,[ebx+esi*type tablew]
	mov numb2 ,ax
	cmp numb2,7
	je Xblock
	mov ax, numb1
	mov [ebx+esi*type tablew] ,ax
	call crlf
	jmp swapp

	down:
	
	cmp row,9
	ja caseWrongInput
	
	mov eax , 0
	mov ebx ,offset tablew
	mov ecx, 0 
	mov eax , rowsize
	mov edx ,row
	inc edx
	mov row1,edx
	mul row1
	add ebx , eax
	mov esi ,col
	mov ax,[ebx+esi*type tablew]
	mov numb2 ,ax
	cmp numb2,7
	je Xblock
	mov ax, numb1
	mov [ebx+esi*type tablew] ,ax
	call crlf
	jmp swapp
	






 swapp:	
mov eax , 0
mov ebx ,offset tablew
mov ecx, 0 
mov eax , rowsize
mul row
add ebx , eax
mov esi ,col
mov ax,[ebx+esi*type tablew]
call writedec
mov ax,numb2
mov [ebx+esi*type tablew] ,ax
call crlf

mov ax ,numb2
mov dx ,6
cmp ax ,dx 
jne bomb 


cmp ax,7
je Xblock

mov eax , 0
mov ebx ,offset tablew
mov ecx, 0 
mov eax , rowsize
mul row
add ebx , eax
mov esi ,col
mov dx, 0
mov ecx,10
		bb:
		mov eax , rowsize
		mul row
		add ebx , eax
		mov esi ,col
		mov [ebx+esi*type tablew] ,dx
		inc score
		inc col
		loop bb
call crlf

		
bomb:

cmp ax,7
je Xblock

call crlf
;call display


call crlf
;;
mov ebx ,offset tablew
mov ecx ,10 
 d1:
	push ecx
	mov ecx , 10 
	d2:
		mov eax , 0 
		mov ax , [ebx]
		call writedec
		mov edx,offset strting
		call writestring
		add ebx ,type tablew
	loop d2
	CALL crlf
	pop ecx
loop d1
call crlf
call crlf
call crlf
;bombb
mov ecx ,10
 mov ebx , offset tablew
mov esi, 0
 loop11:
	push ecx
	mov ecx ,10
	loop22:
		mov eax,tablew[esi]
		cmp eax,tablew[esi+2]
		jne labelout
		cmp eax ,tablew[esi+4]
		jne labelout
		mov dx, 0

		mov tablew[esi],edx
		add score,1
		mov tablew[esi+2],edx
		add score,1
		mov tablew[esi+4],edx
		add score,1
		jmp labelpopx

		labelpopx:
		cmp eax,tablew[esi+8]
		je labelpop1
		jmp labelout
		
		labelpop1:
		mov tablew[esi+8],edx
		add score,1
		jmp labelout

		labelout:
		add esi ,type tablew
		add ebx ,type tablew
				
	loop loop22
	pop ecx
loop loop11


add move,1



ret

Swapping endp

 horizontal proc
 mov esi,0
 loopi:
	mov j, 0
	loopj:
		 
		 mov i , 0
		 mov ebx,tablew[esi]
		 cmp eax,tablew[esi+colsize]
		 jne labelout
		 cmp eax,tablew[esi+2*colsize]
		 jne labelout

		 mov eax , 0
		 mov tablew[esi],eax
		 mov tablew[esi+colsize],eax
		 mov tablew[esi+colsize],eax

		 add score,3


		 mov ecx ,'X'
		 cmp tablew[esi-40],ecx
		 jne labelpopy1
		 mov tablew[esi-40],eax
		 jmp labelpopy

		 labelpopy1:
		 cmp tablew[esi-4],ecx
		 jne labelpopy2
		 mov tablew[esi-4],eax
		 jmp labelpopy

		 labelpopy2:
		 cmp tablew[esi+40],ecx
		 jne labelpopy3
		 mov tablew[esi+40],eax
		 jmp labelpopy

		 labelpopy3:
		 cmp tablew[esi+4-40],ecx
		 jne labelpopy4
		 cmp tablew[esi+4-40],eax
		 jmp labelpopy

		 labelpopy4:
		 cmp tablew[esi+40+4],ecx
		 jne labelpopy5
		 cmp tablew[esi+40+4],eax
		 jmp labelpopy

		 labelpopy5:
		 cmp tablew[esi+4+4-40],ecx
		 jne labelpopy6
		 cmp tablew[esi+4+4-40],eax
		 jmp labelpopy

		 labelpopy6:
		 cmp tablew[esi+4+4+40],ecx
		 jne labelpopy7
		 cmp tablew[esi+4+4+40],eax
		 jmp labelpopy

		 labelpopy7:
		 cmp tablew[esi+4+4+4],ecx
		 jne labelpopy7
		 cmp tablew[esi+4+4+4],eax
		 
		 labelpopy:
		 cmp tablew[esi+4*3],ebx
		 jne labelout
		 mov tablew[esi+3*4], eax
				
		cmp tablew[esi+4+4+4+4],ecx	;compares to see if there is obstacle after fourth index
		jne labelPopY8
		mov tablew[esi+4+4+4+4],eax
		jmp labelpopyend
				
		labelPopY8:
		cmp tablew[esi+4+4+4+40],ecx			;compares to see if there is obstacle below the fourth index
		jne labelPopY9
		mov tablew[esi+4+4+4+40],eax
		jmp labelpopyend
				
		labelPopY9:
		cmp tablew[esi+4*3-40],ecx		;compares to see if there is obstacle above the fourth index
		jne labelpopyend
		mov tablew[esi+4*3-40],eax

		labelpopyend:

		cmp tablew[esi+4*4], ebx				; for combo of 5
		jne labelout			
		mov tablew[esi+4*4], eax
				
		cmp tablew[esi+20],ecx 		;compares to see if there is obstacle after the fifth index
		jne labelPopY10
		mov tablew[esi+20],eax
		jmp labelPopYend2
				
		labelPopY10:
		cmp tablew[esi+4*4+40],ecx			;compares to see if there is obstacle below the fifth index
		jne labelPopY11
		mov tablew[esi+4*4+40],eax
		jmp labelPopYend2
				
		labelPopY11:
		cmp tablew[esi+4*4-40],ecx		;compares to see if there is obstacle above the fifth index
		jne labelPopYend2
		mov tablew[esi+4*4-40],eax
				
		labelPopYend2:
				
				cmp tablew[esi+5*4], ebx			; for combo of 6
				jne labelout			
				mov tablew[esi+5*4], eax
				
				cmp tablew[esi+6*4],ecx ;compares to see if there is obstacle after the sixth index
				jne labelPopY12
				mov tablew[esi+6*4],eax
				jmp labelout
				
				labelPopY12:
				cmp tablew[esi+60],ecx			;compares to see if there is obstacle below the sixth index
				jne labelPopY13
				mov tablew[esi+60],eax
				jmp labelout
				
				labelPopY13:
				cmp tablew[esi+20-40],ecx			;compares to see if there is obstacle above the sixth index
				jne labelout
				mov tablew[esi+20-40],eax



	labelout:
		add esi,type tablew
		inc j
		cmp j,10
		jne loopj
inc i
cmp  i,10
jne loopi

ret
 horizontal endp


END main