function [y,s0n,s1n,s2n] = taus(a0,a1,a2)

cons0=uint32(hex2dec('FFFFFFFE'));
cons1=uint32(hex2dec('FFFFFFF8'));
cons2=uint32(hex2dec('FFFFFFF0'));

b0 = uint32(bitsll(a0,13));
c0 = bitxor(b0,a0);
e0 = bitsrl(c0,19);
d0 = bitand(a0,cons0);
f0 = bitsll(d0,12);
s0 = bitxor(e0,f0);


b1 = uint32(bitsll(a1,2));
c1 = bitxor(b1,a1);
e1 = bitsrl(c1,25);
d1 = bitand(a1,cons1);
f1 = bitsll(d1,4);
s1 = bitxor(e1,f1);

b2 = uint32(bitsll(a2,3));
c2 = bitxor(b2,a2);
e2 = bitsrl(c2,11);
d2 = bitand(a2,cons2);
f2 = bitsll(d2,17);
s2 = bitxor(e2,f2);

y = bitxor(bitxor(s0,s1),s2);

s0n = s0;
s1n = s1;
s2n = s2;
end