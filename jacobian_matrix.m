function J = Jacobian_Matrix(theta_1, theta_2, theta_3)

  d1 = 500.0; 
  a2 = 500.0; 
  a3 = 500.0; 
    
  % Forward Kinematics matrices
  T0_1 = dh_matrix(d1,  theta1, 0 , pi/2);
  T1_2 = dh_matrix(0,   theta2, a2, 0   );
  T2_3 = dh_matrix(0,   theta3, a3, 0   );

  T0_2 = T0_1 * T1_2;
  T0_3 = T0_2 * T2_3;
       
  p0 = [0; 0; 0];
  z0 = [0; 0; 1];
  
  p1 = T0_1(1:3, 4);
  z1 = T0_1(1:3, 3);
  
  p2 = T0_2(1:3, 4);
  z2 = T0_2(1:3, 3);
  
  pe = T0_3(1:3, 4);
  
  % Compute Jacobian
  Jv1 = cross(z0, (pe - p0));
  Jv2 = cross(z1, (pe - p1));
  Jv3 = cross(z2, (pe - p2));
  
  Jw = [z0, z1, z2];
  
  % Combine linear and angular velocity parts
  J = [Jv1, Jv2, Jv3;
            Jw     ];
        
end
