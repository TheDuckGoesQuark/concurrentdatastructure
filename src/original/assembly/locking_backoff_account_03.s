	.file	"locking_backoff_account.c"
	.text
	.p2align 4,,15
	.globl	assignCurrentTimePlusDelay
	.type	assignCurrentTimePlusDelay, @function
assignCurrentTimePlusDelay:
.LFB30:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, (%rsp)
	movq	%rsi, 8(%rsp)
	xorl	%edi, %edi
	movq	%rsp, %rsi
	call	clock_gettime@PLT
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE30:
	.size	assignCurrentTimePlusDelay, .-assignCurrentTimePlusDelay
	.p2align 4,,15
	.globl	obtainLock
	.type	obtainLock, @function
obtainLock:
.LFB31:
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
	xorl	%edi, %edi
	addq	$8, %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	movdqa	(%rsp), %xmm0
	leaq	16(%rsp), %rsi
	movq	%rsp, %rbp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 16(%rsp)
	leaq	32(%rsp), %r12
	call	clock_gettime@PLT
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L6:
	movdqa	(%rsp), %xmm0
	movq	%r12, %rsi
	xorl	%edi, %edi
	movaps	%xmm0, 32(%rsp)
	call	clock_gettime@PLT
.L5:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pthread_mutex_timedlock@PLT
	testl	%eax, %eax
	jne	.L6
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L9
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE31:
	.size	obtainLock, .-obtainLock
	.p2align 4,,15
	.globl	releaseLock
	.type	releaseLock, @function
releaseLock:
.LFB32:
	.cfi_startproc
	addq	$8, %rdi
	jmp	pthread_mutex_unlock@PLT
	.cfi_endproc
.LFE32:
	.size	releaseLock, .-releaseLock
	.p2align 4,,15
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
.LFE33:
	.size	createAccount, .-createAccount
	.p2align 4,,15
	.globl	getBalance
	.type	getBalance, @function
getBalance:
.LFB34:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movq	%rdi, %r13
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%edi, %edi
	leaq	8(%r13), %rbx
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movdqa	(%rsp), %xmm0
	leaq	32(%rsp), %rsi
	movq	%rsp, %rbp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 32(%rsp)
	leaq	16(%rsp), %r12
	call	clock_gettime@PLT
	jmp	.L14
	.p2align 4,,10
	.p2align 3
.L15:
	movdqa	(%rsp), %xmm0
	movq	%r12, %rsi
	xorl	%edi, %edi
	movaps	%xmm0, 16(%rsp)
	call	clock_gettime@PLT
.L14:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pthread_mutex_timedlock@PLT
	testl	%eax, %eax
	jne	.L15
	movl	0(%r13), %ebp
	movq	%rbx, %rdi
	call	pthread_mutex_unlock@PLT
	movq	56(%rsp), %rdx
	xorq	%fs:40, %rdx
	movl	%ebp, %eax
	jne	.L18
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
.L18:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE34:
	.size	getBalance, .-getBalance
	.p2align 4,,15
	.globl	deposit
	.type	deposit, @function
deposit:
.LFB35:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%esi, %r14d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	xorl	%edi, %edi
	leaq	8(%r13), %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movdqa	(%rsp), %xmm0
	leaq	32(%rsp), %rsi
	movq	%rsp, %rbp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 32(%rsp)
	leaq	16(%rsp), %r12
	call	clock_gettime@PLT
	jmp	.L20
	.p2align 4,,10
	.p2align 3
.L21:
	movdqa	(%rsp), %xmm0
	movq	%r12, %rsi
	xorl	%edi, %edi
	movaps	%xmm0, 16(%rsp)
	call	clock_gettime@PLT
.L20:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pthread_mutex_timedlock@PLT
	testl	%eax, %eax
	jne	.L21
	addl	%r14d, 0(%r13)
	movq	%rbx, %rdi
	call	pthread_mutex_unlock@PLT
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L24
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L24:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE35:
	.size	deposit, .-deposit
	.p2align 4,,15
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB36:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%esi, %r14d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %r13
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	xorl	%edi, %edi
	leaq	8(%r13), %rbx
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movdqa	(%rsp), %xmm0
	leaq	32(%rsp), %rsi
	movq	%rsp, %rbp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 32(%rsp)
	leaq	16(%rsp), %r12
	call	clock_gettime@PLT
	jmp	.L26
	.p2align 4,,10
	.p2align 3
.L27:
	movdqa	(%rsp), %xmm0
	movq	%r12, %rsi
	xorl	%edi, %edi
	movaps	%xmm0, 16(%rsp)
	call	clock_gettime@PLT
.L26:
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	call	pthread_mutex_timedlock@PLT
	testl	%eax, %eax
	jne	.L27
	subl	%r14d, 0(%r13)
	movq	%rbx, %rdi
	call	pthread_mutex_unlock@PLT
	movq	56(%rsp), %rdx
	xorq	%fs:40, %rdx
	movl	%r14d, %eax
	jne	.L30
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L30:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE36:
	.size	withdraw, .-withdraw
	.p2align 4,,15
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
	popq	%rbx
	.cfi_def_cfa_offset 8
	jmp	free@PLT
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
