
Computer Organization - Spring 2024
==============================================================
## Iran Univeristy of Science and Technology
## Assignment 1: Assembly code execution on phoeniX RISC-V core

- Name: Parsa Ghorbani
- Team Members: AmirMohammad Chamanzari & AmirReza Bakhtaki
- Student ID: 400413161
- Date: 24 May 2024

## Report

### Quick Sort

This RISC-V assembly program implements the quicksort algorithm to sort an array of integers. The array is stored in memory and sorted in-place using the quicksort technique. This README provides an overview of how the program is structured and how it functions.

#### Program Structure:

1. **Stack Pointer Initialization:**
   - The stack pointer is initialized to allocate space for stack operations.

    ```assembly
    addi sp, sp, 1000
    ```

2. **Store Array Values:**
   - The array `{10, 80, 30, 90, 40, 50, 70}` is stored in contiguous memory starting at address `0x0`.

    ```assembly
    addi a0, x0, 0

    addi t0, x0, 10
    sw t0, 0(a0)
    addi t0, x0, 80
    sw t0, 4(a0)
    addi t0, x0, 30
    sw t0, 8(a0)
    addi t0, x0, 90
    sw t0, 12(a0)
    addi t0, x0, 40
    sw t0, 16(a0)
    addi t0, x0, 50
    sw t0, 20(a0)
    addi t0, x0, 70
    sw t0, 24(a0)
    ```

3. **Set Start and End Indices:**
   - Initialize the start (`a1`) and end (`a2`) indices for the quicksort function.

    ```assembly
    addi a1, x0, 0 # start
    addi a2, x0, 6 # end
    ```

4. **Call Quicksort:**
   - Call the quicksort function and then exit the program.

    ```assembly
    jal ra, QUICKSORT
    jal ra, EXIT
    ```

#### Quicksort Function:

1. **Save Registers:**
   - Save the return address and other registers on the stack to preserve their values.

    ```assembly
    addi sp, sp, -20
    sw ra, 16(sp)
    sw s3, 12(sp)
    sw s2, 8(sp)
    sw s1, 4(sp)
    sw s0, 0(sp)
    ```

2. **Initialize Local Variables:**
   - Set local variables for the array address (`s0`), start (`s1`), and end (`s2`) indices.

    ```assembly
    addi s0, a0, 0
    addi s1, a1, 0
    addi s2, a2, 0
    ```

3. **Base Case:**
   - If the end index is less than the start index, return from the function.

    ```assembly
    BLT a2, a1, START_GT_END
    ```

4. **Partitioning:**
   - Call the partition function to rearrange the array elements around a pivot.

    ```assembly
    jal ra, PARTITION
    ```

5. **Recursive Quicksort:**
   - Recursively apply quicksort to the subarrays before and after the pivot.

    ```assembly
    addi s3, a0, 0   # pi

    addi a0, s0, 0
    addi a1, s1, 0
    addi a2, s3, -1
    jal ra, QUICKSORT  # quicksort(arr, start, pi - 1);

    addi a0, s0, 0
    addi a1, s3, 1
    addi a2, s2, 0
    jal ra, QUICKSORT  # quicksort(arr, pi + 1, end);
    ```

6. **Restore Registers and Return:**
   - Restore the saved registers and return from the function.

    ```assembly
    START_GT_END:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    jalr x0, ra, 0
    ```

#### Partition Function:

1. **Save Return Address:**
   - Save the return address on the stack.

    ```assembly
    addi sp, sp, -4
    sw ra, 0(sp)
    ```

2. **Initialize Variables:**
   - Set the pivot element and initialize indices for partitioning.

    ```assembly
    slli t0, a2, 2   # end * sizeof(int)
    add t0, t0, a0  
    lw t0, 0(t0)     # pivot = arr[end]
    addi t1, a1, -1  # i = (start - 1)

    addi t2, a1, 0   # j = start
    ```

