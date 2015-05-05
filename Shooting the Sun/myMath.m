(* ::Package:: *)

(*Lab 12*) 

(*CONSTANTS*) 
t1 = List[];
t0 = 0;
phi = 0.436332313;
mSun = 1.99*10^30;
mEarth = 5.97*10^24; (*original = 5.97*10^24*) 
rES = 1.5*10^11;
rEarth = 6.37*10^6; 
rSun = 6.96*10^8;
vESC =  1.1*10^4; (*original = 1.1*10^4 *) 
SE = 1.5;
omega = 1.99*10^-7; (*original = 1.99*10^-7*) 
g = 9.81 ;
G = 6.574*10^-11;
LS = (rES*mEarth)/(mEarth + mSun);
LE = (rES*mSun)/(mEarth + mSun);
v0 = Sqrt[(G*mSun^2)/(rES*(mSun+mEarth))];
v0 = SE*vESC;

noIter = 1;
While [noIter< 1000,
	SE = RandomReal[{15,30}];
	(*SE = 0.7; *)
	degPhi = RandomReal[360];
	(*degPhi = 100;*)
	phi = degPhi * \[Pi]/180;
	v0 = SE*vESC;

	(*LIMITS OF INTEGRATION *) 

	deltaT = 500; 
	tmin = 0;
	t = tmin;
	tmax = 3*365*24*60*60; (* original =  3*365*24*60*60 *) 

(*INITIAL CONDITIONS*) 


	x0 = LE + rEarth*Cos[phi];
	v0X =  v0*Cos[phi];
	x1= x0+ (v0X*deltaT);

	y0 =  rEarth*Sin[phi];
	v0Y = (LE*omega)+  v0*Sin[phi];
	y1 = y0 + (v0Y*deltaT);
	xPROJ = x1;
	yPROJ = y1;
	(*
	myPath = List[]; 
	AppendTo[myPath,{x0,y0}];
	AppendTo[myPath,{x1,y1}];
	myPath;
	*)

	t = deltaT;

	dS = Sqrt[(x1 + LS*Cos[omega*t])^2+ (y1 + LS*Sin[omega*t])^2];
	dE = Sqrt[(x1 - LE*Cos[omega*t])^2+ (y1 -LE*Sin[omega*t])^2];
	ax = (-(G *mSun)*(x1 + LS*Cos[omega*t]) )/((dS)^3)  + (-(G *mEarth)*(x1- LE*Cos[omega*t]))/(dE)^3;
	ay = (-(G *mSun)*(y1 + LS*Sin[omega*t]) )/((dS)^3)  + (-(G *mEarth)*(y1- LE*Sin[omega*t]))/(dE)^3;

(*START ITERATIONS*) 
	While[t<tmax,
		dS = Sqrt[(x1 + LS*Cos[omega*t])^2+ (y1 + LS*Sin[omega*t])^2];
		dE = Sqrt[(x1 - LE*Cos[omega*t])^2+ (y1 -LE*Sin[omega*t])^2];
		a1x = -((G *mSun*(x1 + LS*Cos[omega*t]) )/((dS)^3) ) - (G *mEarth*(x1- LE*Cos[omega*t]))/(dE)^3;
		a1y =-((G *mSun*(y1 + LS*Sin[omega*t]) )/((dS)^3) ) - (G *mEarth*(y1- LE*Sin[omega*t]))/(dE)^3;
	
		xPROJ=2x1- x0 + a1x*deltaT^2;
		yPROJ=2y1- y0 + a1y*deltaT^2;
		(*AppendTo[myPath,{xPROJ,yPROJ}]; *)
		dC = Sqrt[xPROJ^2+yPROJ^2];

		(*If[dS<rSun, Print["SUN HIT"]];*)
		 If[dS<rSun, dC = -1];
		If[ dS< rSun, Break[]];
		(*If[dE<rEarth, Print["EARTH HIT"]];*)
		If[dE<rEarth, dC = -2];
		If[dE < rEarth, Break[]]; 

		x0 = x1;
		x1 = xPROJ;
		y0 = y1; 
		y1 = yPROJ; 
	
	
		t = t + deltaT; ];

	AppendTo[t1, {degPhi, SE, dC}];
	noIter++;
]
Export["myMathOutput.dat",t1]
Quit
