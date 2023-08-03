from numpy import ndarray
from math import isqrt


def pritchard(limit):
    """ Pritchard sieve of primes up to limit """

    members = ndarray(limit + 1, dtype=bool)
    members.fill(False)
    members[1] = True
    steplength, prime, rtlim, nlimit = 1, 2, isqrt(limit), 2
    primes = []
    while prime <= rtlim:
        if steplength < limit:
            for w in range(1, len(members)):
                if members[w]:
                    n = w + steplength
                    while n <= nlimit:
                        members[n] = True
                        n += steplength
            steplength = nlimit

        np = 5
        mcpy = members.copy()
        for w in range(1, len(members)):
            if mcpy[w]:
                if np == 5 and w > prime:
                    np = w
                n = prime * w
                if n > nlimit:
                    break  # no use trying to remove items that can't even be there
                members[n] = False  # no checking necessary now

        if np < prime:
            break
        primes.append(prime)