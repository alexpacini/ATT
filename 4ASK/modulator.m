function ber = modulator(N0)
%modulator by Alex Pacini v2
%50 times faster 

N0l=length(N0);
rand ('state', 0);
randn ('state', 0);
N0=N0.';

Zn=sqrt(N0/2)*randn(1, 5000);

Zbit=ones(N0l,1)*rand(1, 10000);
%
%for i = 1:length(Zbit)
	%if Zbit(i)<0.5; Zbit(i)=0;
		%else Zbit(i)=1;
		%end
%end	
Zbit(Zbit<0.5)=0;
Zbit(Zbit>=0.5)=1;
Zsym=zeros (N0l, length(Zbit)/2);

%for i = 1:length(Zsym)
	%if (Zbit((i*2)-1)==0 && (i*2)==0); Zsym(i)=-3;
	%elseif (Zbit((i*2)-1)==0 && Zbit(i*2)==1); Zsym(i)=-1;
	%elseif (Zbit((i*2)-1)==1 && Zbit(i*2)==1); Zsym(i)=1;
	%elseif (Zbit((i*2)-1)==1 && Zbit(i*2)==0); Zsym(i)=3;
	%end
%end
%mapping
Zsym (Zbit(:,1:2:length(Zbit)-1)==0 & Zbit(:,2:2:length(Zbit))==0) = -3;
Zsym (Zbit(:,1:2:length(Zbit)-1)==0 & Zbit(:,2:2:length(Zbit))==1) = -1;
Zsym (Zbit(:,1:2:length(Zbit)-1)==1 & Zbit(:,2:2:length(Zbit))==1) = 1;
Zsym (Zbit(:,1:2:length(Zbit)-1)==1 & Zbit(:,2:2:length(Zbit))==0) = 3;

Rsym=Zsym+Zn;

Bitouth1=zeros ( N0l, length(Rsym));
Bitouth2=zeros ( N0l, length(Rsym));


%Rec. -3
Bitouth1(Rsym<-2)=0;
Bitouth2(Rsym<-2)=0;
%Rec. -1
Bitouth1(Rsym>=-2 & Rsym<0)=0;
Bitouth2(Rsym>=-2 & Rsym<0)=1;
%Rec. 1
Bitouth1(Rsym>=0 & Rsym<=2)=1;
Bitouth2(Rsym>=0 & Rsym<=2)=1;
%Rec. 3
Bitouth1(Rsym>2)=1;
Bitouth2(Rsym>2)=0;

%Vector Interleaving
Bitout = reshape([Bitouth1;Bitouth2], N0l, 2*length(Rsym) );

%for i= 1:length(Rsym)
	%if Rsym(i)<-2;
		%Bitout((i*2)-1)=0;  
		%Bitout(i*2)=0;
	%elseif (Rsym(i)>=-2 && Rsym(i)<0);
		%Bitout((i*2)-1)=0; 
		%Bitout(i*2)=1;
	%elseif (Rsym(i)>=0 && Rsym(i)<=2); 
		%Bitout((i*2)-1)=1; 
		%Bitout(i*2)=1;
	%elseif Rsym(i)>2; 
		%Bitout((i*2)-1)=1; 
		%Bitout(i*2)=0;
	%end
%end

%err=0;
%for i = 1:length(Bitout)
	%if Zbit(i)~=Bitout(i); err=err+1;
	%end
%end

errv= xor(Zbit, Bitout);
err=sum(errv.');

ber1=err/length(Bitout); 
ber=ber1.';
