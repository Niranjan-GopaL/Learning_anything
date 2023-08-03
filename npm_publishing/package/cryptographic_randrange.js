
import crypto from 'crypto';

// [ min, max )
export const  getRandomNumberInRange = (min, max) => {
    const range = max - min + 1;
    const randomBytes = crypto.randomBytes(4); // 4 bytes = 32 bits
    const randomValue = randomBytes.readUInt32LE(0); // Convert bytes to a 32-bit integer

    return min + (randomValue % range);
}





