.model small
.stack 500h
.data 
t1 db '***** * **** *****     *     ****  ***** **** ****', '$'
t2 db '  *   * *      *      * *    *       *   *  * *   ', '$'
t3 db '  *   * *      *     *   *   *       *   *  * ****', '$'
t4 db '  *   * *      *    *******  *       *   *  * *   ', '$'
t5 db '  *   * ****   *   *       * ****    *   **** ****', '$'
tagline db  'developed by mamoona$' 
pak db 'press any key to continue...$'
r db 'game rules:$' 
r1 db '1. players will take turns.$'
r2 db '2. player 1 will start the game.$'
r3 db '3. player 1 will set "x" and player 2 will set "o".$'
r4 db '4. the board is marked with cell numbers.$'
r5 db '5. enter cell number to place your mark.$'
r6 db '6. set 3 of your marks horizontally, vertically or diagonally to win.$'   
r7 db 'good luck!$'
 
pc1 db ' (x)$'
pc2 db ' (o)$' 

l1 db '   |   |   $'
l2 db '-----------$'
n1 db ' | $'
c1 db '1$' 
c2 db '2$'
c3 db '3$'
c4 db '4$'
c5 db '5$'
c6 db '6$'
c7 db '7$'
c8 db '8$'
c9 db '9$'
player db 50, '$' 
moves db 0
done db 0
dr db 0 
inp db 32, ':: enter cell no. : $'
tkn db 'this cell is taken! press any key...$' 
cur db 88
w1 db 'player $'
w2 db ' won the game!$'
drw db 'the game is draw!$'
tra db 'want to play again? (y/n): $'
wi db  32, 32, 32, 'wrong input! press any key...   $' 

; this line is used to overwrite a line to clean the area
emp db '                                        $'  


.code
main proc
    mov ax, @data
    mov ds, ax

    mov cx, 5           ; number of lines to print
    mov si, 0           ; counter to track lines

home_loop:
    mov bx, si          ; copy si (16-bit) to bx
    mov dh, 6           ; row
    add dh, bl          ; add bl (low byte of si) increment row
    mov dl, 14          ; column
    
    call set_cursor
    cmp si, 0
    je print_t1
    cmp si, 1
    je print_t2
    cmp si, 2
    je print_t3
    cmp si, 3
    je print_t4
    cmp si, 4
    je print_t5

print_t1:
    lea dx, t1
    call print_string
    jmp loopcontinue

print_t2:
    lea dx, t2
    call print_string
    jmp loopcontinue

print_t3:
    lea dx, t3
    call print_string
    jmp loopcontinue

print_t4:
    lea dx, t4
    call print_string
    jmp loopcontinue

print_t5:
    lea dx, t5
    call print_string

loopcontinue:
    inc si
    loop home_loop

    mov dh, 12
    mov dl, 22
    call set_cursor
    lea dx, tagline
    call print_string

    mov dh, 13
    mov dl, 24
    call set_cursor
    lea dx, pak
    call print_string

    mov ah, 7
    int 21h

    call clear_screen
    jmp rules


rules:  
        mov dh, 6
        mov dl, 7
        call set_cursor
    lea dx, r
    call print_string
      
        mov dh, 7
        mov dl, 7
        call set_cursor 
    lea dx, r1  
    call print_string
        
        mov dh, 8
        mov dl, 7
        call set_cursor 
    lea dx, r2   
    call print_string
         
        mov dh, 9
        mov dl, 7
        call set_cursor 
    lea dx, r3  
    call print_string
        
        mov dh, 10
        mov dl, 7
        call set_cursor
    lea dx, r4   
    call print_string
    
        mov dh, 11
        mov dl, 7
        call set_cursor          
    lea dx, r5  
    call print_string
        
        mov dh, 12
        mov dl, 7
        call set_cursor
    lea dx, r6
    call print_string
        
        mov dh, 13
        mov dl, 7
        call set_cursor
    lea dx, r7
    call print_string
        
        mov dh, 15
        mov dl, 7
        call set_cursor     
    lea dx, pak 
    call print_string
    
    mov ah, 7   
    int 21h  

init:
    mov player, 50
    mov moves, 0
    mov done, 0
    mov dr, 0
    mov c1, 49
    mov c2, 50
    mov c3, 51
    mov c4, 52
    mov c5, 53
    mov c6, 54
    mov c7, 55
    mov c8, 56
    mov c9, 57
    jmp plrchange
    
