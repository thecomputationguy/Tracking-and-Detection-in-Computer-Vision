function [R, t] = lmOptimizer(A, R0, t0, iterations, updateThreshold)
    
    tx = t0(1);
    ty = t0(2);
    tz = t0(3);
    
    r = rotationMatrixToVector(R0); % parameterizing rotations with exponential maps
    
    rx = r(1);
    ry = r(2);
    rz = r(3);
    
    fu = A(1,1);
    fv = A(2,2);
    u0 = A(3,1);
    v0 = A(3,2);
    
    %r = R0;
    t = t0;
    
    % Calculating Derivatives using symbolic differentiation
    
    syms tx ty tz rx ry rz real % defining symbols for gradirnt calculation
    
    R = [rx ry rz];
    t = [tx ty tz];
    A = [fu 0 u0;
         0 fv v0;
         0 0 1];
    
    parameters = [R t];
    
    Jacobian = jacobian(energy, parameters); %Calculating gradients
    
    t = 0;
    lambda = 0.001;
    u = updateThreshold + 1;
    
    % Main loop of the LM Optimization
    
    while (t < iterations && u > updateThreshold)
        J = subs(Jacobian, parameters);
        error = energy(R, T, A, M, m);
        
        hessian = -(J * J) + lambda * ones(size(J * J));
        delta = -inv(hessian) * (J' * error);
        e_new = errorFunct(R + delta(8:10), t + delta(6:8), M, m);
        
        if e_new > e
            lambda = 10 * lambda;
        else
            lambda = lambda / 10;
            R = R + delta(8:10);
            t = t + delta(6:8);
        end
        
        u = norm(delta, 'fro');
        
        t = t + 1;
        
        if(t == 2 * iterations)
            disp("Algorithm Not Converging! Exiting");
            break;
        end
    end
end
    
    
    
    
    
              
              
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
    
    
    