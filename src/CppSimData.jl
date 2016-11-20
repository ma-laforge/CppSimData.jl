#CppSimData: A Julia wrapper for CppSimData tools
#-------------------------------------------------------------------------------
module CppSimData

const rootpath = realpath(joinpath(dirname(realpath(@__FILE__)),"../."))
const libroot = joinpath(rootpath, "core/lib")

const objfilename = @static (
if is_windows()
	joinpath(:x86_64 == Sys.ARCH?"win64":"win32", "cppsimdata_lib.dll")
elseif is_apple()
	joinpath("macosx", "cppsimdata_lib.so")
elseif is_linux()
	joinpath(:x86_64 == Sys.ARCH?"glnxa64":"glnx86", "cppsimdata_lib.so")
else
	error("No compiled sources for $(Sys.KERNEL) ($(Sys.ARCH))")
end
)
const objfile = joinpath(libroot, objfilename)

include("base.jl")
include("show.jl")

initialize() #Initialize CppSimData module

export loadsig, lssig, evalsig

end #CppSimData
#Last line
