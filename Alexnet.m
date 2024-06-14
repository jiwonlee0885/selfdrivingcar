% Copyright 2016 The MathWorks, Inc.

clear

load birdsnet_94.mat
camera = webcam;                         % Connect to the camera
%nnet = birdsnet_94;                          % Load the neural net

while true
 picture = snapshot(camera);              % Take a picture    
 picture = imresize(picture,[227,227]);  % Resize the picture

 label = classify(birdsnet_94, picture);        % Classify the picture

 imagesc(picture);                         % Show the picture
 title(char(label));                     % Show the label
 drawnow;
end
