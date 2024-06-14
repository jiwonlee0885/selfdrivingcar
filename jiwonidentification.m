videoFReader = vision.VideoFileReader("roadtrip2.mov"); 
videoPlayer = vision.VideoPlayer;		% Create a video player object to play the video. 

while ~isDone(videoFReader)  	% While not reaching the end of file 
    videoFrame = videoFReader(); 		% Read a video frame
    IGray = rgb2gray(videoFrame); 
    IBlur = imgaussfilt(IGray, 3);
    Iedgedet = edge(IBlur,"canny");
    			% Play a video frame
    %imshow(edgedet);
    % imageSize = size(videoFrame);		% Get image size
    % Define the ROI polygon coordinates (trapezoid)
    imageSize = size(videoFrame);
    irow = [imageSize(1)*1 imageSize(1)*0.8 imageSize(1)*0.8 imageSize(1)*1]; % ROI row vector (y-coordinates)
    icol = [imageSize(2)*0.2 imageSize(2)*0.4 imageSize(2)*0.6 imageSize(2)*0.7]; % ROI col vector (x-coordinates)
    % Create a binary mask from the ROI polygon
    imageBWROI = roipoly(Iedgedet, icol, irow);
    imageBWMasked = immultiply(Iedgedet, imageBWROI);
[H,T,R] = hough(imageBWMasked);                     % hough transform
     %figure('Name','Hough Image');                       % create a figure for masked image
     noLines = 8;                                        % define no. of lines
     peaks = houghpeaks(H,noLines,'threshold',ceil(0.3*max(H(:))));
     lines = houghlines(imageBWMasked,T,R,peaks,'FillGap',15,'MinLength', 30); 
     lengthLine = length(lines);
     xy = zeros(lengthLine, 4);
     for k = 1:lengthLine;
         xy(k,1:4) = [lines(k).point1(1) lines(k).point1(2) lines(k).point2(1) lines(k).point2(2)]; 
     end
     LaneID = insertShape(videoFrame,'line',xy,'LineWidth',2, 'Color','red');
     % figure('Name','Land Identification');			% create a figure for masked image
     videoPlayer(LaneID); 
end
release(videoPlayer); 					% Release the video player object
release(videoFReader); 					% Release the video reader object


% Irgb = imread("roadtrip2.mov");		% Read image from file
% % Irgb = imread('roadtrip2.mov');         % Read image from file
% imshow(Irgb);                           % Displays the image in a figure window
% Ihsv = rgb2hsv(Irgb);                   % Convert RGB image to HSV color space
% figure;                                 % Create figure window
% imshow(Ihsv);                           % Displays the image in a figure window
% Irgb2 = hsv2rgb(Ihsv);                  % Convert HSV image to RGB color space
% figure;                                 % Create figure window
% imshow(Irgb2);                          % Displays the image in a figure 
% 
% RGB = imread('roadtrip2.mov');
% imshow(RGB);
% I = rgb2gray(RGB);
% %I = RGB;
% figure;
% imshow(I);
% imageBlur1 = imgaussfilt(I, 3);
% figure;
% imshow(imageBlur1);
% imageBlur2 = imgaussfilt(I, 5);
% figure;
% imshow(imageBlur2);

