%# read and display image
img = imread('laberinto.jpg');
figure,imshow(img)

%# make sure the image doesn't disappear if we plot something else
hold on

%# define points (in matrix coordinates)
p1 = [10,100];
p2 = [100,20];
p3 = [200,20];

%# plot the points.
%# Note that depending on the definition of the points,
%# you may have to swap x and y
plot([p1(2),p2(2)],[p1(1),p2(1)],'Color','r','LineWidth',2)