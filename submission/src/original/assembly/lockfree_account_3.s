	.file	"lockfree_account.c"
	.text
	.p2align 4,,15
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
	movl	(%rdi), %eax
	.p2align 4,,10
	.p2align 3
.L6:
	leal	(%rsi,%rax), %edx
	lock cmpxchgl	%edx, (%rdi)
	cmpl	%eax, %edx
	jne	.L6
	rep ret
	.cfi_endproc
.LFE21:
	.size	deposit, .-deposit
	.p2align 4,,15
	.globl	withdraw
	.type	withdraw, @function
withdraw:
.LFB22:
	.cfi_startproc
	movl	(%rdi), %eax
	.p2align 4,,10
	.p2align 3
.L9:
	movl	%eax, %edx
	subl	%esi, %edx
	lock cmpxchgl	%edx, (%rdi)
	cmpl	%eax, %edx
	jne	.L9
	movl	%esi, %eax
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
	jmp	free@PLT
	.cfi_endproc
.LFE23:
	.size	destroyAccount, .-destroyAccount
	.ident	"GCC: (Ubuntu 7.3.0-27ubuntu1~18.04) 7.3.0"
	.section	.note.GNU-stack,"",@progbits
