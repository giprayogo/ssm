function plotParticles(particles::Array)
	for i = 1:length(particles)
		scatter3D(particles[i].rd[1], particles[i].rd[2], particles[i].rd[3],s=80)
	end
end

function humaneNeighborList(pcl, neighList, nList)
	cursor = 1
	for (id_k, k) in enumerate(nList)
		@printf("Neighbors of particle no: %d (%.3f, %.3f, %.3f)\n", id_k, pcl[id_k].rd[1], pcl[id_k].rd[2], pcl[id_k].rd[3])
		for iter = 1:nList[id_k]
			which = neighList[cursor]
			@printf("Particle no: %d, at (%.3f, %.3f, %.3f)\n", which, pcl[which].rd[1], pcl[which].rd[2], pcl[which].rd[3])
			cursor += 1
		end
		println()
	end
end 

function mdf(particles, neList, nList, boundary, max, div)
	cursor = 1
	sum = zeros(div,1)
	for (id_me,me) in enumerate(particles)
		for i = 1:nList[id_me]
			s = distance(me,particles[neList[cursor]],boundary)
			sabs = sqrt(dot(s,s))
			loci = floor((sabs/max)*div)
			sum[loci] += 1
			cursor += 1
		end
	end
	scala = linspace(0,max,div)
	plot(scala,sum)
end
				
#=function checkForce()
	points = [Particle([0,0,0]),
				Particle([1,0,0)]
	for r=1:0.05
		lennardJones!(points)=#
