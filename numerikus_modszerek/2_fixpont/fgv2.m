function [y] = fgv2(x)

arguments (Input)
    x
end

arguments (Output)
    y
end

y = atan(x)-nthroot(x,3)+1;
end