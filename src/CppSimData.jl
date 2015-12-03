#CppSimData: A Julia wrapper for CppSimData tools
#-------------------------------------------------------------------------------
module CppSimData

const rootpath = realpath(joinpath(dirname(realpath(@__FILE__)),"../."))
const libroot = joinpath(rootpath, "core/lib")

#TODO: is Sys.ARCH a supported feature??
const objfile = joinpath(libroot,
@windows? (joinpath(:x86_64 == Sys.ARCH?"win64":"win32", "cppsimdata_lib.dll")
):@osx? (joinpath("macosx", "cppsimdata_lib.so")
): joinpath(:x86_64 == Sys.ARCH?"glnxa64":"glnx86", "cppsimdata_lib.so")
)
#else: error("OS not supported: ", Sys.OS_NAME))??

include("base.jl")
include("show.jl")

initialize() #Initialize CppSimData module

export loadsig, lssig, evalsig

end #CppSimData
#Last line
