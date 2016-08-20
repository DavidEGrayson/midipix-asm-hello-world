	.file	"mylib.c"
	.globl	shared_string

	.section .got$shared_string,"r"
	.global __imp_shared_string
__imp_shared_string:
	.quad	shared_string
	.linkonce discard

	.data
	.data
shared_string:
	.ascii "woot\0"
	.section .drectve
	.ascii " -export:\"shared_string\",data"
