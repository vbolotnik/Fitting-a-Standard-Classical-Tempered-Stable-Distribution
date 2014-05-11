% generate random sample %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = pearsrnd(0,1,.7,20,[1,1000]);
% pearsrnd(mean,variance,skew,kurt,[m,n])
% note: there is a skew and high kurtosis (normal kurt = 3)

%ksdensity(X)

% fit the theoretical cf to ecf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I = 1i;
% set initial values and package into THETA
lamPos_o = 20;
lamNeg_o = 100;
alpha_o = 1.4;
THETA_o = [alpha_o,lamPos_o,lamNeg_o];

% define objective function
obj = @(THETA) meanSqrDiff(X,THETA);

% set options, LB, UB for optimizer
options= optimoptions(@fmincon,'Display','iter','Algorithm','interior-point',...
        'MaxFunEvals',5000,'TolCon', 1e-20,'TolFun',1e-20,'TolX',1e-20);
LB = [0.01,0.01,0.01];
UB = [1.99,Inf,Inf];

%run optimizer
[optParam,diff] = fmincon(obj,THETA_o,[],[],[],[],LB,UB,[],options)

optParam

% plot ecf and fitted cf on one plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cf = red, ecf = blue
span = -2*pi:.1:2*pi;
n = length(span);

ecm = @(u)mean(exp(I*u*X));
alpha = optParam(1);
lamPos = optParam(2);
lamNeg = optParam(3);

cf = @(u) stdCTS_CF(u,alpha,lamPos,lamNeg);

vals_ecf = zeros(1,n);
vals_cf = zeros(1,n);

for u = 1:n
    evalAt = span(u);
    vals_ecf(u) = real(ecm(evalAt));
    vals_cf(u) = real(cf(evalAt));
end

plot(span,vals_ecf)
hold on
plot(span,vals_cf,'r')

% convert fitted cf into pdf via stdCTS_pdf.m function and plot against
% emperical density

[pdf,x]= stdCTS_pdf(alpha,lamPos,lamNeg);
plot(x,pdf,'r');
hold on
ksdensity(X)
axis([-4 4 0 .7])
