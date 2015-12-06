.LC0: 
	.string "%i\n"
	.text
	.globl  main
	.type   main, @function
main:
	pushq %rbp
	movq  %rsp, %rbp
  	pushq %rbp
 	push $2
	movq 8(%rsp), %rbp
	 call fact
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


	.globl fact
	.type fact, @function
fact:
 	push $1
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
#	pushq %rbp
# 	 push -8(%rbp)
#	movq 8(%rsp), %rbp
#	 call fact
#	push %raxi
        push $0
.L3:
	 pop %rsi
	mov $0, %rax
	add %rsi, %rax
	add $8, %rsp
	pop %rsi
	add $8, %rsp
	popq %rbp
	jmp *%rsi
	.size fact, .-fact


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
	.section        .note.GNU-stack,"",@progbits