victory:
    lea dx, w1
    call print_string
    lea dx, player
    call print_string
    lea dx, w2
    call print_string
    mov ah, 2
    mov dh, 17
    mov dl, 28
    int 10h

    lea dx, pak
    call print_string
    mov ah, 7
    int 21h
    jmp tryagain

draw:
    lea dx, drw
    call print_string
    mov dh, 17
    mov dl, 28       
    call set_cursor

    lea dx, pak
    call print_string
    mov ah, 7
    int 21h
    jmp tryagain

; check: there are 8 possible winning combinations

check1:  ; checking 1, 2, 3
    mov al, c1
    mov bl, c2 
    mov cl, c3
    
    cmp al, bl
    jnz check2
    
    cmp bl, cl
    jnz check2
    
    mov done, 1
    jmp board

check2:  ; checking 4, 5, 6
    mov al, c4
    mov bl, c5 
    mov cl, c6
    
    cmp al, bl
    jnz check3
    
    cmp bl, cl
    jnz check3
    
    mov done, 1
    jmp board

check3:  ; checking 7, 8, 9
    mov al, c7
    mov bl, c8 
    mov cl, c9
    
    cmp al, bl
    jnz check4
    
    cmp bl, cl
    jnz check4 
    
    mov done, 1
    jmp board

check4:  ; checking 1, 4, 7
    mov al, c1
    mov bl, c4 
    mov cl, c7
    
    cmp al, bl
    jnz check5
    
    cmp bl, cl
    jnz check5
    
    mov done, 1
    jmp board

check5:  ; checking 2, 5, 8
    mov al, c2
    mov bl, c5 
    mov cl, c8
    
    cmp al, bl
    jnz check6
    
    cmp bl, cl
    jnz check6
    
    mov done, 1
    jmp board

check6:  ; checking 3, 6, 9
    mov al, c3
    mov bl, c6 
    mov cl, c9
    
    cmp al, bl
    jnz check7
    
    cmp bl, cl
    jnz check7
    
    mov done, 1
    jmp board

check7:  ; checking 1, 5, 9
    mov al, c1
    mov bl, c5 
    mov cl, c9
    
    cmp al, bl
    jnz check8
    
    cmp bl, cl
    jnz check8
    
    mov done, 1
    jmp board  

check8:  ; checking 3, 5, 7
    mov al, c3
    mov bl, c5 
    mov cl, c7
    
    cmp al, bl
    jnz drawcheck
    
    cmp bl, cl
    jnz drawcheck
    
    mov done, 1
    jmp board

drawcheck:
    mov al, moves
    cmp al, 9
    jb plrchange
    
    mov dr, 1
    jmp board

       

plrchange:
    cmp player, 49     
    je p2              
    cmp player, 50     
    je p1              
p1:
    mov player, 49     
    mov cur, 88      
    jmp board          

p2:
    mov player, 50    
    mov cur, 79       
    jmp board        


board:
    call clear_screen              

    mov dh, 6
    mov dl, 30
    call set_cursor
    lea dx, l1
    call print_string

    mov dh, 7
    mov dl, 30
    call set_cursor
    mov ah, 2
    mov dl, 32
    int 21h
    lea dx, c1
    call print_string
    lea dx, n1
    call print_string
    lea dx, c2
    call print_string
    lea dx, n1
    call print_string
    lea dx, c3
    call print_string

    mov dh, 8
    mov dl, 30
    call set_cursor
    lea dx, l2
    call print_string
   
    mov dh, 9 
    mov dl,30
    call set_cursor
    lea dx, l1
    call print_string

    mov dh, 10
    mov dl, 30
    call set_cursor
    mov ah, 2
    mov dl, 32
    int 21h
    lea dx, c4
    call print_string
    lea dx, n1
    call print_string
    lea dx, c5
    call print_string
    lea dx, n1
    call print_string
    lea dx, c6
    call print_string

    mov dh, 11
    mov dl, 30
    call set_cursor
    lea dx, l1
    call print_string
    
    mov dh, 12
    mov dl, 30
    call set_cursor
    lea dx, l2
    call print_string
 
    mov dh, 13
    mov dl, 30
    call set_cursor
    lea dx, l1
    call print_string

    mov dh, 14
    mov dl, 30
    call set_cursor
    mov ah, 2
    mov dl, 32
    int 21h
    lea dx, c7
    call print_string
    lea dx, n1
    call print_string
    lea dx, c8
    call print_string
    lea dx, n1
    call print_string
    lea dx, c9
    call print_string

    mov dh, 15
    mov dl, 30
    call set_cursor
    lea dx, l1
    call print_string
    
    mov dh, 16
    mov dl, 20
    call set_cursor
    cmp done, 1
    je victory          
    cmp dr, 1
    je draw             


