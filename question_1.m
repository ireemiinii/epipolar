%Firstly Load the fundamental matrices(F13 and F23) and the images
image_2 = imread('florence2.jpg');
image_3 = imread('florence3.jpg');
imshow(image_2);
[x,y] = getpts % Select points in image 2

% Create The Coordinates Matrix
Coordinates_mat = [x,y]'; 
Coordinates_mat(3,:) = [1];

%Create Empty Matrix With Dimensions 3x5 For Epipolar Lines
epipolar_lines = zeros(3,5);

% Calculate Epipolar Lines With For Loop 
for i = 1: 5
    
    epipolar_lines(:,i) = (F23 * Coordinates_mat(:,i));
      
end

% To Do The Normalization Defined The A,B and C. 
A = epipolar_lines(1,:) ;
B = epipolar_lines(2,:) ;
C = epipolar_lines(3,:) ;
% Calculate normalization values
p1 = A ./ sqrt(A.^2 + B.^2);
p2 = B ./ sqrt(A.^2 + B.^2);
p3 = C ./ sqrt(A.^2 + B.^2);
normalize = [p1;p2;p3];

%Draw Epipolar Lines
% Calculate The X and Y Values From Line Equaion
% Y = -(X*A + C) / B
X = [1,1536]; %width of the Image_3

%Calculate Y Values
Y1 = - (X.*p1(1,1) + p3(1,1)) / p2(1,1) ;
Y2 = - (X.*p1(1,2) + p3(1,2)) / p2(1,2) ;
Y3 = - (X.*p1(1,3) + p3(1,3)) / p2(1,3) ;
Y4 = - (X.*p1(1,4) + p3(1,4)) / p2(1,4) ;
Y5 = - (X.*p1(1,5) + p3(1,5)) / p2(1,5) ;

% Draw The Selected Points On Image_3
figure_1 = figure;
imshow(image_2);
hold on ;

plot(Coordinates_mat(1,1),Coordinates_mat(2,1) ,'r-*', 'MarkerSize', 12);
plot(Coordinates_mat(1,2),Coordinates_mat(2,2) ,'g-*', 'MarkerSize', 12)
plot(Coordinates_mat(1,3),Coordinates_mat(2,3) ,'b-*', 'MarkerSize', 12)
plot(Coordinates_mat(1,4),Coordinates_mat(2,4) ,'c-*', 'MarkerSize', 12)
plot(Coordinates_mat(1,5),Coordinates_mat(2,5) ,'m-*', 'MarkerSize', 12)

% Draw The Epipolar Lines On Image_3 With Different Colors
figure_2 = figure;
imshow(image_3);
hold on;

plot(X,Y1,'r','LineWidth',2);
plot(X,Y2,'g','LineWidth',2);
plot(X,Y3,'b','LineWidth',2);
plot(X,Y4,'c','LineWidth',2);
plot(X,Y5,'m','LineWidth',2);
       




