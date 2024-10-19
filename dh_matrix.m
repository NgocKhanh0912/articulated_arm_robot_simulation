function [A] = DH_Matrix(d, theta, a, alpha)

    c = cos(theta); 
    s = sin(theta); 
    
    ca = cos(alpha);
    sa = sin(alpha);

    A = [c   -ca*s   sa*s   a*c; 
         s    c*ca  -sa*c   a*s;
         0    sa     ca     d ; 
         0    0      0      1];

end
