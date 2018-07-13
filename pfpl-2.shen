(datatype nat
  ___________
  zero : nat;

  A : nat;
  _______________
  [succ A] : nat;)

(datatype tree
  _____________
  empty : tree;

  A1 : tree; A2 : tree;
  ____________________
  [node A1 A2] : tree;)

(datatype list
  ___________
  nil : list;

  A : nat; B : list;
  __________________
  [cons A B] : list;)

(datatype evenodd
  ____________
  zero : even;
  
  A : odd;
  ________________
  [succ A] : even;

  A : even;
  _______________
  [succ A] : odd;)

(datatype fun
  B : nat;
  _______________
  [sum zero B B] : fun-proof;
  

  [sum A B C] : fun-proof;
  __________________________
  [sum [succ A] B [succ C]] : fun-proof;)

// TODO modes
