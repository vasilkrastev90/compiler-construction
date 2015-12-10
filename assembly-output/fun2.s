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
  	pushq %rbp
 	push $3
mov %rsp, %rsi
	add $8, %rsi
	movq %rsi, %rbp
	 call bar
	push %rax
	 pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	pop     %rax
	add $0, %rsp
	popq    %rbp
	ret
	.size   main, .-main


	.globl bar
	.type bar, @function
bar:
 	push $3
	push $4
 .L0B:
  	 push -24(%rbp)
	 push -32(%rbp)
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	 push -8(%rbp)
	pop %rdi
	pop %rsi
	imul %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -8(%rbp)
	push %rsi
	 pop %rsi
	add $0, %rsp
	push $0
	jmp .L0E 
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L0E:
	 pop %rsi
	 push -8(%rbp)
	 pop %rsi
	mov $0, %rax
	add %rsi, %rax
	add $16, %rsp
	pop %rsi
	add $8, %rsp
	popq %rbp
	jmp *%rsi
	.size bar, .-bar


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
