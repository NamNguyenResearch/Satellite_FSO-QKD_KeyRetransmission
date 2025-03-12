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
ScaleCo_Weak=0.7;
ScaleCo_Strong=1.4;
P_T_dBm=0:1:30;

%Calculate Key loss rate
%(a) Thick fog
%Weak turbulence
QBER_Weak_fog=zeros(1,length(P_T_dBm));
P_sift_Weak_fog=zeros(1,length(P_T_dBm));

keyLossRate1_Weak_fog=zeros(1,length(P_T_dBm));
keyLossRate2_Weak_fog=zeros(1,length(P_T_dBm));
keyLossRate4_Weak_fog=zeros(1,length(P_T_dBm));
keyLossRate6_Weak_fog=zeros(1,length(P_T_dBm));
keyLossRate8_Weak_fog=zeros(1,length(P_T_dBm));

%Strong turbulence
QBER_Strong_fog=zeros(1,length(P_T_dBm));
P_sift_Strong_fog=zeros(1,length(P_T_dBm));

keyLossRate1_Strong_fog=zeros(1,length(P_T_dBm));
keyLossRate2_Strong_fog=zeros(1,length(P_T_dBm));
keyLossRate4_Strong_fog=zeros(1,length(P_T_dBm));
keyLossRate6_Strong_fog=zeros(1,length(P_T_dBm));
keyLossRate8_Strong_fog=zeros(1,length(P_T_dBm));

%(a) Heavy rain
%Weak turbulence
QBER_Weak_rain=zeros(1,length(P_T_dBm));
P_sift_Weak_rain=zeros(1,length(P_T_dBm));

keyLossRate1_Weak_rain=zeros(1,length(P_T_dBm));
keyLossRate2_Weak_rain=zeros(1,length(P_T_dBm));
keyLossRate4_Weak_rain=zeros(1,length(P_T_dBm));
keyLossRate6_Weak_rain=zeros(1,length(P_T_dBm));
keyLossRate8_Weak_rain=zeros(1,length(P_T_dBm));

%Strong turbulence
QBER_Strong_rain=zeros(1,length(P_T_dBm));
P_sift_Strong_rain=zeros(1,length(P_T_dBm));

keyLossRate1_Strong_rain=zeros(1,length(P_T_dBm));
keyLossRate2_Strong_rain=zeros(1,length(P_T_dBm));
keyLossRate4_Strong_rain=zeros(1,length(P_T_dBm));
keyLossRate6_Strong_rain=zeros(1,length(P_T_dBm));
keyLossRate8_Strong_rain=zeros(1,length(P_T_dBm));

%(c) Clouds
%Weak turbulence
QBER_Weak_cloud=zeros(1,length(P_T_dBm));
P_sift_Weak_cloud=zeros(1,length(P_T_dBm));

keyLossRate1_Weak_cloud=zeros(1,length(P_T_dBm));
keyLossRate2_Weak_cloud=zeros(1,length(P_T_dBm));
keyLossRate4_Weak_cloud=zeros(1,length(P_T_dBm));
keyLossRate6_Weak_cloud=zeros(1,length(P_T_dBm));
keyLossRate8_Weak_cloud=zeros(1,length(P_T_dBm));

%Strong turbulence
QBER_Strong_cloud=zeros(1,length(P_T_dBm));
P_sift_Strong_cloud=zeros(1,length(P_T_dBm));

keyLossRate1_Strong_cloud=zeros(1,length(P_T_dBm));
keyLossRate2_Strong_cloud=zeros(1,length(P_T_dBm));
keyLossRate4_Strong_cloud=zeros(1,length(P_T_dBm));
keyLossRate6_Strong_cloud=zeros(1,length(P_T_dBm));
keyLossRate8_Strong_cloud=zeros(1,length(P_T_dBm));

