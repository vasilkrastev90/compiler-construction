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
	push $0
 .L0B:
  	push $0
	pop %rsi
	mov %rsi, -8(%rbp)
	push %rsi
	 pop %rsi
.L1B:
  	 push -8(%rbp)
	push $5
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
	je .L10
	add $0, %rsp
	push $0
	jmp .L1E 
	jmp .L11
.L10:
.L4B:
  	push $0
	pop %rsi
	mov %rsi, -16(%rbp)
	push %rsi
	 pop %rsi
.L5B:
  	 push -16(%rbp)
	push $10
	pop %rdi
	pop %rsi
	cmp %rdi, %rsi
	jg .L6
	push $0
	jmp .L7
.L6:
	push $1
.L7:
	pop %rsi
	cmp $0, %rsi
	je .L8
	add $0, %rsp
	push $0
	jmp .L5E 
	jmp .L9
.L8:
	 push -8(%rbp)
	push $10
	pop %rdi
	pop %rsi
	imul %rdi, %rsi
	push %rsi
	 push -16(%rbp)
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	pop %rsi
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
.L9:
	 pop %rsi
	 push -16(%rbp)
	push $1
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -16(%rbp)
	push %rsi
	 pop %rsi
	add $0, %rsp
	jmp .L5B 
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L5E:
	 pop %rsi
	add $0, %rsp
	 push %rsi
.L4E:
.L11:
	 pop %rsi
	 push -8(%rbp)
	push $1
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	pop %rsi
	mov %rsi, -8(%rbp)
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
	push %rsi
	movl    $.LC0, %edi
	movl    $0, %eax
	call    printf
	pop     %rax
	add $16, %rsp
	popq    %rbp
	ret
	.size   main, .-main


	.globl bar
	.type bar, @function
bar:
  	 push -8(%rbp)
	push $2
	pop %rdi
	pop %rsi
	add %rdi, %rsi
	push %rsi
	 pop %rsi
	mov $0, %rax
	add %rsi, %rax
	add $0, %rsp
	pop %rsi
	add $8, %rsp
	popq %rbp
	jmp *%rsi
	.size bar, .-bar


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
