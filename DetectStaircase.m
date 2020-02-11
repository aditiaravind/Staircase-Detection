clc
close all
clear all

L=[];
I  = imread('10.jpeg');
I=imresize(I,[256 256]);
I=imsharpen(I);
B=im2double(I);
B=rgb2gray(B);
figure
subplot(2,2,1)
imshow(B)
rotI=bfilter2(B,[3 3],[3 3]);
BW = edge(rotI,'canny');
subplot(2,2,2)
imshow(BW)
[H,T,R] = hough(BW);
subplot(2,2,3)
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
% colormap(hot)
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
hold off
% Find lines and plot them
lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',10);
subplot(2,2,4)
imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   lines(k).ord=lines(k).point2(2);
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
   if len<25
       L(k)=0;
       lines(k).length=0;
       continue;
   end
   L(k)=len;
   lines(k).length=len;
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
 
end
% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue')

T = struct2table(lines); 
sortedT = sortrows(T, 'ord'); 
Slines = table2struct(sortedT);

Dist=zeros(length(Slines));
for i=1:length(Slines)
    for j=1:length(Slines)
        if ((Slines(i).theta>=83)&&(Slines(j).theta>=83))||((Slines(j).theta<=-83)&&(Slines(i).theta<=-83))
                    dist=DistBetween2Segment(Slines(i).point1,Slines(i).point2,Slines(j).point1,Slines(j).point2);
                    Dist(i,j)=dist;
        else
            Dist(i,j)=0;
        end
    end
end
CloseDist=[];
for i=1:length(Slines)
    for j=1:length(Slines)
        if abs(i-j)==1
            CloseDist=[CloseDist Dist(i,j)];
        end
    end
end

if (length(find(CloseDist~=0))/length(CloseDist)>0.4)
    display('It is a staircase')
elseif (length(find(CloseDist~=0))/length(CloseDist)<=0.4)&&(length(find(CloseDist~=0))/length(CloseDist)>0.2)
    display('Staircase is nearby')
else
    display('No staircase nearby')
end
