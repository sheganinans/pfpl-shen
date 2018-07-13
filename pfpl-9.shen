(datatype godel-t
  ________
  z : nat;

  E : nat;
  ___________
  [s E] : nat;

  E : nat;
  E0 : nat;
  X : nat, Y : T >> E1 : T;
  ______________________
  [rec E E0 X Y E1] : T;

  X : P >> E : T;
  ________________________
  [lam P X E] : (arr P T);

  E1 : (arr T2 T);
  E2 : T2;
  _______________
  [ap E1 E2] : T;)
