function [y] = g(x)

arguments (Input)
    x
end

arguments (Output)
    y
end

y = log(x^2+sqrt(x));
end