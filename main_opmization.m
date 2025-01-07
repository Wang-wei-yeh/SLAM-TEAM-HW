clc; clear;close all;

addpath("function\","function\method","function\math_calculate","anime");

[x,y] = meshgrid(-2:0.1:2,-1:0.1:3);
% Rosenbrock function
f = (1-x).^2+100*(y-x.^2).^2;

%variable set
var = setvar();

% figure set
[ax1,ax2,fig] = figset(f,x,y);

% algorithm plot set
pic = picset(ax1,ax2);
% beginning point
beta0 = [var.X;var.Y;F(var.X,var.Y)];
%algorithm data 
Beta = struct('betaGD',beta0, 'betaNW',beta0, 'betaGN',beta0, 'betaLM',beta0,'betaDL',beta0,'converge',[]);

% vidoe record set
if var.videoset == true
    video = VideoWriter("Optimization","MPEG-4");
    video.FrameRate = 10;
    open(video)
end

%main loop
% tic
for i = 1:var.iter
    Beta = GD(Beta,var,i);
    Beta = NW(Beta,i);
    Beta = GN(Beta,i);
    [Beta,var] = LM(Beta,i,var);
    [Beta,var] = DL(Beta,i,var);
    anime(pic,i,ax2,Beta)
    drawnow;
    vidoe record start
    if var.videoset == true
        frame = getframe(fig);
        writeVideo(video,frame);
    end
    if all(Beta.converge < 1e-6) 
        break
    end
end
% toc
% vidoe record end
if var.videoset == true
    close(video);
end


