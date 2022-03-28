module MD
using PyPlot
#export testRun, simulate

include("types.jl")
include("state.jl")
include("physics.jl")
include("crystal.jl")
include("plotting.jl")

function traceEnergy(particles, neList, nList, Δt, boundary, N, cutoff, flag)
	eTrace = Array(Float64, 0)
	pTrace = Array(Float64, 0)
	kTrace = Array(Float64, 0)
	for i = 1:N
		timeStep!(particles, neList, nList, Δt, boundary, cutoff)
		push!(eTrace, sumTotalEnergy(particles, neList, nList, boundary))
		push!(pTrace, sumPotentialEnergy(particles, neList, nList, boundary))
		push!(kTrace, sumKineticEnergy(particles))
	end
	scala = linspace(0,1,N)
	if (flag == "PE")
		plot(scala, pTrace)
		legend([flag])
	elseif(flag == "KE")
		plot(scala, kTrace)
		legend([flag])
	elseif(flag == "TE")
		plot(scala, eTrace)
		legend([flag])
	else
		plot(scala, eTrace, scala, pTrace, scala, kTrace)
		legend([["TE"],["PE"],["KE"]])		
	end
end
function traceEnergy!(bundle::Bundle, flag::Flags)
	particles = bundle.particles
	eTrace = Array(Float64, 0)
	pTrace = Array(Float64, 0)
	kTrace = Array(Float64, 0)
	for i = 1:N
		timeStep!(particles, neList, nList, Δt, boundary, cutoff)
		push!(eTrace, sumTotalEnergy(particles, neList, nList, boundary))
		push!(pTrace, sumPotentialEnergy(particles, neList, nList, boundary))
		push!(kTrace, sumKineticEnergy(particles))
	end
	scala = linspace(0,1,N)
	if (flag == "PE")
		plot(scala, pTrace)
		legend([flag])
	elseif(flag == "KE")
		plot(scala, kTrace)
		legend([flag])
	elseif(flag == "TE")
		plot(scala, eTrace)
		legend([flag])
	else
		plot(scala, eTrace, scala, pTrace, scala, kTrace)
		legend([["TE"],["PE"],["KE"]])		
	end
end

function followParticle(particles, neList, nList, Δt, boundary, N, cutoff)
	xTrace = zeros(0)
	yTrace = zeros(0)
	zTrace = zeros(0)
	for i = 1:N
		(particles, neList, nList) = timeStep(particles, neList, nList, Δt, boundary, cutoff)
		push!(xTrace, particles[1].rd[1])
		push!(yTrace, particles[1].rd[2])
		push!(zTrace, particles[1].rd[3])
	end
	scala = linspace(0,1,N)
	plot(scala, xTrace, scala, yTrace, scala, zTrace)
end

end
#=function simulate(b, f)
	if(f.doPlot ==)
		eTrace
	elseif

	elseif

	end

	(b.neList, b.nList) = neighborList(b.particles,f.cutoff,b.boundary)
	for i = 1:f.N
		for u = 1:f.Nsam
			(particles, neList, nList) = timeStep(particles, neList, nList, Δt, boundary, cutoff)
		end
		
	end
end

function timeStep(particles, neList, nList, Δt, boundary, cutoff)
	(particles, neList, nList) = VerletAlgorithm(particles, neList, nList, Δt, boundary)
	evalBoundary!(particles, boundary)	
	(neList, nList) = neighborList(particles, cutoff, boundary)	
	return particles, neList, nList
end

TODO
function loadSystem
function loadBundle
=#
