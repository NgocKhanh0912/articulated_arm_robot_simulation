function Draw_Robot(theta1, theta2, theta3)

  global trajectory_points;

  if isempty(trajectory_points)
      trajectory_points = [];
  end

  cla;
  hold on;

  d1 = 500.0; 
  a2 = 500.0; 
  a3 = 500.0; 

  % Forward Kinematics matrices
  T0_1 = dh_matrix(d1,  theta1, 0 , pi/2);
  T1_2 = dh_matrix(0,   theta2, a2, 0   );
  T2_3 = dh_matrix(0,   theta3, a3, 0   );

  T0_2 = T0_1 * T1_2;
  T0_3 = T0_2 * T2_3;

  effector_position = T0_3(1:3, 4)';
  trajectory_points = [trajectory_points; effector_position];

  if size(trajectory_points, 1) > 1
      plot3(trajectory_points(:, 1), trajectory_points(:, 2), trajectory_points(:, 3), ...
            'r-', 'LineWidth', 2); % Đường liên tục
  end

  plot3(effector_position(1), effector_position(2), effector_position(3), ...
        'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');

  draw_base();

  % Joint 1
  h_joint1 = 300;
  n = 10000;

  [X, Y, Z] = cylinder(80, n);
  Z = Z * h_joint1;
  Z = Z - h_joint1 / 2;

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = T0_1 * A;
  B_new = T0_1 * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  surf(X, Y, Z, 'EdgeColor', [0, 0, 255]/255); 
  
  hold("on");

  fill3(X(1, :), Y(1, :), Z(1, :), [0, 0, 255]/255); 
  fill3(X(2, :), Y(2, :), Z(2, :), [0, 0, 255]/255); 
  hold("on");

  % Link 1
  h_link1 = 500;
  n = 10;

  [X, Y, Z] = cylinder(60, n);
  Z = Z * h_link1;
  Z = Z - h_link1;

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = rotate_y(90) * A;
  B_new = rotate_y(90) * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = T0_2 * A;
  B_new = T0_2 * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  surf(X, Y, Z, 'FaceColor', [0, 255, 255]/255); 
  fill3(X(1, :), Y(1, :), Z(1, :), [0, 255, 255]/255); 
  fill3(X(2, :), Y(2, :), Z(2, :), [0, 255, 255]/255); 

  % Joint 2
  h_joint2 = 300;
  n = 10000;

  [X, Y, Z] = cylinder(80, n);

  Z = Z * h_joint2;
  Z = Z - h_joint2 / 2;

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = T0_2 * A;
  B_new = T0_2 * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  surf(X, Y, Z, 'EdgeColor', [255, 0, 255]/255); 
  hold("on");

  fill3(X(1, :), Y(1, :), Z(1, :), [255, 0, 255]/255);
  fill3(X(2, :), Y(2, :), Z(2, :), [255, 0, 255]/255);
  hold("on");

  % Link 2
  h_link2 = 500;
  n = 10;

  [X, Y, Z] = cylinder(60, n);
  Z = Z * h_link2;
  Z = Z - h_link2;

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = rotate_y(90) * A;
  B_new = rotate_y(90) * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = T0_3 * A;
  B_new = T0_3 * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  surf(X, Y, Z, 'FaceColor', [255, 255, 0]/255); 
  fill3(X(1, :), Y(1, :), Z(1, :), [255, 255, 0]/255); 
  fill3(X(2, :), Y(2, :), Z(2, :), [255, 255, 0]/255); 

  % Effector 
  h_effector = 300;
  n = 10000;

  [X, Y, Z] = cylinder(80, n);

  Z = Z * h_effector;
  Z = Z - h_effector / 2;

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = rotate_x(90) * A;
  B_new = rotate_x(90) * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  A = [X(1,:); Y(1,:); Z(1,:); ones(1, size(X, 2))];
  B = [X(2,:); Y(2,:); Z(2,:); ones(1, size(X, 2))];

  A_new = T0_3 * A;
  B_new = T0_3 * B;

  X(1,:) = A_new(1,:);
  X(2,:) = B_new(1,:);
  Y(1,:) = A_new(2,:);
  Y(2,:) = B_new(2,:);
  Z(1,:) = A_new(3,:);
  Z(2,:) = B_new(3,:);

  surf(X, Y, Z, 'EdgeColor', [127, 127, 127]/255); 
  hold("on");

  fill3(X(1, :), Y(1, :), Z(1, :), [127, 127, 127]/255);
  fill3(X(2, :), Y(2, :), Z(2, :), [127, 127, 127]/255);
  hold("on");

  % Draw workspace
  r_workspace = 1100; 
  theta = linspace(0, 2*pi, 100); 
  x_workspace = r_workspace * cos(theta); 
  y_workspace = r_workspace * sin(theta); 
  z_workspace = zeros(size(x_workspace)); 

  plot3(x_workspace, y_workspace, z_workspace, 'k-', 'LineWidth', 1.5);
  hold on;

  % Title
  axis equal;
  xlabel('X-axis');
  ylabel('Y-axis');
  zlabel('Z-axis');

  grid on;
  view(3); 
  title('Articulated Arm');
  rotate3d on;

end
