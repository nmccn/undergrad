sum = 0;
for k = -20:20
    if k == -3
    elseif k == 3
    else
        sum = sum + cos(3*pi*k)*exp(-2*abs(k));
    end  
end

disp(sum)

