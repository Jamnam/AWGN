%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Evaluate f = sqrt(e)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e = dec2bin(e*2^24);
e = bin2dec(e);

%Range Reduction
exp_f = 5-lzd(e,31);
x_f1 =  e*2^(-exp_f);

if mod(exp_f,2)
    x_f = x_f1/2;
else
    x_f = x_f1;
end

%Approximate sqrt(f) where x_f = [1,4)
%Degree-1 piecewise polynomial
x_f = dec2bin(x_f);
l = length(x_f);

if l==25
    x_f_A = x_f(2:7);
    x_f_B = x_f(8:25);
else
    x_f_A = x_f(2:7);
    x_f_B = x_f(8:26);
end

x_f_A = bin2dec(x_f_A);
x_f_B = bin2dec(x_f_B)/2^18;
x_f = bin2dec(x_f)/2^24;

if mod(exp_f,2)
    y_f = C1_f0(x_f_A+1)*x_f_B+C0_f0(x_f_A+1);
else
    y_f = C1_f1(x_f_A+1)*x_f_B+C0_f1(x_f_A+1);
end

%Range Reconstruction
if mod(exp_f,2)
    exp_f1 = (exp_f+1)/2;
else
    exp_f1 = exp_f/2;
end

f = y_f * 2^(exp_f1);