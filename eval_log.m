%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Evaluate e = -2ln(u0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Range Reduction
exp_e = lzd(u0,48)+1;
x_e = bitsll(u0,exp_e);
%Approximate ln(x_e) where x_e = [1,2)
%Degree-2 piecewise polynomial

%Seperate x_e to x_e_A and x_e_B
x_e = dec2bin(x_e);
x_e_A = x_e(2:9);
x_e_B = [x_e(10:49)];
x_e_A = bin2dec(x_e_A);
x_e_B = bin2dec(x_e_B)/2^40;
x_e = bin2dec(x_e)/2^48;

y_e = C2_e(x_e_A+1)*x_e_B^2 + C1_e(x_e_A+1)*x_e_B+C0_e(x_e_A+1);

%Range Reconstruction
ln2 = log(2);
ee = exp_e * ln2;
e = (ee - y_e)*2;