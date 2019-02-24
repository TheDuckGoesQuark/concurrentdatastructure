	.file	"lockfree_account.c"
	.text
	.globl	createAccount
	.type	createAccount, @function
createAccount:
.LFB19:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	%edi, %ebx
	movl	$4, %edi
	call	malloc@PLT
	movl	%ebx, (%rax)
	popq	%rbx
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
	movl	(%rdi), %eax
	ret
	.cfi_endproc
.LFE20:
	.size	getBalance, .-getBalance
	.globl	deposit
	.type	deposit, @function
deposit:
.LFB21:
	.cfi_startproc
	movq	%rdi, %r8
	movl	(%rdi), %edx
.L5:
	leal	(%rsi,%rdx), %ecx
	movl	%edx, %eax
	lock cmpxchgl	%ecx, (%r8)
	movl	%eax, %edx
	cmpl	%eax, %ecx
	jne	.L5
	rep ret
	.cfi_endproc
.LFE21:
	.size	deposit, .-deposit
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB22:
	.cfi_startproc
	movq	%rdi, %r8
	movl	(%rdi), %edx
.L8:
	movl	%edx, %ecx
	subl	%esi, %ecx
	movl	%edx, %eax
	lock cmpxchgl	%ecx, (%r8)
	movl	%eax, %edx
	cmpl	%eax, %ecx
	jne	.L8
	movl	%esi, %eax
	ret
	.cfi_endproc
.LFE22:
	.size	withdraw, .-withdraw
	.globl	destroyAccount
	.type	destroyAccount, @function
destroyAccount:
.LFB23:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	free@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE23:
	.size	destroyAccount, .-destroyAccount
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
