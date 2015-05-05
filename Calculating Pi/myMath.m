(* ::Package:: *)


nthrows = 10000;
radius=1.0;
nhits=0;

Do[x0=RandomReal[{0,radius}];
y0=RandomReal[{0,radius}];
r0=Sqrt[x0^2 + y0^2];
If[r0<=radius, nhits++],
{i,1,nthrows}
]; 

dnhits = Sqrt[nhits];
myPi=4*nhits/nthrows;
dmyPi=4*dnhits/nthrows;
ratio = myPi/\[Pi];
dratio=dmyPi/\[Pi];
results={nhits,nthrows};
Print["myPi=",N[myPi]," \[PlusMinus] ",N[dmyPi],"; Ratio =",N[ratio]," \[PlusMinus] ",N[dratio]]


Export["myMathOutput.dat", results]
Quit[]
