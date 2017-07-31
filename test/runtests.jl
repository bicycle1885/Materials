using Materials
using Base.Test

@testset "Materialize" begin
    @test Materials.materialize(Materials) === nothing
end

@testset "Material" begin
    @test isfile(material(Materials, "P53"))
    @material Materials P53
    @test P53 isa String
    @test isfile(P53)

    @material Materials primes
    @test primes isa Vector{Int}
    @test length(primes) == 10_000
end
