function Xw =  MyFT(Xt, t, w)
    % Xt is array of values
    % t is set of time points corresponding to Xt by index
    % w frequency
    
    length_t = length(t);
    length_xt = length(Xt);
    time_inc = t(2) - t(1);
    
    % Ensure indices for Xt and t align
    if length_t < length_xt
        last_time = t(length_t);
        inc_fill = last_time+time_inc:time_inc:(length_xt-1)*time_inc+t(0);
        t = [t, inc_fill];
        disp('length_t < length_xt');
    elseif length_t > length_xt
        zeros_fill = zeros(1, length_t - length_xt);
        Xt = [Xt, zeros_fill];
        disp('length_t > length_xt');
    end
    
    lb = 1;
    ub = length(t); % uses new length
    
    % aperiodic ctft analysis eqn: 
    % X(jw) = integral[-inf->inf]( x(t) * exp(-j*w*t) dt)
    
    exponential = @(t) exp(-1j*w*t);
    
    % integral approximation;
    sum = 0;
    for index = lb:ub
        time_val = t(index);
        signal_val = Xt(index); % value of Xt at time_val, index-keyed
        sum = sum + signal_val * exponential(time_val) * time_inc;
    end
    
    Xw = sum;
end