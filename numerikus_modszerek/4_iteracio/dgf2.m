function [y] = dgf2(x)

arguments (Input)
    x
end

arguments (Output)
    y
end

% g2-f2 fuggveny derivaltja
y = exp(tan(x))*(1/cos(x)^2)-(1/(1+x^2));
end