3. **Partition Loop:**
   - Iterate over the array, swapping elements to partition around the pivot.

    ```assembly
    LOOP:
    BEQ t2, a2, LOOP_DONE   # while (j < end)

    slli t3, t2, 2   # j * sizeof(int)
    add a6, t3, a0   # (arr + j)
    lw t3, 0(a6)     # arr[j]

    addi t0, t0, 1   # pivot + 1
    BLT t0, t3, CURR_ELEMENT_GTE_PIVOT  # if (pivot <= arr[j])
    addi t1, t1, 1   # i++

    slli t5, t1, 2   # i * sizeof(int)
    add a7, t5, a0   # (arr + i)
    lw t5, 0(a7)     # arr[i]

    sw t5, 0(a6)
    sw t3, 0(a7)     # swap(&arr[i], &arr[j])

    CURR_ELEMENT_GTE_PIVOT:
    addi t2, t2, 1   # j++
    beq x0, x0, LOOP
    LOOP_DONE:
    ```

4. **Final Swap:**
   - Swap the pivot element to its correct position.

    ```assembly
    addi t5, t1, 1   # i + 1
    addi a5, t5, 0   # Save for return value.
    slli t5, t5, 2   # (i + 1) * sizeof(int)
    add a7, t5, a0   # (arr + (i + 1))
    lw t 5, 0(a7)     # arr[i + 1]

    slli t3, a2, 2   # end * sizeof(int)
    add a6, t3, a0   # (arr + end)
    lw t3, 0(a6)     # arr[end]

    sw t5, 0(a6)
    sw t3, 0(a7)     # swap(&arr[i + 1], &arr[end])
    ```

5. **Return Partition Index:**
   - Return the partition index (`i + 1`).

    ```assembly
    addi a0, a5, 0   # return i + 1

    lw ra, 0(sp)
    addi sp, sp, 4
    jalr x0, ra, 0
    ```

#### Exit Function:

1. **Exit the Program:**
   - Use `ebreak` to terminate the program.

    ```assembly
    EXIT:
    ebreak
    ```

#### Key Points

- The program demonstrates the quicksort algorithm implemented in RISC-V assembly.
- Recursive function calls are managed by saving and restoring register values on the stack.
- The partition function rearranges the array elements around a pivot.
- The sorted array can be verified by examining the memory content after program execution.

This program serves as an educational example of implementing sorting algorithms in low-level assembly language, illustrating the use of stack management and recursive function calls in RISC-V.

- Waveform image

![Quick Sort Waveform](https://raw.githubusercontent.com/Parsa10Gh/phoeniX_test/main/QuickSort_Waveform.png)

### Integer Square Root

- This RISC-V assembly program calculates the integer square root of a given value (64 in this case) using a simple iterative method. The integer square root of a number ***n*** is the largest integer  ***x***  such that  ***x<sup>2</sup> $\le$ n*** .
#### Steps:  
1. ***Load the Value:****  
- The program starts by loading the value whose integer square root is to be found (64) into the register `a0`.  
  
**

```
    addi a0, x0, 64
```

  
2. **Initialize Variables:****  
- The guess (`t0`) is initialized to 1.  
  
**

```
    li t0, 1
```

  
3. **Loop:****  
- The program enters a loop where it squares the current guess and compares it to the value in `a0`.  
- If the square of the guess is greater than or equal to the value, the loop exits.  
- Otherwise, the guess is incremented and the loop repeats.  
  
**

```
    loop:
        mul t2, t0, t0      # Calculate the square of the guess
        bge t2, a0, end_loop # If guess squared >= value, exit loop

        addi t0, t0, 1      # Increment guess
        j loop              # Repeat loop
```

  
4. **End of Loop:****  
- When the loop exits, `t0` is the first value for which `t0^2 >= a0`. Therefore, `t0` is decremented by 1 to get the largest `t0` for which `t0^2 < a0`.  
- The result is stored in `a0`.  
  
**

```
    end_loop:
        addi t0, t0, -1  # Decrement guess since the loop exits when t0^2 >= a0
        sub a0, t0, x0   # Store result (integer square root) in a0
```

  
5. **Exit the Program:*** - The program uses `ebreak` to signal the end of execution.  

```
    ebreak
```

  
#### Purpose:  
This program demonstrates a straightforward method to compute the integer square root by iterative guessing and checking. It incrementally increases the guess until the square of the guess is greater than or equal to the target value, then adjusts to find the correct integer square root. This approach, while not the most efficient for large numbers, is simple and easy to understand.
- Waveform image

![ineger square root Waveform](https://raw.githubusercontent.com/Parsa10Gh/phoeniX_test/main/integer%20square%20root%20simulation.png)

