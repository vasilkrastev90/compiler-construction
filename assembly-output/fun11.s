.LC0: 
	.string "%i\n"
.LC1: 
	.string "%i"
	.text
	.globl  main
	.type   main, @function
main:
	pushq %rbp
	movq  %rsp, %rbp
 	push $0
 	movl    $4, %edi
	call    malloc
	push    %rax
	movq    %rax, %rsi
	movl    $.LC1, %edi
	movl    $0, %eax
	call    __isoc99_scanf
	pop     %rax
	mov   (%rax), %rdi
	mov  %rdi, -8(%rbp)
	movq    %rax, %rdi
	call    free
	 push $0
	 pop %rsi
	pushq %rbp
 	 push -8(%rbp)
mov %rsp, %rsi
	add $8, %rsi
	movq %rsi, %rbp
	 call fact
	push %rax
	 pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	pop     %rax
	add $8, %rsp
	popq    %rbp
	ret
	.size   main, .-main


	.globl fact
	.type fact, @function
fact:
  	 push -8(%rbp)
	pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	 pop %rsi
	 push -8(%rbp)
	push $1
	pop %rdi
	pop %rsi
	cmp %rdi, %rsi
	je .L0
	push $0
	jmp .L1
.L0:
	push $1
.L1:
	pop %rsi
	cmp $0, %rsi
	je .L2
	push $1
	jmp .L3
.L2:
	 push -8(%rbp)
	pushq %rbp
 	 push -8(%rbp)
	push $1
	pop %rdi
	pop %rsi
	neg %rdi
	add %rdi, %rsi
	push %rsi
mov %rsp, %rsi
	add $8, %rsi
	movq %rsi, %rbp
	 call fact
	push %rax
	pop %rdi
	pop %rsi
	imul %rdi, %rsi
	push %rsi
.L3:
	 pop %rsi
	mov $0, %rax
	add %rsi, %rax
	add $0, %rsp
	pop %rsi
	add $8, %rsp
	popq %rbp
	jmp *%rsi
	.size fact, .-fact


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
