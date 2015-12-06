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
 	push $3
	push $3
	push $1
	push $0
 .L0B:
  	push $1
	pop %rsi
	mov %rsi, -32(%rbp)
	push %rsi
	 pop %rsi
.L1B:
  	 push -32(%rbp)
	 push -8(%rbp)
	pop %rdi
	pop %rsi
	cmp %rdi, %rsi
	jg .L2
	push $0
	jmp .L3
.L2:
	push $1
.L3:
	pop %rsi
	cmp $0, %rsi
	je .L4
	add $0, %rsp
	push $0
	jmp .L1E 
	jmp .L5
.L4:
	 push -24(%rbp)
	pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
.L5:
	 pop %rsi
	 push -24(%rbp)
	 push -16(%rbp)
	pop %rdi
	pop %rsi
	imul %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -24(%rbp)
	push %rsi
	 pop %rsi
	 push -32(%rbp)
	push $1
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -32(%rbp)
	push %rsi
	 pop %rsi
	add $0, %rsp
	jmp .L1B 
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L1E:
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L0E:
	 pop %rsi
	 push -24(%rbp)
	 pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	pop     %rax
	add $32, %rsp
	popq    %rbp
	ret
	.size   main, .-main


	.globl bar
	.type bar, @function
bar:
  	push $3
	 pop %rsi
	mov $0, %rax
	add %rsi, %rax
	add $0, %rsp
	pop %rsi
	add $0, %rsp
	popq %rbp
	jmp *%rsi
	.size bar, .-bar


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
