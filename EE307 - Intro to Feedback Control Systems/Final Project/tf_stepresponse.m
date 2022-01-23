%%Natural Frequency, rise time of 10s
w_n = .157 / 2.389;
%%Damping Ratio, where a lot of the confusion comes from
zeta = .14649 * 2;
%%The target value, in our case the target flight height.
k = 400;
%%Numerator from 2nd order systems
Num = k * (w_n)^2;
%%Denominator from 2nd order systems
Den = [1 (2 * zeta * w_n) (w_n)^2];
%%Transfer function
myfunct = tf(Num, Den)
%%Step Response
step(myfunct);
 