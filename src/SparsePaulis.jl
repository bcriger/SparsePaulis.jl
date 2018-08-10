module SparsePaulis

# TODO - learn how to allow user to choose between Set and IntSet.

export SparsePauli

"""
For multiplying Paulis by complex numbers, we have a dict that
basically gives us the complex log: 

    const PHASES = Dict{Complex, UInt8}(1 => 0, im => 1, -1 => 2, -im => 3)
"""
const PHASES = Dict{Complex, UInt8}(1 => 0, im => 1, -1 => 2, -im => 3)

"""
Parametric type representing sparse Pauli operators on an unknown
number of qubits. Uses two sets internally, `x_set` and `z_set`, as
well as an integer between 0 and 3 which represents the phase. 

Written out, the entire n-qubit Pauli operator would look like this:

i^{`phase_int`} * prod_{j in `x_set`} X_j  * prod_{k in `z_set`} Z_j

Recommended reading: Dehaene and De Moor, PRA 2004 
"""
type SparsePauli{T}
    x_set::Set{T}
    z_set::Set{T}
    phase_int::UInt8
    function SparsePauli{T}(x_set::Set{T}, z_set::Set{T}, phase_int::Integer) where T
        new(x_set, z_set, UInt8(mod(phase_int, 4)))
    end #function 
end # type

function SparsePauli{T}(x_set::Set{T}, z_set::Set{T}) where T
    SparsePauli{T}(x_set, z_set, 0x00)
end #function 

function SparsePauli{T}() where T
    SparsePauli{T}(Set{T}([]), Set{T}([]))
end #function

SparsePauli() = SparsePauli{Any}()

"""
Spits out an X/Y/Z depending on what sets elem is a member of.

Note: I've decided that elem has to be the same type as the
referenced SparsePauli, for performance. 
"""    
function char(elem::T, pauli::SparsePauli{T}) where T
    if in(elem, pauli.x_set)
        return in(elem, pauli.z_set) ? 'Y' : 'X'
    else
        return in(elem, pauli.z_set) ? 'Z' : 'I'
    end #if
end #function

"""
Copies a SparsePauli by returning a new SparsePauli whose x_set, z_set
and phase_int are all `copy`d.
"""
function copy(pauli::SparsePauli{T}) where T
    SparsePauli{T}(copy(pauli.x_set), copy(pauli.z_set), copy(phase_int))
end #function

end # module
