.data
arr: .word 71 27 50 81 34 12 84 41 68 7 57 69 40 51 85 66 63 47 65 61 28 92 80 70 88 98 35 89 54 56 13 30 46 45 64 91 5 86 3 87 2 6 99 11 79 72 14 29 44 60 55 22 26 31 9 43 37 24 52 42 67 83 74 18 10 73 8 20 53 0 96 4 16 82 58 62 15 95 38 76 1 97 75 33 49 21 23 32 36 59 25 17 94 39 48 77 93 90 19 78
arrS: .word 100

.macro print_int
	li a7 1
	ecall
.end_macro
.macro print_array
	mv a0 s0
	mv a1 s1
	call PRINT_ARRAY
.end_macro
.macro new_line
	li a7 11
	li a0 10
	ecall
.end_macro
.macro space
	li a7 11
	li a0 32
	ecall
.end_macro

.text
MAIN:
	la s0 arr	 # s0 = nums.begin()
	lw s2 arrS   # s2 = nums.size()
	slli t0 s2 2
	add s1 s0 t0 # s1 = nums.end()

    print_array()

    mv s10 zero    # loop counter
MAIN_LOOP:
    beq s10 s2 MAIN_DONE
 	mv a0 s0
 	mv a1 s1
 	call ARRAY_PAIRS

    addi s10 s10 1
    j MAIN_LOOP
MAIN_DONE:
    print_array()
    j EXIT

# prints all elements of array
PRINT_ARRAY:
	mv t0 a0 # t1 = a0 = s.begin()
	mv t1 a1 # t2 = a1 = s.end()
PRINT_LOOP:
	beq t0 t1 PRINT_DONE # if t0 == s.end() -> done

	lw t2 0(t0)	   # t2 is *t0
	mv a0 t2
	print_int()
	space()

	addi t0 t0 4   # adds to the iterator
	j PRINT_LOOP
PRINT_DONE:
	new_line()
	jr ra

# iterates through array once swapping unordered pairs
ARRAY_PAIRS:
	mv t0 a0 # t1 = a0 = s.begin()
	addi t1 a1 -4  # t2 = a1-4 = s.end()-1
PAIRS_LOOP:
	beq t0 t1 PAIRS_DONE # if t0 == s.end() -> done

	lw t2 0(t0)	   # t2 is *t0
	lw t3 4(t0)	   # t2 is *(t0+1)

	bgt t3 t2 PAIRS_OK   # if sorted skip swap
	sw t2 4(t0)
	sw t3 0(t0)
PAIRS_OK:
	addi t0 t0 4   # adds to the iterator
	j PAIRS_LOOP
PAIRS_DONE:
	jr ra

EXIT:
	li a7 10
	ecall