function Plot_Robot_Information(handles)

  robot_information_image = imread('robot_information.jpg'); 

  axes(handles.robot_information_axes);  
  imshow(robot_information_image);
  axis image; 
  axis off;

end
