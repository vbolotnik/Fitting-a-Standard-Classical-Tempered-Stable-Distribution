function [ err ] = meanSqrDiff(X,THETA)

    I = sqrt(-1);
    
    % unpack parameter vector THETA
    alpha = THETA(1);
    lamPos = THETA(2);
    lamNeg = THETA(3);
    
    % create vector of u values.
    % du can be set to a smaller value for better precision, but slower
    % interations
    
    du = 0.1;
    span = -2*pi:du:2*pi;
    n = length(span);
    
    % define emperical/sample CF
    ecm = @(u)mean(exp(I*u*X));
    
    % define theoretical CF using stdCTS_CF.m
    cf = @(u) stdCTS_CF(u,alpha,lamPos,lamNeg);
    
    % preallocate error vector
    diff = zeros(1,n);
    
    % calculate square differences/errors of real values between ecf and cf
    for u = 1:n
        evalAt = span(u);
        diff(u) = (real(ecm(evalAt))-real(cf(evalAt)))^2;
    end
    
    % return mean square error
    err = mean(diff);
end
