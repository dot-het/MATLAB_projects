%CHAPTER 3
%Calculate the area of the circle
fprintf('Units will be in cm. \n')
rad = input('Please enter now the radius:');
area = pi*(rad^2);
circ = 2*pi*rad;

%Print all the variables
fprintf('For a circle with radius %.3f cm, \n', rad);
fprintf('the area is %.3f cm squared, \n', area);
fprintf('the circum is %.3f cm, \n', circ);
%%

fprintf('Some fun is coming!\n')
char = input('Enter a character:', 's');
fprintf('%.3c\n', char);
num = input('Enter a number:');
fprintf('%8-3d\n', num); 

%%
fprintf('You will need to enter some number\n');
a = input('Enter a number:');
b = input('Enter a different number:');
mymat = rand(a,b);
fprintf('Here is your matrix created with the first given number %d\n', a)
fprintf('and the second given number %d\n', b)
disp(mymat)

%%

a = [1.2 1.4 1.8 1.3 
    2.2 2.5 1.7 2.9];
save salesfig.data a -ascii;
%%
load salesfig.data
divA = salesfig(1,:);
divB = salesfig(2,:);
hold on
plot(divA,'ko');
plot(divB, 'k*');
xlabel('Quarter');
ylabel('Sales(billions');
title('ABC CORPORATION SALES 2013');
legend('o Division A', '* Division B')
%%

radius = input('Please enter the radius:');
height = input('Please enter the height:');
conevol(radius,height);
fprintf('The cone volume is %.2f\n',conevol(radius,height))

%%
a = input('Please enter the length of a in cm:');
b = input('Please enter the length of b in cm:');
calcrect(a,b);
fprintf('The area of the given rectangle is %.2f cm squared\n', calcrect(a,b))

%%
q  = input('Enter the worked hours:');
if q > 40
    disp('You will get overtime');
else 
    disp('You are a loser')
end

%%
num = input('Enter the angle:');
raddeg = input('Radians or degree:', 's');
if raddeg == 'd'
    fprintf('The sin is: %.3f\n', sind(num))
else 
    fprintf('The sin is: %.3f\n', sin(num))
end

%%
istr = input('Please enter a letter: ','s');
if isletter(istr)
    disp('It is  a string')
else
    disp('it isnot a string')
end

%%
%Write a script that tests whether the user can follow instructions. It prompts the
%user to enter an ‘x’. If the user enters anything other than an ‘x’, it prints an error
%message; otherwise, the script does nothing.

h = input('Please enter an x: ', 's');
if h == 'x'
   disp('you are right')
else 
    disp('error')
end

%%
hour = input('Please give the current hour: ')
if hour  > 0 && hour < 12 
    fprintf('The next hour will be %d.\n',nexthour(hour))
else 
    disp('The given input argument is wrong.')
end
%%
% 2.54 cm 1 inch
length = input('Enter the length: ');    
width = input('Enter the width: ');
height = input('Enter the height: ');
measure = input('Is it cm (c) or inch (i)? ', 's');
if measure  == 'i'
    fprintf('The volume of the pyramid is %f.\n',calvol(length,width,height))
else measure  == 'c'
    fprintf('The volume of the pyramid is %f.\n',calvol(length,width,height)*2.54)
end
 %%
 force = randi([0,12]); 
 %input('Please enter a number between 0-12:');
 disp(force);
 if force <= 0 | force > 12
    disp('error, wrong input');
 elseif force <= 6 & force >= 1
    disp('There is a breeze')
 elseif force > 6 & force < 10
    disp('This is a gale')
 elseif force == 10 | force == 11
    disp('It is a storm')
 elseif force == 12
    disp('Hello, Hurricane!')
 end

%%
val = randi([1,10]);
disp(val);
switch val
    case 0
        disp('hello');
    case {5,6,7}
        disp('ok')
    case {1,2,3,4,5,6,7,8}
        disp('xx')
    case {9,10}
        disp('yy')
    case {1,2}
        disp('yy')
    case {3}
        disp('tt')
end

%%
%CHAPTER 5
counter = 0;
inputnum=input('Enter a positive number: ');
while inputnum > 0
fprintf('You entered a %d.\n\n',inputnum)
counter = counter + 1;
inputnum = input('Enter a positive number: ');
end
fprintf('OK!,you have entered %d numbers.\n', counter)
        
