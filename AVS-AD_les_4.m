% Calculating the voltage over the capacitor, during charge, as function of
% time
 
	clc; 			% means clear Command Window
	clear all;		% means clear Workspace
	close all; 		% means close all figure/plots
% first we give the parameters some value
	R=500; 			% Resistor [Ohm]
	C=1.2E-6; 		% Capacity [F]
	tau=R*C; 		% RC time constant [s]
	Vin=0; 			% Input voltage
	V_init=12; 		% Starting voltage over the capacitor
% Now we specify an array with the amount of calculation points
	t=0:0.00012:0.012; 														% t is the time steps written in an array from 0 to 0.012 with step of 0.0012
	Vc=(V_init-Vin)*exp(-t/tau)+Vin; 										% calculating the voltage over the capacitor [V]
	I_t=(Vin-Vc)/R; 														% the current through the resistance as function of time [A]
	Ur=I_t*R; 																% is the voltage over R as function of time [V]
	[ax,L,R] = plotyy([t',t',t'],[Vin*ones(size(t))',Vc',Ur'],t,I_t),grid 	% plot t as x-axes for each curve and Vin, Vc, Ur on the left y-axes as function of time
% plot the current I_t on the secondary y-axis. the ' after each is to
% transform a row vector into a column vector
	title('RC circuit step response')
	legend('Input voltage','Capacitor voltage','Resistance voltage','Current')
	xlabel('time [s]')
	ylabel(ax(1),'Voltage [V]') 										% ylabel left side
	ylabel(ax(2),'Current [A]') 										% ylabel right side
	xlim([0 0.012]); ylim(ax(1),[-14 14]);ylim(ax(2),[-0.012 0.012]) 	% limits for the x and y axes
 
 
%% RC circuit for filter application
% first we give the parameters some value
	R2=1000; 	% Resistance [Ohm]
	C2=2.2E-6; 	% Capacity [F]


% Specify an array with the amount of calculated frequencies
	f=1:1E4; 				% f is the frequency steps written in an array from 1[Hz] to 10[kHz]
	Xc=1./(2*pi*f*C2); 		% Xc is the reactance of the capacitor for all frequencies of f. (Therefor we need the ‘dot’ before the command ‘divide’ – this also count when we take the power but not for an ordinary multplication).
	Z= sqrt(Xc.^2+R2^2);
	gain=Xc./Z; 			% Calculates the gain for each frequency f
	Adb=mag2db(gain); 		% Changes the magnitude in [db] for a logarithm scale
	phase=-atand(R2./Xc); 	% Calculates the phase shift in degrees
	figure(2)
	subplot(2,1,1) 			% 2-rows, 1 column, position nr 1
	semilogx(f,Adb),grid 	% plot a logarithm x-axis
	ylim([-40 10])
	title('Bode diagram of a CR circuit');
	ylabel('Gain [db]')


	subplot(2,1,2) 			% 2-rows, 1 column, position nr 2 – subplot 2 must have the same rows and colomns as subplot 1
	semilogx(f,phase),grid
	ylabel('Phase [deg]');
	xlabel('Frequency [Hz]');


%% RC circuit for filter application (option B: transfer function method)
	s=tf('s'); 	% means that s is not used as a parameter, but s is used for transferfunctions
	R3=1000; 	% Resistance [Ohm]
	C3=2.2E-6; 	% Capacity [F]
 
	Hrc=1/(R3*C3*s+1); % Hrc is the transferfunction of the RC ciruit
 
	figure(3) 					% create figure 3
	subplot(1,2,1); 			% Within this figure, plot 1 row and 2 coloms to depic the results
	step(Hrc),grid; 			% Depicts a stepresponse of Hrc. The grid finction depict the gridlines in the plot
	title('Step response of the RC circuit');
	subplot(1,2,2); 			% the last number indicates the position of the plot in the figure.
	p=bodeoptions; 				% Default bodeplot settings are rad/s. This co	mand can be used to change the default settings
	p.FreqUnits='Hz' 			% Change rad/s into Hz
	b=bodeplot(Hrc,p),grid,; 	% Depicts a bodeplot of Hrc
	title('Bode diagram of the RC circuit');


