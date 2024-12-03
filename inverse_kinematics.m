function Inverse_Kinematics(handles, X, Y, Z)

  axes(handles.robot_axes);
  
  d1 = 500.0; 
  a2 = 500.0; 
  a3 = 500.0; 

  theta1 = atan2(Y, X);
  
  r = sqrt(X^2 + Y^2);
  
  z_effective = Z - d1;
  
  c3 = (r^2 + z_effective^2 - a2^2 - a3^2) / (2 * a2 * a3);
  s3 = -sqrt(1 - c3^2);
  theta3 = atan2(s3, c3); 
  
  A = a2 + a3 * c3;
  B = a3 * s3;

  c2 = (r * A + B * z_effective) / (A^2 + B^2);
  s2 = (z_effective * A - B * r) / (A^2 + B^2);
  theta2 = atan2(z_effective, r) - atan2(B, A);

  set(handles.x_response_value, 'String', num2str(X));
  set(handles.y_response_value, 'String', num2str(Y));
  set(handles.z_response_value, 'String', num2str(Z));

  set(handles.theta1_response_value, 'String', num2str(rad2deg(theta1)));
  set(handles.theta2_response_value, 'String', num2str(rad2deg(theta2)));
  set(handles.theta3_response_value, 'String', num2str(rad2deg(theta3)));
  
  draw_robot(theta1, theta2, theta3);
  
end
