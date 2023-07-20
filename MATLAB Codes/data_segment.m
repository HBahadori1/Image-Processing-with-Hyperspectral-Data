clear; close all
figure;
f = zeros(18,2);
bands = [37, 88, 150];
for i=1:18
    path = strcat("..\Dataset\", string(i), "\HSI_1400_10_15");
    load(path)
    I = ISD(10:end-10,:,bands);
    I(:,:,1) = mat2gray(I(:,:,1));
    I(:,:,2) = mat2gray(I(:,:,2));
    I(:,:,3) = mat2gray(I(:,:,3));
    % Segmentation
    % Adjust data to span data range.
    I1 = I(:,:,3);
    X = imadjust(I1);
    % Threshold image - global threshold
    BW = imbinarize(I1);
    % Create masked image.
    maskedImage = I1;
    maskedImage(~BW) = 0;
    %     figure; imshow(BW)
    e = edge(BW);
    %     figure; imshow(e)
    subplot(4,5,i)
    imshow(I1 + e)
    s = find(BW==0);
    Iv = reshape(I, [size(I,1)*size(I,2),3]);
    ss = Iv(s,:);
    f(i,1:3) = mean(ss);
    f(i,4:6) = var(ss);
    title(strcat('m=', string(f(i,1)), 'v=', string(f(i,4))));
end

%% Clustering
%% Fuzzy C-means clutering
k=2;
[C,U,]=fcm(f,k);
[~,IDX]=max(U);
% plot
Colors=hsv(k);
figure
for i=1:k
    Xi=f(IDX==i,:);
    plot(Xi(:,1),Xi(:,4),'bo','Markersize',10,'Color',Colors(i,:));
    hold on;
    plot(C(i,1),C(i,4),'ks','Markersize',12,'MarkerFaceColor',Colors(i,:));
end