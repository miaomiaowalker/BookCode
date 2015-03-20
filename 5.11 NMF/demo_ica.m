s1=imread('machines.jpg');
s2=imread('arnie.jpg');

s1=double(s1(:,:,2))/255;
s2=double(s2(:,:,2))/255;

beta=3/5;

% Mixing Matrix
A=[4/5 beta;1/2 2/3];

x1=A(1,1)*s1+A(1,2)*s2;
x2=A(2,1)*s1+A(2,2)*s2;



[m,n]=size(x1);

subplot(3,2,1),imshow(s1)
subplot(3,2,2),imshow(s2)
subplot(3,2,3),imshow(x1)
subplot(3,2,4),imshow(x2)


x1=reshape(x1,m*n,1);
x2=reshape(x2,m*n,1);

mix=[x1,x2];

x1=x1-mean(x1);
x2=x2-mean(x2);

theta0=0.5*atan(-2*sum(x1.*x2)/sum(x1.^2-x2.^2));

Us=[cos(theta0) sin(theta0); -sin(theta0) cos(theta0)];

sig1=sum((x1*cos(theta0)+x2*sin(theta0)).^2);
sig2=sum((x1*cos(theta0-pi/2)+x2*sin(theta0-pi/2)).^2);

sigma=[1/sqrt(sig1) 0;0 1/sqrt(sig2)];

x1bar=sigma(1,1)*(Us(1,1)*x1+Us(1,2)*x2);
x2bar=sigma(2,2)*(Us(2,1)*x1+Us(2,2)*x2);

x1bar=reshape(x1bar,m*n,1);
x2bar=reshape(x2bar,m*n,1);

phi0 = 0.25*atan(-sum(2*(x1bar.^3).*x2bar-2*x1bar.*(x2bar.^3))/...
    sum(3*(x1bar.^2).*(x2bar.^2)-0.5*(x1bar.^4)-0.5*(x2bar.^4)));

V=[cos(phi0) sin(phi0);-sin(phi0) cos(phi0)];

s1bar=V(1,1)*x1bar+V(1,2)*x2bar;
s2bar=V(2,1)*x1bar+V(2,2)*x2bar;

s1bar=Scale(s1bar);
s2bar=Scale(s2bar);

s1bar=reshape(s1bar,m,n);
s2bar=reshape(s2bar,m,n);

subplot(3,2,5),imshow(s1bar);
subplot(3,2,6),imshow(s2bar);