%!--------------------------------------------------------------------------------------------------
%! @file      step_function.m
%! @author    Hunter Mills
%! @date      Febuary 2024
%! @brief     Create a step_function with the ablility to have a time shift
%! @details   
%!
%!            INPUTS
%!            ---------------
%!            t - float[]
%!                Time Vector
%!            delay - float
%!                Delay in seconds
%!
%!            OUTPUTS
%!            ---------------
%!            step - int[]
%!                Output Square wave
%!
%!--------------------------------------------------------------------------------------------------

function step = step_function(t, delay)
    % Input checking
    if delay < t(1) || delay > t(length(t))
        error('ERROR: Delay outside of time vector range')
    end
        
    % Initialize output
    step = zeros(length(t), 1);

    % Create Step Wave
    step(find(t > delay)) = 1;
end