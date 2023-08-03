import random
die = random.SystemRandom() # A single dice.
import time


def single_test(n, a):
    exp = n - 1

    # a & 1 
    #    -> is 0 ==> a is even
    #    -> is 1 ==> a is odd
    while not (exp &  1):
        # right shifting == // 2
        exp >>= 1  
        
    if pow(a, exp, n) == 1:
        return True
        
    while exp < n - 1:
        if pow(a, exp, n) == n - 1:
            return True
        # left shifting == * 2
        exp <<= 1
        
    return False


    
def miller_rabin(n, k=40):
    for i in range(k):
        a = die.randrange(2, n - 1)
        if not single_test(n, a):
            return False
            
    return True
    

def gen_prime(bits):
    startTime = time.time()
    while True:
        # Guarantees that a is odd.
        a = (die.randrange(1 << bits - 1, 1 << bits) << 1) + 1
        if miller_rabin(a):
            print(f"Completed in {time.time() - startTime} seconds.")
            return a
            
if __name__ == "__main__":
    print(miller_rabin(5811223068218817380677271643908200031029))