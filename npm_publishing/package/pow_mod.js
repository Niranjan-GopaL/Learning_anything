// Modular Exponentiation (also known as exponentiation by squaring)
// https://en.wikipedia.org/wiki/Modular_exponentiation
export const expmod = (base, exp, mod) => {
    if (exp === 0n) return 1n;

    let result = 1n;
    base = base % mod;

    while (exp > 0n) {
        if (exp % 2n === 1n) {
            result = (result * base) % mod;
        }

        exp = exp / 2n;
        base = (base * base) % mod;
    }
    // console.log(`THIS IS result of mod ${result}`)
    return result;
};


// Fails for large numbers 
// export const expmod = ( base, exp, mod ) => {

//     if (exp == 0) return 1;

//     if (exp % 2 == 0){
//         return Math.pow( expmod( base, (exp / 2), mod), 2) % mod;
//     }
//     else {
//         return (base * expmod( base, (exp - 1), mod)) % mod;
//     }
// }