function Ry = rotate_y(theta_y)
  theta_y = deg2rad(theta_y);

  Ry = [ cos(theta_y),  0, sin(theta_y),  0 ;
                    0,  1,            0,  0 ;
        -sin(theta_y),  0, cos(theta_y),  0 ;
                    0,  0,            0,  1];
end
