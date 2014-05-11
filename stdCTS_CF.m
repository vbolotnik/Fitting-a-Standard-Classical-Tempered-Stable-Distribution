function stdCTS = stdCTS_CF(u,alpha,lamPos,lamNeg)

    % function defines characteric function for std CTS distribution
    
    m = 0; % set location param to 0
    I = 1i;
    
    stdCTS = exp(I.*u*m-I.*u*(1/(gamma(2-alpha)*(lamPos^(alpha-2)+lamNeg^(alpha-2))))*...
            gamma(1-alpha)*(lamPos^(alpha-1)-lamNeg^(alpha-1))+(1/(gamma(2-alpha)*...
            (lamPos^(alpha-2)+lamNeg^(alpha-2))))*gamma(-alpha)*(((lamPos-I.*u).^alpha)-...
            lamPos^alpha+(lamNeg+I.*u).^alpha-lamNeg^alpha));


end
