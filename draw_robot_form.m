function Draw_Robot_Form(handles)

  axes(handles.robot_axes);

  theta_1_begin = 0;
  theta_2_begin = 0;
  theta_3_begin = 0;

  draw_robot(theta_1_begin, theta_2_begin, theta_3_begin);
  
end