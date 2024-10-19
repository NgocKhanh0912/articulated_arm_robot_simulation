  xAB = linspace(-140, 70, 20);
  xBA = linspace(70, -140, 20);
  yDU = linspace(-90, 90, 20);
  yUD = linspace(90, -90, 20);

  % Base
  x(1,:) = [-140*ones(size(yDU)) xAB 70*ones(size(yUD)) xBA];
  x(2,:) = x(1,:);
  y(1,:) = [yDU 90*ones(size(xAB)) yUD -90*ones(size(xBA))];
  y(2,:) = y(1,:);

  z = ones(size(x));
  z(1,:) = 0;
  z(2,:) = 150;

  surf(x,y,z,'FaceColor',[255, 0, 0]/255);
  hold("on");

  fill3(x(2,:),y(2,:),z,[255, 0, 0]/255);
  hold("on");

  [X,Y,Z] = cylinder(60);
  Z(1,:) = 150;
  Z(2,:) = 500;
  surf(X,Y,Z,'FaceColor',[0, 255, 0]/255);
  hold("on");
  fill3(X(2,:),Y(2,:),Z,[0, 255, 0]/255);
  hold("on");

  % Link 1
  [X_1,Y_1,Z_1] = cylinder(80); 
  Z_1 = (Z_1 * 200) - 100;

  X_rot_1 = X_1;
  Z_rot_1 = Y_1;
  Y_rot_1 = Z_1;

  Z_rot_1 = Z_rot_1 + 500;

  surf(X_rot_1, Y_rot_1, Z_rot_1, 'FaceColor', [0, 0, 255]/255);
  hold on;

  fill3(X_rot_1(1,:), Y_rot_1(1,:), Z_rot_1(1,:), [0, 0, 255]/255);
  hold on;

  fill3(X_rot_1(2,:), Y_rot_1(2,:), Z_rot_1(2,:), [0, 0, 255]/255);
  hold on;

  % Link 2
  [X_2,Y_2,Z_2] = cylinder(60); 
  Z_2 = (Z_2 * 500);

  X_rot_2 = X_2;
  Z_rot_2 = Y_2;
  Y_rot_2 = Z_2;
  
  rotate = X_rot_2;
  X_rot_2 = Y_rot_2;
  Y_rot_2 = rotate;

  Z_rot_2 = Z_rot_2 + 500;

  surf(X_rot_2, Y_rot_2, Z_rot_2, 'FaceColor', [0, 255, 255]/255);
  hold on;

  fill3(X_rot_2(1,:), Y_rot_2(1,:), Z_rot_2(1,:), [0, 255, 255]/255);
  hold on;

  fill3(X_rot_2(2,:), Y_rot_2(2,:), Z_rot_2(2,:), [0, 255, 255]/255);
  hold on;

  % Link 3
  [X_3,Y_3,Z_3] = cylinder(80); 
  Z_3 = (Z_3 * 200) - 100;

  X_rot_3 = X_3 + 500;
  Z_rot_3 = Y_3;
  Y_rot_3 = Z_3;

  Z_rot_3 = Z_rot_3 + 500;

  surf(X_rot_3, Y_rot_3, Z_rot_3, 'FaceColor', [255, 0, 255]/255);
  hold on;

  fill3(X_rot_3(1,:), Y_rot_3(1,:), Z_rot_3(1,:), [255, 0, 255]/255);
  hold on;

  fill3(X_rot_3(2,:), Y_rot_3(2,:), Z_rot_3(2,:), [255, 0, 255]/255);
  hold on;

  % Link 4
  [X_4,Y_4,Z_4] = cylinder(60); 
  Z_4 = (Z_4 * 500);

  X_rot_4 = X_4;
  Z_rot_4 = Y_4;
  Y_rot_4 = Z_4;

  rotate = X_rot_4;
  X_rot_4 = Y_rot_4 + 500;
  Y_rot_4 = rotate;

  Z_rot_4 = Z_rot_4 + 500;

  surf(X_rot_4, Y_rot_4, Z_rot_4, 'FaceColor', [255, 255, 0]/255);
  hold on;

  fill3(X_rot_4(1,:), Y_rot_4(1,:), Z_rot_4(1,:), [255, 255, 0]/255);
  hold on;

  fill3(X_rot_4(2,:), Y_rot_4(2,:), Z_rot_4(2,:), [255, 255, 0]/255);
  hold on;

  % Effector 
  [X_5, Y_5, Z_5] = sphere; 

  surf(X_5 * 100 + 1000, Y_5 * 100, Z_5 * 100 + 500, 'FaceColor', [127, 127, 127]/255);
  hold on;

  % Title
  axis equal;
  xlabel('X-axis');
  ylabel('Y-axis');
  zlabel('Z-axis');
  grid on;
  view(3); 
  title('Articulated Arm');
