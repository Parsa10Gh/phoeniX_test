# Load argument (value whose square root is to be found)
addi a0, x0, 64 

# Initialize variables
li t0, 1         # Initialize guess to 1

# Loop until the guess squared is greater than or equal to the value
loop:
    mul t2, t0, t0   # Calculate the square of the guess
    bge t2, a0, end_loop # If guess squared >= value, exit loop
    
    addi t0, t0, 1   # Increment guess
    j loop           # Repeat loop

end_loop:
    sub a0, t0, x0 # Store result (integer square root) in a0

# Exit the program
ebreak