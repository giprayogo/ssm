function scCrystal(nx, ny, nz, nullpoint=[0.0, 0.0, 0.0], dx = 1, dy = dx, dz = dy)
	points = Particle[]
	#basis
	a1 = [dx, 0.0, 0.0]
	a2 = [0.0, dy, 0.0]
	a3 = [0.0, 0.0, dz]
	for z = 1:nz
		for y = 1:ny
			for x = 1:nx
				coordinate = (x-1)*a1 + (y-1)*a2 + (z-1)*a3 + nullpoint
				push!(points, Particle(coordinate))
			end
		end
	end
	return points
end

function bccCrystal(nx, ny, nz, nullpoint=[0.0, 0.0, 0.0], dx = 1, dy = dx, dz = dy)
	edge = scCrystal(nx, ny, nz, nullpoint, dx, dy, dz)
	body = scCrystal(nx-1, ny-1, nz-1, nullpoint + dx/2, dx, dy, dz)
	return [edge, body]
end

function diAtom()
	points = [Particle(0.0,0.0,0.0), Particle(1.0,0.0,0.0)]
	return points
end
