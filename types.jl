type Particle
	rd::Vector
	rv::Vector
	ra::Vector
	mass
end

Particle(dis::Vector) = Particle(dis, [0.0,0.0,0.0], [0.0,0.0,0.0], 1)
Particle(dis::Vector, vel::Vector) = Particle(dis, vel, [0.0,0.0,0.0], 1)
Particle(dis::Vector, vel::Vector, acc::Vector) = Particle(dis, vel, acc, 1)
Particle(x::Float64,y::Float64,z::Float64) = Particle([x,y,z])

type Boundary
	origin::Vector
	wx::Float64
	wy::Float64
	wz::Float64
end

Boundary(origin, s) = Boundary(origin, s, s, s)

type Bundle
	nList::Union(Array{Int64, 1}, Int64)
	neList::Union(Array{Int64, 1}, Int64)
	particles::Particle
	boundary::Boundary
end

type Flags
	cutoff::Float64
	ensemble::String
	dyn::String
	N::Int64
	doPlot::Bool
end
