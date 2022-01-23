%%Natural Frequency, rise time of 20s
w_n = .157 / 2.389;
%%Damping Ratio, where a lot of the confusion comes from
zeta = .14649 * 2;
%%The target value, in our case the target flight height.
k = 400;
%%Numerator from 2nd order systems
Num = k*(w_n)^2;
%%Denominator from 2nd order systems
Den = [1 (2 * zeta * w_n) (w_n)^2];
%%Transfer function of the plant
G_s = tf(Num, Den);

%%Step Response (Not useful now).
%%step(myfunct);
 
%%PID implementation
Kp = 1;
Ki = 0;
Kd = 0;
C = pid(Kp,Ki,Kd);

%%closed loop system implementation
sys = C*G_s;
sys2 = feedback(sys, 1);

figure(2)
step(sys2)
sisotool(sys2)

