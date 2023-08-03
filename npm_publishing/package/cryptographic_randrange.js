// Cryptographic RNG
// import crypto from 'crypto';

// [ min, max )
// export const  get_random_number_in_range = (min, max) => {
//     const range = max - min + 1n;
//     const randomBytes = crypto.randomBytes(4); 
//     const randomValue = BigInt(randomBytes.readUInt32LE(0)); 
//     return min + (randomValue % range);
// }


export const get_random_number_in_range = (min, max) => {
    const range = max - min + 1n;
    let randomValue = '';

    for (let i = min.toString().length; i <= max.toString().length; i++) {
        const digit = Math.floor(Math.random() * 10); // Generate a random digit between 0 and 9
        randomValue += digit.toString();
    }

    return BigInt(randomValue) % range + min;
}