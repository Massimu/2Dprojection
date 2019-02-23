# 2Dprojection
Generating 2D projections from 3D volume (Volumetric data) using MATLAB
------------------------------------------------------------------------
The main idea:  
considering the data type, volumetric data, finding a strategy to extract projections at different directions from the volume is the main challenge of this task. After reviewing several papers I realized that there are several methods in spatial and spectral domain to face this kind of problem. Taking into account single axis tilting strategy which requires an axis to fixed tilt at center of specimen and an angle which increments in plane perpendicular to tilt to build a series of projections, I preferred to apply Fourier volume rendering theory, because it could be the best choice that include all points to deal with the problem. As it is based on projection-slice theorem, I started reading some references about visualizing volumetric data, and the algorithm of Fourier volume rendering to gure it out how I can provide code to solve the problem.  


Fourier volume rendering theory:  
The principle idea of any frequency domain volume rendering algorithm is based on the projection- slice theorem. It establishes a link between the projections of multidimensional signals and their k-space transforms. In three dimensional space, the theorem states that the two-dimensional projection of a three-dimensional volume at an arbitrary angle is equivalent to the inverse two-dimensional Fourier
transform of a central slice or plane passing through the origin of the three-dimensional frequency spectrum of this volume at the same angle. This means that the two-dimensional Fourier transform of a projection of the spatial volume reects a two dimensional slice extracted from the k-space represen-tation of the volume with a normal that is perpendicular on the viewing direction of the slice.
Therefore, I devised a plan consists of the above theory and a reduced version of the theorem which gives projections for the volume data.    
Fourier volumetric theorem:  
1 - Spectral representing of the volume using Fast Fourier Transform (FFT) method.  
2 - Extracting projection slices from the spectrum at certain angles.  
3 - Interpolating slices using back-transformed by inverse two dimensional FFT operation. and two other steps corresponding the task description.  
4 - Adding random Gaussian noise (white noise) to each projection using agwn function of MATLAB.  
5 - Shifting the images by adding a small random number to each projection and store the results to
provide data set for Cryo EM.  

FVR_main: the main which reads the Volume data and transform it into Fourier space. Then, 2D projections extract from complex space by applying functions which describe below.   
SplitComplexVolume : splits the complex volume to real and imaginary part. after that,  
ExtractProjectionSliceFromUnifiedVolume: extracts slice for both real and imaginary parts and  
then combines them together to make the complex slice.  
ExtractSliceFromUnifiedVolume: this function extracts slices using projection-slice theorem.  


