/*
    Implementation of Miler-Rabin Primality Test.

*/
import { expmod } from './pow_mod.js';
import { getRandomNumberInRange } from './cryptographic_randrange.js';



const is_prime = (n) => {   
    var exp = n - 1;

    var a = getRandomNumberInRange(2, n - 1)
    console.log(a)

    while (!(exp & 1)) {
        exp >>= 1;
        console.log(exp)
    }

    if ( expmod(a, exp, n) == 1) {
        return true;
    }

    while (exp < n - 1) {
        if (expmod(a, exp, n) == n - 1) {
            return true;
        }
        exp <<= 1;
    }
    
    return false
}



console.log(is_prime(421));