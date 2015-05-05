(* ::Package:: *)

trials = 100;
table = {};
Do[x1 = RandomReal[{0, \[Pi]}]; y1 = RandomReal[{0, 1}]; y2 = Sin[x1];
  If[y1 < y2, AppendTo[table, x1]],
  {i, 1, trials}];
Export["myMathOutput.dat",table];
Quit[]

