.LC0:
                  	.string "%i\n"
                  	.text
                  	.globl  main
                  	.type   main, @function
                  main:
                  LFB0:
                  	pushq %rbp
                  	movq    %rsp, %rbp
                   	push $14
	push $7
	pop %rsi
              	pop %rdi
              	xor  %rdx, %rdx  
              	mov  %rdi, %rax 
              	idiv %rsi       
              	push %rax
               	pop %rsi
                   	push %rsi
                   	movl    $.LC0, %edi
                   	movl    $0, %eax
                   	call    printf
                   	pop     %rax
                   	popq    %rbp
                   	ret
                   	.LFE0:
                   	.size   main, .-main
                   	.ident  "GCC: (Ubuntu 4.8.4-2ubuntu1~14.04) 4.8.4"
                   	.section        .note.GNU-stack,"",@progbits
                   
