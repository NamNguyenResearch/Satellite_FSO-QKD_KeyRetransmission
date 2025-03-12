%Quantum key distribution and ARQ protocol over free-space optics using
%dual-threshold direct-detection receiver
clear;
clc;

%Parameters Simulation
global Rb;               %Bit rate (bps)
global P_LO_dBm;         %Power of Local Oscillator (dBm)
global lamda_wavelength; %Wavelength (m)
global v_wind;           %Wind speed (m/s)
global H_S;              %Satellite altitude (m)
global H_G;              %Ground station height (m)
global H_a;              %Amospheric altitude (m)
global l_k;              %Length of bit string (in bits)
global zenithAng_Do

Rb=10*10^9;
P_LO_dBm=0;
lamda_wavelength=1550*10^-9;
v_wind=21;
H_S=600*10^3;
H_G=5;   
H_a=20*10^3;
l_k=5*10^7; 
zenithAng_Do=50;

C2n_Weak=5*10^-15;       %Refractive index structure coefficient
C2n_Strong=7*10^-12; 
MArray=[1,2,3,4,5,6,7,8];%Maximum number of transmissions
B=10;                    %BS buffer size
lamda_Weak=65;
lamda_Strong=65;
Attenuation=0.43;
ScaleCo_Weak=0.7;
ScaleCo_Strong=1.4;
P_T_dBm=8:0.5:18; 

%Calculate Key loss rate
%Weak turbulence
QBER_Weak=zeros(1,length(P_T_dBm));
P_sift_Weak=zeros(1,length(P_T_dBm));

keyLossRate1_Weak=zeros(1,length(P_T_dBm));
keyLossRate2_Weak=zeros(1,length(P_T_dBm));
keyLossRate3_Weak=zeros(1,length(P_T_dBm));
keyLossRate4_Weak=zeros(1,length(P_T_dBm));
keyLossRate5_Weak=zeros(1,length(P_T_dBm));
keyLossRate6_Weak=zeros(1,length(P_T_dBm));
keyLossRate7_Weak=zeros(1,length(P_T_dBm));
keyLossRate8_Weak=zeros(1,length(P_T_dBm));

