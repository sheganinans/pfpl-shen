(datatype transition-system
\\  ______________________
\\  [S ~>* S] : transition;

\\  [S ~> 1 S1] : transition;
\\  [S1 ~>* S2] : transition;
\\  _______________________
\\  [S ~>* S2] : transition;

  ________________________
  [S ~> 0 S] : transition;

  [S ~> 1 S1] : transition;
  [S1 ~> N S2] : transition;
  _______________________________
  [S ~> (+ 1 N) S2] : transition;)


(datatype struct-dyn

  if (= N (+ N1 N2))
  _____________________________________________________
  [[plus [num N1] [num N2]] ~> 1 [num N]] : transition;

  [E1 ~> 1 E1'] : transition;
  _______________________________________________
  [[plus E1 E2] ~> 1 [plus E1' E2]] : transition;

  [E2 ~> 1 E2'] : transition;
  _________________________________________________________
  [[plus [num N] E2] ~> 1 [plus [num N] E2']] : transition;)


(datatype ctx-dyn
  __________
  o : ectxt;

  E1 : ectxt;
  E2 : num-expr;
  _____________________
  [plus E1 E2] : ectxt;

  E2 : ectxt;
  ______________
  [plus [num N] E2] : ectxt;


  C : ectxt;
  E : num-expr;
  ____________________
  [ctx C E] : ctx-c;

  ____________________
  [E eq [ctx o E]] : judgem;

  [E1 eq [ctx E1ctx E]] : judgem;
  ______________
  [[plus E1 E2] eq [ctx [plus E1ctx E2] E]] : judgem;

  [E2 eq [ctx E2ctx E]] : judgem;
  ______________
  [[plus [num N] E2] eq [ctx [plus [num N] E2] E]] : judgem;


  [E eq [ctx Ectx E0]] : judgem;
  [E0 ~> 1 E0'] : transition;
  [E' eq [ctx Ectx E0']] : judgem;
  ______________
  [E ~> 1 E'] : transition;)


(datatype fun-eq

  E : T;
  ==================
  [E eq E] : (eq T);


  [E1 eq E1'] : (eq num); [E2 eq E2'] : (eq num);
  ============================================
  [[plus E1 E2] eq [plus E1' E2']] : (eq num);
  
  [E1 eq E1'] : (eq str); [E2 eq E2'] : (eq str);
  ==========================================
  [[cat E1 E2] eq [cat E1' E2']] : (eq str);
  

  [E1 eq E1'] : (eq T1);
  X : T1 >> [E2 eq E2'] : (eq T2);
  _____________________________________________
  [[let E1 X E2] eq [let E1' X E2']] : (eq T2);

  if (= N (+ N1 N2))
  _________________________________________________
  [[plus [num N1] [num N2]] eq [num N]] : (eq num);

  ____________________________________________
  [[let E1 X E2] eq (subst X E1 E2)] : (eq T);)


(datatype eval-ts \\ Make more like the book?

  N : number;
  ==============
  [num N] : val;

  S : string;
  ==============
  [str S] : val;


  A : val; B : val;
  =================
  [plus A B] : val;

  A : val; B : val;
  ==================
  [times A B] : val;

  A : val; B : val;
  ================
  [cat A B] : val;

  A : val;
  ==============
  [len A] : val;

  X : val;
  Y : val;
  Z : val;
  ==================
  [let X Y Z] : val;)


(define eval-lns {val --> val}
  [plus [num A] [num B]] -> [num (+ A B)]
  [plus [num A] B] -> (eval-lns [plus [num A] (eval-lns B)])
  [plus A [num B]] -> (eval-lns [plus (eval-lns A) [num B]])
  [times [num A] [num B]] -> [num (* A B)]
  [times [num A] B] -> (eval-lns [times [num A] (eval-lns B)])
  [times A [num B]] -> (eval-lns [times (eval-lns A) [num B]])
  [cat [str A] [str B]] -> [str (@s A B)]
  [cat A [str B]] -> (eval-lns [cat (eval-lns A) [str B]])
  [cat [str A] B] -> (eval-lns [cat [str A] (eval-lns B) ])
  [len [str S]] -> [num (length (explode S))]
  [len E] -> (eval-lns [len (eval-lns E)])
  [let X Y Z] -> (eval-lns (subst Y X Z)))
