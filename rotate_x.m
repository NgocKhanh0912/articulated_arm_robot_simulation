function Rx = rotate_x(theta_x)
  theta_x = deg2rad(theta_x);

  Rx = [1,            0,             0,  0  ;
        0, cos(theta_x), -sin(theta_x),  0  ;
        0, sin(theta_x),  cos(theta_x),  0  ;
        0,            0,             0,  1 ];
end