%%
mat = randi(20,3,4);
disp(mat)
[r,c] = size(mat);
for col = 1:c
    mymatmin = min(mat);
end 
%%
inputnum = input('Enter a negative number: \n');
counter = 0;
while inputnum < 0
fprintf('You entered %d.\n',inputnum)
counter = counter + 1;
inputnum = input('Enter a negative number: \n');
end
fprintf('The average was: %d \n', mean(inputnum));
fprintf('No negative numbers to average \n');
fprintf('Thanks, you entered %d  numbers.\n',counter)

%%
% Error checks until the user enters a positive integer
num2 = int32(inputnum);
while num2 == inputnum && num2 > 0
inputnum = input('Enter a positive integer: ');
fprintf('Thanks, you entered a %d \n',inputnum);
num2 = int32(inputnum);
end
fprintf('Invalid!Enter a negative integer: %d \n',inputnum);

%%
i = 0;
for inc = 0: 0.5: 3
    i = i + 1;
    myvec(i) = sqrt(inc)
end
%%

%%
%Write a for loop that will print the column of real numbers from 1.5 to 3.1 in steps of
%0.2.   
for i = 1.5:0.2:3.1
    disp(i)
end

%%
%CHAPTER 6
% This script prompts the user for the radius of a circle,
% calls a function to calculate and return both the area
% and the circumference, and prints the results
% It ignores units and error-checking for simplicity
radius = input('Please enter the radius of the circle: ');
[area, circ] = areacirc(radius);
fprintf('For a circle with a radius of %.1f,\n', radius)
fprintf('the area is %.1f and the circumference is %.1f\n',area, circ)

%%
% Prompt the user for the length and width of a rectangle,
% call a function to calculate and return the perimeter
% and area, and print the result
% For simplicity it ignores units and error-checking
length = input('Please enter the length of the rectangle: ');
width = input('Please enter the width of the rectangle: ');
[area, perimeter] = areaperim(length, width);
fprintf('For a rectangle with a length of %.1f and a', length)
fprintf(' width of %.1f,\nthe perimeter is %.1f,', width, perimeter)
fprintf(' and the area is %.1f\n', area)

%%
% This is the main script to calculate the
% area of a circle
% It calls 3 functions to accomplish this
radius = readradius;
area = calcarea(radius);
printarea(radius,area)

%%

%Write a script righttri that calls a function to prompt the user and read in values for the hypotenuse
%and the angle (in radians), and then calls a function to calculate and return the lengths of sides a
%and b and a function to print out all values in a sentence format. For simplicity, ignore units. Here
%is an example of running the script; the output format should be exactly as shown here:

% This program calculates & prints the sides of a triangle
% Call a fn to prompt the user & read the side c and the angle theta in
% radian
[c, theta] = readct;
% Call a fn to calculate and print the area
printtrisides(c, theta)

%%
[lat,long] = readlatlong;
printcalcloc(lat,long);
resp = input('If you want to change it to dms, please press: D\n', 's');
if resp =='d' 
    [r,t,y] = breakdegree(lat,long);
    fprintf('The calculated earth location is: %d\n',r);
    fprintf('The calculated earth location is: %d\n',t);
    fprintf('The calculated earth location is: %d\n',y);
end 

%%
%CHAPTER 7 STRING MANIPULATION

word = input('Enter something nice:\n', 's');
length(word);
word(1);
word(1,end);
%%
clc;
clear all;
word = 'northeast';
word1 = word(1:5);
word2 = word(6:9);
mtx = char(word1, word2);
%%
a = (1:5)
for i = 1:length(a)
    sprintf('filedata%d.data\n', a)
end
%%
%Create an x vector. Prompt the user for ‘sin’, ‘cos’, or ‘tan’, and create a string with that function of
%x (e.g., ‘sin(x)’ or ‘cos(x)’). Use eval to create a y vector using the specified function.

x = randi(25,1,10);
mt = input('Enter (s) for sin, enter (c) for cos or enter (t) for tan: \n', 's');
if mt =='s'
    sprintf('You have entered s for sin, the sins are: %f\n', sin(x))
elseif mt =='c'
    sprintf('You have entered c for cos, the cos are: %f\n', cos(x))
elseif mt =='t'
    sprintf('You have entered t for tan, the tans are: %f\n', tan(x))
end

