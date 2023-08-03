// Cryptographic RNG
import crypto from 'crypto';

// [ min, max )
export const  get_random_number_in_range = (min, max) => {
    const range = max - min + 1n;
    const randomBytes = crypto.randomBytes(4); 
    const randomValue = BigInt(randomBytes.readUInt32LE(0)); 
    return min + (randomValue % range);
}