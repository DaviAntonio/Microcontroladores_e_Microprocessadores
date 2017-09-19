	.file	"multiplica_assembly.c"
	.arch msp430g2553
	.cpu 430
	.mpy none

	.text
.Ltext0:
	.section	.init9,"ax",@progbits
	.p2align 1,0
.global	main
	.type	main,@function
/***********************
 * Function `main' 
 ***********************/
main:
.LFB0:
	.file 1 "multiplica_assembly.c"
	.loc 1 10 0
	mov	r1, r4
.LCFI0:
	add	#2, r4
.LCFI1:
	.loc 1 11 0
	mov	#23168, &__WDTCTL
	.loc 1 12 0
#APP
 ;  12 "multiplica_assembly.c" 1
	; Instrução inútil para colocar o breakpoint antes do call 
dummy: 
clr.w R13 
call mult_unsigned 
; Quando a multiplicação retornar, loop infinito 
keep: 
jmp keep 
; Recebe R15 e R14 
mult_unsigned: 
; Se R14 = 0, retornar 0 em R15 e sair da função 
tst.w R14 
jnz mult_op 
clr.w R15 
ret 
mult_op: 
; Guardar R15 na pilha, precisaremos dele, já que quando R14 = 0, 
; limparemos o R15 
push.w R15 
; a*b = a + a + a + ... + a (b vezes) 
dec.w R14 
call mult_unsigned 
; Quando R14 = 0, um ret fará SP vir para cá 
; Precisamos recuperar R15 da pilha e colocar em R14 
pop.w R14 
; R14 = R15, então agora é só ir somando até as R14 vezes 
add.w R14, R15 
ret
 ;  0 "" 2
	.loc 1 44 0
#NOAPP
	mov	#0, r15
	.loc 1 45 0
.LIRD0:
.LFE0:
.Lfe1:
	.size	main,.Lfe1-main
;; End of function 

	.section	.debug_frame,"",@progbits
.Lframe0:
	.4byte	.LECIE0-.LSCIE0
.LSCIE0:
	.4byte	0xffffffff
	.byte	0x1
	.string	""
	.uleb128 0x1
	.sleb128 -2
	.byte	0
	.byte	0xc
	.uleb128 0x1
	.uleb128 0x2
	.byte	0x80
	.uleb128 0x1
	.p2align 1,0
.LECIE0:
.LSFDE0:
	.4byte	.LEFDE0-.LASFDE0
.LASFDE0:
	.4byte	.Lframe0
	.2byte	.LFB0
	.2byte	.LFE0-.LFB0
	.byte	0x4
	.4byte	.LCFI0-.LFB0
	.byte	0xd
	.uleb128 0x4
	.byte	0x4
	.4byte	.LCFI1-.LCFI0
	.byte	0xe
	.uleb128 0
	.p2align 1,0
.LEFDE0:
	.text
.Letext0:
	.file 2 "/usr/lib/gcc/msp430/4.6.3/../../../../msp430/include/msp430g2553.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x60
	.2byte	0x2
	.4byte	.Ldebug_abbrev0
	.byte	0x2
	.uleb128 0x1
	.4byte	.LASF1
	.byte	0x1
	.4byte	.LASF2
	.4byte	.LASF3
	.2byte	0
	.2byte	0
	.4byte	.Ldebug_ranges0+0
	.4byte	.Ldebug_line0
	.4byte	.Ldebug_macinfo0
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.4byte	.LASF0
	.uleb128 0x3
	.byte	0x1
	.4byte	.LASF4
	.byte	0x1
	.byte	0x9
	.byte	0x1
	.4byte	0x45
	.2byte	.LFB0
	.2byte	.LFE0
	.4byte	.LLST0
	.uleb128 0x4
	.byte	0x2
	.byte	0x5
	.string	"int"
	.uleb128 0x5
	.4byte	.LASF5
	.byte	0x2
	.2byte	0x386
	.4byte	.LASF6
	.4byte	0x5e
	.byte	0x1
	.byte	0x1
	.uleb128 0x6
	.4byte	0x29
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x52
	.uleb128 0x1
	.uleb128 0x55
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x6
	.uleb128 0x43
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x2e
	.byte	0
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0xc
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x1
	.uleb128 0x40
	.uleb128 0x6
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x2007
	.uleb128 0xe
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0xc
	.uleb128 0x3c
	.uleb128 0xc
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x35
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
.Ldebug_loc0:
.LLST0:
	.2byte	.LFB0
	.2byte	.LCFI0
	.2byte	0x2
	.byte	0x71
	.sleb128 0
	.2byte	.LCFI0
	.2byte	.LCFI1
	.2byte	0x2
	.byte	0x74
	.sleb128 0
	.2byte	.LCFI1
	.2byte	.LFE0
	.2byte	0x2
	.byte	0x74
	.sleb128 -2
	.2byte	0
	.2byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x10
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x2
	.byte	0
	.2byte	.LFB0
	.2byte	.LFE0-.LFB0
	.2byte	0
	.2byte	0
	.section	.debug_ranges,"",@progbits
.Ldebug_ranges0:
	.2byte	.LFB0
	.2byte	.LFE0
	.2byte	0
	.2byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_macinfo,"",@progbits