%%
getstr
fprintf('Thank you, your string is %d characters long\n', length(thestring));


%%
%CHAPTER 8

cellrowvec = {25, 'a', 85, 5:10, 66, 'b', 'elem'};
[c1, c2] = cellrowvec{4:5}

%%
onepart = struct('part_no', 123, 'quantity', 4, 'costper', 33.95);
fprintf( 'The cost is per item: $%.2f \n', onepart.costper)

%%
inputfield = input('Which field would you like to see: ','s');
    if isfield(onepart, inputfield)
        sprintf('The value of the %s field is: ', inputfield)
        disp(eval(['onepart.' inputfield]))
    else
        sprintf('Error: %s is not a valid field\n', inputfield)
    end
%%
a = input('yo\n');
if a == 5
    fprintf('score is %.1d\n', a)
else
    fprintf('nothing\n')
end 

%%
parts(1) = struct('partno', 123, 'quantity', 4, 'costper', 33);
parts(2) = struct('partno', 142, 'quantity', 1, 'costper', 150);
parts(3) = struct('partno', 106, 'quantity', 20, 'costper', 7.500);
parts(4) = struct('partno', 106, 'quantity', 20, 'costper', 7.500);

%%
for i = 1:length(parts)
    totalparts = parts(i).quantity * parts(i).costper;
    fprintf('partno: %0.f\n The total cost is: $%.2f \n',parts(i).partno, totalparts);
end

%%
cyls(1) = struct('code', 'x', 'dimensions', struct('rad', 3, 'height', 6, 'weight', 7));
cyls(2) = struct('code', 'a', 'dimensions', struct('rad', 4, 'height', 2, 'weight', 5));
cyls(3) = struct('code', 'c', 'dimensions', struct('rad', 3, 'height', 6, 'weight', 9));
vol = pi * cyls(1).dimensions.rad^2 * cyls(1).dimensions.height;
area = 2*pi*cyls(1).dimensions.rad^2 + 2*pi*cyls(1).dimensions.rad*cyls(1).dimensions.height; 
printcylvols(cyls)

%cyls(3) = struct('code', 'c', 'dimensions', struct('rad', 3, 'height', 6), 'weight', 9);


%%

n = input('Enter a positive integer n: \n'); 
int = 1 : n;
b = 0;
for i=1:length(int)
 b(i) = n(i) + 1;
 disp(b)
end 

%%

b = 0;
for i=1:7
 b = b(i) + 1;
 disp(b)
end 
        
%%
%CHAPTER 9
fil = zeros(20,1);
fil(:,1) = rand(20,1,1);
%fil(:,2)  = ['a';'b';'c';'a';'b';'c';'a';'b';'c';'a';'b';'c';'a';'b';'c';'a';'b';'c';'a';'b'];
char(fil)
disp(fil)

%%
% Reads from a file one line at a time using fgetl
% Each line has a number and a character
% The script separates and prints them
% Open the file and check for success
fid = fopen('subjexp.dat');
if fid == -1
disp('File open not successful')
else
while feof(fid) == 0
aline = fgetl(fid);
% Separate each line into the number and character
% code and convert to a number before printing
[num, charcode] = strtok(aline);
fprintf('%.2f %s\n', str2double(num), charcode)
end
% Check the file close for success
closeresult = fclose(fid);
if closeresult == 0
disp('File close successful')
else
disp('File close not successful')
end
end

%%
%chapter 5 practice
%#4
clear all
n = (0:9);
for i = 1:7
    a(i) = n(i)+1;
    disp(a*8+1);
end

%%
%#5
inputnum = input('Enter a positive integer: ');
num2 = int32(inputnum);
if num2 == inputnum && num2 > 0
%inputnum = input('Enter a positive integer: ');
fprintf('Thanks, you entered a %d \n',inputnum);
else
fprintf('Invalid!Enter a negative integer: %d \n',inputnum);
end
n = 1:num2;
for i = 1:length(n)
    fprintf('I love this stuff!\n')
end 
%%
clear
clf
x = rand;
y = rand;
plot(x,y)
hold on
for it = 1:10000
choic = round(rand*2);
if choic == 0
x = x/2;
y = y/2;
elseif choic == 1
x = (x+1)/2;
y = y/2;
else
x = (x+0.5)/2;
y = (y+1)/2;
end
plot(x,y)
hold on
end

