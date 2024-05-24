
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

