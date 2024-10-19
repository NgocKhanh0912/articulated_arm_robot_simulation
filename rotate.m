function R = Rotate(theta)

     c = cos(theta); 
     s = sin(theta); 
    
     R = [c, -s, 0 ,0;
          s,  c, 0, 0;
          0,  0, 1, 0;
          0,  0, 0, 1];
end

