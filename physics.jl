function setRandomVel!(particle, mul=1)
	for i=1:length(particle)
		particle[i].rv = mul*rand(3)
	end
end

function setZeroVel!(particle)
	for i=1:length(particle)
		particle[i].rv = [0.0,0.0,0.0]
	end
end

function setZeroAcc!(particle)
	for i=1:length(particle)
		particle[i].ra = [0.0,0.0,0.0]
	end
end

#updates particle(s) acceleration
function lennardJones!(particle::Array, neList, nList, dList)
	cursor = 1 #for probing through neighbor list
	for (id_k, k) in enumerate(particle)
		k.ra = [0,0,0]
		for i = 1:nList[id_k]
			#r = distance(k,particle[neList[cursor]], boundary) 
			r = dList[cursor]
			rabs = sqrt(dot(r, r))
			r = r/rabs
			k.ra += 48 * (rabs^-14 - 0.5*rabs^-8) * -r
			cursor += 1
		end
	end	
end

function timeStep!(particles, neList, nList, dList, Δt, boundary, cutoff)
	#update V-D -> 0.5chro
	for sample in particles
		sample.rv = sample.rv + 0.5*Δt*sample.ra
		sample.rd = sample.rd + Δt*sample.rv
	end
	evalBoundary!(particles, boundary)	
	neighborList!(nList, neList, dList, particles, cutoff, boundary)	
	lennardJones!(particles, neList, nList, dList)
	for sample in particles
		sample.rv = sample.rv + 0.5*Δt*sample.ra
	end
end

