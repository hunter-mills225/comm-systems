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

    % Create Triangle Wave
    tri = (1-abs(t)) .* (t >=-1) .* (t<1);
end