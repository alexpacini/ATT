%4ASK simulation by Alex Pacini #Octave code
%v2 -- MATLAB compliant language fixes, vectorization (speed up octave, because lack of JIT makes for construct too slow)
clear
clc
close 
tic
Eb=5/2;
EbN0targdB=[-1:0.01:10];
EbN0targ=10.^(EbN0targdB/10);
N0= (EbN0targ*(1/Eb)).^-1;

%for i=[1:length(N0)]
	%ber(i)= modulator(N0(i));
%end
%single processor manual parallelized
ber= modulator(N0);
toc %gives computation time
title('4-ASK');
%subplot(211),plot(EbN0targ,ber),xlabel('Eb/N0'),ylabel('BER'),grid;
%subplot(212),semilogy(EbN0targdB,abs(ber)),xlabel('Eb/N0 [dB]'),ylabel('BER'),grid;
semilogy(EbN0targdB,abs(ber)),xlabel('Eb/N0 [dB]'),ylabel('BER'),grid;
