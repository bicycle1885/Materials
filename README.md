# Materials

[![Build Status](https://travis-ci.org/bicycle1885/Materials.jl.svg?branch=master)](https://travis-ci.org/bicycle1885/Materials.jl)

[![Coverage Status](https://coveralls.io/repos/bicycle1885/Materials.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/bicycle1885/Materials.jl?branch=master)

[![codecov.io](http://codecov.io/github/bicycle1885/Materials.jl/coverage.svg?branch=master)](http://codecov.io/github/bicycle1885/Materials.jl?branch=master)

```julia
julia> Materials.materialize(Materials)
INFO: materializing P53
INFO: materializing primes

julia> using Materials

julia> @material Materials P53
INFO: load P53 as String

julia> P53
"/Users/kenta/.julia/v0.6/Materials/materials/P04637.fasta"

help?> P53
search:

  A FASTA file that contains a protein sequence of human tumor antigen protein p53.

julia> @material Materials primes
INFO: load primes as 10000-element Array{Int64,1}

julia> primes[1:10]
10-element Array{Int64,1}:
  2
  3
  5
  7
 11
 13
 17
 19
 23
 29

help?> primes
search: airyprime reprmime airybiprimex airybiprime airyaiprimex airyaiprime

  The first 10,000 prime numbers.

```