input:

    lea dx, w1
    call print_string
    mov ah, 2
    mov dl, player
    int 21h
    cmp player, 49
    je pl1

    lea dx, pc2
    call print_string
    jmp takeinput

    pl1:
        lea dx, pc1
        call print_string

takeinput:
    lea dx, inp
    call print_string
    mov ah, 1
    int 21h 
    inc moves 
    
    mov bl, al 
    sub bl, 48
    mov cl, cur 

    cmp bl, 1
    je  c1u 

    cmp bl, 2
    je  c2u

    cmp bl, 3
    je  c3u

    cmp bl, 4
    je  c4u

    cmp bl, 5
    je  c5u

    cmp bl, 6
    je  c6u

    cmp bl, 7
    je  c7u

    cmp bl, 8
    je  c8u

    cmp bl, 9
    je  c9u  

    dec moves 

    mov dh, 16
    mov dl, 20 
    call set_cursor
    lea dx, wi
    call print_string
    mov ah, 7 
    int 21h

    call set_cursor
    lea dx, emp  
    call print_string 
    mov dh, 16
    mov dl, 20 
    call set_cursor
    jmp input

taken:
    dec moves 
    mov dh, 16
    mov dl, 20 
    call set_cursor   

    lea dx, tkn   
    call print_string  

    mov ah, 7    
    int 21h 

    call set_cursor
    lea dx, emp  
    call print_string 

    mov dh, 16
    mov dl, 20 
    call set_cursor

    jmp input


c1u:
    cmp c1, 88
    jz taken
    cmp c1, 79
    jz taken 
    mov c1, cl
    jmp check

c2u:
    cmp c2, 88
    jz taken
    cmp c2, 79
    jz taken 
    mov c2, cl
    jmp check

c3u:
    cmp c3, 88
    jz taken
    cmp c3, 79
    jz taken 
    mov c3, cl
    jmp check

c4u: 
    cmp c4, 88
    jz taken
    cmp c4, 79
    jz taken 
    mov c4, cl
    jmp check 

c5u: 
    cmp c5, 88
    jz taken
    cmp c5, 79
    jz taken 
    mov c5, cl
    jmp check

c6u:
    cmp c6, 88
    jz taken
    cmp c6, 79
    jz taken 
    mov c6, cl
    jmp check

c7u: 
    cmp c7, 88
    jz taken
    cmp c7, 79
    jz taken 
    mov c7, cl
    jmp check 

c8u: 
    cmp c8, 88
    jz taken
    cmp c8, 79
    jz taken 
    mov c8, cl
    jmp check

c9u:
    cmp c9, 88
    jz taken
    cmp c9, 79
    jz taken 
    mov c9, cl
    jmp check

tryagain:
    call clear_screen
    mov dh, 10
    mov dl, 24
    call set_cursor

    lea dx, tra  
    call print_string

    mov ah, 1     
    int 21h

    cmp al, 121 
    jz init 

    cmp al, 89   
    jz init

    cmp al, 110
    jz exit

    cmp al, 78   
    jz exit  

    mov dh, 10
    mov dl, 24
    call set_cursor

    lea dx, wi  
    call print_string 

    mov ah, 7 
    int 21h

    mov dh, 10
    mov dl, 24
    call set_cursor

    lea dx, emp 
    call print_string

    jmp tryagain 

exit:
    mov ah, 4ch
    int 21h 
    main endp 

set_cursor proc
    mov ah,2
    mov bh,0
    int 10h
    ret
set_cursor endp

print_string proc
    mov ah, 9
    int 21h
    ret
print_string endp   

clear_screen proc
    mov ax, 0600h   ; scroll entire screen up (clears it)
    mov bh, 07h     ; attribute: white on black
    mov cx, 0000h   ; upper-left corner (row 0, col 0)
    mov dx, 184fh   ; bottom-right corner (row 24, col 79)
    int 10h         ; bios video service
    ret
clear_screen endp        

end main
                
                
                      