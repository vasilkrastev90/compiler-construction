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
 	push $5
	push $3
	push $1
 .L0B:
  	 push -8(%rbp)
	push $1
	pop %rdi
	pop %rsi
	cmp %rdi, %rsi
	jl .L1
	push $0
	jmp .L2
.L1:
	push $1
.L2:
	pop %rsi
	cmp $0, %rsi
	je .L3
	add $0, %rsp
	push $0
	jmp .L0E 
	jmp .L4
.L3:
	 push -24(%rbp)
	 push -16(%rbp)
	pop %rdi
	pop %rsi
	imul %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -24(%rbp)
	push %rsi
.L4:
	 pop %rsi
	 push -8(%rbp)
	push $1
	pop %rdi
	pop %rsi
	neg %rdi
	add %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -8(%rbp)
	push %rsi
	 pop %rsi
	add $0, %rsp
	jmp .L0B 
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L0E:
	 pop %rsi
	push $1
	 pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	pop     %rax
	add $24, %rsp
	popq    %rbp
	ret
	.size   main, .-main


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
