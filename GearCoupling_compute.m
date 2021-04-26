function [results]=GearCoupling_compute_version06242013(parameters)
format LONG e;

% input parameters
N=parameters(1);  % number of teeth
P=parameters(2); % Diametral pitch
F=parameters(3); % Effective face width
L=parameters(4); % Distance between gear mesh centerline
PHI=parameters(5);% Pressure angle
ID=parameters(6);  % Design mislignment angle, degrees
TC=parameters(7);  % Hub tooth circular tooth thickness
TC_S=parameters(8); % Sleeve tooth circular tooth thickness
DO=parameters(9); % Major diameter of hub
DI=parameters(10); % Minor diameter of sleeve
HO=parameters(11); % Hub tooth tip chamfer
RF=parameters(12); %Face crown radius (normal)
H=parameters(13); % Face crown height
RC=parameters(14); % Root crown radius at pitch diameter
Y1=parameters(15); % Hob tooth AGMA form factor
Y2=parameters(16); % Sleeve tooth AGMA form factor
KF=parameters(17);  %Hub tooth stress concentration factor
K=parameters(18);  % Accuracy factor
E=parameters(19);  % Young's modulus
T_rated=parameters(20);  % Torque
HT_method=parameters(21); % Heat Treatment
Type_AB=parameters(22); % Type A and B for Induction Hardened
HB=parameters(23);
Su_case=parameters(24); % material property
Su_core=parameters(25);
S_yield_case=parameters(26); % material property
S_yield_core=parameters(27); % material property
tol_imax=parameters(28);
D2R=1;  % Degree to radian

I_min=parameters(29);
I_max=parameters(30);
dI=parameters(31);
T_min=parameters(32);
T_max=parameters(33);
dT=parameters(34);
Torque_var=(T_min:dT:T_max)*T_rated;
I_var=(I_min:dI:I_max)*D2R;
len_I=length(I_var);
len_torque=length(Torque_var);

dis_cc=[];
F_e=[];
force_cc=[];



% MAIN PROGRAM
F_v=F;
for ll=1:length(F_v)
    sum_tl=zeros(len_I,len_torque,length(F_v));
    % F=F_v(ll);
    % RF=RF_v(ll);
    PHI=PHI*D2R;
    R=N/(2*P);
    H1=(DO-DI)/2-HO;
    C1=P*KF*cosd(PHI)/(F*Y1); % Coefficient for bending stress
    C3=cosd(PHI)/TC/F;  % Coefficient for shear stress
    Z1=Y1/(0.76+7.25*Y1);
    Z2=Y2/(0.76+7.25*Y2);
    C=F*E*Z1*Z2/(Z1+Z2);  % Single pair of teeth contact stiffness
    disp('tooth contact stiffness equals')
    disp (C);
    
    
    [S_bending,S_contact,S_shear,S_by,S_cy,S_sy]=Strength_Calculation(HT_method,Type_AB,HB,Su_core,Su_case,S_yield_core,S_yield_case);
    
    
    % Iteration program
    
    
    for j=1:len_torque
        for i=1:len_I
            I0=I_var(i);
            if RF==0
                if RC==0
                    if H==0
                        RC=F*tand(PHI)/(3*tand(I0));
                    else
                        RF=(F^2/4+H^2)/(2*H);
                        RC=RF*cosd(I0)*sind(PHI);
                    end
                else
                    RF=RC/(cosd(I0)*sind(PHI));
                end
            else
                RC=RF*cosd(I0)*sind(PHI);
            end
            
            H=RF-(RF^2-F^2/4)^0.5;
            C2=0.418*(E/(RF*H1))^0.5; % Coefficient for contact stress
            
            % Calculate Jam angle
            
            SC2=pi/P-TC_S;
            I_max=acosd((2*RF-SC2)/(2*RF-TC)); % Maximm tilting angle before jamming
            
            W1(i,j)=Torque_var(j)/(R*cosd(PHI));
            W2(i,j)=W1(i,j)/(K*N);
            
            %if no misalignmet
            if I_var(i)==0
                W1(i,j)=Torque_var(j)/(R*cosd(PHI));
                W2(i,j)=W1(i,j)/(K*N);      % Max tooth load
                %with misalignment
                
                S1(i,j)=C1*W2(i,j);
                S2(i,j)=C2*W2(i,j)^0.5;
                S3(i,j)=C3*W2(i,j);
                
                Ie(i,j)=0;
                q(i,j)=0;
                z9(i,j)=0;
                z0(i,j)=0;
                W3(i,j)=0;%W2(i,j);
                
            else
                F0=2;q1=0.05;q2=0.05;
                [q(i,j), z9(i,j),z0(i,j), W3(i,j),W2(i,j)] = qfinding(F0,q1,q2,W2(i,j),C,RC,I_var(i),PHI,tol_imax);
                Ie(i,j)=L*tand(I_var(i));
                S1(i,j)=C1*W3(i,j);  % Bending Stress
                S2(i,j)=C2*W3(i,j)^0.5;  % Contact Stress
                S3(i,j)=C3*W3(i,j);  % Shear Stress
                
                % Tooth Load Distribution Calculation
                W2p=W3(i,j);
                
                N_max=round(q(i,j)*N/4);
                if (q(i,j)*N/2-floor(q(i,j)*N/2))<1e-7
                    offset=0.5/N*2*pi;
                else
                    offset=0;
                end
                
                for iii=-N_max:1:N_max
                    
                    if RF*sind(I_var(i))>=F/2
                        
                        sum_tl(i,j,ll)=sum_tl(i,j,ll)+2*W2p*F/2*...
                            (1-z0(i,j)*(sin(2*pi/N*(iii)+offset))^2/(z9(i,j)*z0(i,j)))*abs(cos((2*pi/N*(iii))+offset))...
                            *abs(cos((2*pi/N*(iii))+offset));
                    else
                        
                        sum_tl(i,j,ll)=sum_tl(i,j,ll)+2*RF*W2p*sind(I_var(i))...
                            *(1-z0(i,j)*(sin(2*pi/N*(iii)+offset))^2/(z9(i,j)*z0(i,j)))*abs(cos((2*pi/N*(iii))+offset))...
                            *abs(cos((2*pi/N*(iii))+offset));
                    end
                    
                    
                    force_cc=[force_cc;W2p*(1-z0(i,j)*(sin(2*pi/N*(iii)+offset))^2/(z9(i,j)*z0(i,j)))];
                    def_c=W2p*(1-z0(i,j)*(sin(2*pi/N*(iii)+offset))^2/(z9(i,j)*z0(i,j)))/C;
                    F_e=[F_e;sqrt(4*(RF.^2-(RF-def_c).^2))];
                    dis_cc=[dis_cc;RF*sind(I_var(i))*abs(cos((2*pi/N*(iii))+offset))];
                end
            end
            n_bf(i,j)=S_bending/S1(i,j)*1000;
            n_cf(i,j)=S_contact/S2(i,j)*1000;
            n_sf(i,j)=S_shear/S3(i,j)*1000;
            n_by(i,j)=S_by/S1(i,j)*1000;
            n_cy(i,j)=S_cy/S2(i,j)*1000;
            n_sy(i,j)=S_sy/S3(i,j)*1000;
            tl_d(i,ll)=sum_tl(i,j,ll);
        end
    end
    results_temp_2(ll,:)=[F,RF,q(i,j), z9(i,j),z0(i,j), W3(i,j),S1(i,j), S2(i,j),S3(i,j),n_bf(i,j),n_cf(i,j),n_sf(i,j),n_by(i,j),n_cy(i,j),n_sy(i,j), I_max,C];
