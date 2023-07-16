r = 1; % radius of cylinder
h = 2; % height of cylinder
n = 50; % number of vertices around the circumference
[X,Y,Z] = cylinder(r,n);
Z = Z*h; % scale the height of the cylinder
surf2stl('cylinder.stl',X,Y,Z);

clear
[l,m,n]=cylinder;

figure()
surf(l,m,n)
hold on
top = patch(l(1,:),m(1,:),n(1,:),'r')
bottom = patch(l(2,:),m(2,:),n(2,:),'g')
side = patch(l,m,n,'g')
hold off
view(30,-30)


a.vertices = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
a.faces = [1 2 3; 1 3 4; 2 6 7; 2 7 3; 4 3 7; 4 7 8; 1 5 6; 1 6 2; 5 6 7; 5 7 8; 1 4 8; 1 8 5];
patch2stl('cube1.stl',a);


a = importGeometry('cube1.stl') 
b = a
add(a,b)

g1 = multicuboid(2,2,2);
pdegplot(g1,"CellLabels","on","FaceAlpha",0.4)

g2 = multicuboid(1,1,1);
hold on
pdegplot(g2,"CellLabels","on","FaceAlpha",0.4)

g3 = addVoid(g1,g2);



a.vertices = [0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
a.faces = [1 2 3; 1 3 4; 2 6 7; 2 7 3; 4 3 7; 4 7 8; 1 5 6; 1 6 2; 5 6 7; 5 7 8; 1 4 8; 1 8 5];
patch2stl('cube1.stl',a);
a.vertices = 0.5*[0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1];
a.faces = [1 2 3; 1 3 4; 2 6 7; 2 7 3; 4 3 7; 4 7 8; 1 5 6; 1 6 2; 5 6 7; 5 7 8; 1 4 8; 1 8 5];
patch2stl('cube2.stl',a);

% Read the STL files into Matlab using stlread
[vertices1, faces1] = stlread('cube1.stl');
[vertices2, faces2] = stlread('cube2.stl');

% Create patch objects from the STL data
patch1 = patch('Vertices', vertices1, 'Faces', faces1);
patch2 = patch('Vertices', vertices2, 'Faces', faces2);

% Perform a Boolean operation (intersection) on the two patch objects
result = patchBoolean(patch1, patch2, 'intersection');

% Display the resulting patch object
patch('Vertices', result.vertices, 'Faces', result.faces, 'FaceColor', 'red');