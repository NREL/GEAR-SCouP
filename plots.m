function plots(val,parameters,results,fh,ax,th_1)
toplot_1=val(1);
toplot_1=1;
toplot_2=val(3);
toplot_3=val(2);
toplot_4=val(4);
% input parameters
D2R=1;  % Degree to radian

tol_imax=results.i_tol;

Ie=results.Ie;
z0=results.z0;
z9=results.z9;
q=results.q;
W1=results.W1;
W2=results.W2;
W3=results.W3;
S1=results.S1;
S2=results.S2;
S3=results.S3;
n_bf=results.n_bf;
n_cf=results.n_cf;
n_sf=results.n_sf;
n_by=results.n_sf;
n_cy=results.n_cy;
n_sy=results.n_sy;
S_bending=results.S_bending;
S_contact=results.S_contact;
S_shear=results.S_shear;
T_rated=results.Torque_rated;
FW_slice=results.FW_slice;
FW_slice_2=results.FW_slice_2;
F=results.F;
force_e=results.force_e;
lin_var=results.lin_var;
lin_var_2=results.lin_var_2;
N=results.N;


PHI=results.PHI;
I_max=results.I_max; % Maximm tilting angle before jamming
I_var=results.I_var;
Torque_var=results.Torque_var;
len_I=length(I_var);
len_torque=length(Torque_var);


figure(fh);
if len_I>1 && len_torque>1
    
    if toplot_1==1;
