#Test code
#-------------------------------------------------------------------------------

using CppSimData

#No real test code yet... just demonstrate use:

testfile = "test.tr0"
println("\nLoad test file:")
reader = loadsig(joinpath(CppSimData.rootpath, "core/data", testfile))
@show reader

println("\nRead in list of signal names:")
@show lssig(reader)

signame = "TIME"
println("\nRead in $signame vector:")
t = evalsig(reader, signame)
@show t[1], t[end]

:Test_Complete
