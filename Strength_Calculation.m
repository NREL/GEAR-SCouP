function [S_bending,S_contact,S_shear,S_by,S_cy,S_sy]=Strength_Calculation(HT_method,Type,HB,Su_core,Su_case,S_yield_core,S_yield_case)

switch HT_method
    case 0 % Through_hardened
        
        
        if (HB==0)
            HB=200;
        end
        Su_case=0.5*HB;
        Su_core=0.5*HB;
        
        if (S_yield_case==0)
            S_yield_case=1.0242*Su_case-24.038;
        end
        if (S_yield_core==0)
            S_yield_core=1.0242*Su_core-24.038;
        end
        
        
        Se_d=0.5*Su_case;% Endurance limit of mechanical part
        
        if Su_case<86
            ka=0.76;
        elseif Su_case<101
            ka=0.74;
        elseif Su_case<126
            ka=0.70;
        elseif Su_case<151
            ka=0.68;
        elseif Su_case<176
            ka=0.66;
        elseif Su_case<201
            ka=0.64;
        end
        
        kb=0.85; % size factor
        kc=0.897; % reliablity factor
        kd=1.0; % temperature factor <160F;
        ke=1.0;kf=1.0; % stress concentration factor and misc effects
        Se=ka*kb*kc*kd*ke*kf*Se_d;
        Su=Su_case;
        S_bending=2*Se/(1+Se/Su);
        S_contact=2.56*Se/(1+Se/Su);
        S_shear=0.5*S_bending;
        S_yield=1.0242*Su-24.038;
        S_by=S_yield;
        S_cy=1.28*S_yield;
        S_sy=0.5*S_yield;
        
    case 1 % Carburized
        % need parameters s_yield for case and core!! and Su for case
        if (Su_case==0)
            Su_case=300;
        end
        if (Su_core==0)
            Su_core=180;
        end
        if (S_yield_case==0)
            S_yield_case=240;%1.0242*Su-24.038??? check this
        end
        if (S_yield_core==0)
            S_yield_core=140;
        end
        
        if Su_case>200
            Se_d=100;
        else
            Se_d=0.5*Su_case;
        end
        ka=0.63;
        kb=0.85; % size factor
        kc=0.897; % reliablity factor
        kd=1.0; % temperature factor <160F;
        ke=1.0;kf=1.0; % stress concentration factor and misc effects
        Se=ka*kb*kc*kd*ke*kf*Se_d;
        S_bending=2*Se/(1+Se/Su_case);
        S_contact=2.56*Se/(1+Se/Su_case);
        S_shear=0.5*S_bending;
        S_by=S_yield_core;
        S_cy=1.28*S_yield_case;
        S_sy=0.5*S_yield_core;
        
    case 2 % Nitrided
        
        if (Su_case==0)
            Su_case=300;
        end
        if (Su_core==0)
            Su_core=160;
        end
        if (S_yield_case==0)
            S_yield_case=230;%1.0242*Su-24.038??? check this
        end
        if (S_yield_core==0)
            S_yield_core=140;
        end
        
        
        Se_d=0.5*Su_core;
        ka=0.67;
        kb=0.85; % size factor
        kc=0.897; % reliablity factor
        kd=1.0; % temperature factor <160F;
        ke=1.0;kf=1.0; % stress concentration factor and misc effects
        Se=ka*kb*kc*kd*ke*kf*Se_d;
        S_bending=2*Se/(1+Se/Su_core);
        
        Se_dc=100;
        ka_c=0.63;
        kb_c=0.85; % size factor
        kc_c=0.897; % reliablity factor
        kd_c=1.0; % temperature factor <160F;
        ke_c=1.0;kf_c=1.0; % stress concentration factor and misc effects
        Se_c=ka_c*kb_c*kc_c*kd_c*ke_c*kf_c*Se_dc;
        
        S_contact=2.56*Se_c/(1+Se_c/Su_case);  % follow carburized
        S_shear=0.5*S_bending;
        S_yield=S_yield_core;
        S_cy=1.28*S_yield;
        S_sy=0.5*S_yield;
        S_by=S_yield;
        
    case 3 % Induction-Hardened
        if Type==1 % Flank and root hardened
            
            if (Su_case==0)
                Su_case=250;
            end
            if (Su_core==0)
                Su_core=140;
            end
            if (S_yield_case==0)
                S_yield_case=230;%1.0242*Su-24.038??? check this
            end
            if (S_yield_core==0)
                S_yield_core=120;
            end
            
            if Su_case>200
                Se_d=100;
            else
                Se_d=0.5*Su_case;
            end
            ka=0.63;
            kb=0.85; % size factor
            kc=0.897; % reliablity factor
            kd=1.0; % temperature factor <160F;
            ke=1.0;kf=1.0; % stress concentration factor and misc effects
            Se=ka*kb*kc*kd*ke*kf*Se_d;
            S_bending=2*Se/(1+Se/Su_case);
            S_contact=2.56*Se/(1+Se/Su_case);
            S_shear=0.5*S_bending;
            S_yield=S_yield_core;
            S_cy=1.28*S_yield_case;
            S_sy=0.5*S_yield_core;
            S_by=S_yield;
        elseif Type==2
            
            % Flank hardened only (root soft)
            if (Su_case==0)
                Su_case=250;
            end
            if (Su_core==0)
                Su_core=140;
            end
            if (S_yield_case==0)
                S_yield_case=230;%1.0242*Su-24.038??? check this
            end
            if (S_yield_core==0)
                S_yield_core=120;
            end
            
            Se_d=0.5*Su_core;
            ka=0.7;
            kb=0.85; % size factor
            kc=0.897; % reliablity factor
            kd=1.0; % temperature factor <160F;
            ke=0.5;
            kf=1.0; % stress concentration factor and misc effects
            Se=ka*kb*kc*kd*ke*kf*Se_d;
            S_bending=2*Se/(1+Se/Su_core);
            
            % contact follow the flank definition
           if Su_case>200
                Se_d=100;
            else
                Se_d=0.5*Su_case;
            end
            ka=0.63;
            kb=0.85; % size factor
            kc=0.897; % reliablity factor
            kd=1.0; % temperature factor <160F;
            ke=1.0;kf=1.0; % stress concentration factor and misc effects
            Se_c=ka*kb*kc*kd*ke*kf*Se_d;
            %
            %                  Se_c=48;
            S_contact=2.56*Se_c/(1+Se_c/Su_case);
            %
            S_shear=0.5*S_bending;
            S_yield=S_yield_core;
            S_cy=1.28*S_yield_case;
            S_sy=0.5*S_yield;
            S_by=S_yield;
        else
        end
        
    otherwise
        
end
