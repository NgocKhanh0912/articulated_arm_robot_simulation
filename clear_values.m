function Clear_Values(handles)

    global trajectory_points;
    trajectory_points = [];

    % Reset graph
    axes(handles.theta_1_v_axes); 
    cla;
    axes(handles.theta_2_v_axes); 
    cla;
    axes(handles.theta_3_v_axes); 
    cla;

    % Reset values
    set(handles.theta_1_response, 'String', 0);
    set(handles.theta_2_response, 'String', 0);
    set(handles.theta_3_response, 'String', 0);

    set(handles.theta1_response_value, 'String', 0);
    set(handles.theta2_response_value, 'String', 0);
    set(handles.theta3_response_value, 'String', 0);

    set(handles.x_response_value, 'String', 1000);
    set(handles.y_response_value, 'String', 0);
    set(handles.z_response_value, 'String', 500);

    % Reset Robot
    draw_robot_form(handles);

end
