function [pdf,x] = stdCTS_pdf(alpha,lamPos,lamNeg)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Approximate the PDF using the inverse discrete Fourier Transform. 

% we use the Mid-Point approximation method described by Menn, Rachev (1)

%(1) Christian Menn and Svetlozar T. Rachev. Calibrated fft-based density 
%    approximations for alpha-stable distributions. Computational Statistics
%    and Data Analysis, 2006

% we set m = 13 and h ~ .01 as suggested by Stoyanov, Racheva-Iotova (2)

%(2) Stoyanov and B. Racheva-Iotova. Univariate stable laws in the field of
%    finance- approximations of density and distribution functions. Journal
%    of Concrete and Applicable Mathematics, 2005.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    I = 1i;
    
%error check: alpha cannot equal 1
      if alpha == 1
          alpha = 1.00001;
      end
      
% define CF

    PHI = @(u)stdCTS_CF(u,alpha,lamPos,lamNeg);

% descretise integral and perform FFT (see (1)) %%%%%%%%%%%%%%%%%%%%%%%%%%%

    m = 13; % see (2)
    N = 2^m;
    a = 41;
    h = 2*a/N; % see (2)

    t = @(j) -a+j.*h;
    x = @(k) -((N*pi)/(2*a))+(pi*k/a);
    tStar = @(j) 0.5*(t(j)+t(j+1));
    y = @(j)((-1).^j).*PHI(tStar(j));
    C = @(k) (2*a/N)*((-1).^k).*exp(-I*(pi/N).*k)*I;
    fHat = @(k) C(k).*fft(y(k),N);
    pdf = real(fHat(0:N-1))./(2*pi);
    x = x(0:N-1);
    
% return pdf approximation along with corresponding domain values

end