for i=1:length(P_T_dBm) 
    %(a) Thick fog
    Attenuation=1;
    %Weak turbulence
    [QBER_Weak_fog(i),P_sift_Weak_fog(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    
    keyLossRate1_Weak_fog(i)=calculateKeyLossRate(MArray(1),B,QBER_Weak_fog(i),P_sift_Weak_fog(i),lamda_Weak);
    keyLossRate2_Weak_fog(i)=calculateKeyLossRate(MArray(2),B,QBER_Weak_fog(i),P_sift_Weak_fog(i),lamda_Weak);  
    keyLossRate4_Weak_fog(i)=calculateKeyLossRate(MArray(4),B,QBER_Weak_fog(i),P_sift_Weak_fog(i),lamda_Weak);
    keyLossRate6_Weak_fog(i)=calculateKeyLossRate(MArray(6),B,QBER_Weak_fog(i),P_sift_Weak_fog(i),lamda_Weak);
    keyLossRate8_Weak_fog(i)=calculateKeyLossRate(MArray(8),B,QBER_Weak_fog(i),P_sift_Weak_fog(i),lamda_Weak);
    
    %Strong turbulence
    [QBER_Strong_fog(i),P_sift_Strong_fog(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Strong,P_T_dBm(i),C2n_Strong);
    
    keyLossRate1_Strong_fog(i)=calculateKeyLossRate(MArray(1),B,QBER_Strong_fog(i),P_sift_Strong_fog(i),lamda_Strong);
    keyLossRate2_Strong_fog(i)=calculateKeyLossRate(MArray(2),B,QBER_Strong_fog(i),P_sift_Strong_fog(i),lamda_Strong);
    keyLossRate4_Strong_fog(i)=calculateKeyLossRate(MArray(4),B,QBER_Strong_fog(i),P_sift_Strong_fog(i),lamda_Strong);
    keyLossRate6_Strong_fog(i)=calculateKeyLossRate(MArray(6),B,QBER_Strong_fog(i),P_sift_Strong_fog(i),lamda_Strong);
    keyLossRate8_Strong_fog(i)=calculateKeyLossRate(MArray(8),B,QBER_Strong_fog(i),P_sift_Strong_fog(i),lamda_Strong);
    
    %(b) Heavy rain
    Attenuation=2;
    %Weak turbulence
    [QBER_Weak_rain(i),P_sift_Weak_rain(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    
    keyLossRate1_Weak_rain(i)=calculateKeyLossRate(MArray(1),B,QBER_Weak_rain(i),P_sift_Weak_rain(i),lamda_Weak);
    keyLossRate2_Weak_rain(i)=calculateKeyLossRate(MArray(2),B,QBER_Weak_rain(i),P_sift_Weak_rain(i),lamda_Weak);  
    keyLossRate4_Weak_rain(i)=calculateKeyLossRate(MArray(4),B,QBER_Weak_rain(i),P_sift_Weak_rain(i),lamda_Weak);
    keyLossRate6_Weak_rain(i)=calculateKeyLossRate(MArray(6),B,QBER_Weak_rain(i),P_sift_Weak_rain(i),lamda_Weak);
    keyLossRate8_Weak_rain(i)=calculateKeyLossRate(MArray(8),B,QBER_Weak_rain(i),P_sift_Weak_rain(i),lamda_Weak);
    
    %Strong turbulence
    [QBER_Strong_rain(i),P_sift_Strong_rain(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Strong,P_T_dBm(i),C2n_Strong);
    
    keyLossRate1_Strong_rain(i)=calculateKeyLossRate(MArray(1),B,QBER_Strong_rain(i),P_sift_Strong_rain(i),lamda_Strong);
    keyLossRate2_Strong_rain(i)=calculateKeyLossRate(MArray(2),B,QBER_Strong_rain(i),P_sift_Strong_rain(i),lamda_Strong);
    keyLossRate4_Strong_rain(i)=calculateKeyLossRate(MArray(4),B,QBER_Strong_rain(i),P_sift_Strong_rain(i),lamda_Strong);
    keyLossRate6_Strong_rain(i)=calculateKeyLossRate(MArray(6),B,QBER_Strong_rain(i),P_sift_Strong_rain(i),lamda_Strong);
    keyLossRate8_Strong_rain(i)=calculateKeyLossRate(MArray(8),B,QBER_Strong_rain(i),P_sift_Strong_rain(i),lamda_Strong);
    
    %(c) Clouds
    Attenuation=3;
    %Weak turbulence
    [QBER_Weak_cloud(i),P_sift_Weak_cloud(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Weak,P_T_dBm(i),C2n_Weak);
    
    keyLossRate1_Weak_cloud(i)=calculateKeyLossRate(MArray(1),B,QBER_Weak_cloud(i),P_sift_Weak_cloud(i),lamda_Weak);
    keyLossRate2_Weak_cloud(i)=calculateKeyLossRate(MArray(2),B,QBER_Weak_cloud(i),P_sift_Weak_cloud(i),lamda_Weak);  
    keyLossRate4_Weak_cloud(i)=calculateKeyLossRate(MArray(4),B,QBER_Weak_cloud(i),P_sift_Weak_cloud(i),lamda_Weak);
    keyLossRate6_Weak_cloud(i)=calculateKeyLossRate(MArray(6),B,QBER_Weak_cloud(i),P_sift_Weak_cloud(i),lamda_Weak);
    keyLossRate8_Weak_cloud(i)=calculateKeyLossRate(MArray(8),B,QBER_Weak_cloud(i),P_sift_Weak_cloud(i),lamda_Weak);
    
    %Strong turbulence
    [QBER_Strong_cloud(i),P_sift_Strong_cloud(i)]=calculateQBER_QPSK_Gamma(Attenuation,ScaleCo_Strong,P_T_dBm(i),C2n_Strong);
    
    keyLossRate1_Strong_cloud(i)=calculateKeyLossRate(MArray(1),B,QBER_Strong_cloud(i),P_sift_Strong_cloud(i),lamda_Strong);
    keyLossRate2_Strong_cloud(i)=calculateKeyLossRate(MArray(2),B,QBER_Strong_cloud(i),P_sift_Strong_cloud(i),lamda_Strong);
    keyLossRate4_Strong_cloud(i)=calculateKeyLossRate(MArray(4),B,QBER_Strong_cloud(i),P_sift_Strong_cloud(i),lamda_Strong);
    keyLossRate6_Strong_cloud(i)=calculateKeyLossRate(MArray(6),B,QBER_Strong_cloud(i),P_sift_Strong_cloud(i),lamda_Strong);
    keyLossRate8_Strong_cloud(i)=calculateKeyLossRate(MArray(8),B,QBER_Strong_cloud(i),P_sift_Strong_cloud(i),lamda_Strong);
end

% figure(1)
% subplot(2,1,1)
% %Weak turbulence
% semilogy(P_T_dBm,keyLossRate1_Weak_fog,'k-',P_T_dBm,keyLossRate2_Weak_fog,'k-s',...
%          P_T_dBm,keyLossRate4_Weak_fog,'k-*',P_T_dBm,keyLossRate6_Weak_fog,'k-o',...
%          P_T_dBm,keyLossRate8_Weak_fog,'k-h','LineWidth',1.5);
% hold on
% semilogy(P_T_dBm,keyLossRate1_Weak_rain,'r-',P_T_dBm,keyLossRate2_Weak_rain,'r-s',...
%          P_T_dBm,keyLossRate4_Weak_rain,'r*-',P_T_dBm,keyLossRate6_Weak_rain,'r-o',...
%          P_T_dBm,keyLossRate8_Weak_rain,'r-h','LineWidth',1.5);
%      
% semilogy(P_T_dBm,keyLossRate1_Weak_cloud,'b-',P_T_dBm,keyLossRate2_Weak_cloud,'b-s',...
%          P_T_dBm,keyLossRate4_Weak_cloud,'b*-',P_T_dBm,keyLossRate6_Weak_cloud,'b-o',...
%          P_T_dBm,keyLossRate8_Weak_cloud,'b-h','LineWidth',1.5);
% hold off
% grid on
% xlabel('Peak transmitted power, P_{T} (dBm)');
% ylabel('Key loss rate, KLR');
% title('(a)','FontWeight','Normal');
% legend('Conventional QKD (Thick fog)','QKD-KR, M = 1 (Thick fog)','QKD-KR, M = 3 (Thick fog)','QKD-KR, M = 5 (Thick fog)','QKD-KR, M = 7 (Thick fog)',...
%        'Conventional QKD (Heavy rain)','HAP-QKD-KR, M = 1 (Heavy rain)','HAP-QKD-KR, M = 3 (Heavy rain)','HAP-QKD-KR, M = 5 (Heavy rain)','HAP-QKD-KR, M = 7 (Heavy rain)',...
%        'Conventional QKD (Clouds)','HAP-QKD-KR, M = 1 (Clouds)','HAP-QKD-KR, M = 3 (Clouds)','HAP-QKD-KR, M = 5 (Clouds)','HAP-QKD-KR, M = 7 (Clouds)',...
%        'Location','southeast');
% axis([0,30,1.e-10,1.e-0]);
% 
% subplot(2,1,2)
% %Strong turbulence
% semilogy(P_T_dBm,keyLossRate1_Strong_fog,'k-',P_T_dBm,keyLossRate2_Strong_fog,'k-s',...
%          P_T_dBm,keyLossRate4_Strong_fog,'k-*',P_T_dBm,keyLossRate6_Strong_fog,'k-o',...
%          P_T_dBm,keyLossRate8_Strong_fog,'k-h','LineWidth',1.5);
% hold on
% semilogy(P_T_dBm,keyLossRate1_Strong_rain,'r-',P_T_dBm,keyLossRate2_Strong_rain,'r-s',...
%          P_T_dBm,keyLossRate4_Strong_rain,'r-*',P_T_dBm,keyLossRate6_Strong_rain,'r-o',...
%          P_T_dBm,keyLossRate8_Strong_rain,'r-h','LineWidth',1.5);
%      
% semilogy(P_T_dBm,keyLossRate1_Strong_cloud,'b-',P_T_dBm,keyLossRate2_Strong_cloud,'b-s',...
%          P_T_dBm,keyLossRate4_Strong_cloud,'b-*',P_T_dBm,keyLossRate6_Strong_cloud,'b-o',...
%          P_T_dBm,keyLossRate8_Strong_cloud,'b-h','LineWidth',1.5);
% hold off
% grid on
% xlabel('Peak transmitted power, P_{T} (dBm)');
% ylabel('Key loss rate, KLR');
% title('(b)','FontWeight','Normal');
% legend('Conventional QKD (Thick fog)','QKD-KR, M = 1 (Thick fog)','QKD-KR, M = 3 (Thick fog)','QKD-KR, M = 5 (Thick fog)','QKD-KR, M = 7 (Thick fog)',...
%        'Conventional QKD (Heavy rain)','HAP-QKD-KR, M = 1 (Heavy rain)','HAP-QKD-KR, M = 3 (Heavy rain)','HAP-QKD-KR, M = 5 (Heavy rain)','HAP-QKD-KR, M = 7 (Heavy rain)',...
%        'Conventional QKD (Clouds)','HAP-QKD-KR, M = 1 (Clouds)','HAP-QKD-KR, M = 3 (Clouds)','HAP-QKD-KR, M = 5 (Clouds)','HAP-QKD-KR, M = 7 (Clouds)',...
%        'Location','southeast');
% axis([0,30,1.e-10,1.e-0]);

% figure(1)
% %Weak turbulence
% semilogy(P_T_dBm,keyLossRate1_Weak_fog,'k-',P_T_dBm,keyLossRate2_Weak_fog,'k-s',...
%          P_T_dBm,keyLossRate4_Weak_fog,'k-*',P_T_dBm,keyLossRate6_Weak_fog,'k-o',...
%          P_T_dBm,keyLossRate8_Weak_fog,'k-h','LineWidth',1.5);
% hold on
% semilogy(P_T_dBm,keyLossRate1_Weak_rain,'r-',P_T_dBm,keyLossRate2_Weak_rain,'r-s',...
%          P_T_dBm,keyLossRate4_Weak_rain,'r*-',P_T_dBm,keyLossRate6_Weak_rain,'r-o',...
%          P_T_dBm,keyLossRate8_Weak_rain,'r-h','LineWidth',1.5);
%      
% semilogy(P_T_dBm,keyLossRate1_Weak_cloud,'b-',P_T_dBm,keyLossRate2_Weak_cloud,'b-s',...
%          P_T_dBm,keyLossRate4_Weak_cloud,'b*-',P_T_dBm,keyLossRate6_Weak_cloud,'b-o',...
%          P_T_dBm,keyLossRate8_Weak_cloud,'b-h','LineWidth',1.5);
% hold off
% grid on
% xlabel('Peak transmitted power, P_{T} (dBm)');
% ylabel('Key loss rate, KLR');
% title('(a)','FontWeight','Normal');
% legend('Conventional QKD (Thick fog)','QKD-KR, M = 1 (Thick fog)','QKD-KR, M = 3 (Thick fog)','QKD-KR, M = 5 (Thick fog)','QKD-KR, M = 7 (Thick fog)',...
%        'Conventional QKD (Heavy rain)','HAP-QKD-KR, M = 1 (Heavy rain)','HAP-QKD-KR, M = 3 (Heavy rain)','HAP-QKD-KR, M = 5 (Heavy rain)','HAP-QKD-KR, M = 7 (Heavy rain)',...
%        'Conventional QKD (Clouds)','HAP-QKD-KR, M = 1 (Clouds)','HAP-QKD-KR, M = 3 (Clouds)','HAP-QKD-KR, M = 5 (Clouds)','HAP-QKD-KR, M = 7 (Clouds)',...
%        'Location','southeast');
% axis([0,30,1.e-10,1.e-0]);

figure(1)
%Weak turbulence
semilogy(P_T_dBm,keyLossRate1_Weak_cloud,'b-',P_T_dBm,keyLossRate2_Weak_cloud,'b-s',...
         P_T_dBm,keyLossRate4_Weak_cloud,'b*-',P_T_dBm,keyLossRate6_Weak_cloud,'b-o',...
         P_T_dBm,keyLossRate8_Weak_cloud,'b-h','LineWidth',1.5);
hold on
semilogy(P_T_dBm,keyLossRate1_Weak_rain,'r-',P_T_dBm,keyLossRate2_Weak_rain,'r-s',...
         P_T_dBm,keyLossRate4_Weak_rain,'r*-',P_T_dBm,keyLossRate6_Weak_rain,'r-o',...
         P_T_dBm,keyLossRate8_Weak_rain,'r-h','LineWidth',1.5);
     
semilogy(P_T_dBm,keyLossRate1_Weak_fog,'k-',P_T_dBm,keyLossRate2_Weak_fog,'k-s',...
         P_T_dBm,keyLossRate4_Weak_fog,'k-*',P_T_dBm,keyLossRate6_Weak_fog,'k-o',...
         P_T_dBm,keyLossRate8_Weak_fog,'k-h','LineWidth',1.5);
hold off
grid on
xlabel('Peak transmitted power, P_{T} (dBm)');
ylabel('Key loss rate, KLR');
legend('Conventional QKD','QKD-KR, M = 1','QKD-KR, M = 3','QKD-KR, M = 5','QKD-KR, M = 7','Location','southeast');
axis([2,30,1.e-10,1.e-0]);