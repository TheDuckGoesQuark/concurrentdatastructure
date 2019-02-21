	.file	"account.c"
	.text
	.p2align 4,,15
	.globl	createAccount
	.type	createAccount, @function
createAccount:
.LFB19:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movl	%edi, %ebp
	movl	$48, %edi
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	malloc@PLT
	leaq	8(%rax), %rdi
	movl	%ebp, (%rax)
	xorl	%esi, %esi
	movq	%rax, %rbx
	call	pthread_mutex_init@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE19:
	.size	createAccount, .-createAccount
	.p2align 4,,15
	.globl	getBalance
	.type	getBalance, @function
getBalance:
.LFB20:
	.cfi_startproc
	movl	(%rdi), %eax
	ret
	.cfi_endproc
.LFE20:
	.size	getBalance, .-getBalance
	.p2align 4,,15
	.globl	deposit
	.type	deposit, @function
deposit:
.LFB21:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	leaq	8(%rdi), %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movl	%esi, %r12d
	movq	%rbp, %rdi
	call	pthread_mutex_lock@PLT
	addl	%r12d, (%rbx)
	movq	%rbp, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	pthread_mutex_unlock@PLT
	.cfi_endproc
.LFE21:
	.size	deposit, .-deposit
	.p2align 4,,15
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB22:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	leaq	8(%rdi), %r12
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movl	%esi, %ebp
	movq	%r12, %rdi
	call	pthread_mutex_lock@PLT
	subl	%ebp, (%rbx)
	movq	%r12, %rdi
	call	pthread_mutex_unlock@PLT
	movl	%ebp, %eax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE22:
	.size	withdraw, .-withdraw
	.p2align 4,,15
	.globl	destroyAccount
	.type	destroyAccount, @function
destroyAccount:
.LFB23:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	leaq	8(%rdi), %rdi
	call	pthread_mutex_destroy@PLT
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	free@PLT
	.cfi_endproc
.LFE23:
	.size	destroyAccount, .-destroyAccount
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
