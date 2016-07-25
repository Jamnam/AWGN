clear;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate Coefficients
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
get_coeff;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = uint32(2147483648);
s2 = uint32(2147483648);
s3 = uint32(2147483648);

s4 = uint32(2147483648);
s5 = uint32(2147483648);
s6 = uint32(2147483648);

x0 = zeros(1,10000);
x1 = zeros(1,10000);

for n=1:10000
    
    [a,s1,s2,s3] = taus(s1,s2,s3);
    [b,s4,s5,s6] = taus(s4,s5,s6);
    a = dec2hex(a);
    b = dec2hex(b);
    l_a = length(a);
    l_b = length(b);
    n_a = 8-l_a;
    n_b = 8-l_b;
    
    if (n_a>0)
        for k=1:n_a
            a = cat(2,'0',a);
        end
    end
    
    if (n_b>0)
        for k= 1:n_b
            b = cat(2,'0',b);
        end
    end
    
    ab = [a,b];
    u0 = hex2dec(ab(1:12));
    u1 = hex2dec(ab(13:16));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Evaluate e = -2ln(u0)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    eval_log;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Evaluate f = sqrt(e)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    eval_sqrt;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Evaluate g0=sin(2*pi*u1),g1=cos(2*pi*u1)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    eval_cos;
    
    x0(n) = f*g0;
    x1(n) = f*g1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Kolmogorov-Smirnov test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ks;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write data into text file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
soft_out = zeros(10000,1);
x00 = fix(x0.*2^11);

for n=1:10000
    if x00(n)>=0
        soft_out(n)= str2num(dec2bin(x00(n)));
    else
        soft_out(n)= str2num(dec2bin(bitcmp(uint16(-x00(n)))+1));
    end
end
       
fid = fopen('soft_out.txt','wt');
fprintf(fid,'%d\n',soft_out); 
fclose(fid);