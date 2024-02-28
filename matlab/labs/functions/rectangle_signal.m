%!--------------------------------------------------------------------------------------------------
%! @file      rectangle_signal.m
%! @author    Hunter Mills
%! @date      Febuary 2024
%! @brief     Create a rectangle signal with the ablility to have a time shift
%! @details   
%!
%!            INPUTS
%!            ---------------
%!            t - float[]
%!                Time Vector
%!            start - float
%!                Start of rectange signal in seconds
%!            stop - float
%!                End of rectange signal in seconds
%!            delay - float
%!                Delay in seconds
%!
%!            OUTPUTS
%!            ---------------
%!            step - int[]
%!                Output Rectangle wave
%!
%!--------------------------------------------------------------------------------------------------

function rect = rectangle_signal(t, start, stop, delay)
    % Input checking
    if delay < t(1) || delay > t(length(t))
        error('ERROR: Delay outside of time vector range')
    end
    if start < t(1) || start > t(length(t))
        error('ERROR: Start outside of time vector range')
    end
    if stop < t(1) || stop > t(length(t))
        error('ERROR: Stop outside of time vector range')
    end

    % Create Rectangle Wave
    rect = step_function(t, start+delay) - step_function(t, stop+delay);
end