end

% Tooth Load Distribution Calculation
dis_cc_up=dis_cc+F_e/2;
dis_cc_dn=dis_cc-F_e/2;

len_slices=21;
force_e=zeros(length(force_cc),length(len_slices));
for ppp=1:length(force_cc)
    mm=0;
    for qqq=-floor(len_slices/2):1:floor(len_slices/2)
        mm=mm+1;
        force_e(ppp,mm)=force_cc(ppp)*cos(pi*qqq/floor(len_slices/2)/2);
        force_e(ppp,mm)=((dis_cc(ppp)+F_e(ppp)/len_slices*qqq)<=F/2)*force_e(ppp,mm)/N_max*2;
        
    end
end


Num_teeth=length(force_cc);
FW_slice=zeros((Num_teeth),len_slices);

for qq=1:(Num_teeth)
    FW_slice(qq,:)=linspace(dis_cc_dn(qq,1),dis_cc_up(qq,1),len_slices);
end

delta_num=round((N-(N/2+1+Num_teeth))/2);

lin=linspace(1+delta_num,Num_teeth+delta_num,Num_teeth);
lin_2=linspace(N/2+1+delta_num,N/2+1+Num_teeth+delta_num,Num_teeth);
FW_slice_2=-FW_slice;

lin_var=repmat(lin,len_slices,1);
lin_var_2=repmat(lin_2,len_slices,1);


results.FW_slice=FW_slice;
results.FW_slice_2=FW_slice_2;
results.F=F;
results.force_e=force_e;
results.lin_var=lin_var;
results.lin_var_2=lin_var_2;
results.N=N;

results.Ie=Ie;
results.z0=z0;
results.z9=z9;
results.q=q;

results.W1=W1;
results.W2=W2;
results.W3=W3;
results.S1=S1;
results.S2=S2;
results.S3=S3;


results.n_bf=n_bf;
results.n_cf=n_cf;
results.n_sf=n_sf;
results.n_by=n_by;
results.n_cy=n_cy;
results.n_sy=n_sy;

results.S_bending=S_bending*1000;
results.S_contact=S_contact*1000;
results.S_shear=S_shear*1000;



results.PHI=PHI;

results.R=R;
results.H1=H1;
results.C1=C1; % Coefficient for bending stress
results.C3=C3;  % Coefficient for shear stress
results.Z1=Z1;
results.Z2=Z2;
results.C=C;  % Single pair of teeth contact stiffness
results.TC_S=TC_S;
results.SC2=SC2;
results.I_max=I_max; % Maximm tilting angle before jamming
results.H=H;
results.C2=C2; % Coefficient for contact stress
results.I_var=I_var;
results.Torque_var=Torque_var;
results.Torque_rated=T_rated;
results.i_tol=tol_imax;
