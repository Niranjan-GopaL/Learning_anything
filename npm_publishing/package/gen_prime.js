import {is_prime} from './is_prime.js'
import { get_random_number_in_range } from './cryptographic_randrange.js';

const small_primes = [
    2n,
    3n,
    5n,
    7n,
    11n,
    13n,
    17n,
    19n,
    23n,
    29n,
    31n,
    37n,
    41n,
    43n,
    47n,
    53n,
    59n,
    61n,
    67n,
    71n,
    73n,
    79n,
    83n,
    89n,
    97n,
    101n,
    103n,
    107n,
    109n,
    113n,
    127n,
    131n,
    137n,
    139n,
    149n,
    151n,
    157n,
    163n,
    167n,
    173n,
    179n,
    181n,
    191n,
    193n,
    197n,
]


const get_random_odd_number = (d) => {
    const min = 10n ** (BigInt(d) - 1n); // Minimum value with d digits
    const max = (10n ** BigInt(d)) - 1n; // Maximum value with d digits

    let randomBigInt;
    
    while (1){

        randomBigInt = BigInt(get_random_number_in_range(min, max));
        for(const prime of small_primes){
            if(randomBigInt % prime === 0n){
                break;
            }
        }
        return randomBigInt;
    }
}



const gen_prime = (digit) => {
    var count = 0;
    while (true) {
        var odd = get_random_odd_number(digit);
        console.log(`Numbers checked : ${count}`)
        console.log(`odd numer generated : ${odd}`);
        if (is_prime(odd)) {
            return odd; 
        }
        count++;
    }
}   


console.log(gen_prime(600));