% chenxy, 2019-11-19
% A demonstration program for Mandelbrot set.

clear; close all; clc;

echo on;

% sim_mode:
% 1: Naive nest-loop implementation
% 2: Vectorized implementation
% 3: Both 1 and 2.
% Note: For simulation of naive implementation, please set niter and step reasonably,
%       because it runs very slowly, maybe thousands times slower than vectorized 
%       implementation.
sim_mode = 2; 

step   = 0.001;
niter  = 50;

[X, Y] = meshgrid(-2:step:1, -1.3:step:1.3);
C      = complex(X, Y);
Z0     = zeros(size(C));

Z      = zeros(size(C));

% Naive implementation using nested loop, very slow.
if(sim_mode == 1 || sim_mode == 3)
    tstart = tic;
    for k = 1:1:size(C,1)
        for l = 1:1:size(C,2)
            for iter = 1:1:niter
                Z(k,l) = Z(k,l)*Z(k,l) + C(k,l);
                echo off;
            end
        end
    end
    echo on;
    telapsed = toc(tstart);
    
    imshow(abs(Z) > 4);
    
    fprintf(1,'Naive nested-loop implementation\n');
    fprintf(1,'niter = %d; step = %g; grid size = {%d, %d}\n', niter, step, size(C,1), size(C,2));
    fprintf(1,'Time elapsed: %g seconds\n', telapsed);
end

% Vectorized implementation .
if(sim_mode == 2 || sim_mode == 3)
    tstart = tic;
    %for k = 1:1:size(C,1)
    %    for l = 1:1:size(C,2)
            for iter = 1:1:niter
                Z = Z.*Z + C;
                echo off;
            end
    %    end
    %end
    echo on;
    telapsed = toc(tstart);
    
    imshow(abs(Z) > 4);
    
    fprintf(1,'Vectorized implementation\n');
    fprintf(1,'niter = %d; step = %g; grid size = {%d, %d}\n', niter, step, size(C,1), size(C,2));
    fprintf(1,'Time elapsed: %g seconds\n', telapsed);       
end    