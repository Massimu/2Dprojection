% Loading the volume data from the RAW file 
load('volume.mat');
N = size(r,1);
% % 3D FFT-shift for the spatial volume
volume = fftshift(r);
%Compute the 3D Spectrum 
spectrum = fft3(volume); 
%Do a fft shift 
spectrum = fftshift(spectrum);
%Split the volume to the two components real and imaginary, and fine the
%projection slice for every component.
[realVolume, imagVolume] = SplitComplexVolume(spectrum, N, N, N);
snps= cell(1,1001); 
counterC = 1 ;
ps= cell(1,1001); 
counterA = 1 ;
%Tilt axis : in this case y axis
pivot = 'Y';
for angle = -90:0.18:90
%     % Extract the projection slice 
    projectionSlice = ExtractProjectionSliceFromUnifiedVolume ... 
                                (realVolume, imagVolume, N, pivot, angle);
%     % Backtransforming the slice to the spatial domain to yield the 
%     % projection followed by 2D FFT-shift for the projection. 
    projection = fftshift(abs(ifft2(projectionSlice)));
	%adding noise using agwn function
    NoisyProjectionY = awgn(projection,15,'measured'); 
	%shifting the projection by adding a random number between [ 0.01]
    ShiftedNoisyProjectionY = NoisyProjectionY + ((0.01).*rand(1));
    %scale projection in coordinate
    ShiftedNoisyProjectionscale = (NoisyProjectionY + ((0.01).*rand(1)))* 1e-3;
    snps{counterC} = ShiftedNoisyProjectionscale;
    counterC = counterC +1 ;
	%correcting the scale of representing
    ps{counterA} = projection*1e-3;
    counterA = counterA +1 ;
    figure(1);
    figure(2);
    subplot(1,2,1),imshow((projection)* 1e-3),title('Pure Projections');
    subplot(1,2,2),imshow(ShiftedNoisyProjectionscale),title('SN Projections');
% for saving projections one can turn off 34 to 37 and turn on 39 and 40
%     snpY = imshow(ShiftedNoisyProjectionscale);
%     saveas(snpY,sprintf('SNP_Y_%d.png',angle)); 
     
end
save(['snps','.mat'],'snps');


