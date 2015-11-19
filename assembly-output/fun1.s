.LC0:
                  	.string "%i\n"
                  	.text
                  	.globl  main
                  	.type   main, @function
                  main:
                  	pushq %rbp
                  	movq    %rsp, %rbp
                   	push $3
	push $4
	push $5
 
                  	pushq %rbp
                  	movq    %rsp, %rbp
                  	push $5
	push $4
	 call doh
	push %rax
	 pop %rsi
                            
                  	pushq %rbp
                  	movq    %rsp, %rbp
                  	push $12
	push $13
	 call blah
	push %rax
	 pop %rsi
                            	 push -8(%rbp)
                             	 push -16(%rbp)
                             	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              
                  	pushq %rbp
                  	movq    %rsp, %rbp
                  	push $1
	push $1
	 call bar
	push %rax
	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
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
                          

	.globl bar
                          	.type bar, @function
                          bar:
 	push $3
	push $2
 	 push -40(%rbp)
                             	 push -32(%rbp)
                             	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              	 push -8(%rbp)
                             	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              	 push -16(%rbp)
                             	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              	 pop %rsi
                            	mov $0, %rax
                                         	add %rsi, %rax
                                         	add $16, %rsp     
                                         	pop %rsi
                                         	add $16, %rsp
                                         	popq %rbp
                                         	jmp *%rsi
                                         	.size bar, .-bar


	.globl doh
                          	.type doh, @function
                          doh:
  	 push -8(%rbp)
                             	 push -16(%rbp)
                             	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              	 pop %rsi
                            	mov $0, %rax
                                         	add %rsi, %rax
                                         	add $0, %rsp     
                                         	pop %rsi
                                         	add $16, %rsp
                                         	popq %rbp
                                         	jmp *%rsi
                                         	.size doh, .-doh


	.globl blah
                          	.type blah, @function
                          blah:
  	 push -8(%rbp)
                             	 push -16(%rbp)
                             	pop %rdi
              	pop %rsi
              	neg %rdi
              	add %rdi, %rsi
              	push %rsi
              	 push -8(%rbp)
                             	push $2
	pop %rdi
              	pop %rsi
              	imul %rdi, %rsi
              	push %rsi
              	pop %rdi
              	pop %rsi
              	add %rdi, %rsi
              	push %rsi
              	 pop %rsi
                            	mov $0, %rax
                                         	add %rsi, %rax
                                         	add $0, %rsp     
                                         	pop %rsi
                                         	add $16, %rsp
                                         	popq %rbp
                                         	jmp *%rsi
                                         	.size blah, .-blah


	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
                       	.section        .note.GNU-stack,"",@progbits
                       
