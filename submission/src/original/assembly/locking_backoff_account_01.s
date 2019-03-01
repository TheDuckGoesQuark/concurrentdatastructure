	.file	"locking_backoff_account.c"
	.text
	.globl	assignCurrentTimePlusDelay
	.type	assignCurrentTimePlusDelay, @function
assignCurrentTimePlusDelay:
.LFB30:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, (%rsp)
	movq	%rsi, 8(%rsp)
	movq	%rsp, %rsi
	movl	$0, %edi
	call	clock_gettime@PLT
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE30:
	.size	assignCurrentTimePlusDelay, .-assignCurrentTimePlusDelay
	.globl	obtainLock
	.type	obtainLock, @function
obtainLock:
.LFB31:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movq	%rdi, %rbp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	initial_delay_nsec(%rip), %rbx
	movq	(%rsp), %rax
	movq	8(%rsp), %rdx
	movq	%rax, 16(%rsp)
	movq	%rdx, 24(%rsp)
	leaq	16(%rsp), %rsi
	movl	$0, %edi
	call	clock_gettime@PLT
	movq	%rsp, %r12
	addq	$8, %rbp
	leaq	32(%rsp), %r13
	jmp	.L4
.L5:
	movq	(%rsp), %rax
	movq	8(%rsp), %rdx
	movq	%rax, 32(%rsp)
	movq	%rdx, 40(%rsp)
	movq	%r13, %rsi
	movl	$0, %edi
	call	clock_gettime@PLT
.L4:
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	pthread_mutex_timedlock@PLT
	testl	%eax, %eax
	je	.L9
	addq	%rbx, %rbx
	cmpq	%rbx, max_delay_nsec(%rip)
	jg	.L5
	movq	initial_delay_nsec(%rip), %rbx
	jmp	.L5
.L9:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L10
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	obtainLock, .-obtainLock
	.globl	releaseLock
	.type	releaseLock, @function
releaseLock:
.LFB32:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	addq	$8, %rdi
	call	pthread_mutex_unlock@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE32:
	.size	releaseLock, .-releaseLock
	.globl	createAccount
	.type	createAccount, @function
createAccount:
.LFB33:
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
.LFE33:
	.size	createAccount, .-createAccount
	.globl	getBalance
	.type	getBalance, @function
getBalance:
.LFB34:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	call	obtainLock
	movl	(%rbx), %ebp
	leaq	8(%rbx), %rdi
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
.LFE34:
	.size	getBalance, .-getBalance
	.globl	deposit
	.type	deposit, @function
deposit:
.LFB35:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movl	%esi, %ebp
	call	obtainLock
	addl	%ebp, (%rbx)
	leaq	8(%rbx), %rdi
	call	pthread_mutex_unlock@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE35:
	.size	deposit, .-deposit
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB36:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rbx
	movl	%esi, %ebp
	call	obtainLock
	subl	%ebp, (%rbx)
	leaq	8(%rbx), %rdi
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
.LFE36:
	.size	withdraw, .-withdraw
	.globl	destroyAccount
	.type	destroyAccount, @function
destroyAccount:
.LFB37:
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
.LFE37:
	.size	destroyAccount, .-destroyAccount
	.globl	initial_delay_nsec
	.data
	.align 8
	.type	initial_delay_nsec, @object
	.size	initial_delay_nsec, 8
initial_delay_nsec:
	.quad	1000
	.globl	max_delay_nsec
	.align 8
	.type	max_delay_nsec, @object
	.size	max_delay_nsec, 8
max_delay_nsec:
	.quad	10000
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
