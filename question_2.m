% Load The Fundamental Matrices(F13 and F23) And The Image 
image_1 = imread('florence1.jpg');
image_2 = imread('florence2.jpg');
image_3 = imread('florence3.jpg');
imshow(image_1);
% Select Points In Image_1
[x1,y1] = getpts 

% Create The Coordinates Matrix Of Image_1
Coordinates_1 = [x1,y1]'; 
Coordinates_1(3,:) = [1];

imshow(image_2);
% Select Points In Image_2
[x2,y2] = getpts 

% Create The Coordinates Matrix Of Image_2
Coordinates_2 = [x2,y2]';
Coordinates_2(3,:) = [1];

% Create Empty Matrix With Dimensions 3x5 For Epipolar Lines
EpL_13 = zeros(3,5);
EpL_23 = zeros(3,5);

% Calculate Epipolar Lines With For Loop
for i = 1: 5
    
    EpL_13(:,i) = (F13 * Coordinates_1(:,i));
    
    EpL_23(:,i) = (F23 * Coordinates_2(:,i));
    
end

% Image_1 Values
A1 = EpL_13(1,:) ;
B1 = EpL_13(2,:) ;
C1 = EpL_13(3,:) ;
% Image_2 Values
A2 = EpL_23(1,:) ;
B2 = EpL_23(2,:) ;
C2 = EpL_23(3,:) ;
% Calculate Of Image_1 For Normalization 
P1_1 = A1 ./ sqrt(A1.^2 + B1.^2);
P1_2 = B1 ./ sqrt(A1.^2 + B1.^2);
P1_3 = C1 ./ sqrt(A1.^2 + B1.^2);
% Calculate Of Image_2 For Normalization 
P2_1 = A2 ./ sqrt(A2.^2 + B2.^2);
P2_2 = B2 ./ sqrt(A2.^2 + B2.^2);
P2_3 = C2 ./ sqrt(A2.^2 + B2.^2);
normalize_1 = [P1_1;P1_2;P1_3];
normalize_2 = [P2_1;P2_2;P2_3];
 
% Y = -(X*A + C) / B
% Width Of Image_3
X = [1,1536]; 
% Calculate Y Values
Y1_1 = - (X.*P1_1(1,1) + P1_3(1,1)) / P1_2(1,1) ;
Y1_2 = - (X.*P1_1(1,2) + P1_3(1,2)) / P1_2(1,2) ;
Y1_3 = - (X.*P1_1(1,3) + P1_3(1,3)) / P1_2(1,3) ;
Y1_4 = - (X.*P1_1(1,4) + P1_3(1,4)) / P1_2(1,4) ;
Y1_5 = - (X.*P1_1(1,5) + P1_3(1,5)) / P1_2(1,5) ;
% Calculate Y Values   
Y2_1 = - (X.*P2_1(1,1) + P2_3(1,1)) / P2_2(1,1) ;
Y2_2 = - (X.*P2_1(1,2) + P2_3(1,2)) / P2_2(1,2) ;
Y2_3 = - (X.*P2_1(1,3) + P2_3(1,3)) / P2_2(1,3) ;
Y2_4 = - (X.*P2_1(1,4) + P2_3(1,4)) / P2_2(1,4) ;
Y2_5 = - (X.*P2_1(1,5) + P2_3(1,5)) / P2_2(1,5) ;

