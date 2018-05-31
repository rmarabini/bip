function phm = pixelize(E, xVec, yVec);

[xGrid, yGrid] = meshgrid(xVec, yVec);
phm = zeros(size(xGrid));

for i = 1 : size(E, 1)
    x0 = E(i, 1);           % x offset
    y0 = E(i, 2);           % y offset
     a = E(i, 3);            % radius
  dens = E(i, 4);        % density
     x = xGrid - x0;
     y = yGrid - y0;
   idx = find(x.^2 + y.^2 < a^2);
   phm(idx) = phm(idx) + dens;
end