function Rz = rotate_z(theta_z)
  theta_z = deg2rad(theta_z);

  Rz = [cos(theta_z), -sin(theta_z),  0,  0 ;
        sin(theta_z),  cos(theta_z),  0,  0 ;
                   0,             0,  1,  0 ;
                   0,             0,  0,  1];
    
end