%         h=figure('Name','Coupling Loads','Position',[400 0 1500 1500]);
        hold on;
        linestyle='k-';
        subplot(3,4,2);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,Ie'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Equivalent Parallel Offset, in');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,3);
        [X,Y]=meshgrid(I_var(2:end)/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,z0(2:end,:)'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Maximum Tooth Separation, in');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,4);
        [X,Y]=meshgrid(I_var(2:end)/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,z9(2:end,:)'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('ZE/Z0=Ratio Tooth Deformation');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,6);
        [X,Y]=meshgrid(I_var(2:end)/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,q(2:end,:)'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('load Sharing Factor');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,7);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,W1'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Total Tangential Load, lb');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,8);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,W3'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Max Tooth Load, lb');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,10);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,S1'*scale);ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Bending Stress, psi');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,11);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,S2'*scale);ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Hertizian Stress, psi');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(3,4,12);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,S3'*scale);ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Shear Stress, psi');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        
        Index=find(abs(I_var-I_max)<tol_imax);
        linestyle='k*';
        linestyle_2='g.';
        factor=1.0;
        if ~isempty(Index)
            subplot(3,4,2);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,Ie(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,Ie(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,3);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,z0(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,z0(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,4);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,z9(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,z9(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,6);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,q(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,q(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,7);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,W1,linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,W1(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,8);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,W3(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,W3(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,10);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,S1(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,S1(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,11);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,S2(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,S2(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,12);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,S3(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,S3(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
        else
            subplot(3,4,2);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,3);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,4);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,6);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,7);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,8);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,10);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,11);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,12);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
        end
    else
    end
    if toplot_3==1;
          linestyle_2='g.';
               [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        subplot(3,4,10);
        hold on; plot3(X,Y,S_bending*ones(size(X)),linestyle_2);hold on;
        text(0,1,S_bending*factor,'Bending Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,11);
        hold on; plot3(X,Y,S_contact*ones(size(X)),linestyle_2);hold on;
        text(0,1,S_bending*factor,'Contact Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,12);hold on; plot3(X,Y,S_shear*ones(size(X)),linestyle_2);hold on;
        text(0,1,S_shear*factor,'Shear Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
    else
    end
    
    if toplot_2==1;
        % plot safety factors;
        % h=figure('Name','Coupling Safety factors','Position',[400 0 1500 1500]);
        hold on;
        linestyle='k-';
        subplot(2,4,2);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_bf'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Bending factor based on fatigue');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(2,4,3);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_cf'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Contact factor based on fatigue');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(2,4,4);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_sf'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Shear factor based on fatigue');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(2,4,6);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_by'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Bending factor based on yielding');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(2,4,7);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_cy'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Contact factor based on yielding');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        subplot(2,4,8);
        [X,Y]=meshgrid(I_var/D2R,Torque_var/T_rated);scale=1;
        h=surfc(X,Y,n_sy'*scale);axis tight;ylabel('Torque/Rated');xlabel('Misalignment, o');zlabel('Shear factor based on yielding');
        shading interp;
        colormap(jet)
        alpha(0.8)
        grid on; box off;
        hold on;
        
        % Index=find(abs(I_var-I_max)<tol_imax);
        linestyle='k*';
        % factor=1.2;
            Index=find(abs(I_var-I_max)<tol_imax);
        if ~isempty(Index)
            subplot(2,4,2);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_bf(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_bf(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,3);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_cf(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_cf(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,4);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_sf(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_sf(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,6);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_by(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_by(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,7);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_cy(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_cy(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,8);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,n_sy(Index(1),:),linestyle);
            text(I_max/D2R,Torque_var(end)/T_rated,n_sy(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            hold on; plot3(X,Y,ones(size(X)),linestyle_2);hold on;
            text(0,1,1,'Safety boundary', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            
        else
            subplot(2,4,2);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,3);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,4);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,6);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,7);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(2,4,8);plot3(I_max/D2R*ones(len_torque,1),Torque_var/T_rated,zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
        end
    end
    
    
elseif (len_I==1 && len_torque==1)
%     if I_var==0
%     table_data=[Torque_var,I_var/D2R,Ie, z0,z9,q,W1,W2,S1,S2,S3,n_bf,n_cf,n_sf,n_by,n_cy,n_sy,S_bending,S_contact,S_shear,I_max/D2R];
%     else
%     table_data=[Torque_var,I_var/D2R,Ie, z0,z9,q,W1,W3,S1,S2,S3,n_bf,n_cf,n_sf,n_by,n_cy,n_sy,S_bending,S_contact,S_shear,I_max/D2R];
%     end
%     DataNames = {'Torque, in-lb',...
%         'Misalignment, degree',...
%         'Equivalent Parallel Offset, in',...
%         'Maximum Tooth Separation, in',...
%         'Tooth Deformation Ratio',...
%         'Load Sharing Factor',...
%         'Total Tangential Load, lb',...
%         'Max Tooth Load, lb',...
%         'Bending Stress, psi',...
%         'Hertizian Stress, psi',...
%         'Shear Stress, psi',...
%         'Safety factor, bending, fatigue',...
%         'Safety factor, contact, fatigue',...
%         'Safety factor, shear, fatigue',...
%         'Safety factor, bending, yield',...
%         'Safety factor, contact, yield',...
%         'Safety factor, shear, fatigue',...
%         'Strength_bending,psi',...
%         'Strength_contact,psi',...
%         'Strength_shear, psi',...
%         'I_max, degree'};
%     rnames = {'Value'};
%     columneditable =  [true];
%     rnames = {'Value'};
%     th_1 = uitable('Parent',fh,'Data',table_data','ColumnName',rnames ,'ColumnEditable', columneditable,'ColumnWidth',{100},...
%         'RowName',DataNames,'Position',[550 280 750 550]);
%     set(th_1,'Enable','on');
if toplot_4==1
subplot(2,2,4);
[C,h]=contourf(FW_slice'/F+0.5,lin_var,force_e','ko');grid off;
hold on;
[C,h]=contourf(FW_slice_2'/F+0.5,lin_var_2,force_e','ko');
hold on;
[C,h]=contourf(FW_slice_2'/F+0.5,lin_var_2,force_e','ko');
set(h,'ShowText','off','TextStep',get(h,'LevelStep')*0.001)

colormap jet
hold on;
colorbar('location','EastOutside')
ylabel('Tooth Number','fontsize',12);xlabel('Facewidth, dimensionless','fontsize',12);
title('Tooth Load Pattern, N','fontsize',12)
ylim([1 N]);xlim([0 1]);
end
elseif (len_I>1 && len_torque==1)
    
    if toplot_1==1;
        % h=figure('Name','Coupling Loads','Position',[400 0 1500 1500]);
        hold on;
        linestyle='k-';
        subplot(3,4,2);
        h=plot(I_var/D2R,Ie');axis tight;xlabel('Misalignment, o');ylabel('Equivalent Parallel Offset, in');
        hold on;
        subplot(3,4,3);
        [X,Y]=meshgrid(I_var(2:end)/D2R,Torque_var/T_rated);scale=1;
        h=plot(I_var(2:end)/D2R,z0(2:end,:)');axis tight;xlabel('Misalignment, o');ylabel('Maximum Tooth Separation, in');
        hold on;
        subplot(3,4,4);
        h=plot(I_var(2:end)/D2R,z9(2:end,:)');axis tight;xlabel('Misalignment, o');ylabel('ZE/Z0=Ratio Tooth Deformation');
        hold on;
        subplot(3,4,6);
        h=plot(I_var(2:end)/D2R,q(2:end,:)');axis tight;xlabel('Misalignment, o');ylabel('load Sharing Factor');
        hold on;
        subplot(3,4,7);
        h=plot(I_var/D2R,W1');axis tight;xlabel('Misalignment, o');ylabel('Total Tangential Load, lb');
        hold on;
        subplot(3,4,8);
        h=plot(I_var/D2R,W3');axis tight;xlabel('Misalignment, o');ylabel('Max Tooth Load, lb');
        hold on;
        subplot(3,4,10);
        h=plot(I_var/D2R,S1');xlabel('Misalignment, o');ylabel('Bending Stress, psi');
        hold on;
        subplot(3,4,11);
        h=plot(I_var/D2R,S2');xlabel('Misalignment, o');ylabel('Hertizian Stress, psi');
        hold on;
        subplot(3,4,12);
        h=plot(I_var/D2R,S3');xlabel('Misalignment, o');ylabel('Shear Stress, psi');
        hold on;
        
        Index=find(abs(I_var-I_max)<tol_imax);
        linestyle='k*';
        linestyle_2='g.';
        factor=1.2;
        if ~isempty(Index)
            subplot(3,4,2);plot(I_max/D2R*ones(len_torque,1),Ie(Index(1),:),linestyle);
            text(I_max/D2R,Ie(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,3);plot(I_max/D2R*ones(len_torque,1),z0(Index(1),:),linestyle);
            text(I_max/D2R,z0(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,4);plot(I_max/D2R*ones(len_torque,1),z9(Index(1),:),linestyle);
            text(I_max/D2R,z9(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,6);plot(I_max/D2R*ones(len_torque,1),q(Index(1),:),linestyle);
            text(I_max/D2R,q(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,7);plot(I_max/D2R*ones(len_torque,1),W1,linestyle);
            text(I_max/D2R,W1(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,8);plot(I_max/D2R*ones(len_torque,1),W3(Index(1),:),linestyle);
            text(I_max/D2R,W3(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            subplot(3,4,10);plot(I_max/D2R*ones(len_torque,1),S1(Index(1),:),linestyle);
            text(I_max/D2R,S1(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,11);plot(I_max/D2R*ones(len_torque,1),S2(Index(1),:),linestyle);
            text(I_max/D2R,S2(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,12);plot(I_max/D2R*ones(len_torque,1),S3(Index(1),:),linestyle);
            text(I_max/D2R,S3(Index(1),end)*factor,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
        else
            subplot(3,4,2);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,3);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,4);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,6);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,7);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,8);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,10);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,11);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
            subplot(3,4,12);plot(I_max/D2R*ones(len_torque,1),zeros(len_torque,1),linestyle);
            text(I_max/D2R,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
            axis tight;
        end
    else
    end
    if toplot_3==1;
        subplot(3,4,10);
        hold on; plot(I_var/D2R,S_bending*ones(size(I_var)),linestyle_2);hold on;
        text(0,S_bending*factor,'Bending Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,11);
        hold on; plot(I_var/D2R,S_contact*ones(size(I_var)),linestyle_2);hold on;
        text(0,S_bending*factor,'Contact Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,12);hold on; plot(I_var/D2R,S_shear*ones(size(I_var)),linestyle_2);hold on;
        text(0,S_shear*factor,'Shear Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
    else
    end
    
    if toplot_2==1;
        % plot safety factors;        
        hold on;
        linestyle='k-';
        subplot(2,4,2);
        scale=1;
        h=plot(I_var/D2R,n_bf'*scale);axis tight;xlabel('Misalignment, o');ylabel('Bending factor based on fatigue');
        hold on;
        subplot(2,4,3);
        h=plot(I_var/D2R,n_cf'*scale);axis tight;xlabel('Misalignment, o');ylabel('Contact factor based on fatigue');
        hold on;
        subplot(2,4,4);
        h=plot(I_var/D2R,n_sf'*scale);axis tight;xlabel('Misalignment, o');ylabel('Shear factor based on fatigue');
        hold on;
        subplot(2,4,6);
        h=plot(I_var/D2R,n_by'*scale);axis tight;xlabel('Misalignment, o');ylabel('Bending factor based on yielding');
        hold on;
        subplot(2,4,7);
        h=plot(I_var/D2R,n_cy'*scale);axis tight;xlabel('Misalignment, o');ylabel('Contact factor based on yielding');
        hold on;
        subplot(2,4,8);
        h=plot(I_var/D2R,n_sy'*scale);axis tight;xlabel('Misalignment, o');ylabel('Shear factor based on yielding');
        hold on;
        
        % Index=find(abs(I_var-I_max)<tol_imax);
        linestyle='k*';
        % factor=1.2;
        if ~isempty(Index)
        subplot(2,4,2);plot(I_max/D2R*ones(len_torque,1),Ie(Index(1),:),linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(2,4,3);plot(I_max/D2R*ones(len_torque,1),z0(Index(1),:),linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(2,4,4);plot(I_max/D2R*ones(len_torque,1),z9(Index(1),:),linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(2,4,6);plot(I_max/D2R*ones(len_torque,1),q(Index(1),:),linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(2,4,7);plot(I_max/D2R*ones(len_torque,1),W1,linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(2,4,8);plot(I_max/D2R*ones(len_torque,1),W3(Index(1),:),linestyle);
        text(I_max/D2R,0,0,'Max/Jam I', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        end
        
    end
    
elseif (len_I==1 && len_torque>1)
    
    if toplot_1==1;
        % h=figure('Name','Coupling Loads','Position',[400 0 1500 1500]);
        hold on;
        linestyle='k-';
        subplot(3,4,2);
        h=plot(Torque_var/T_rated,Ie');axis tight;xlabel('Torque/Rated');ylabel('Equivalent Parallel Offset, in');
        hold on;
        subplot(3,4,3);
        h=plot(Torque_var/T_rated,z0');axis tight;xlabel('Torque/Rated');ylabel('Maximum Tooth Separation, in');
        hold on;
        subplot(3,4,4);
        h=plot(Torque_var/T_rated,z9');axis tight;xlabel('Torque/Rated');ylabel('ZE/Z0=Ratio Tooth Deformation');
        hold on;
        subplot(3,4,6);
        h=plot(Torque_var/T_rated,q');axis tight;xlabel('Torque/Rated');ylabel('load Sharing Factor');
        hold on;
        subplot(3,4,7);
        h=plot(Torque_var/T_rated,W1');axis tight;xlabel('Torque/Rated');ylabel('Total Tangential Load, lb');
        hold on;
        subplot(3,4,8);
        h=plot(Torque_var/T_rated,W3');axis tight;xlabel('Torque/Rated');ylabel('Max Tooth Load, lb');
        hold on;
        subplot(3,4,10);
        h=plot(Torque_var/T_rated,S1');xlabel('Torque/Rated');ylabel('Bending Stress, psi');
        hold on;
        subplot(3,4,11);
        h=plot(Torque_var/T_rated,S2');xlabel('Torque/Rated');ylabel('Hertizian Stress, psi');
        hold on;
        subplot(3,4,12);
        h=plot(Torque_var/T_rated,S3');xlabel('Torque/Rated');ylabel('Shear Stress, psi');
        hold on;
        
        Index=find(abs(I_var-I_max)<tol_imax);
        linestyle='k*';
        linestyle_2='g.';
        factor=1.2;
    else
    end
    if toplot_3==1;
        subplot(3,4,10);
        hold on; plot(Torque_var/T_rated,S_bending*ones(size(Torque_var)),linestyle_2);hold on;
        text(0,S_bending*factor,'Bending Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,11);
        hold on; plot(Torque_var/T_rated,S_contact*ones(size(Torque_var)),linestyle_2);hold on;
        text(0,S_bending*factor,'Contact Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
        subplot(3,4,12);
        hold on; plot(Torque_var/T_rated,S_shear*ones(size(Torque_var)),linestyle_2);hold on;
        text(0,S_shear*factor,'Shear Strength', 'VerticalAlignment','bottom','HorizontalAlignment','left','Rotation',0,'BackgroundColor',[.7 .9 .7],'FontWeight','bold','FontSize',12);hold on;
        axis tight;
    else
    end
    
    if toplot_2==1;
        % plot safety factors;
        
        hold on;
        linestyle='k-';
        subplot(2,4,2);
        scale=1;
        h=plot(Torque_var/T_rated,n_bf'*scale);axis tight;xlabel('Torque/Rated');ylabel('Bending factor based on fatigue');
        hold on;
        subplot(2,4,3);
        h=plot(Torque_var/T_rated,n_cf'*scale);axis tight;xlabel('Torque/Rated');ylabel('Contact factor based on fatigue');
        hold on;
        subplot(2,4,4);
        h=plot(Torque_var/T_rated,n_sf'*scale);axis tight;xlabel('Torque/Rated');ylabel('Shear factor based on fatigue');
        hold on;
        subplot(2,4,6);
        h=plot(Torque_var/T_rated,n_by'*scale);axis tight;xlabel('Torque/Rated');ylabel('Bending factor based on yielding');
        hold on;
        subplot(2,4,7);
        h=plot(Torque_var/T_rated,n_cy'*scale);axis tight;xlabel('Torque/Rated');ylabel('Contact factor based on yielding');
        hold on;
        subplot(2,4,8);
        h=plot(Torque_var/T_rated,n_sy'*scale);axis tight;xlabel('Torque/Rated');ylabel('Shear factor based on yielding');
        hold on;
        
    end
    
end


end