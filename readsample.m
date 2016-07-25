%This scrpit reads 10M samples from FPGA simulation, then it compares the
%PDF with theoretical Gaussion distribution
m = load('sample_out.txt');

l = length(m);
f = zeros(1,l);
for n=1:l
    if m(n)> 32768
        f(n)=-double(bitcmp(uint16(m(n)))+1)/2^11;
    else
        f(n)=m(n)/2^11;
    end
end

histogram(f,'Normalization','pdf');
hold on;
pd = makedist('Normal',0,1);
x = [-5:.001:5];
y = pdf(pd,x);
plot(x,y,'r.');
legend('Hardware','Software');