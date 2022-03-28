function distance(pcl_1, pcl_2, boundary::Boundary)
	Δ = pcl_2.rd - pcl_1.rd
	Δx = pcl_2.rd[1] - pcl_1.rd[1]
	Δy = pcl_2.rd[2] - pcl_1.rd[2]
	Δz = pcl_2.rd[3] - pcl_1.rd[3]
	#check for ****
	if Δx ≥ boundary.wx/2
		Δx -= boundary.wx
	elseif Δx < -boundary.wx/2
		Δx += boundary.wx
	end
	if Δy ≥ boundary.wy/2
		Δy -= boundary.wy
	elseif Δy < -boundary.wy/2
		Δy += boundary.wy
	end
	if Δz ≥ boundary.wz/2
		Δz -= boundary.wz	
	elseif Δz < -boundary.wz/2
		Δz += boundary.wz
	end
	return [Δx,Δy,Δz]
end

function neighborList!(nList, neList, particles, cutoff, boundary::Boundary)
	empty!(nList)
	empty!(neList)
	for (ix_m, me) in enumerate(particles)
	push!(nList, 0)
		for (ix_f, friend) in enumerate(particles)
			if me ≠ friend
				#calculate distances	
				s = distance(me, friend, boundary)	 	
				sabs = sqrt(dot(s, s))
				if sabs < cutoff
					nList[ix_m] += 1
					push!(neList, ix_f)
				end
			end
		end
	end
end

function evalBoundary!(particles, boundary::Boundary)
	minx = boundary.origin[1] - boundary.wx/2
	miny = boundary.origin[2] - boundary.wy/2
	minz = boundary.origin[3] - boundary.wz/2
	maxx = boundary.origin[1] + boundary.wx/2
	maxy = boundary.origin[2] + boundary.wy/2
	maxz = boundary.origin[3] + boundary.wz/2
	for particle in particles
		if particle.rd[1] ≥ maxx
			particle.rd[1] -= boundary.wx
		elseif particle.rd[1] < minx
			particle.rd[1] += boundary.wx
		end
		if particle.rd[2] ≥ maxy
			particle.rd[2] -= boundary.wy	
		elseif particle.rd[2] < miny
			particle.rd[2] += boundary.wy
		end
		if particle.rd[3] ≥ maxz
			particle.rd[3] -= boundary.wz	
		elseif particle.rd[3] < minz
			particle.rd[3] += boundary.wz
		end
	end
end

function omitDuplicates!(particles::Array)
	tagList = Array(Int64,0)
	i = 1
	while true
		y = i
		while true
			if y != i && particles[y].rd == particles[i].rd
				push!(tagList, y)
				deleteat!(particles,y)
				y -= 1
				#println(endof(particles))
			end
			y += 1
			if y > endof(particles)
				break
			end
		end
		i += 1
		if i > endof(particles)
			break
		end
	end
end

function sumKineticEnergy(particles)
	KE = 0.0
	for f in particles
		KE += 0.5*dot(f.rv, f.rv)
	end
	return KE
end

function sumPotentialEnergy(particles, neList, nList, boundary)
	PE = 0.0
	cursor = 1
	for (id_f, f) in enumerate(particles)
		for i = 1:nList[id_f]
			r = distance(f,particles[neList[cursor]], boundary)
			rabs = sqrt(dot(r,r))
			PE += 4 * (rabs^-12 + rabs^-6)
			cursor += 1
		end
	end
	return PE
end

function sumTotalEnergy(particles, neList, nList, boundary)
	TE = sumKineticEnergy(particles) + sumPotentialEnergy(particles, neList, nList, boundary)
	return TE
end

#=
TODO
function MDF(particles)
	for f in particles
		distances = f.rd

	plot
=#

