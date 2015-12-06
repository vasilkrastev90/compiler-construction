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
 	pushq %rbp
 	push $1
mov %rsp, %rsi
	add $8, %rsi
	movq %rsi, %rbp
	 call bar
	push %rax
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
