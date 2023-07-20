clear

figure;
for i=1:20
    path = strcat("..\Dataset\", string(i), "\HSI_1400_10_15");
    load(path)
    I = ISD(:,:,100);
    I = mat2gray(I);
    subplot(4,5,i)
    imshow(I)
end