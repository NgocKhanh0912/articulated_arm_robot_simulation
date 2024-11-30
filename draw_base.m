function Draw_Base()

  % Rectangle shape
  xAB = linspace(-140, 70, 20);
  xBA = linspace(70, -140, 20);
  yDU = linspace(-90, 90, 20);
  yUD = linspace(90, -90, 20);

  num_points = length(yDU) + length(xAB) + length(yUD) + length(xBA);

  x = zeros(2, num_points);
  y = zeros(2, num_points);

  x(1,:) = [-140*ones(size(yDU)) xAB 70*ones(size(yUD)) xBA];
  x(2,:) = x(1,:);
  y(1,:) = [yDU 90*ones(size(xAB)) yUD -90*ones(size(xBA))];
  y(2,:) = y(1,:);

  z = ones(size(x));
  z(1,:) = 0;
  z(2,:) = 150;

  surf(x, y, z,'FaceColor', [255, 0, 0]/255);
  hold("on");

  fill3(x(2,:), y(2,:), z, [255, 0, 0]/255);
  hold("on");

  % Prismatic shape
  [X, Y, Z] = cylinder(60);
  Z(1,:) = 150;
  Z(2,:) = 500;

  surf(X, Y, Z,'FaceColor', [0, 255, 0]/255);
  hold("on");
  
  fill3(X(2,:), Y(2,:), Z, [0, 255, 0]/255);
  hold("on");
  
end