.Ldebug_macinfo0:
	.byte	0x1
	.uleb128 0
	.string	"__STDC__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__STDC_HOSTED__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__GNUC__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__GNUC_MINOR__ 6"
	.byte	0x1
	.uleb128 0
	.string	"__GNUC_PATCHLEVEL__ 3"
	.byte	0x1
	.uleb128 0
	.string	"__VERSION__ \"4.6.3 20120301 (mspgcc LTS 20120406 unpatched)\""
	.byte	0x1
	.uleb128 0
	.string	"__FINITE_MATH_ONLY__ 0"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_INT__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_LONG__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_LONG_LONG__ 8"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_SHORT__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_FLOAT__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_DOUBLE__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_LONG_DOUBLE__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_SIZE_T__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__CHAR_BIT__ 8"
	.byte	0x1
	.uleb128 0
	.string	"__BIGGEST_ALIGNMENT__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__ORDER_LITTLE_ENDIAN__ 1234"
	.byte	0x1
	.uleb128 0
	.string	"__ORDER_BIG_ENDIAN__ 4321"
	.byte	0x1
	.uleb128 0
	.string	"__ORDER_PDP_ENDIAN__ 3412"
	.byte	0x1
	.uleb128 0
	.string	"__BYTE_ORDER__ __ORDER_LITTLE_ENDIAN__"
	.byte	0x1
	.uleb128 0
	.string	"__FLOAT_WORD_ORDER__ __ORDER_LITTLE_ENDIAN__"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_POINTER__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__SIZE_TYPE__ unsigned int"
	.byte	0x1
	.uleb128 0
	.string	"__PTRDIFF_TYPE__ long int"
	.byte	0x1
	.uleb128 0
	.string	"__WCHAR_TYPE__ int"
	.byte	0x1
	.uleb128 0
	.string	"__WINT_TYPE__ unsigned int"
	.byte	0x1
	.uleb128 0
	.string	"__INTMAX_TYPE__ long long int"
	.byte	0x1
	.uleb128 0
	.string	"__UINTMAX_TYPE__ long long unsigned int"
	.byte	0x1
	.uleb128 0
	.string	"__CHAR16_TYPE__ short unsigned int"
	.byte	0x1
	.uleb128 0
	.string	"__CHAR32_TYPE__ unsigned int"
	.byte	0x1
	.uleb128 0
	.string	"__GXX_ABI_VERSION 1002"
	.byte	0x1
	.uleb128 0
	.string	"__USING_SJLJ_EXCEPTIONS__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__SCHAR_MAX__ 127"
	.byte	0x1
	.uleb128 0
	.string	"__SHRT_MAX__ 32767"
	.byte	0x1
	.uleb128 0
	.string	"__INT_MAX__ 32767"
	.byte	0x1
	.uleb128 0
	.string	"__LONG_MAX__ 2147483647L"
	.byte	0x1
	.uleb128 0
	.string	"__LONG_LONG_MAX__ 9223372036854775807LL"
	.byte	0x1
	.uleb128 0
	.string	"__WCHAR_MAX__ 32767"
	.byte	0x1
	.uleb128 0
	.string	"__WCHAR_MIN__ (-__WCHAR_MAX__ - 1)"
	.byte	0x1
	.uleb128 0
	.string	"__WINT_MAX__ 65535U"
	.byte	0x1
	.uleb128 0
	.string	"__WINT_MIN__ 0U"
	.byte	0x1
	.uleb128 0
	.string	"__PTRDIFF_MAX__ 2147483647L"
	.byte	0x1
	.uleb128 0
	.string	"__SIZE_MAX__ 65535U"
	.byte	0x1
	.uleb128 0
	.string	"__INTMAX_MAX__ 9223372036854775807LL"
	.byte	0x1
	.uleb128 0
	.string	"__INTMAX_C(c) c ## LL"
	.byte	0x1
	.uleb128 0
	.string	"__UINTMAX_MAX__ 18446744073709551615ULL"
	.byte	0x1
	.uleb128 0
	.string	"__UINTMAX_C(c) c ## ULL"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_EVAL_METHOD__ 0"
	.byte	0x1
	.uleb128 0
	.string	"__DEC_EVAL_METHOD__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_RADIX__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MANT_DIG__ 24"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_DIG__ 6"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MIN_EXP__ (-125)"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MIN_10_EXP__ (-37)"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MAX_EXP__ 128"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MAX_10_EXP__ 38"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_DECIMAL_DIG__ 9"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MAX__ 3.40282347e+38F"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_MIN__ 1.17549435e-38F"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_EPSILON__ 1.19209290e-7F"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_DENORM_MIN__ 1.40129846e-45F"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_HAS_DENORM__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_HAS_INFINITY__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__FLT_HAS_QUIET_NAN__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MANT_DIG__ 24"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_DIG__ 6"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MIN_EXP__ (-125)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MIN_10_EXP__ (-37)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MAX_EXP__ 128"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MAX_10_EXP__ 38"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_DECIMAL_DIG__ 9"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MAX__ ((double)3.40282347e+38L)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_MIN__ ((double)1.17549435e-38L)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_EPSILON__ ((double)1.19209290e-7L)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_DENORM_MIN__ ((double)1.40129846e-45L)"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_HAS_DENORM__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_HAS_INFINITY__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__DBL_HAS_QUIET_NAN__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MANT_DIG__ 24"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_DIG__ 6"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MIN_EXP__ (-125)"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MIN_10_EXP__ (-37)"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MAX_EXP__ 128"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MAX_10_EXP__ 38"
	.byte	0x1
	.uleb128 0
	.string	"__DECIMAL_DIG__ 9"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MAX__ 3.40282347e+38L"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_MIN__ 1.17549435e-38L"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_EPSILON__ 1.19209290e-7L"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_DENORM_MIN__ 1.40129846e-45L"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_HAS_DENORM__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_HAS_INFINITY__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__LDBL_HAS_QUIET_NAN__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_MANT_DIG__ 7"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_MIN_EXP__ (-94)"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_MAX_EXP__ 97"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_MIN__ 1E-95DF"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_MAX__ 9.999999E96DF"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_EPSILON__ 1E-6DF"
	.byte	0x1
	.uleb128 0
	.string	"__DEC32_SUBNORMAL_MIN__ 0.000001E-95DF"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_MANT_DIG__ 16"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_MIN_EXP__ (-382)"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_MAX_EXP__ 385"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_MIN__ 1E-383DD"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_MAX__ 9.999999999999999E384DD"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_EPSILON__ 1E-15DD"
	.byte	0x1
	.uleb128 0
	.string	"__DEC64_SUBNORMAL_MIN__ 0.000000000000001E-383DD"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_MANT_DIG__ 34"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_MIN_EXP__ (-6142)"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_MAX_EXP__ 6145"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_MIN__ 1E-6143DL"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_MAX__ 9.999999999999999999999999999999999E6144DL"
	.byte	0x1
	.uleb128 0
	.string	"__DEC128_EPSILON__ 1E-33DL"
	.byte	0x1
	.uleb128 0
	.ascii	"__DE"
	.string	"C128_SUBNORMAL_MIN__ 0.000000000000000000000000000000001E-6143DL"
	.byte	0x1
	.uleb128 0
	.string	"__REGISTER_PREFIX__ "
	.byte	0x1
	.uleb128 0
	.string	"__USER_LABEL_PREFIX__ "
	.byte	0x1
	.uleb128 0
	.string	"__GNUC_GNU_INLINE__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__NO_INLINE__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__PRAGMA_REDEFINE_EXTNAME 1"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_WCHAR_T__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_WINT_T__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__SIZEOF_PTRDIFF_T__ 4"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430 1"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430__ 1"
	.byte	0x1
	.uleb128 0
	.string	"MSP430 1"
	.byte	0x1
	.uleb128 0
	.string	"MSP430_NO_HWMUL 1"
	.byte	0x1
	.uleb128 0
	.string	"__MSPGCC__ 20120406"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_CPU_MSP430__ 0"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_CPU_MSP430X__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_CPU_MSP430XV2__ 3"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_NONE__ 0"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_TYPE_16__ 16"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_TYPE_32__ 32"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_TYPE_ANY__ 48"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_HAS_SE__ 1"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_HAS_DW__ 2"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_16__ 16"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_16SE__ 17"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_32__ 49"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_MPY_32DW__ 51"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_CPU__ 0"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430_IVCNT__ 16"
	.byte	0x1
	.uleb128 0
	.string	"__interrupt __attribute__((__interrupt__))"
	.byte	0x1
	.uleb128 0
	.string	"__MSP430G2553__ 1"
	.byte	0x3
	.uleb128 0
	.uleb128 0x1
	.file 3 "/usr/lib/gcc/msp430/4.6.3/../../../../msp430/include/msp430.h"
	.byte	0x3
	.uleb128 0x7
	.uleb128 0x3
	.byte	0x1
	.uleb128 0xd
	.string	"__msp430_h_ "
	.byte	0x1
	.uleb128 0x10
	.string	"__MSP430MCU_UPSTREAM__ 20120330"
	.byte	0x1
	.uleb128 0x12
	.string	"__MSP430MCU__ 20120406"
	.byte	0x1
	.uleb128 0x16
	.string	"MSP430_CPU_MSP430 0x0000"
	.byte	0x1
	.uleb128 0x17
	.string	"MSP430_CPU_MSP430X 0x0002"
	.byte	0x1
	.uleb128 0x18
	.string	"MSP430_CPU_MSP430XV2 0x0003"
	.byte	0x1
	.uleb128 0x1c
	.string	"MSP430_MPY_NONE 0x0000"
	.byte	0x1
	.uleb128 0x1d
	.string	"MSP430_MPY_TYPE_16 0x0010"
	.byte	0x1
	.uleb128 0x1e
	.string	"MSP430_MPY_TYPE_32 0x0020"
	.byte	0x1
	.uleb128 0x1f
	.string	"MSP430_MPY_TYPE_ANY 0x0030"
	.byte	0x1
	.uleb128 0x20
	.string	"MSP430_MPY_HAS_SE 0x0001"
	.byte	0x1
	.uleb128 0x21
	.string	"MSP430_MPY_HAS_DW 0x0002"
	.byte	0x1
	.uleb128 0x22
	.string	"MSP430_MPY_16 MSP430_MPY_TYPE_16"
	.byte	0x1
	.uleb128 0x23
	.string	"MSP430_MPY_16SE (MSP430_MPY_16 | MSP430_MPY_HAS_SE)"
	.byte	0x1
	.uleb128 0x24
	.ascii	"MSP430_MPY_"
	.string	"32 (MSP430_MPY_TYPE_16 | MSP430_MPY_TYPE_32 | MSP430_MPY_HAS_SE)"
	.byte	0x1
	.uleb128 0x25
	.string	"MSP430_MPY_32DW (MSP430_MPY_32 | MSP430_MPY_HAS_DW)"
	.byte	0x3
	.uleb128 0x14a
	.uleb128 0x2
	.byte	0x1
	.uleb128 0x30
	.string	"__MSP430G2553 "
	.byte	0x1
	.uleb128 0x32
	.string	"__MSP430_HEADER_VERSION__ 1064"
	.byte	0x1
	.uleb128 0x34
	.string	"__MSP430_TI_HEADERS__ "
	.file 4 "/usr/lib/gcc/msp430/4.6.3/../../../../msp430/include/iomacros.h"
	.byte	0x3
	.uleb128 0x3a
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x25
	.string	"__MSP430_IOMACROS_H_ "
	.byte	0x1
	.uleb128 0x33
	.string	"sfrb_(x,x_) volatile unsigned char x __asm__(\"__\" #x)"
	.byte	0x1
	.uleb128 0x34
	.string	"sfrb(x,x_) extern sfrb_(x,x_)"
	.byte	0x1
	.uleb128 0x36
	.string	"sfrw_(x,x_) volatile unsigned int x __asm__(\"__\" #x)"
	.byte	0x1
	.uleb128 0x37
	.string	"sfrw(x,x_) extern sfrw_(x,x_)"
	.byte	0x1
	.uleb128 0x39
	.string	"sfra_(x,x_) volatile unsigned long int x __asm__(\"__\" #x)"
	.byte	0x1
	.uleb128 0x3a
	.string	"sfra(x,x_) extern sfra_(x,x_)"
	.byte	0x1
	.uleb128 0x3c
	.string	"const_sfrb(x,x_) extern const sfrb_(x,x_)"
	.byte	0x1
	.uleb128 0x3d
	.string	"const_sfrw(x,x_) extern const sfrw_(x,x_)"
	.byte	0x1
	.uleb128 0x3e
	.string	"const_sfra(x,x_) extern const sfra_(x,x_)"
	.byte	0x1
	.uleb128 0x41
	.string	"__interrupt __attribute__((__interrupt__))"
	.byte	0x4
	.byte	0x1
	.uleb128 0x40
	.string	"BIT0 (0x0001)"
	.byte	0x1
	.uleb128 0x41
	.string	"BIT1 (0x0002)"
	.byte	0x1
	.uleb128 0x42
	.string	"BIT2 (0x0004)"
	.byte	0x1
	.uleb128 0x43
	.string	"BIT3 (0x0008)"
	.byte	0x1
	.uleb128 0x44
	.string	"BIT4 (0x0010)"
	.byte	0x1
	.uleb128 0x45
	.string	"BIT5 (0x0020)"
	.byte	0x1
	.uleb128 0x46
	.string	"BIT6 (0x0040)"
	.byte	0x1
	.uleb128 0x47
	.string	"BIT7 (0x0080)"
	.byte	0x1
	.uleb128 0x48
	.string	"BIT8 (0x0100)"
	.byte	0x1
	.uleb128 0x49
	.string	"BIT9 (0x0200)"
	.byte	0x1
	.uleb128 0x4a
	.string	"BITA (0x0400)"
	.byte	0x1
	.uleb128 0x4b
	.string	"BITB (0x0800)"
	.byte	0x1
	.uleb128 0x4c
	.string	"BITC (0x1000)"
	.byte	0x1
	.uleb128 0x4d
	.string	"BITD (0x2000)"
	.byte	0x1
	.uleb128 0x4e
	.string	"BITE (0x4000)"
	.byte	0x1
	.uleb128 0x4f
	.string	"BITF (0x8000)"
	.byte	0x1
	.uleb128 0x55
	.string	"C (0x0001)"
	.byte	0x1
	.uleb128 0x56
	.string	"Z (0x0002)"
	.byte	0x1
	.uleb128 0x57
	.string	"N (0x0004)"
	.byte	0x1
	.uleb128 0x58
	.string	"V (0x0100)"
	.byte	0x1
	.uleb128 0x59
	.string	"GIE (0x0008)"
	.byte	0x1
	.uleb128 0x5a
	.string	"CPUOFF (0x0010)"
	.byte	0x1
	.uleb128 0x5b
	.string	"OSCOFF (0x0020)"
	.byte	0x1
	.uleb128 0x5c
	.string	"SCG0 (0x0040)"
	.byte	0x1
	.uleb128 0x5d
	.string	"SCG1 (0x0080)"
	.byte	0x1
	.uleb128 0x6a
	.string	"LPM0_bits (CPUOFF)"
	.byte	0x1
	.uleb128 0x6b
	.string	"LPM1_bits (SCG0+CPUOFF)"
	.byte	0x1
	.uleb128 0x6c
	.string	"LPM2_bits (SCG1+CPUOFF)"
	.byte	0x1
	.uleb128 0x6d
	.string	"LPM3_bits (SCG1+SCG0+CPUOFF)"
	.byte	0x1
	.uleb128 0x6e
	.string	"LPM4_bits (SCG1+SCG0+OSCOFF+CPUOFF)"
	.file 5 "/usr/lib/gcc/msp430/4.6.3/../../../../msp430/include/in430.h"
	.byte	0x3
	.uleb128 0x70
	.uleb128 0x5
	.byte	0x1
	.uleb128 0x3
	.string	"__MSP430_IN430_H_ "
	.file 6 "/usr/lib/gcc/msp430/4.6.3/../../../../msp430/include/intrinsics.h"
	.byte	0x3
	.uleb128 0x4
	.uleb128 0x6
	.byte	0x1
	.uleb128 0x26
	.string	"__MSP430_INTRINSICS_H_ "
	.byte	0x1
	.uleb128 0x85
	.string	"nop() __nop()"
	.byte	0x1
	.uleb128 0x86
	.string	"_NOP() __nop()"
	.byte	0x1
	.uleb128 0x87
	.string	"READ_SP __read_stack_pointer();"
	.byte	0x1
	.uleb128 0x88
	.string	"WRITE_SP(_x) __write_stack_pointer(_x)"
	.byte	0x1
	.uleb128 0x89
	.string	"READ_SR __read_status_register()"
	.byte	0x1
	.uleb128 0x8a
	.string	"WRITE_SR(_x) __write_status_register(_x)"
	.byte	0x1
	.uleb128 0x8b
	.string	"_BIS_SR(_b) __bis_status_register(_b)"
	.byte	0x1
	.uleb128 0x8c
	.string	"_BIC_SR(_b) __bic_status_register(_b)"
	.byte	0x1
	.uleb128 0x8d
	.string	"_BIS_SR_IRQ(_b) __bis_status_register_on_exit(_b)"
	.byte	0x1
	.uleb128 0x8e
	.string	"_BIC_SR_IRQ(_b) __bic_status_register_on_exit(_b)"
	.byte	0x1
	.uleb128 0x91
	.string	"__no_operation() __nop()"
	.byte	0x1
	.uleb128 0x92
	.string	"__bic_SR_register(_b) __bic_status_register(_b)"
	.byte	0x1
	.uleb128 0x93
	.string	"__bic_SR_register_on_exit(_b) __bic_status_register_on_exit(_b)"
	.byte	0x1
	.uleb128 0x94
	.string	"__bis_SR_register(_b) __bis_status_register(_b)"
	.byte	0x1
	.uleb128 0x95
	.string	"__bis_SR_register_on_exit(_b) __bis_status_register_on_exit(_b)"
	.byte	0x1
	.uleb128 0x96
	.string	"__enable_interrupt() __eint()"
	.byte	0x1
	.uleb128 0x97
	.string	"__disable_interrupt() __dint()"
	.byte	0x1
	.uleb128 0x9a
	.string	"_EINT() __eint()"
	.byte	0x1
	.uleb128 0x9b
	.string	"_DINT() __dint()"
	.byte	0x4
	.byte	0x4
	.byte	0x1
	.uleb128 0x72
	.string	"LPM0 _BIS_SR(LPM0_bits)"
	.byte	0x1
	.uleb128 0x73
	.string	"LPM0_EXIT _BIC_SR_IRQ(LPM0_bits)"
	.byte	0x1
	.uleb128 0x74
	.string	"LPM1 _BIS_SR(LPM1_bits)"
	.byte	0x1
	.uleb128 0x75
	.string	"LPM1_EXIT _BIC_SR_IRQ(LPM1_bits)"
	.byte	0x1
	.uleb128 0x76
	.string	"LPM2 _BIS_SR(LPM2_bits)"
	.byte	0x1
	.uleb128 0x77
	.string	"LPM2_EXIT _BIC_SR_IRQ(LPM2_bits)"
	.byte	0x1
	.uleb128 0x78
	.string	"LPM3 _BIS_SR(LPM3_bits)"
	.byte	0x1
	.uleb128 0x79
	.string	"LPM3_EXIT _BIC_SR_IRQ(LPM3_bits)"
	.byte	0x1
	.uleb128 0x7a
	.string	"LPM4 _BIS_SR(LPM4_bits)"
	.byte	0x1
	.uleb128 0x7b
	.string	"LPM4_EXIT _BIC_SR_IRQ(LPM4_bits)"
	.byte	0x1
	.uleb128 0x86
	.string	"IE1_ 0x0000"
	.byte	0x1
	.uleb128 0x88
	.string	"WDTIE (0x01)"
	.byte	0x1
	.uleb128 0x89
	.string	"OFIE (0x02)"
	.byte	0x1
	.uleb128 0x8a
	.string	"NMIIE (0x10)"
	.byte	0x1
	.uleb128 0x8b
	.string	"ACCVIE (0x20)"
	.byte	0x1
	.uleb128 0x8d
	.string	"IFG1_ 0x0002"
	.byte	0x1
	.uleb128 0x8f
	.string	"WDTIFG (0x01)"
	.byte	0x1
	.uleb128 0x90
	.string	"OFIFG (0x02)"
	.byte	0x1
	.uleb128 0x91
	.string	"PORIFG (0x04)"
	.byte	0x1
	.uleb128 0x92
	.string	"RSTIFG (0x08)"
	.byte	0x1
	.uleb128 0x93
	.string	"NMIIFG (0x10)"
	.byte	0x1
	.uleb128 0x95
	.string	"IE2_ 0x0001"
	.byte	0x1
	.uleb128 0x97
	.string	"UC0IE IE2"
	.byte	0x1
	.uleb128 0x98
	.string	"UCA0RXIE (0x01)"
	.byte	0x1
	.uleb128 0x99
	.string	"UCA0TXIE (0x02)"
	.byte	0x1
	.uleb128 0x9a
	.string	"UCB0RXIE (0x04)"
	.byte	0x1
	.uleb128 0x9b
	.string	"UCB0TXIE (0x08)"
	.byte	0x1
	.uleb128 0x9d
	.string	"IFG2_ 0x0003"
	.byte	0x1
	.uleb128 0x9f
	.string	"UC0IFG IFG2"
	.byte	0x1
	.uleb128 0xa0
	.string	"UCA0RXIFG (0x01)"
	.byte	0x1
	.uleb128 0xa1
	.string	"UCA0TXIFG (0x02)"
	.byte	0x1
	.uleb128 0xa2
	.string	"UCB0RXIFG (0x04)"
	.byte	0x1
	.uleb128 0xa3
	.string	"UCB0TXIFG (0x08)"
	.byte	0x1
	.uleb128 0xa9
	.string	"__MSP430_HAS_ADC10__ "
	.byte	0x1
	.uleb128 0xab
	.string	"ADC10DTC0_ 0x0048"
	.byte	0x1
	.uleb128 0xad
	.string	"ADC10DTC1_ 0x0049"
	.byte	0x1
	.uleb128 0xaf
	.string	"ADC10AE0_ 0x004A"
	.byte	0x1
	.uleb128 0xb2
	.string	"ADC10CTL0_ 0x01B0"
	.byte	0x1
	.uleb128 0xb4
	.string	"ADC10CTL1_ 0x01B2"
	.byte	0x1
	.uleb128 0xb6
	.string	"ADC10MEM_ 0x01B4"
	.byte	0x1
	.uleb128 0xb8
	.string	"ADC10SA_ 0x01BC"
	.byte	0x1
	.uleb128 0xbc
	.string	"ADC10SC (0x001)"
	.byte	0x1
	.uleb128 0xbd
	.string	"ENC (0x002)"
	.byte	0x1
	.uleb128 0xbe
	.string	"ADC10IFG (0x004)"
	.byte	0x1
	.uleb128 0xbf
	.string	"ADC10IE (0x008)"
	.byte	0x1
	.uleb128 0xc0
	.string	"ADC10ON (0x010)"
	.byte	0x1
	.uleb128 0xc1
	.string	"REFON (0x020)"
	.byte	0x1
	.uleb128 0xc2
	.string	"REF2_5V (0x040)"
	.byte	0x1
	.uleb128 0xc3
	.string	"MSC (0x080)"
	.byte	0x1
	.uleb128 0xc4
	.string	"REFBURST (0x100)"
	.byte	0x1
	.uleb128 0xc5
	.string	"REFOUT (0x200)"
	.byte	0x1
	.uleb128 0xc6
	.string	"ADC10SR (0x400)"
	.byte	0x1
	.uleb128 0xc7
	.string	"ADC10SHT0 (0x800)"
	.byte	0x1
	.uleb128 0xc8
	.string	"ADC10SHT1 (0x1000)"
	.byte	0x1
	.uleb128 0xc9
	.string	"SREF0 (0x2000)"
	.byte	0x1
	.uleb128 0xca
	.string	"SREF1 (0x4000)"
	.byte	0x1
	.uleb128 0xcb
	.string	"SREF2 (0x8000)"
	.byte	0x1
	.uleb128 0xcc
	.string	"ADC10SHT_0 (0x0000)"
	.byte	0x1
	.uleb128 0xcd
	.string	"ADC10SHT_1 (0x0800)"
	.byte	0x1
	.uleb128 0xce
	.string	"ADC10SHT_2 (0x1000)"
	.byte	0x1
	.uleb128 0xcf
	.string	"ADC10SHT_3 (0x1800)"
	.byte	0x1
	.uleb128 0xd1
	.string	"SREF_0 (0x0000)"
	.byte	0x1
	.uleb128 0xd2
	.string	"SREF_1 (0x2000)"
	.byte	0x1
	.uleb128 0xd3
	.string	"SREF_2 (0x4000)"
	.byte	0x1
	.uleb128 0xd4
	.string	"SREF_3 (0x6000)"
	.byte	0x1
	.uleb128 0xd5
	.string	"SREF_4 (0x8000)"
	.byte	0x1
	.uleb128 0xd6
	.string	"SREF_5 (0xA000)"
	.byte	0x1
	.uleb128 0xd7
	.string	"SREF_6 (0xC000)"
	.byte	0x1
	.uleb128 0xd8
	.string	"SREF_7 (0xE000)"
	.byte	0x1
	.uleb128 0xdb
	.string	"ADC10BUSY (0x0001)"
	.byte	0x1
	.uleb128 0xdc
	.string	"CONSEQ0 (0x0002)"
	.byte	0x1
	.uleb128 0xdd
	.string	"CONSEQ1 (0x0004)"
	.byte	0x1
	.uleb128 0xde
	.string	"ADC10SSEL0 (0x0008)"
	.byte	0x1
	.uleb128 0xdf
	.string	"ADC10SSEL1 (0x0010)"
	.byte	0x1
	.uleb128 0xe0
	.string	"ADC10DIV0 (0x0020)"
	.byte	0x1
	.uleb128 0xe1
	.string	"ADC10DIV1 (0x0040)"
	.byte	0x1
	.uleb128 0xe2
	.string	"ADC10DIV2 (0x0080)"
	.byte	0x1
	.uleb128 0xe3
	.string	"ISSH (0x0100)"
	.byte	0x1
	.uleb128 0xe4
	.string	"ADC10DF (0x0200)"
	.byte	0x1
	.uleb128 0xe5
	.string	"SHS0 (0x0400)"
	.byte	0x1
	.uleb128 0xe6
	.string	"SHS1 (0x0800)"
	.byte	0x1
	.uleb128 0xe7
	.string	"INCH0 (0x1000)"
	.byte	0x1
	.uleb128 0xe8
	.string	"INCH1 (0x2000)"
	.byte	0x1
	.uleb128 0xe9
	.string	"INCH2 (0x4000)"
	.byte	0x1
	.uleb128 0xea
	.string	"INCH3 (0x8000)"
	.byte	0x1
	.uleb128 0xec
	.string	"CONSEQ_0 (0x0000)"
	.byte	0x1
	.uleb128 0xed
	.string	"CONSEQ_1 (0x0002)"
	.byte	0x1
	.uleb128 0xee
	.string	"CONSEQ_2 (0x0004)"
	.byte	0x1
	.uleb128 0xef
	.string	"CONSEQ_3 (0x0006)"
	.byte	0x1
	.uleb128 0xf1
	.string	"ADC10SSEL_0 (0x0000)"
	.byte	0x1
	.uleb128 0xf2
	.string	"ADC10SSEL_1 (0x0008)"
	.byte	0x1
	.uleb128 0xf3
	.string	"ADC10SSEL_2 (0x0010)"
	.byte	0x1
	.uleb128 0xf4
	.string	"ADC10SSEL_3 (0x0018)"
	.byte	0x1
	.uleb128 0xf6
	.string	"ADC10DIV_0 (0x0000)"
	.byte	0x1
	.uleb128 0xf7
	.string	"ADC10DIV_1 (0x0020)"
	.byte	0x1
	.uleb128 0xf8
	.string	"ADC10DIV_2 (0x0040)"
	.byte	0x1
	.uleb128 0xf9
	.string	"ADC10DIV_3 (0x0060)"
	.byte	0x1
	.uleb128 0xfa
	.string	"ADC10DIV_4 (0x0080)"
	.byte	0x1
	.uleb128 0xfb
	.string	"ADC10DIV_5 (0x00A0)"
	.byte	0x1
	.uleb128 0xfc
	.string	"ADC10DIV_6 (0x00C0)"
	.byte	0x1
	.uleb128 0xfd
	.string	"ADC10DIV_7 (0x00E0)"
	.byte	0x1
	.uleb128 0xff
	.string	"SHS_0 (0x0000)"
	.byte	0x1
	.uleb128 0x100
	.string	"SHS_1 (0x0400)"
	.byte	0x1
	.uleb128 0x101
	.string	"SHS_2 (0x0800)"
	.byte	0x1
	.uleb128 0x102
	.string	"SHS_3 (0x0C00)"
	.byte	0x1
	.uleb128 0x104
	.string	"INCH_0 (0x0000)"
	.byte	0x1
	.uleb128 0x105
	.string	"INCH_1 (0x1000)"
	.byte	0x1
	.uleb128 0x106
	.string	"INCH_2 (0x2000)"
	.byte	0x1
	.uleb128 0x107
	.string	"INCH_3 (0x3000)"
	.byte	0x1
	.uleb128 0x108
	.string	"INCH_4 (0x4000)"
	.byte	0x1
	.uleb128 0x109
	.string	"INCH_5 (0x5000)"
	.byte	0x1
	.uleb128 0x10a
	.string	"INCH_6 (0x6000)"
	.byte	0x1
	.uleb128 0x10b
	.string	"INCH_7 (0x7000)"
	.byte	0x1
	.uleb128 0x10c
	.string	"INCH_8 (0x8000)"
	.byte	0x1
	.uleb128 0x10d
	.string	"INCH_9 (0x9000)"
	.byte	0x1
	.uleb128 0x10e
	.string	"INCH_10 (0xA000)"
	.byte	0x1
	.uleb128 0x10f
	.string	"INCH_11 (0xB000)"
	.byte	0x1
	.uleb128 0x110
	.string	"INCH_12 (0xC000)"
	.byte	0x1
	.uleb128 0x111
	.string	"INCH_13 (0xD000)"
	.byte	0x1
	.uleb128 0x112
	.string	"INCH_14 (0xE000)"
	.byte	0x1
	.uleb128 0x113
	.string	"INCH_15 (0xF000)"
	.byte	0x1
	.uleb128 0x116
	.string	"ADC10FETCH (0x001)"
	.byte	0x1
	.uleb128 0x117
	.string	"ADC10B1 (0x002)"
	.byte	0x1
	.uleb128 0x118
	.string	"ADC10CT (0x004)"
	.byte	0x1
	.uleb128 0x119
	.string	"ADC10TB (0x008)"
	.byte	0x1
	.uleb128 0x11a
	.string	"ADC10DISABLE (0x000)"
	.byte	0x1
	.uleb128 0x11f
	.string	"__MSP430_HAS_BC2__ "
	.byte	0x1
	.uleb128 0x121
	.string	"DCOCTL_ 0x0056"
	.byte	0x1
	.uleb128 0x123
	.string	"BCSCTL1_ 0x0057"
	.byte	0x1
	.uleb128 0x125
	.string	"BCSCTL2_ 0x0058"
	.byte	0x1
	.uleb128 0x127
	.string	"BCSCTL3_ 0x0053"
	.byte	0x1
	.uleb128 0x12a
	.string	"MOD0 (0x01)"
	.byte	0x1
	.uleb128 0x12b
	.string	"MOD1 (0x02)"
	.byte	0x1
	.uleb128 0x12c
	.string	"MOD2 (0x04)"
	.byte	0x1
	.uleb128 0x12d
	.string	"MOD3 (0x08)"
	.byte	0x1
	.uleb128 0x12e
	.string	"MOD4 (0x10)"
	.byte	0x1
	.uleb128 0x12f
	.string	"DCO0 (0x20)"
	.byte	0x1
	.uleb128 0x130
	.string	"DCO1 (0x40)"
	.byte	0x1
	.uleb128 0x131
	.string	"DCO2 (0x80)"
	.byte	0x1
	.uleb128 0x133
	.string	"RSEL0 (0x01)"
	.byte	0x1
	.uleb128 0x134
	.string	"RSEL1 (0x02)"
	.byte	0x1
	.uleb128 0x135
	.string	"RSEL2 (0x04)"
	.byte	0x1
	.uleb128 0x136
	.string	"RSEL3 (0x08)"
	.byte	0x1
	.uleb128 0x137
	.string	"DIVA0 (0x10)"
	.byte	0x1
	.uleb128 0x138
	.string	"DIVA1 (0x20)"
	.byte	0x1
	.uleb128 0x139
	.string	"XTS (0x40)"
	.byte	0x1
	.uleb128 0x13a
	.string	"XT2OFF (0x80)"
	.byte	0x1
	.uleb128 0x13c
	.string	"DIVA_0 (0x00)"
	.byte	0x1
	.uleb128 0x13d
	.string	"DIVA_1 (0x10)"
	.byte	0x1
	.uleb128 0x13e
	.string	"DIVA_2 (0x20)"
	.byte	0x1
	.uleb128 0x13f
	.string	"DIVA_3 (0x30)"
	.byte	0x1
	.uleb128 0x141
	.string	"DIVS0 (0x02)"
	.byte	0x1
	.uleb128 0x142
	.string	"DIVS1 (0x04)"
	.byte	0x1
	.uleb128 0x143
	.string	"SELS (0x08)"
	.byte	0x1
	.uleb128 0x144
	.string	"DIVM0 (0x10)"
	.byte	0x1
	.uleb128 0x145
	.string	"DIVM1 (0x20)"
	.byte	0x1
	.uleb128 0x146
	.string	"SELM0 (0x40)"
	.byte	0x1
	.uleb128 0x147
	.string	"SELM1 (0x80)"
	.byte	0x1
	.uleb128 0x149
	.string	"DIVS_0 (0x00)"
	.byte	0x1
	.uleb128 0x14a
	.string	"DIVS_1 (0x02)"
	.byte	0x1
	.uleb128 0x14b
	.string	"DIVS_2 (0x04)"
	.byte	0x1
	.uleb128 0x14c
	.string	"DIVS_3 (0x06)"
	.byte	0x1
	.uleb128 0x14e
	.string	"DIVM_0 (0x00)"
	.byte	0x1
	.uleb128 0x14f
	.string	"DIVM_1 (0x10)"
	.byte	0x1
	.uleb128 0x150
	.string	"DIVM_2 (0x20)"
	.byte	0x1
	.uleb128 0x151
	.string	"DIVM_3 (0x30)"
	.byte	0x1
	.uleb128 0x153
	.string	"SELM_0 (0x00)"
	.byte	0x1
	.uleb128 0x154
	.string	"SELM_1 (0x40)"
	.byte	0x1
	.uleb128 0x155
	.string	"SELM_2 (0x80)"
	.byte	0x1
	.uleb128 0x156
	.string	"SELM_3 (0xC0)"
	.byte	0x1
	.uleb128 0x158
	.string	"LFXT1OF (0x01)"
	.byte	0x1
	.uleb128 0x159
	.string	"XT2OF (0x02)"
	.byte	0x1
	.uleb128 0x15a
	.string	"XCAP0 (0x04)"
	.byte	0x1
	.uleb128 0x15b
	.string	"XCAP1 (0x08)"
	.byte	0x1
	.uleb128 0x15c
	.string	"LFXT1S0 (0x10)"
	.byte	0x1
	.uleb128 0x15d
	.string	"LFXT1S1 (0x20)"
	.byte	0x1
	.uleb128 0x15e
	.string	"XT2S0 (0x40)"
	.byte	0x1
	.uleb128 0x15f
	.string	"XT2S1 (0x80)"
	.byte	0x1
	.uleb128 0x161
	.string	"XCAP_0 (0x00)"
	.byte	0x1
	.uleb128 0x162
	.string	"XCAP_1 (0x04)"
	.byte	0x1
	.uleb128 0x163
	.string	"XCAP_2 (0x08)"
	.byte	0x1
	.uleb128 0x164
	.string	"XCAP_3 (0x0C)"
	.byte	0x1
	.uleb128 0x166
	.string	"LFXT1S_0 (0x00)"
	.byte	0x1
	.uleb128 0x167
	.string	"LFXT1S_1 (0x10)"
	.byte	0x1
	.uleb128 0x168
	.string	"LFXT1S_2 (0x20)"
	.byte	0x1
	.uleb128 0x169
	.string	"LFXT1S_3 (0x30)"
	.byte	0x1
	.uleb128 0x16b
	.string	"XT2S_0 (0x00)"
	.byte	0x1
	.uleb128 0x16c
	.string	"XT2S_1 (0x40)"
	.byte	0x1
	.uleb128 0x16d
	.string	"XT2S_2 (0x80)"
	.byte	0x1
	.uleb128 0x16e
	.string	"XT2S_3 (0xC0)"
	.byte	0x1
	.uleb128 0x173
	.string	"__MSP430_HAS_CAPLUS__ "
	.byte	0x1
	.uleb128 0x175
	.string	"CACTL1_ 0x0059"
	.byte	0x1
	.uleb128 0x177
	.string	"CACTL2_ 0x005A"
	.byte	0x1
	.uleb128 0x179
	.string	"CAPD_ 0x005B"
	.byte	0x1
	.uleb128 0x17c
	.string	"CAIFG (0x01)"
	.byte	0x1
	.uleb128 0x17d
	.string	"CAIE (0x02)"
	.byte	0x1
	.uleb128 0x17e
	.string	"CAIES (0x04)"
	.byte	0x1
	.uleb128 0x17f
	.string	"CAON (0x08)"
	.byte	0x1
	.uleb128 0x180
	.string	"CAREF0 (0x10)"
	.byte	0x1
	.uleb128 0x181
	.string	"CAREF1 (0x20)"
	.byte	0x1
	.uleb128 0x182
	.string	"CARSEL (0x40)"
	.byte	0x1
	.uleb128 0x183
	.string	"CAEX (0x80)"
	.byte	0x1
	.uleb128 0x185
	.string	"CAREF_0 (0x00)"
	.byte	0x1
	.uleb128 0x186
	.string	"CAREF_1 (0x10)"
	.byte	0x1
	.uleb128 0x187
	.string	"CAREF_2 (0x20)"
	.byte	0x1
	.uleb128 0x188
	.string	"CAREF_3 (0x30)"
	.byte	0x1
	.uleb128 0x18a
	.string	"CAOUT (0x01)"
	.byte	0x1
	.uleb128 0x18b
	.string	"CAF (0x02)"
	.byte	0x1
	.uleb128 0x18c
	.string	"P2CA0 (0x04)"
	.byte	0x1
	.uleb128 0x18d
	.string	"P2CA1 (0x08)"
	.byte	0x1
	.uleb128 0x18e
	.string	"P2CA2 (0x10)"
	.byte	0x1
	.uleb128 0x18f
	.string	"P2CA3 (0x20)"
	.byte	0x1
	.uleb128 0x190
	.string	"P2CA4 (0x40)"
	.byte	0x1
	.uleb128 0x191
	.string	"CASHORT (0x80)"
	.byte	0x1
	.uleb128 0x193
	.string	"CAPD0 (0x01)"
	.byte	0x1
	.uleb128 0x194
	.string	"CAPD1 (0x02)"
	.byte	0x1
	.uleb128 0x195
	.string	"CAPD2 (0x04)"
	.byte	0x1
	.uleb128 0x196
	.string	"CAPD3 (0x08)"
	.byte	0x1
	.uleb128 0x197
	.string	"CAPD4 (0x10)"
	.byte	0x1
	.uleb128 0x198
	.string	"CAPD5 (0x20)"
	.byte	0x1
	.uleb128 0x199
	.string	"CAPD6 (0x40)"
	.byte	0x1
	.uleb128 0x19a
	.string	"CAPD7 (0x80)"
	.byte	0x1
	.uleb128 0x19f
	.string	"__MSP430_HAS_FLASH2__ "
	.byte	0x1
	.uleb128 0x1a1
	.string	"FCTL1_ 0x0128"
	.byte	0x1
	.uleb128 0x1a3
	.string	"FCTL2_ 0x012A"
	.byte	0x1
	.uleb128 0x1a5
	.string	"FCTL3_ 0x012C"
	.byte	0x1
	.uleb128 0x1a8
	.string	"FRKEY (0x9600)"
	.byte	0x1
	.uleb128 0x1a9
	.string	"FWKEY (0xA500)"
	.byte	0x1
	.uleb128 0x1aa
	.string	"FXKEY (0x3300)"
	.byte	0x1
	.uleb128 0x1ac
	.string	"ERASE (0x0002)"
	.byte	0x1
	.uleb128 0x1ad
	.string	"MERAS (0x0004)"
	.byte	0x1
	.uleb128 0x1ae
	.string	"WRT (0x0040)"
	.byte	0x1
	.uleb128 0x1af
	.string	"BLKWRT (0x0080)"
	.byte	0x1
	.uleb128 0x1b0
	.string	"SEGWRT (0x0080)"
	.byte	0x1
	.uleb128 0x1b2
	.string	"FN0 (0x0001)"
	.byte	0x1
	.uleb128 0x1b3
	.string	"FN1 (0x0002)"
	.byte	0x1
	.uleb128 0x1b5
	.string	"FN2 (0x0004)"
	.byte	0x1
	.uleb128 0x1b8
	.string	"FN3 (0x0008)"
	.byte	0x1
	.uleb128 0x1bb
	.string	"FN4 (0x0010)"
	.byte	0x1
	.uleb128 0x1bd
	.string	"FN5 (0x0020)"
	.byte	0x1
	.uleb128 0x1be
	.string	"FSSEL0 (0x0040)"
	.byte	0x1
	.uleb128 0x1bf
	.string	"FSSEL1 (0x0080)"
	.byte	0x1
	.uleb128 0x1c1
	.string	"FSSEL_0 (0x0000)"
	.byte	0x1
	.uleb128 0x1c2
	.string	"FSSEL_1 (0x0040)"
	.byte	0x1
	.uleb128 0x1c3
	.string	"FSSEL_2 (0x0080)"
	.byte	0x1
	.uleb128 0x1c4
	.string	"FSSEL_3 (0x00C0)"
	.byte	0x1
	.uleb128 0x1c6
	.string	"BUSY (0x0001)"
	.byte	0x1
	.uleb128 0x1c7
	.string	"KEYV (0x0002)"
	.byte	0x1
	.uleb128 0x1c8
	.string	"ACCVIFG (0x0004)"
	.byte	0x1
	.uleb128 0x1c9
	.string	"WAIT (0x0008)"
	.byte	0x1
	.uleb128 0x1ca
	.string	"LOCK (0x0010)"
	.byte	0x1
	.uleb128 0x1cb
	.string	"EMEX (0x0020)"
	.byte	0x1
	.uleb128 0x1cc
	.string	"LOCKA (0x0040)"
	.byte	0x1
	.uleb128 0x1cd
	.string	"FAIL (0x0080)"
	.byte	0x1
	.uleb128 0x1d2
	.string	"__MSP430_HAS_PORT1_R__ "
	.byte	0x1
	.uleb128 0x1d3
	.string	"__MSP430_HAS_PORT2_R__ "
	.byte	0x1
	.uleb128 0x1d5
	.string	"P1IN_ 0x0020"
	.byte	0x1
	.uleb128 0x1d7
	.string	"P1OUT_ 0x0021"
	.byte	0x1
	.uleb128 0x1d9
	.string	"P1DIR_ 0x0022"
	.byte	0x1
	.uleb128 0x1db
	.string	"P1IFG_ 0x0023"
	.byte	0x1
	.uleb128 0x1dd
	.string	"P1IES_ 0x0024"
	.byte	0x1
	.uleb128 0x1df
	.string	"P1IE_ 0x0025"
	.byte	0x1
	.uleb128 0x1e1
	.string	"P1SEL_ 0x0026"
	.byte	0x1
	.uleb128 0x1e3
	.string	"P1SEL2_ 0x0041"
	.byte	0x1
	.uleb128 0x1e5
	.string	"P1REN_ 0x0027"
	.byte	0x1
	.uleb128 0x1e8
	.string	"P2IN_ 0x0028"
	.byte	0x1
	.uleb128 0x1ea
	.string	"P2OUT_ 0x0029"
	.byte	0x1
	.uleb128 0x1ec
	.string	"P2DIR_ 0x002A"
	.byte	0x1
	.uleb128 0x1ee
	.string	"P2IFG_ 0x002B"
	.byte	0x1
	.uleb128 0x1f0
	.string	"P2IES_ 0x002C"
	.byte	0x1
	.uleb128 0x1f2
	.string	"P2IE_ 0x002D"
	.byte	0x1
	.uleb128 0x1f4
	.string	"P2SEL_ 0x002E"
	.byte	0x1
	.uleb128 0x1f6
	.string	"P2SEL2_ 0x0042"
	.byte	0x1
	.uleb128 0x1f8
	.string	"P2REN_ 0x002F"
	.byte	0x1
	.uleb128 0x1fe
	.string	"__MSP430_HAS_PORT3_R__ "
	.byte	0x1
	.uleb128 0x200
	.string	"P3IN_ 0x0018"
	.byte	0x1
	.uleb128 0x202
	.string	"P3OUT_ 0x0019"
	.byte	0x1
	.uleb128 0x204
	.string	"P3DIR_ 0x001A"
	.byte	0x1
	.uleb128 0x206
	.string	"P3SEL_ 0x001B"
	.byte	0x1
	.uleb128 0x208
	.string	"P3SEL2_ 0x0043"
	.byte	0x1
	.uleb128 0x20a
	.string	"P3REN_ 0x0010"
	.byte	0x1
	.uleb128 0x210
	.string	"__MSP430_HAS_TA3__ "
	.byte	0x1
	.uleb128 0x212
	.string	"TA0IV_ 0x012E"
	.byte	0x1
	.uleb128 0x214
	.string	"TA0CTL_ 0x0160"
	.byte	0x1
	.uleb128 0x216
	.string	"TA0CCTL0_ 0x0162"
	.byte	0x1
	.uleb128 0x218
	.string	"TA0CCTL1_ 0x0164"
	.byte	0x1
	.uleb128 0x21a
	.string	"TA0CCTL2_ 0x0166"
	.byte	0x1
	.uleb128 0x21c
	.string	"TA0R_ 0x0170"
	.byte	0x1
	.uleb128 0x21e
	.string	"TA0CCR0_ 0x0172"
	.byte	0x1
	.uleb128 0x220
	.string	"TA0CCR1_ 0x0174"
	.byte	0x1
	.uleb128 0x222
	.string	"TA0CCR2_ 0x0176"
	.byte	0x1
	.uleb128 0x226
	.string	"TAIV TA0IV"
	.byte	0x1
	.uleb128 0x227
	.string	"TACTL TA0CTL"
	.byte	0x1
	.uleb128 0x228
	.string	"TACCTL0 TA0CCTL0"
	.byte	0x1
	.uleb128 0x229
	.string	"TACCTL1 TA0CCTL1"
	.byte	0x1
	.uleb128 0x22a
	.string	"TACCTL2 TA0CCTL2"
	.byte	0x1
	.uleb128 0x22b
	.string	"TAR TA0R"
	.byte	0x1
	.uleb128 0x22c
	.string	"TACCR0 TA0CCR0"
	.byte	0x1
	.uleb128 0x22d
	.string	"TACCR1 TA0CCR1"
	.byte	0x1
	.uleb128 0x22e
	.string	"TACCR2 TA0CCR2"
	.byte	0x1
	.uleb128 0x22f
	.string	"TAIV_ TA0IV_"
	.byte	0x1
	.uleb128 0x230
	.string	"TACTL_ TA0CTL_"
	.byte	0x1
	.uleb128 0x231
	.string	"TACCTL0_ TA0CCTL0_"
	.byte	0x1
	.uleb128 0x232
	.string	"TACCTL1_ TA0CCTL1_"
	.byte	0x1
	.uleb128 0x233
	.string	"TACCTL2_ TA0CCTL2_"
	.byte	0x1
	.uleb128 0x234
	.string	"TAR_ TA0R_"
	.byte	0x1
	.uleb128 0x235
	.string	"TACCR0_ TA0CCR0_"
	.byte	0x1
	.uleb128 0x236
	.string	"TACCR1_ TA0CCR1_"
	.byte	0x1
	.uleb128 0x237
	.string	"TACCR2_ TA0CCR2_"
	.byte	0x1
	.uleb128 0x23a
	.string	"CCTL0 TACCTL0"
	.byte	0x1
	.uleb128 0x23b
	.string	"CCTL1 TACCTL1"
	.byte	0x1
	.uleb128 0x23c
	.string	"CCTL2 TACCTL2"
	.byte	0x1
	.uleb128 0x23d
	.string	"CCR0 TACCR0"
	.byte	0x1
	.uleb128 0x23e
	.string	"CCR1 TACCR1"
	.byte	0x1
	.uleb128 0x23f
	.string	"CCR2 TACCR2"
	.byte	0x1
	.uleb128 0x240
	.string	"CCTL0_ TACCTL0_"
	.byte	0x1
	.uleb128 0x241
	.string	"CCTL1_ TACCTL1_"
	.byte	0x1
	.uleb128 0x242
	.string	"CCTL2_ TACCTL2_"
	.byte	0x1
	.uleb128 0x243
	.string	"CCR0_ TACCR0_"
	.byte	0x1
	.uleb128 0x244
	.string	"CCR1_ TACCR1_"
	.byte	0x1
	.uleb128 0x245
	.string	"CCR2_ TACCR2_"
	.byte	0x1
	.uleb128 0x247
	.string	"TASSEL1 (0x0200)"
	.byte	0x1
	.uleb128 0x248
	.string	"TASSEL0 (0x0100)"
	.byte	0x1
	.uleb128 0x249
	.string	"ID1 (0x0080)"
	.byte	0x1
	.uleb128 0x24a
	.string	"ID0 (0x0040)"
	.byte	0x1
	.uleb128 0x24b
	.string	"MC1 (0x0020)"
	.byte	0x1
	.uleb128 0x24c
	.string	"MC0 (0x0010)"
	.byte	0x1
	.uleb128 0x24d
	.string	"TACLR (0x0004)"
	.byte	0x1
	.uleb128 0x24e
	.string	"TAIE (0x0002)"
	.byte	0x1
	.uleb128 0x24f
	.string	"TAIFG (0x0001)"
	.byte	0x1
	.uleb128 0x251
	.string	"MC_0 (0x0000)"
	.byte	0x1
	.uleb128 0x252
	.string	"MC_1 (0x0010)"
	.byte	0x1
	.uleb128 0x253
	.string	"MC_2 (0x0020)"
	.byte	0x1
	.uleb128 0x254
	.string	"MC_3 (0x0030)"
	.byte	0x1
	.uleb128 0x255
	.string	"ID_0 (0x0000)"
	.byte	0x1
	.uleb128 0x256
	.string	"ID_1 (0x0040)"
	.byte	0x1
	.uleb128 0x257
	.string	"ID_2 (0x0080)"
	.byte	0x1
	.uleb128 0x258
	.string	"ID_3 (0x00C0)"
	.byte	0x1
	.uleb128 0x259
	.string	"TASSEL_0 (0x0000)"
	.byte	0x1
	.uleb128 0x25a
	.string	"TASSEL_1 (0x0100)"
	.byte	0x1
	.uleb128 0x25b
	.string	"TASSEL_2 (0x0200)"
	.byte	0x1
	.uleb128 0x25c
	.string	"TASSEL_3 (0x0300)"
	.byte	0x1
	.uleb128 0x25e
	.string	"CM1 (0x8000)"
	.byte	0x1
	.uleb128 0x25f
	.string	"CM0 (0x4000)"
	.byte	0x1
	.uleb128 0x260
	.string	"CCIS1 (0x2000)"
	.byte	0x1
	.uleb128 0x261
	.string	"CCIS0 (0x1000)"
	.byte	0x1
	.uleb128 0x262
	.string	"SCS (0x0800)"
	.byte	0x1
	.uleb128 0x263
	.string	"SCCI (0x0400)"
	.byte	0x1
	.uleb128 0x264
	.string	"CAP (0x0100)"
	.byte	0x1
	.uleb128 0x265
	.string	"OUTMOD2 (0x0080)"
	.byte	0x1
	.uleb128 0x266
	.string	"OUTMOD1 (0x0040)"
	.byte	0x1
	.uleb128 0x267
	.string	"OUTMOD0 (0x0020)"
	.byte	0x1
	.uleb128 0x268
	.string	"CCIE (0x0010)"
	.byte	0x1
	.uleb128 0x269
	.string	"CCI (0x0008)"
	.byte	0x1
	.uleb128 0x26a
	.string	"OUT (0x0004)"
	.byte	0x1
	.uleb128 0x26b
	.string	"COV (0x0002)"
	.byte	0x1
	.uleb128 0x26c
	.string	"CCIFG (0x0001)"
	.byte	0x1
	.uleb128 0x26e
	.string	"OUTMOD_0 (0x0000)"
	.byte	0x1
	.uleb128 0x26f
	.string	"OUTMOD_1 (0x0020)"
	.byte	0x1
	.uleb128 0x270
	.string	"OUTMOD_2 (0x0040)"
	.byte	0x1
	.uleb128 0x271
	.string	"OUTMOD_3 (0x0060)"
	.byte	0x1
	.uleb128 0x272
	.string	"OUTMOD_4 (0x0080)"
	.byte	0x1
	.uleb128 0x273
	.string	"OUTMOD_5 (0x00A0)"
	.byte	0x1
	.uleb128 0x274
	.string	"OUTMOD_6 (0x00C0)"
	.byte	0x1
	.uleb128 0x275
	.string	"OUTMOD_7 (0x00E0)"
	.byte	0x1
	.uleb128 0x276
	.string	"CCIS_0 (0x0000)"
	.byte	0x1
	.uleb128 0x277
	.string	"CCIS_1 (0x1000)"
	.byte	0x1
	.uleb128 0x278
	.string	"CCIS_2 (0x2000)"
	.byte	0x1
	.uleb128 0x279
	.string	"CCIS_3 (0x3000)"
	.byte	0x1
	.uleb128 0x27a
	.string	"CM_0 (0x0000)"
	.byte	0x1
	.uleb128 0x27b
	.string	"CM_1 (0x4000)"
	.byte	0x1
	.uleb128 0x27c
	.string	"CM_2 (0x8000)"
	.byte	0x1
	.uleb128 0x27d
	.string	"CM_3 (0xC000)"
	.byte	0x1
	.uleb128 0x280
	.string	"TA0IV_NONE (0x0000)"
	.byte	0x1
	.uleb128 0x281
	.string	"TA0IV_TACCR1 (0x0002)"
	.byte	0x1
	.uleb128 0x282
	.string	"TA0IV_TACCR2 (0x0004)"
	.byte	0x1
	.uleb128 0x283
	.string	"TA0IV_6 (0x0006)"
	.byte	0x1
	.uleb128 0x284
	.string	"TA0IV_8 (0x0008)"
	.byte	0x1
	.uleb128 0x285
	.string	"TA0IV_TAIFG (0x000A)"
	.byte	0x1
	.uleb128 0x28a
	.string	"__MSP430_HAS_T1A3__ "
	.byte	0x1
	.uleb128 0x28c
	.string	"TA1IV_ 0x011E"
	.byte	0x1
	.uleb128 0x28e
	.string	"TA1CTL_ 0x0180"
	.byte	0x1
	.uleb128 0x290
	.string	"TA1CCTL0_ 0x0182"
	.byte	0x1
	.uleb128 0x292
	.string	"TA1CCTL1_ 0x0184"
	.byte	0x1
	.uleb128 0x294
	.string	"TA1CCTL2_ 0x0186"
	.byte	0x1
	.uleb128 0x296
	.string	"TA1R_ 0x0190"
	.byte	0x1
	.uleb128 0x298
	.string	"TA1CCR0_ 0x0192"
	.byte	0x1
	.uleb128 0x29a
	.string	"TA1CCR1_ 0x0194"
	.byte	0x1
	.uleb128 0x29c
	.string	"TA1CCR2_ 0x0196"
	.byte	0x1
	.uleb128 0x2a2
	.string	"TA1IV_NONE (0x0000)"
	.byte	0x1
	.uleb128 0x2a3
	.string	"TA1IV_TACCR1 (0x0002)"
	.byte	0x1
	.uleb128 0x2a4
	.string	"TA1IV_TACCR2 (0x0004)"
	.byte	0x1
	.uleb128 0x2a5
	.string	"TA1IV_TAIFG (0x000A)"
	.byte	0x1
	.uleb128 0x2aa
	.string	"__MSP430_HAS_USCI__ "
	.byte	0x1
	.uleb128 0x2ac
	.string	"UCA0CTL0_ 0x0060"
	.byte	0x1
	.uleb128 0x2ae
	.string	"UCA0CTL1_ 0x0061"
	.byte	0x1
	.uleb128 0x2b0
	.string	"UCA0BR0_ 0x0062"
	.byte	0x1
	.uleb128 0x2b2
	.string	"UCA0BR1_ 0x0063"
	.byte	0x1
	.uleb128 0x2b4
	.string	"UCA0MCTL_ 0x0064"
	.byte	0x1
	.uleb128 0x2b6
	.string	"UCA0STAT_ 0x0065"
	.byte	0x1
	.uleb128 0x2b8
	.string	"UCA0RXBUF_ 0x0066"
	.byte	0x1
	.uleb128 0x2ba
	.string	"UCA0TXBUF_ 0x0067"
	.byte	0x1
	.uleb128 0x2bc
	.string	"UCA0ABCTL_ 0x005D"
	.byte	0x1
	.uleb128 0x2be
	.string	"UCA0IRTCTL_ 0x005E"
	.byte	0x1
	.uleb128 0x2c0
	.string	"UCA0IRRCTL_ 0x005F"
	.byte	0x1
	.uleb128 0x2c5
	.string	"UCB0CTL0_ 0x0068"
	.byte	0x1
	.uleb128 0x2c7
	.string	"UCB0CTL1_ 0x0069"
	.byte	0x1
	.uleb128 0x2c9
	.string	"UCB0BR0_ 0x006A"
	.byte	0x1
	.uleb128 0x2cb
	.string	"UCB0BR1_ 0x006B"
	.byte	0x1
	.uleb128 0x2cd
	.string	"UCB0I2CIE_ 0x006C"
	.byte	0x1
	.uleb128 0x2cf
	.string	"UCB0STAT_ 0x006D"
	.byte	0x1
	.uleb128 0x2d1
	.string	"UCB0RXBUF_ 0x006E"
	.byte	0x1
	.uleb128 0x2d3
	.string	"UCB0TXBUF_ 0x006F"
	.byte	0x1
	.uleb128 0x2d5
	.string	"UCB0I2COA_ 0x0118"
	.byte	0x1
	.uleb128 0x2d7
	.string	"UCB0I2CSA_ 0x011A"
	.byte	0x1
	.uleb128 0x2db
	.string	"UCPEN (0x80)"
	.byte	0x1
	.uleb128 0x2dc
	.string	"UCPAR (0x40)"
	.byte	0x1
	.uleb128 0x2dd
	.string	"UCMSB (0x20)"
	.byte	0x1
	.uleb128 0x2de
	.string	"UC7BIT (0x10)"
	.byte	0x1
	.uleb128 0x2df
	.string	"UCSPB (0x08)"
	.byte	0x1
	.uleb128 0x2e0
	.string	"UCMODE1 (0x04)"
	.byte	0x1
	.uleb128 0x2e1
	.string	"UCMODE0 (0x02)"
	.byte	0x1
	.uleb128 0x2e2
	.string	"UCSYNC (0x01)"
	.byte	0x1
	.uleb128 0x2e5
	.string	"UCCKPH (0x80)"
	.byte	0x1
	.uleb128 0x2e6
	.string	"UCCKPL (0x40)"
	.byte	0x1
	.uleb128 0x2e7
	.string	"UCMST (0x08)"
	.byte	0x1
	.uleb128 0x2ea
	.string	"UCA10 (0x80)"
	.byte	0x1
	.uleb128 0x2eb
	.string	"UCSLA10 (0x40)"
	.byte	0x1
	.uleb128 0x2ec
	.string	"UCMM (0x20)"
	.byte	0x1
	.uleb128 0x2ee
	.string	"UCMODE_0 (0x00)"
	.byte	0x1
	.uleb128 0x2ef
	.string	"UCMODE_1 (0x02)"
	.byte	0x1
	.uleb128 0x2f0
	.string	"UCMODE_2 (0x04)"
	.byte	0x1
	.uleb128 0x2f1
	.string	"UCMODE_3 (0x06)"
	.byte	0x1
	.uleb128 0x2f4
	.string	"UCSSEL1 (0x80)"
	.byte	0x1
	.uleb128 0x2f5
	.string	"UCSSEL0 (0x40)"
	.byte	0x1
	.uleb128 0x2f6
	.string	"UCRXEIE (0x20)"
	.byte	0x1
	.uleb128 0x2f7
	.string	"UCBRKIE (0x10)"
	.byte	0x1
	.uleb128 0x2f8
	.string	"UCDORM (0x08)"
	.byte	0x1
	.uleb128 0x2f9
	.string	"UCTXADDR (0x04)"
	.byte	0x1
	.uleb128 0x2fa
	.string	"UCTXBRK (0x02)"
	.byte	0x1
	.uleb128 0x2fb
	.string	"UCSWRST (0x01)"
	.byte	0x1
	.uleb128 0x306
	.string	"UCTR (0x10)"
	.byte	0x1
	.uleb128 0x307
	.string	"UCTXNACK (0x08)"
	.byte	0x1
	.uleb128 0x308
	.string	"UCTXSTP (0x04)"
	.byte	0x1
	.uleb128 0x309
	.string	"UCTXSTT (0x02)"
	.byte	0x1
	.uleb128 0x30a
	.string	"UCSSEL_0 (0x00)"
	.byte	0x1
	.uleb128 0x30b
	.string	"UCSSEL_1 (0x40)"
	.byte	0x1
	.uleb128 0x30c
	.string	"UCSSEL_2 (0x80)"
	.byte	0x1
	.uleb128 0x30d
	.string	"UCSSEL_3 (0xC0)"
	.byte	0x1
	.uleb128 0x30f
	.string	"UCBRF3 (0x80)"
	.byte	0x1
	.uleb128 0x310
	.string	"UCBRF2 (0x40)"
	.byte	0x1
	.uleb128 0x311
	.string	"UCBRF1 (0x20)"
	.byte	0x1
	.uleb128 0x312
	.string	"UCBRF0 (0x10)"
	.byte	0x1
	.uleb128 0x313
	.string	"UCBRS2 (0x08)"
	.byte	0x1
	.uleb128 0x314
	.string	"UCBRS1 (0x04)"
	.byte	0x1
	.uleb128 0x315
	.string	"UCBRS0 (0x02)"
	.byte	0x1
	.uleb128 0x316
	.string	"UCOS16 (0x01)"
	.byte	0x1
	.uleb128 0x318
	.string	"UCBRF_0 (0x00)"
	.byte	0x1
	.uleb128 0x319
	.string	"UCBRF_1 (0x10)"
	.byte	0x1
	.uleb128 0x31a
	.string	"UCBRF_2 (0x20)"
	.byte	0x1
	.uleb128 0x31b
	.string	"UCBRF_3 (0x30)"
	.byte	0x1
	.uleb128 0x31c
	.string	"UCBRF_4 (0x40)"
	.byte	0x1
	.uleb128 0x31d
	.string	"UCBRF_5 (0x50)"
	.byte	0x1
	.uleb128 0x31e
	.string	"UCBRF_6 (0x60)"
	.byte	0x1
	.uleb128 0x31f
	.string	"UCBRF_7 (0x70)"
	.byte	0x1
	.uleb128 0x320
	.string	"UCBRF_8 (0x80)"
	.byte	0x1
	.uleb128 0x321
	.string	"UCBRF_9 (0x90)"
	.byte	0x1
	.uleb128 0x322
	.string	"UCBRF_10 (0xA0)"
	.byte	0x1
	.uleb128 0x323
	.string	"UCBRF_11 (0xB0)"
	.byte	0x1
	.uleb128 0x324
	.string	"UCBRF_12 (0xC0)"
	.byte	0x1
	.uleb128 0x325
	.string	"UCBRF_13 (0xD0)"
	.byte	0x1
	.uleb128 0x326
	.string	"UCBRF_14 (0xE0)"
	.byte	0x1
	.uleb128 0x327
	.string	"UCBRF_15 (0xF0)"
	.byte	0x1
	.uleb128 0x329
	.string	"UCBRS_0 (0x00)"
	.byte	0x1
	.uleb128 0x32a
	.string	"UCBRS_1 (0x02)"
	.byte	0x1
	.uleb128 0x32b
	.string	"UCBRS_2 (0x04)"
	.byte	0x1
	.uleb128 0x32c
	.string	"UCBRS_3 (0x06)"
	.byte	0x1
	.uleb128 0x32d
	.string	"UCBRS_4 (0x08)"
	.byte	0x1
	.uleb128 0x32e
	.string	"UCBRS_5 (0x0A)"
	.byte	0x1
	.uleb128 0x32f
	.string	"UCBRS_6 (0x0C)"
	.byte	0x1
	.uleb128 0x330
	.string	"UCBRS_7 (0x0E)"
	.byte	0x1
	.uleb128 0x332
	.string	"UCLISTEN (0x80)"
	.byte	0x1
	.uleb128 0x333
	.string	"UCFE (0x40)"
	.byte	0x1
	.uleb128 0x334
	.string	"UCOE (0x20)"
	.byte	0x1
	.uleb128 0x335
	.string	"UCPE (0x10)"
	.byte	0x1
	.uleb128 0x336
	.string	"UCBRK (0x08)"
	.byte	0x1
	.uleb128 0x337
	.string	"UCRXERR (0x04)"
	.byte	0x1
	.uleb128 0x338
	.string	"UCADDR (0x02)"
	.byte	0x1
	.uleb128 0x339
	.string	"UCBUSY (0x01)"
	.byte	0x1
	.uleb128 0x33a
	.string	"UCIDLE (0x02)"
	.byte	0x1
	.uleb128 0x340
	.string	"UCNACKIE (0x08)"
	.byte	0x1
	.uleb128 0x341
	.string	"UCSTPIE (0x04)"
	.byte	0x1
	.uleb128 0x342
	.string	"UCSTTIE (0x02)"
	.byte	0x1
	.uleb128 0x343
	.string	"UCALIE (0x01)"
	.byte	0x1
	.uleb128 0x346
	.string	"UCSCLLOW (0x40)"
	.byte	0x1
	.uleb128 0x347
	.string	"UCGC (0x20)"
	.byte	0x1
	.uleb128 0x348
	.string	"UCBBUSY (0x10)"
	.byte	0x1
	.uleb128 0x349
	.string	"UCNACKIFG (0x08)"
	.byte	0x1
	.uleb128 0x34a
	.string	"UCSTPIFG (0x04)"
	.byte	0x1
	.uleb128 0x34b
	.string	"UCSTTIFG (0x02)"
	.byte	0x1
	.uleb128 0x34c
	.string	"UCALIFG (0x01)"
	.byte	0x1
	.uleb128 0x34e
	.string	"UCIRTXPL5 (0x80)"
	.byte	0x1
	.uleb128 0x34f
	.string	"UCIRTXPL4 (0x40)"
	.byte	0x1
	.uleb128 0x350
	.string	"UCIRTXPL3 (0x20)"
	.byte	0x1
	.uleb128 0x351
	.string	"UCIRTXPL2 (0x10)"
	.byte	0x1
	.uleb128 0x352
	.string	"UCIRTXPL1 (0x08)"
	.byte	0x1
	.uleb128 0x353
	.string	"UCIRTXPL0 (0x04)"
	.byte	0x1
	.uleb128 0x354
	.string	"UCIRTXCLK (0x02)"
	.byte	0x1
	.uleb128 0x355
	.string	"UCIREN (0x01)"
	.byte	0x1
	.uleb128 0x357
	.string	"UCIRRXFL5 (0x80)"
	.byte	0x1
	.uleb128 0x358
	.string	"UCIRRXFL4 (0x40)"
	.byte	0x1
	.uleb128 0x359
	.string	"UCIRRXFL3 (0x20)"
	.byte	0x1
	.uleb128 0x35a
	.string	"UCIRRXFL2 (0x10)"
	.byte	0x1
	.uleb128 0x35b
	.string	"UCIRRXFL1 (0x08)"
	.byte	0x1
	.uleb128 0x35c
	.string	"UCIRRXFL0 (0x04)"
	.byte	0x1
	.uleb128 0x35d
	.string	"UCIRRXPL (0x02)"
	.byte	0x1
	.uleb128 0x35e
	.string	"UCIRRXFE (0x01)"
	.byte	0x1
	.uleb128 0x362
	.string	"UCDELIM1 (0x20)"
	.byte	0x1
	.uleb128 0x363
	.string	"UCDELIM0 (0x10)"
	.byte	0x1
	.uleb128 0x364
	.string	"UCSTOE (0x08)"
	.byte	0x1
	.uleb128 0x365
	.string	"UCBTOE (0x04)"
	.byte	0x1
	.uleb128 0x367
	.string	"UCABDEN (0x01)"
	.byte	0x1
	.uleb128 0x369
	.string	"UCGCEN (0x8000)"
	.byte	0x1
	.uleb128 0x36a
	.string	"UCOA9 (0x0200)"
	.byte	0x1
	.uleb128 0x36b
	.string	"UCOA8 (0x0100)"
	.byte	0x1
	.uleb128 0x36c
	.string	"UCOA7 (0x0080)"
	.byte	0x1
	.uleb128 0x36d
	.string	"UCOA6 (0x0040)"
	.byte	0x1
	.uleb128 0x36e
	.string	"UCOA5 (0x0020)"
	.byte	0x1
	.uleb128 0x36f
	.string	"UCOA4 (0x0010)"
	.byte	0x1
	.uleb128 0x370
	.string	"UCOA3 (0x0008)"
	.byte	0x1
	.uleb128 0x371
	.string	"UCOA2 (0x0004)"
	.byte	0x1
	.uleb128 0x372
	.string	"UCOA1 (0x0002)"
	.byte	0x1
	.uleb128 0x373
	.string	"UCOA0 (0x0001)"
	.byte	0x1
	.uleb128 0x375
	.string	"UCSA9 (0x0200)"
	.byte	0x1
	.uleb128 0x376
	.string	"UCSA8 (0x0100)"
	.byte	0x1
	.uleb128 0x377
	.string	"UCSA7 (0x0080)"
	.byte	0x1
	.uleb128 0x378
	.string	"UCSA6 (0x0040)"
	.byte	0x1
	.uleb128 0x379
	.string	"UCSA5 (0x0020)"
	.byte	0x1
	.uleb128 0x37a
	.string	"UCSA4 (0x0010)"
	.byte	0x1
	.uleb128 0x37b
	.string	"UCSA3 (0x0008)"
	.byte	0x1
	.uleb128 0x37c
	.string	"UCSA2 (0x0004)"
	.byte	0x1
	.uleb128 0x37d
	.string	"UCSA1 (0x0002)"
	.byte	0x1
	.uleb128 0x37e
	.string	"UCSA0 (0x0001)"
	.byte	0x1
	.uleb128 0x383
	.string	"__MSP430_HAS_WDT__ "
	.byte	0x1
	.uleb128 0x385
	.string	"WDTCTL_ 0x0120"
	.byte	0x1
	.uleb128 0x388
	.string	"WDTIS0 (0x0001)"
	.byte	0x1
	.uleb128 0x389
	.string	"WDTIS1 (0x0002)"
	.byte	0x1
	.uleb128 0x38a
	.string	"WDTSSEL (0x0004)"
	.byte	0x1
	.uleb128 0x38b
	.string	"WDTCNTCL (0x0008)"
	.byte	0x1
	.uleb128 0x38c
	.string	"WDTTMSEL (0x0010)"
	.byte	0x1
	.uleb128 0x38d
	.string	"WDTNMI (0x0020)"
	.byte	0x1
	.uleb128 0x38e
	.string	"WDTNMIES (0x0040)"
	.byte	0x1
	.uleb128 0x38f
	.string	"WDTHOLD (0x0080)"
	.byte	0x1
	.uleb128 0x391
	.string	"WDTPW (0x5A00)"
	.byte	0x1
	.uleb128 0x395
	.string	"WDT_MDLY_32 (WDTPW+WDTTMSEL+WDTCNTCL)"
	.byte	0x1
	.uleb128 0x396
	.string	"WDT_MDLY_8 (WDTPW+WDTTMSEL+WDTCNTCL+WDTIS0)"
	.byte	0x1
	.uleb128 0x397
	.string	"WDT_MDLY_0_5 (WDTPW+WDTTMSEL+WDTCNTCL+WDTIS1)"
	.byte	0x1
	.uleb128 0x398
	.string	"WDT_MDLY_0_064 (WDTPW+WDTTMSEL+WDTCNTCL+WDTIS1+WDTIS0)"
	.byte	0x1
	.uleb128 0x39a
	.string	"WDT_ADLY_1000 (WDTPW+WDTTMSEL+WDTCNTCL+WDTSSEL)"
	.byte	0x1
	.uleb128 0x39b
	.string	"WDT_ADLY_250 (WDTPW+WDTTMSEL+WDTCNTCL+WDTSSEL+WDTIS0)"
	.byte	0x1
	.uleb128 0x39c
	.string	"WDT_ADLY_16 (WDTPW+WDTTMSEL+WDTCNTCL+WDTSSEL+WDTIS1)"
	.byte	0x1
	.uleb128 0x39d
	.string	"WDT_ADLY_1_9 (WDTPW+WDTTMSEL+WDTCNTCL+WDTSSEL+WDTIS1+WDTIS0)"
	.byte	0x1
	.uleb128 0x3a0
	.string	"WDT_MRST_32 (WDTPW+WDTCNTCL)"
	.byte	0x1
	.uleb128 0x3a1
	.string	"WDT_MRST_8 (WDTPW+WDTCNTCL+WDTIS0)"
	.byte	0x1
	.uleb128 0x3a2
	.string	"WDT_MRST_0_5 (WDTPW+WDTCNTCL+WDTIS1)"
	.byte	0x1
	.uleb128 0x3a3
	.string	"WDT_MRST_0_064 (WDTPW+WDTCNTCL+WDTIS1+WDTIS0)"
	.byte	0x1
	.uleb128 0x3a5
	.string	"WDT_ARST_1000 (WDTPW+WDTCNTCL+WDTSSEL)"
	.byte	0x1
	.uleb128 0x3a6
	.string	"WDT_ARST_250 (WDTPW+WDTCNTCL+WDTSSEL+WDTIS0)"
	.byte	0x1
	.uleb128 0x3a7
	.string	"WDT_ARST_16 (WDTPW+WDTCNTCL+WDTSSEL+WDTIS1)"
	.byte	0x1
	.uleb128 0x3a8
	.string	"WDT_ARST_1_9 (WDTPW+WDTCNTCL+WDTSSEL+WDTIS1+WDTIS0)"
	.byte	0x1
	.uleb128 0x3b5
	.string	"CALDCO_16MHZ_ 0x10F8"
	.byte	0x1
	.uleb128 0x3b7
	.string	"CALBC1_16MHZ_ 0x10F9"
	.byte	0x1
	.uleb128 0x3b9
	.string	"CALDCO_12MHZ_ 0x10FA"
	.byte	0x1
	.uleb128 0x3bb
	.string	"CALBC1_12MHZ_ 0x10FB"
	.byte	0x1
	.uleb128 0x3bd
	.string	"CALDCO_8MHZ_ 0x10FC"
	.byte	0x1
	.uleb128 0x3bf
	.string	"CALBC1_8MHZ_ 0x10FD"
	.byte	0x1
	.uleb128 0x3c1
	.string	"CALDCO_1MHZ_ 0x10FE"
	.byte	0x1
	.uleb128 0x3c3
	.string	"CALBC1_1MHZ_ 0x10FF"
	.byte	0x1
	.uleb128 0x3cd
	.string	"PORT1_VECTOR (0x0004)"
	.byte	0x1
	.uleb128 0x3ce
	.string	"PORT2_VECTOR (0x0006)"
	.byte	0x1
	.uleb128 0x3cf
	.string	"ADC10_VECTOR (0x000A)"
	.byte	0x1
	.uleb128 0x3d0
	.string	"USCIAB0TX_VECTOR (0x000C)"
	.byte	0x1
	.uleb128 0x3d1
	.string	"USCIAB0RX_VECTOR (0x000E)"
	.byte	0x1
	.uleb128 0x3d2
	.string	"TIMER0_A1_VECTOR (0x0010)"
	.byte	0x1
	.uleb128 0x3d3
	.string	"TIMER0_A0_VECTOR (0x0012)"
	.byte	0x1
	.uleb128 0x3d4
	.string	"WDT_VECTOR (0x0014)"
	.byte	0x1
	.uleb128 0x3d5
	.string	"COMPARATORA_VECTOR (0x0016)"
	.byte	0x1
	.uleb128 0x3d6
	.string	"TIMER1_A1_VECTOR (0x0018)"
	.byte	0x1
	.uleb128 0x3d7
	.string	"TIMER1_A0_VECTOR (0x001A)"
	.byte	0x1
	.uleb128 0x3d8
	.string	"NMI_VECTOR (0x001C)"
	.byte	0x1
	.uleb128 0x3d9
	.string	"RESET_VECTOR (0x001E)"
	.byte	0x4
	.byte	0x4
	.byte	0x4
	.byte	0
	.section	.debug_str,"MS",@progbits,1
.LASF3:
	.ascii	"/home/davi/Documentos/6o_Per\303\255odo_Engenharia_Eletr\303"
	.ascii	"\264nica/Microcontroladores_e_Micr"
	.string	"oprocessadores_Diogo/Rascunho_Programas_C/Assembly_inline_MSP430"
.LASF0:
	.string	"unsigned int"
.LASF2:
	.string	"multiplica_assembly.c"
.LASF5:
	.string	"WDTCTL"
.LASF6:
	.string	"__WDTCTL"
.LASF1:
	.string	"GNU C 4.6.3 20120301 (mspgcc LTS 20120406 unpatched)"
.LASF4:
	.string	"main"
