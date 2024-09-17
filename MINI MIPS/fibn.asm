
# Fibn.s - compute the nth Fibonacci number
#	
# C-code that this assembly code came from
#
# int fibn(void)
# {
#  int n = 13;		/* Compute nth Fibonacci number */
#  int f1 = 1, f2 = -1	/* last two Fibonacci numbers   */
#  int i = 0.           /* store the value into an array*/
#  int [] fibonacci_array = n;  /* initialize array to store number*/
#  while (n != 0) {	/* count down to n = 0          */
#    f1 = f1 + f2;
#    f2 = f1 - f2;
#    fibonacci_array[i] = f1;
#     i = i + 1;
#     n = n - 1;
#   }
#   return f1;
#  }
#
#
# Register usage: $3=n, $4=f1, $5=f2, $6 = i, $7 = LED output
# store the Fibonacci numbers in a specific address

addi $3, $0, 13		# initialize n = 13
	addi $4, $0, 1		# initialize f1 = 1
	addi $5, $0, -1		# initialize f2 = -1
        addi $6, $0,0           # initialize i = 0
loop:	beq $3, $0, checkForInputs   # Done with loop if n = 0
	add $4, $4, $5		# f1 = f1 + f2
	sub $5, $4, $5		# f2 = f1 - f2
        sb $4, 128($6)          # save the fabinacchi number in expected address
        addi $6, $6, 1          # i = i + 1
	addi $3, $3, -1		# n = n - 1
	j loop                  # repeat until done
checkForInput:                
	lb $6, 255($0)         # Save the desired address into 
	lb $7, 128($6)         # load the desired value into register 7
	sb $7 255($0)          # save the value from register 7 into address 255 to be display 
	j checkForInput       # jump back to checkForInput
exit:
