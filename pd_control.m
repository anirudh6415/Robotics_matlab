function re = pd_control(dhs,L,KR,ML,MM,IL,IM,K_D,K_P,f,xd)
% clc
% close all
% 
% syms t1 t2 t3
% syms c1 c12 c123 s1 s12 s123 % for abbreviation
% DH parameters
% change_PD_control_RTB
    %
    getBCG
    load BCG_value.mat
    Ts = 0.02;
    %disp(dhs)
    a = dhs(:,3);%[1 1 1]';
    %disp(a);
    l = L *a'; %0.5*a';% com
    mm = MM*[1 1 1]';  %50*[1 1 1]';
    iL = IL*[1 1 1]'; %11*[1 1 1]';
    kr = KR*[1 1 1]';%110*[1 1 1]';
    im = IM*[1 1 1]'; %0.03*[1 1 1]';
    % Id = [0 0 0;0 0 0;0 0 1];
    mL = ML*[1 1 1]'; %50*[1 1 1]';
    
    xd = xd;%[1 1 0];
    K_D = K_D;%200;
    K_P = K_P;% 450;
    friction = f;%1;
    qi = [0.5;0.5;0.5];
    % Ts =0.002;
    % DH parameters
    alpha = dhs(:,2);%[0, 0, 0]; 
    a     = [a(1),a(2),a(3)];
    d     = dhs(:,4); %[0, 0, 0];
    % q = [q(1), q(2), q(3)];
    options=simset('SrcWorkspace','current','DstWorkspace','current');
    sim(['force_control.slx'],10, options)
    
    
    % plot desired vs actual end-effector position and contact force
    figure('Name','Indirect force control through PD control');
    
    % plot xe xd at x axis
    subplot(4,1,1);
    plot(ans.time,ans.xe(:,1))
    hold on;
    plot(ans.time,xd(1)*ones(length(ans.time)))
    xlabel('s')
    ylabel('mm')
    title('desired vs actual end-effector at x direction');
    
    % plot ye yd at y axis
    subplot(4,1,2);
    plot(ans.time,ans.xe(:,1))
    hold on;
    plot(ans.time,xd(2)*ones(length(ans.time)))
    xlabel('s')
    ylabel('mm')
    title('desired vs actual end-effector at y direction');
    
    % end effector contact force
    subplot(4,1,3); 
    plot(ans.time,ans.f(:,1))
    xlabel('s')
    ylabel('N')
    title('contact force at x direction');
    
    subplot(4,1,4); 
    plot(ans.time,ans.f(:,2))
    xlabel('s')
    ylabel('N')
    title('contact force at y direction');
