function Inverse_LSPB(handles, X, Y, Z)

    axes(handles.theta_1_v_axes); 
    cla;
    axes(handles.theta_2_v_axes); 
    cla;
    axes(handles.theta_3_v_axes); 
    cla;

    d1 = 500.0; 
    a2 = 500.0; 
    a3 = 500.0; 

    X_start = 1000; 
    Y_start = 0; 
    Z_start = 500;

    theta1_start = atan2(Y_start, X_start);
    r_start = sqrt(X_start^2 + Y_start^2);
    z_effective_start = Z_start - d1;

    c3_start = (r_start^2 + z_effective_start^2 - a2^2 - a3^2) / (2 * a2 * a3);
    s3_start = -sqrt(1 - c3_start^2);
    theta3_start = atan2(s3_start, c3_start);

    A_start = a2 + a3 * c3_start;
    B_start = a3 * s3_start;
    theta2_start = atan2(z_effective_start, r_start) - atan2(B_start, A_start);

    theta1_end = atan2(Y, X);
    r_end = sqrt(X^2 + Y^2);
    z_effective_end = Z - d1;

    c3_end = (r_end^2 + z_effective_end^2 - a2^2 - a3^2) / (2 * a2 * a3);
    s3_end = -sqrt(1 - c3_end^2);
    theta3_end = atan2(s3_end, c3_end);

    A_end = a2 + a3 * c3_end;
    B_end = a3 * s3_end;
    theta2_end = atan2(z_effective_end, r_end) - atan2(B_end, A_end);

    q_max1 = theta1_end - theta1_start;
    q_max2 = theta2_end - theta2_start;
    q_max3 = theta3_end - theta3_start;

    % If values have not been set, robot will use this values:
    T_a1 = 3; 
    T_a2 = 3; 
    T_a3 = 3; 

    T_c1 = 6; 
    T_c2 = 6; 
    T_c3 = 6; 

    % Values from UI
    v_max_from_ui = str2double(get(handles.lspb_v_max_value, 'String'));
    a_max_from_ui = str2double(get(handles.lspb_a_max_value, 'String'));

    if ((v_max_from_ui ~= 0) && (a_max_from_ui ~= 0))
        T_a1 = abs(v_max_from_ui / a_max_from_ui);
        T_a2 = abs(v_max_from_ui / a_max_from_ui);
        T_a3 = abs(v_max_from_ui / a_max_from_ui);

        T_c1 = abs((abs(rad2deg(q_max1)) - abs(a_max_from_ui) * T_a1^2)) / abs(v_max_from_ui);
        T_c2 = abs((abs(rad2deg(q_max2)) - abs(a_max_from_ui) * T_a2^2)) / abs(v_max_from_ui);
        T_c3 = abs((abs(rad2deg(q_max3)) - abs(a_max_from_ui) * T_a3^2)) / abs(v_max_from_ui);
    end

    T1 = 2 * T_a1 + T_c1; 
    T2 = 2 * T_a2 + T_c2; 
    T3 = 2 * T_a3 + T_c3; 

    a_max1 = compute_a_max(q_max1, T_a1, T_c1);
    a_max2 = compute_a_max(q_max2, T_a2, T_c2);
    a_max3 = compute_a_max(q_max3, T_a3, T_c3);

    v_max1 = compute_v_max(q_max1, T_a1, T_c1);
    v_max2 = compute_v_max(q_max2, T_a2, T_c2);
    v_max3 = compute_v_max(q_max3, T_a3, T_c3);

    num_points = 50;
    t1 = linspace(0, T1, num_points);
    t2 = linspace(0, T2, num_points);
    t3 = linspace(0, T3, num_points);
    theta_position = zeros(num_points, 3);

    for i = 1:num_points
        theta_position(i, 1) = compute_lspb_trajectory(t1(i), T_a1, T_c1, T1, q_max1, v_max1, a_max1, theta1_start, theta1_end);
        theta_position(i, 2) = compute_lspb_trajectory(t2(i), T_a2, T_c2, T2, q_max2, v_max2, a_max2, theta2_start, theta2_end);
        theta_position(i, 3) = compute_lspb_trajectory(t3(i), T_a3, T_c3, T3, q_max3, v_max3, a_max3, theta3_start, theta3_end);
    end

    theta1_velocity = zeros(num_points, 1);
    theta2_velocity = zeros(num_points, 2);
    theta3_velocity = zeros(num_points, 3);
    for i = 2:num_points
        if t1(i) <= T_a1
            theta1_velocity(i) = a_max1 * t1(i);
        elseif t1(i) <= T1 - T_a1
            theta1_velocity(i) = v_max1;
        else
            theta1_velocity(i) = v_max1 - a_max1 * (t1(i) - T_a1 - T_c1);
        end

        if t2(i) <= T_a2
            theta2_velocity(i) = a_max2 * t2(i);
        elseif t2(i) <= T2 - T_a2
            theta2_velocity(i) = v_max2;
        else
            theta2_velocity(i) = v_max2 - a_max2 * (t2(i) - T_a2 - T_c2);
        end

        if t3(i) <= T_a3
            theta3_velocity(i) = a_max3 * t3(i);
        elseif t3(i) <= T3 - T_a3
            theta3_velocity(i) = v_max3;
        else
            theta3_velocity(i) = v_max3 - a_max3 * (t3(i) - T_a3 - T_c3);
        end
    end

    current_X = zeros(num_points, 1);
    current_Y = zeros(num_points, 1);
    current_Z = zeros(num_points, 1);

    for i = 1:num_points
        axes(handles.robot_axes);
        draw_robot(theta_position(i, 1), theta_position(i, 2), theta_position(i, 3));

        set(handles.theta1_response_value, 'String', num2str(rad2deg(theta_position(i, 1))));
        set(handles.theta2_response_value, 'String', num2str(rad2deg(theta_position(i, 2))));
        set(handles.theta3_response_value, 'String', num2str(rad2deg(theta_position(i, 3))));

        % Calculate current position
        r = a2 * cos(theta_position(i, 2)) + a3 * cos(theta_position(i, 2) + theta_position(i, 3));
        current_X(i) = r * cos(theta_position(i, 1));
        current_Y(i) = r * sin(theta_position(i, 1));
        current_Z(i) = d1 + a2 * sin(theta_position(i, 2)) + a3 * sin(theta_position(i, 2) + theta_position(i, 3));

        set(handles.x_response_value, 'String', num2str(current_X(i)));
        set(handles.y_response_value, 'String', num2str(current_Y(i)));
        set(handles.z_response_value, 'String', num2str(current_Z(i)));

        axes(handles.theta_1_v_axes);
        plot(t1(1:i), rad2deg(theta1_velocity(1:i)), 'LineWidth', 2);
        grid on;
        xlabel('Time (s)');
        ylabel('Angular Velocity (degree/s)');
        title('Theta 1 Angular Velocity');

        axes(handles.theta_2_v_axes);
        plot(t2(1:i), rad2deg(theta2_velocity(1:i)), 'LineWidth', 2);
        grid on;
        xlabel('Time (s)');
        ylabel('Angular Velocity (degree/s)');
        title('Theta 2 Angular Velocity');

        axes(handles.theta_3_v_axes);
        plot(t3(1:i), rad2deg(theta3_velocity(1:i)), 'LineWidth', 2);
        grid on;
        xlabel('Time (s)');
        ylabel('Angular Velocity (degree/s)');
        title('Theta 3 Angular Velocity');

        pause(0.005);
    end

    set(handles.x_response_value, 'String', num2str(X));
    set(handles.y_response_value, 'String', num2str(Y));
    set(handles.z_response_value, 'String', num2str(Z));
end

function a_max = compute_a_max(q_max, T_a, T_c)
    a_max = q_max / (T_a * (T_a + T_c));
end

function v_max = compute_v_max(q_max, T_a, T_c)
    v_max = q_max / (T_a + T_c);
end

function theta = compute_lspb_trajectory(t, T_a, T_c, T, q_max, v_max, a_max, theta_start, theta_end)
    if t < T_a
        theta = theta_start + 0.5 * a_max * t^2;
    elseif t < T - T_a
        theta = theta_start + 0.5 * a_max * T_a^2 + v_max * (t - T_a);
    else
        theta = theta_start + 0.5 * a_max * T_a^2 + v_max * T_c + v_max * (t - (T_a + T_c)) - 0.5 * a_max * (t - (T_a + T_c))^2;
    end
end
