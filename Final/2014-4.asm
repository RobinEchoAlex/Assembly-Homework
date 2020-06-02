                           data segment

data ends

stack segment stack
 dw 20h dup(?) 
top label word
stack ends

code segment
    assume cs:code,ds:data,ss:stack
main proc far 

    mov ax,data
    mov ds,ax

    mov ax,stack
    mov ss,ax
    lea sp,top

    ;0-9  30h 39h tp digital  and 1111(15)
    ;A-F  41h 46h to digital  - 37h (55)
    ;a-z  61h 66h to digital  - 57h (75)

    mov cx,4
    xor bx,bx

l1: mov ah,01h
    int 21h

    cmp al,0dh
    je input

    cmp al,'0'
    jb l1
    cmp al,'9'
    ja l2   
    ;0-9

    push cx
    mov cl,4
    shl bx,cl ;ahl rol sal
    and al,1111b
    add bl,al   

    pop cx
    loop l1


l2: cmp al,'A'
    jb l1
    cmp al,'F'
    ja l3
    ; 'A-F'
    push ax
    mov cl,4
    shl bx,cl
    sub al,37h
    add bl,al

    pop ax
    loop l1

l3: cmp al,'a'
    jb l1
    cmp al,'f'
    ja l1
    ; 'a-f'
    push cx
    mov cl,4
    shl bx,cl
    sub al,57h
    add bl,al

    pop cx
    loop l1

input:
    mov cx,16

    mov dl,0ah
    mov ah,02h
    int 21h

l4: rol bx,1            ;װ��õ�����ѭ�����ƣ�ȡ����һ�Ĵ����У��������и�λ�������������
    mov dl,bl
    and dl,1
    add dl,30h
    mov ah,02h
    int 21h
    loop l4


exit: 
    mov ah,4ch
    int 21h


main endp
 code  ends
  end main