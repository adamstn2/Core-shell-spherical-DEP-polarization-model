function RealFcm1 = depf(Evacuum,Emedium,Ecyto,Emembrane1,Scyto,Smembrane,Smedium1,Rmembrane,Membranethick,freq)
% Calculates relative DEP force using the parameters
Rcyto = Rmembrane - Membranethick;      %radius of the cytoplasm, microns, approx cell membrane - thickness of cell membrane
a = Rmembrane/Rcyto;       %aspect ratio of the cell membrane to cytoplasm; unitless

w = (2*pi).*freq;          %angular frequency is a function of freq from function generator, radians/sec or Hz

% ------------- Core-shell Spherical Model Equations (DO NOT CHANGE) -------------
ECcyto        = Ecyto + (Scyto./((sqrt(-1)).*w));               %Complex permittivitty of the cytoplasm
ECmembrane1   = Emembrane1 + (Smembrane./((sqrt(-1)).*w)); %Complex permittivitty of the cell membrane
ECmedium1     = Emedium + (Smedium1./((sqrt(-1)).*w));       %Complex permittivitty of the medium, varying medium cond
Eparticleeff1 = ECmembrane1.*((a^3+(2.*((ECcyto-ECmembrane1)./(ECcyto+ ...
                2.*ECmembrane1))))./(a^3-((ECcyto-ECmembrane1)./ ...
                (ECcyto+2.*ECmembrane1))));
Fcm1          = (Eparticleeff1-ECmedium1)./(Eparticleeff1+(2.*ECmedium1));
RealFcm1      = real(Fcm1); %Real part of the clausis mossottie factor for the core shell model
end

