%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Evaluate g0=sin(2*pi*u1),g1=cos(2*pi*u1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Range Reduction
%u1 = dec2bin(u1);
%bitn = 16-length(u1);

quad = bin2dec(dec2bin(u1/2^14));
u1 = dec2bin(u1);
switch quad
    case 0
        x_g_a = u1;
    case 1
        x_g_a = u1(2:15);
    otherwise
        x_g_a = u1(3:16);
end

x_g_b = dec2bin(16383-bin2dec(x_g_a));

%Approximate cos(pi/2*x_g) where x_g = [0,1-2^-14]
%Degree-1 piecewise polynomial
bitn = length(x_g_a);
if bitn>7
    x_g_a_A = x_g_a(1:bitn-7);
    x_g_a_B = x_g_a(bitn-6:bitn);
else
    x_g_a_A = '0';
    x_g_a_B = x_g_a;
end

bitn = length(x_g_b);
if bitn>7
    x_g_b_A = x_g_b(1:bitn-7);
    x_g_b_B = x_g_b(bitn-6:bitn);
else
    x_g_b_A = '0';
    x_g_b_B = x_g_b;
end

x_g_a = bin2dec(x_g_a)/2^14;
x_g_b = bin2dec(x_g_b)/2^14;
x_g_a_A = bin2dec(x_g_a_A);
x_g_b_A = bin2dec(x_g_b_A);
x_g_a_B = bin2dec(x_g_a_B)/128;
x_g_b_B = bin2dec(x_g_b_B)/128;


y_g_a = C1_g(x_g_a_A+1)*x_g_a_B+C0_g(x_g_a_A+1);
y_g_b = C1_g(x_g_b_A+1)*x_g_b_B+C0_g(x_g_b_A+1);

%Range Reconstruction
switch quad
    case 0
        g0 = y_g_b; g1 = y_g_a;
    case 1
        g0 = y_g_a; g1 = -y_g_b;
    case 2
        g0 = -y_g_b; g1 = -y_g_a;
    case 3
        g0 = -y_g_a; g1 = y_g_b;
end