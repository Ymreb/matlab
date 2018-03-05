% Brake Force Distribution
% Assignment AVS - Propaedeutic block 3
% Author: R. Gerritsen - HAN Automotive - jan 2018

% Model to calculate the brake forces and the distribution
% based on a static equilibrium of axle load



% clears previous values
clc, clear all, close all

% Input vehicle parameters
m = 12300;          						% Vehicle mass [kg]
Wb = 6.35;          						% Wheelbase [m]
COG_1 = 4.5;    						   	% Distance CoG to front axle [m]
COG_z = 1.75;       						% Height of CoG [m]
g = 9.81;           						% gravitational acceleration [m/s2]
ax = 0;             						% Acceleration in steady state situation

% Calculated vehicle parameters
COG_2 = Wb-COG_1     						% Distance CoG to rear axle [m]
Fz = m*g             						% Total force by the weight of the vehicle [N]
Fb = m*ax            						% Brake force in steady state situation
mu = ax/g            						% Friction coefficient

% Equilibrium of vertical forces
Fz1 	= m*(g*COG_2 + COG_z*ax)/Wb;        % Normal force front axle [N]
Fz2 	= m*(g*COG_1 - COG_z*ax)/Wb;        % Normal force rear axle [N]
Fx1 	= mu*Fz1;                           % Brake force front axle [N]
Fx2 	= mu*Fz2;                           % Brake force rear axle [N]

% Dynamic calculations for different accelerations in x-direction (ax)
ax 		= [0:10];         					% Varying the brake acceleration      
Fz1 	= m*(g*COG_2 + COG_z*ax)/Wb;
Fz2 	= m*(g*COG_1 - COG_z*ax)/Wb;
mu 		= ax/g;
Fx1 	= mu.*Fz1;            				% Use .* to multiplicate the two vectors 
Fx2 	= mu.*Fz2;            				% Use .* to multiplicate the two vectors    
Phi1 	= Fx1/(m*g);
Phi2 	= Fx2/(m*g);

% Plot figures of axle loads, brake forces and distribution
figure	(1)
subplot	(2,2,1)
plot	(ax,Fz1,'r',ax,Fz2','b')
title	('Axle load')
axis	([0 inf, 0 inf])
xlabel	('acceleration [m/s^2]')
ylabel	('forces [N]')
legend	('Fz1: front axle','Fz2: rear axle')
 
subplot	(2,2,2)
plot	(ax,Fx1,'r',ax,Fx2,'b')  
title	('Max. brake forces')
axis	([0 inf, 0 inf])
xlabel	('acceleration [m/s^2]')
ylabel	('forces [N]')
legend	('Fx1','Fx2')
 
subplot	(2,2,3)
plot	(Fx1,Fx2,'r')
title	('Brake force distribution')
axis	([0 inf, 0 inf])
xlabel	('Front axle [N]')
ylabel	('Rear axle [N]')
 
subplot	(2,2,4)
plot	(Phi1,Phi2,'r')
title	('Brake force distribution')
axis	([0 inf, 0 inf])
xlabel	('Phi1 - front [-]')
ylabel	('Phi2 - rear [-]')
