	.file	"locking_account.c"
	.text
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	%edi, %ebp
	movl	$48, %edi
	call	malloc@PLT
	movq	%rax, %rbx
	movl	%ebp, (%rax)
	leaq	8(%rax), %rdi
	movl	$0, %esi
	call	pthread_mutex_init@PLT
	movq	%rbx, %rax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE19:
	.size	createAccount, .-createAccount
	.globl	getBalance
	.type	getBalance, @function
getBalance:
.LFB20:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbp
	leaq	8(%rdi), %rbx
	movq	%rbx, %rdi
	call	pthread_mutex_lock@PLT
	movl	0(%rbp), %ebp
	movq	%rbx, %rdi
	call	pthread_mutex_unlock@PLT
	movl	%ebp, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE20:
	.size	getBalance, .-getBalance
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
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movl	%esi, %r12d
	leaq	8(%rdi), %rbp
	movq	%rbp, %rdi
	call	pthread_mutex_lock@PLT
	addl	%r12d, (%rbx)
	movq	%rbp, %rdi
	call	pthread_mutex_unlock@PLT
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE21:
	.size	deposit, .-deposit
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB22:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movl	%esi, %ebp
	leaq	8(%rdi), %r12
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
	call	free@PLT
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	destroyAccount, .-destroyAccount
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
