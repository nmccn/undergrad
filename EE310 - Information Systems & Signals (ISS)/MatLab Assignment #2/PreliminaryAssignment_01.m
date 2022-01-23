 %%FR is given as 50
FR = 50;
%%Mass and the effect of gravity due to that mass
mass = 1;
FG = mass * 9.81;
%%coeff for air dampening
damp = 0.01;
%%Numerator Fr - Fg
Num = 1;
%%Denominator ms^2 + bs
Den = [mass damp 0];
%%Transfer function
myfunct = tf(Num, Den);
step(myfunct);