for i=1:length(P_T_dBm) 
    [QBER_Weak(i),P_sift_Weak(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    
    keyLossRate1_Weak(i)=calculateKeyLossRate(MArray(1),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate2_Weak(i)=calculateKeyLossRate(MArray(2),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate3_Weak(i)=calculateKeyLossRate(MArray(3),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);  
    keyLossRate4_Weak(i)=calculateKeyLossRate(MArray(4),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate5_Weak(i)=calculateKeyLossRate(MArray(5),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate6_Weak(i)=calculateKeyLossRate(MArray(6),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate7_Weak(i)=calculateKeyLossRate(MArray(7),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
    keyLossRate8_Weak(i)=calculateKeyLossRate(MArray(8),B,QBER_Weak(i),P_sift_Weak(i),lamda_Weak);
end

%Strong turbulence
QBER_Strong=zeros(1,length(P_T_dBm));
P_sift_Strong=zeros(1,length(P_T_dBm));

keyLossRate1_Strong=zeros(1,length(P_T_dBm));
keyLossRate2_Strong=zeros(1,length(P_T_dBm));
keyLossRate3_Strong=zeros(1,length(P_T_dBm));
keyLossRate4_Strong=zeros(1,length(P_T_dBm));
keyLossRate5_Strong=zeros(1,length(P_T_dBm));
keyLossRate6_Strong=zeros(1,length(P_T_dBm));
keyLossRate7_Strong=zeros(1,length(P_T_dBm));
keyLossRate8_Strong=zeros(1,length(P_T_dBm));

for i=1:length(P_T_dBm) 
    [QBER_Strong(i),P_sift_Strong(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Strong,P_T_dBm(i),C2n_Strong);
    
    keyLossRate1_Strong(i)=calculateKeyLossRate(MArray(1),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate2_Strong(i)=calculateKeyLossRate(MArray(2),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate3_Strong(i)=calculateKeyLossRate(MArray(3),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);  
    keyLossRate4_Strong(i)=calculateKeyLossRate(MArray(4),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate5_Strong(i)=calculateKeyLossRate(MArray(5),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate6_Strong(i)=calculateKeyLossRate(MArray(6),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate7_Strong(i)=calculateKeyLossRate(MArray(7),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
    keyLossRate8_Strong(i)=calculateKeyLossRate(MArray(8),B,QBER_Strong(i),P_sift_Strong(i),lamda_Strong);
end

% %Plot function of the key loss rate
% %Weak turbulence
% figure(1)
% semilogy(P_T_dBm,keyLossRate1_Weak,'b-',P_T_dBm,keyLossRate2_Weak,'r--',P_T_dBm,keyLossRate3_Weak,'kd-',P_T_dBm,keyLossRate4_Weak,'g+-',...
%          P_T_dBm,keyLossRate5_Weak,'m-*',P_T_dBm,keyLossRate6_Weak,'c-o',P_T_dBm,keyLossRate7_Weak,'k-s',P_T_dBm,keyLossRate8_Weak,'b-x','LineWidth',1.5);
% grid on
% xlabel('Peak transmitted power P_{T} (dBm)');
% ylabel('Key loss rate, KLR');
% legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
%        'QKD-KR, M = 5','QKD-KR, M = 6','QKD-KR, M = 7','Location','Southwest');
% axis([8,18,1.e-10,1.e-0]);

% %Strong turbulence
% figure(2)
% semilogy(P_T_dBm,keyLossRate1_Strong,'b-',P_T_dBm,keyLossRate2_Strong,'r--',P_T_dBm,keyLossRate3_Strong,'kd-',P_T_dBm,keyLossRate4_Strong,'g+-',...
%          P_T_dBm,keyLossRate5_Strong,'m-*',P_T_dBm,keyLossRate6_Strong,'c-o',P_T_dBm,keyLossRate7_Strong,'k-s',P_T_dBm,keyLossRate8_Strong,'b-x','LineWidth',1.5);
% grid on
% xlabel('Peak transmitted power P_{T} (dBm)');
% ylabel('Key loss rate, KLR');
% legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
%        'QKD-KR, M = 5','QKD-KR, M = 6','QKD-KR, M = 7','Location','Southwest');
% axis([8,18,1.e-10,1.e-0]);

%Combine
figure(3)
subplot(2,1,1)
%Weak turbulence
semilogy(P_T_dBm,keyLossRate1_Weak,'b-',P_T_dBm,keyLossRate2_Weak,'r--',P_T_dBm,keyLossRate3_Weak,'kd-',P_T_dBm,keyLossRate4_Weak,'g+-',...
         P_T_dBm,keyLossRate5_Weak,'m-*',P_T_dBm,keyLossRate6_Weak,'c-o',P_T_dBm,keyLossRate7_Weak,'k-s',P_T_dBm,keyLossRate8_Weak,'b-x','LineWidth',1.5);
grid on
title('(a)','FontWeight','Normal');
xlabel('Peak transmitted power P_{T} (dBm)');
ylabel('Key loss rate, KLR');
legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
       'QKD-KR, M = 5','QKD-KR, M = 6','QKD-KR, M = 7','Location','Southwest');
axis([8,18,1.e-10,1.e-0]);

subplot(2,1,2)
%Strong turbulence
semilogy(P_T_dBm,keyLossRate1_Strong,'b-',P_T_dBm,keyLossRate2_Strong,'r--',P_T_dBm,keyLossRate3_Strong,'kd-',P_T_dBm,keyLossRate4_Strong,'g+-',...
         P_T_dBm,keyLossRate5_Strong,'m-*',P_T_dBm,keyLossRate6_Strong,'c-o',P_T_dBm,keyLossRate7_Strong,'k-s',P_T_dBm,keyLossRate8_Strong,'b-x','LineWidth',1.5);
grid on
title('(b)','FontWeight','Normal');
xlabel('Peak transmitted power P_{T} (dBm)');
ylabel('Key loss rate, KLR');
legend('Conventional QKD','QKD-KR, M = 1', 'QKD-KR, M = 2', 'QKD-KR, M = 3', 'QKD-KR, M = 4',...
       'QKD-KR, M = 5','QKD-KR, M = 6','QKD-KR, M = 7','Location','Southwest');
axis([8,18,1.e-10,1.e-0]);