% Project The Selected Points On Image_3, Calculated The X Values 
% X = ( (C1 * B2) - (C2 * B1) / (A2 * B1) - (A1 * B2) )
X1 = ( ((P1_3(1,1) * P2_2(1,1)) - (P2_3(1,1) * P1_2(1,1))) / ((P2_1(1,1) * P1_2(1,1)) - (P1_1(1,1) * P2_2(1,1))));
X2 = ( ((P1_3(1,2) * P2_2(1,2)) - (P2_3(1,2) * P1_2(1,2))) / ((P2_1(1,2) * P1_2(1,2)) - (P1_1(1,2) * P2_2(1,2))));
X3 = ( ((P1_3(1,3) * P2_2(1,3)) - (P2_3(1,3) * P1_2(1,3))) / ((P2_1(1,3) * P1_2(1,3)) - (P1_1(1,3) * P2_2(1,3))));
X4 = ( ((P1_3(1,4) * P2_2(1,4)) - (P2_3(1,4) * P1_2(1,4))) / ((P2_1(1,4) * P1_2(1,4)) - (P1_1(1,4) * P2_2(1,4))));
X5 = ( ((P1_3(1,5) * P2_2(1,5)) - (P2_3(1,5) * P1_2(1,5))) / ((P2_1(1,5) * P1_2(1,5)) - (P1_1(1,5) * P2_2(1,5))));
% Substitute The X Values Found In The Equation Y And Computed The Y Values
Y1 = - (X1.*P1_1(1,1) + P1_3(1,1)) / P1_2(1,1) ;
Y2 = - (X2.*P1_1(1,2) + P1_3(1,2)) / P1_2(1,2) ;
Y3 = - (X3.*P1_1(1,3) + P1_3(1,3)) / P1_2(1,3) ; 
Y4 = - (X4.*P1_1(1,4) + P1_3(1,4)) / P1_2(1,4) ;
Y5 = - (X5.*P1_1(1,5) + P1_3(1,5)) / P1_2(1,5) ;
% Found The X And Y Coordinates Of Selected Points On Image_3 

% Draw The Selected Points On Image_1
figure3 = figure;
imshow(image_1);
hold on;

plot(Coordinates_1(1,1),Coordinates_1(2,1) ,'r-*', 'MarkerSize', 12);
plot(Coordinates_1(1,2),Coordinates_1(2,2) ,'g-*', 'MarkerSize', 12)
plot(Coordinates_1(1,3),Coordinates_1(2,3) ,'b-*', 'MarkerSize', 12)
plot(Coordinates_1(1,4),Coordinates_1(2,4) ,'c-*', 'MarkerSize', 12)
plot(Coordinates_1(1,5),Coordinates_1(2,5) ,'m-*', 'MarkerSize', 12)

% Draw The Selected Points On Image_2
figure4 = figure;
imshow(image_2);
hold on;

plot(Coordinates_2(1,1),Coordinates_2(2,1) ,'r-*', 'MarkerSize', 10);
plot(Coordinates_2(1,2),Coordinates_2(2,2) ,'g-*', 'MarkerSize', 10)
plot(Coordinates_2(1,3),Coordinates_2(2,3) ,'b-*', 'MarkerSize', 10)
plot(Coordinates_2(1,4),Coordinates_2(2,4) ,'c-*', 'MarkerSize', 10)
plot(Coordinates_2(1,5),Coordinates_2(2,5) ,'m-*', 'MarkerSize', 10)

figure5 = figure;
imshow(image_3);
hold on;

% Projected The Selected Points On The Image_3 
plot(X1,Y1, 'r*', 'MarkerSize', 20);
plot(X2,Y2, 'g*', 'MarkerSize', 20);
plot(X3,Y3, 'b*', 'MarkerSize', 20);
plot(X4,Y4, 'c*', 'MarkerSize', 20);
plot(X5,Y5, 'm*', 'MarkerSize', 20);

% Draw The Epipolar Lines Of Image_1
plot(X,Y1_1,'r','LineWidth',2);
plot(X,Y1_2,'g','LineWidth',2);
plot(X,Y1_3,'b','LineWidth',2);
plot(X,Y1_4,'c','LineWidth',2);
plot(X,Y1_5,'m','LineWidth',2);

% Draw The Epipolar Lines Of Image_2 
plot(X,Y2_1,'r','LineWidth',2);
plot(X,Y2_2,'g','LineWidth',2);
plot(X,Y2_3,'b','LineWidth',2);
plot(X,Y2_4,'c','LineWidth',2);
plot(X,Y2_5,'m','LineWidth',2);
