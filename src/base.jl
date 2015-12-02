#CppSimData base types & core functions
#-------------------------------------------------------------------------------


#==Main types
===============================================================================#
type DataReader
	filename::ASCIIString
	msgbuf::Vector{UInt8}
	namebuf::Vector{UInt8}
	nsig::Int
	npts::Int
end
function DataReader(filename)
	result = DataReader(filename, Array(UInt8, 1000), Array(UInt8, 1000), 0, 0)
	result.msgbuf[1] = 0
	result.namebuf[1] = 0
	return result
end

#==Helper types
===============================================================================#
type CSTORAGE_INFO
   filename::Cstring
   num_sigs::Cint
   num_samples::Cint
end
#Danger: make sure filename does not risk garbage collection
#Solution: Initialized from DataReader (presuming it is referenced during duration of ccall)
CSTORAGE_INFO(r::DataReader) = CSTORAGE_INFO(pointer(r.filename), r.nsig, r.npts)

#const libref = Libdl.dlopen(objfile)
#initialize() = ccall(Libdl.dlsym(libref, :initialize), Cint, ())
initialize() = ccall((:initialize, objfile), Cint, ())
#initialize() = ccall((:initialize, "./cppsimdata_lib.so"), Cint, ())

function loadsig(filename::AbstractString)
	reader = DataReader(filename)
	info = CSTORAGE_INFO(reader)
	if ccall((:loadsig, objfile), Cint, (Ptr{CSTORAGE_INFO}, Ptr{UInt8}),
		pointer_from_objref(info), reader.msgbuf
	) != 0
		msg = bytestring(pointer(reader.msgbuf))
		error(msg)
	end
	reader.nsig = info.num_sigs
	reader.npts = info.num_samples
	return reader
end

function lssig(r::DataReader)
	result = ASCIIString[] #Always ASCIIString?
	err = ccall((:reset_cur_sig_count, objfile), Cint, ())
	info = CSTORAGE_INFO(r)
	for i in 1:r.nsig
		if ccall((:lssig, objfile), Cint, (Ptr{CSTORAGE_INFO}, Ptr{UInt8}, Ptr{UInt8}),
			pointer_from_objref(info), r.namebuf, r.msgbuf,
		) != 0
			msg = bytestring(pointer(r.msgbuf))
			error(msg)
		end
		signame = bytestring(pointer(r.namebuf))
		push!(result, signame)
	end
	return result
end

function evalsig(r::DataReader, signame::AbstractString)
	result = Array(Cdouble, r.npts)
	info = CSTORAGE_INFO(r)
	if ccall((:evalsig, objfile), Cint, (Ptr{CSTORAGE_INFO}, Cstring, Ptr{Cdouble}, Ptr{UInt8}),
		pointer_from_objref(info), signame, result, r.msgbuf,
	) != 0
		msg = bytestring(pointer(r.msgbuf))
		error(msg)
	end
	return result
end

#Last line
