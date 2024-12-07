function [theta_1, theta_2, theta_3] = Inverse_Kinematics(X, Y, Z)

  d1 = 500.0; 
  a2 = 500.0; 
  a3 = 500.0; 

  theta_1 = atan2(Y, X);
  
  r = sqrt(X^2 + Y^2);
  
  z_effective = Z - d1;
  
  c3 = (r^2 + z_effective^2 - a2^2 - a3^2) / (2 * a2 * a3);
  s3 = -sqrt(1 - c3^2);
  theta_3 = atan2(s3, c3); 
  
  A = a2 + a3 * c3;
  B = a3 * s3;

  c2 = (r * A + B * z_effective) / (A^2 + B^2);
  s2 = (z_effective * A - B * r) / (A^2 + B^2);
  theta_2 = atan2(z_effective, r) - atan2(B, A);

end
