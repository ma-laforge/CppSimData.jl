#CppSimData show functions
#-------------------------------------------------------------------------------

function Base.show(io::IO, r::DataReader)
	print(io, "DataReader($(r.filename), nsig=$(r.nsig), npts=$(r.npts))")
end

#Last line
