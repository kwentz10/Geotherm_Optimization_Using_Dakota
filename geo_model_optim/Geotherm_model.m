% Finite Difference Model of Geotherm + Surface Temperature Warming
% Jan 25 2016

clear all
figure(1)
clf

%% BOREHOLE DATA

load cape_thompson.dat;
data_depth=cape_thompson(:,1);
data_T=cape_thompson(:,2);

%% INITIALIZE

%Constants
k = 2.5; %W/mK
rho = 2000; %kg/m3
Cp = 2000; % J/kg K
kappa = k/(rho*Cp);

%Space Array
N = 100; %number of points
maxdepth=400; %m
dz = maxdepth/N; %spacing in m
z=transpose(0:dz:(dz*(N-1)));

%Time Array
years_elapsed=200; %years
tmax=years_elapsed*24*3600*365; %years to run the code, converted to seconds
years_time_step=1/100; %fraction of a year
dt=years_time_step*24*3600*365; %increment of time step, converted to seconds
t=transpose(0:dt:tmax); %time array
imax=length(t); %for use in time loop max time
nplots=100; %number of plots generated
tplot=tmax/nplots; %time at which to generate plots

%Variable Arrays
Q=zeros(N,1);
T=zeros(N,1);
dTdz=zeros(N,1);

%Boundaries and Initial Conditions
data_bottom_depth=data_depth(end); %deepest depth point in the borehole data (least affected by temp change at the surface)
data_bottom_T=data_T(end); %deepest temperature point in the data file (least affected by temp change at the surface)
slope=diff(data_T)./diff(data_depth); %dTdz slope for borehole data
dTdz_data=mean(slope(end-5:end)); %take the average of bottom five dtdz slope (least affected by temp change at the surface)
Ts_initial=data_bottom_T-(dTdz_data*data_bottom_depth); %solve for surface temperature intercept
data_geotherm=Ts_initial+(dTdz_data*data_depth); %final equation of straight line geotherm for the data set

%Create Initial T Equation & Changing T Equation
dTdz_initial=dTdz_data; %copy of calculated slope of data
T=Ts_initial+(dTdz_initial*z); %initial condition of temperature is the geotherm extracted from the base of the experimental data
T_initial_condition=T; %create a copy of the original geotherm
dTdz(N)=dTdz_data; %keep model heat flux from the base the same as the heat flux determined from the data set

%% READ params.in

%Load in total_surface_temp_change Parameter (flexible)
fid = fopen(params,'r');
C = textscan(fid,'%n%s');
fclose(fid);

num_vars = C{1}(1);
	

% set design variables -- could use vector notation
% geotherm x1

total_surface_temp_change = C{1}(2);

%Surface Temperature Change
%total_surface_temp_change=2; %degrees C  %CHANGING PARAMETER
dT=total_surface_temp_change/imax; %degrees C


%% RUN Geotherm Model

for i=1:imax
    
   %Surface Temperature
    T(1)=T(1)+dT; %degrees C
  
   %Heat Diffusion
    dTdz(1:N-1)=diff(T)/dz; %temperature gradient over depth
    Q= -k*dTdz; %heat flux
    dqdz= diff(Q)/dz; %rate of temperature change over depth

    %Update Temperature
    T(2:N) = T(2:N) - (1/(rho*Cp))*dqdz*dt; %update all nodes below the surface
    
end


%% WRITE results.out

fid = fopen(results,'w');
fprintf(fid,'%20.10e     f\n', f);
%fprintf(fid,'%20.10e     params\n', C{1}(2:5));

fclose(fid);



