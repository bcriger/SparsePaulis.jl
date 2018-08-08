module SparsePaulis

# TODO - learn how to allow user to choose between Set and IntSet.

type SparsePauli{T}
    x_set::Set{T}
    z_set::Set{T}
    phase_int::UInt8
end # type

SparsePauli{T}(x_set::Set{T}, z_set::Set{T}, phase_int::Integer = 0) = 
SparsePauli(x_set, z_set, UInt8(mod(phase_int, 4)))

SparsePauli() = SparsePauli(Set([]), Set([]))

end # module
