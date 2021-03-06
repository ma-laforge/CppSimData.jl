# CppSimData.jl

**DEPRECATED:**  Use <https://github.com/ma-laforge/SpiceData.jl>.

## Description

The CppSimData.jl module provides a Julia interface for Michael H. Perrott's .tr0 reader. The module [core](core/) is composed from parts of a Beta version of "CppSim and NGspice Data Modules for Python".

## Sample Usage

Examples on how to use the CppSimData.jl capabilities can be found under the [test directory](test/).

<a name="Installation"></a>
## Installation

		julia> Pkg.clone("https://github.com/ma-laforge/CppSimData.jl.git")

## Resources/Acknowledgments

### CppSim and NGspice Data Modules for Python

The following are links to Michael H. Perrott's original tools:

 - **CppSim**: <http://www.cppsim.com/index.html>.
 - **Hspice Toolbox**: <http://www.cppsim.com/download_hspice_tools.html>.

## Known Limitations

### Compatibility

Extensive compatibility testing of CppSimData.jl has not been performed.  The module has been tested using the following environment(s):

 - Linux / Julia-1.1.1 (64-bit)

## Disclaimer

This software is provided "as is", with no guarantee of correctness.  Use at own risk.
