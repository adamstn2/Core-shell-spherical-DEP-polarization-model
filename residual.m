function [err, RealFcm1] = residual(x1,y1,Evacuum,Emedium,Smedium1,Rmembrane,Membranethick,x0)
% Finding the residuals of the fit
RealFcm1 = depf(Evacuum,Emedium,x0(1),x0(2),x0(3),x0(4),Smedium1,Rmembrane,Membranethick,x1);
err = x0(5)*sum(abs(RealFcm1-y1./x0(5)));
end

