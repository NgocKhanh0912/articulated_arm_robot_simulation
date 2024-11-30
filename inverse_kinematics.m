function Inverse_Kinematics(X, Y, Z)

  d1 = 500.0; 
  a2 = 500.0; 
  a3 = 500.0; 

  theta1 = atan2(Y, X);
  
  r = sqrt(X^2 + Y^2);
  
  z_effective = Z - d1;
  
  c2 = (r^2 + z_effective^2 - a2^2 - a3^2) / (2 * a2 * a3);
  s2 = sqrt(1 - c2^2);
  theta3 = atan2(s2, c2); 
  
  k1 = a2 + a3 * c2;
  k2 = a3 * s2;
  theta2 = atan2(z_effective, r) - atan2(k2, k1);
  
  draw_robot(theta1, theta2, theta3);
  
end
