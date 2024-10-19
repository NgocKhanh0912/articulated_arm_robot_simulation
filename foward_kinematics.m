function yaw = Foward_Kinematics(theta_1, theta_2, theta_3)

  d1 = 100;
  d2 = 0;
  d3 = 0;
  
  a1 = 0;
  a2 = 50;
  a3 = 50;
  
  alpha1 = pi/2;
  alpha2 = 0;
  alpha3 = 0;
  
  T0_1 = DH_Matrix(d1,  theta_1,  a1,   alpha1);
  T1_2 = DH_Matrix(d2,  theta_2,  a2,   alpha2);
  T2_3 = DH_Matrix(d3,  theta_3,  a3,   alpha3);

  T0_2 = T0_1 * T1_2;
  T0_3 = T0_2 * T2_3;

  cal_R_P_Y = Caculate_R_P_Y(T0_3(1:3,1:3));
  
  yaw = deg2rad(cal_R_P_Y(3));

end