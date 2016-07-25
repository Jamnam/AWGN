%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%log
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = linspace(1,2,2561);
y = log(x);

p = zeros(256,3);
for n=1:256
    p(n,:) = polyfit(x(10*n-9:10*n),y(10*n-9:10*n),2);
end

t_e = p;

x1 = linspace(1,2,2561);
y1 = zeros(1,2561);

for n=1:256
    y1(10*n-9:10*n) = polyval(t_e(n,:),x(10*n-9:10*n));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%sqrt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = linspace(1,2,65);
y = sqrt(x);

p = zeros(64,2);
for n=1:64
    p(n,:) = polyfit(x(n:n+1),y(n:n+1),1);
end

t_f0 = p;

x1 = linspace(1,2,65);
y1 = zeros(1,65);

for n=1:64
    y1(n:n+1) = polyval(t_f0(n,:),x(n:n+1));
end

x = linspace(2,4,65);
y = sqrt(x);

p = zeros(64,2);
for n=1:64
    p(n,:) = polyfit(x(n:n+1),y(n:n+1),1);
end

t_f1 = p;

x1 = linspace(2,4,65);
y1 = zeros(1,65);

for n=1:64
    y1(n:n+1) = polyval(t_f1(n,:),x(n:n+1));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = linspace(0,1-2^-14,129);
y = cos(pi/2*x);

p = zeros(128,2);
for n=1:128
    p(n,:) = polyfit(x(n:n+1),y(n:n+1),1);
end

t_g = p;

x1 = linspace(0,1-2^-14,129);
y1 = zeros(1,129);

for n=1:128
    y1(n:n+1) = polyval(t_g(n,:),x(n:n+1));
end

% figure
% plot(x,y,'o')
% hold on
% plot(x1,y1)
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Coefficents Transformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = [0:255]'./256;
C2 = t_e(:,1);
C1 = t_e(:,2);
C0 = t_e(:,3);

%e
C2_e = C2./65536;
C1_e = (2.*C2.*(A+1)+C1)./256;
C0_e = C2.*(A+1).*(A+1) + C1.*(A+1) + C0;

%f
A = [0:63]'./64;
C1 = t_f0(1:64,1);
C0 = t_f0(1:64,2);
C1_f0 = C1./64;
C0_f0 = C1.*(A+1)+C0;

A = [0:63]'./32;
C1 = t_f1(1:64,1);
C0 = t_f1(1:64,2);
C1_f1 = C1./64;
C0_f1 = C1.*(A+2)+C0;

%g
A = [0:127]'./128;
C1 = t_g(:,1);
C0 = t_g(:,2);
C1_g = C1./128;
C0_g = C1.*A+C0;