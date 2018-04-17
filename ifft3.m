function [spectrum] = ifft3 (data)

spectrum = ifft(ifft(ifft(data,[],1),[],2),[],3); 
end 