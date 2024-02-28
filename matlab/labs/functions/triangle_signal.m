%!--------------------------------------------------------------------------------------------------
%! @file      triangle_signal.m
%! @author    Hunter Mills
%! @date      Febuary 2024
%! @brief     Create a triangle signal centered around 0
%! @details   
%!
%!            INPUTS
%!            ---------------
%!            t - float[]
%!                Time Vector
%!
%!            OUTPUTS
%!            ---------------
%!            tri_sig - int[]
%!                Output Triangle Wave
%!
%!--------------------------------------------------------------------------------------------------

function tri = triangle_signal(t)

    % Initialize output wave
    tri = zeros(length(t), 1);

    % Create Triangle Wave
    tri(find(t > -.5)) = 1-2*abs(t(find(t > -.5)));
    tri(find(t > .5))  = 0;
end