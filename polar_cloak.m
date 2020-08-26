% Frank Trang
 %
 % polar_cloak.m
 %
 % cart to polar to cart plot

 % coordinate transformation

 clear all
 r1 = .254;
 r2 = .762;

 x = -.762*1.5:0.001:.762*1.5;
 y = x;

 Xx = zeros(18, length(x), 1);
 Yx = zeros(18, length(y), 1);
 Xy = Xx;
 Yy = Yx;
xones = ones( length(x), 1 );
yones = ones( length(y), 1 );
 xm = -.762*1.5+.0635;
 ym = -.762*1.5+.0635;


 for m=1:18
 Xx(m,:,:) = xm*xones;
 [thx, rhx] = cart2pol(Xx(m,:,:), y);
 rhxx = (r2-r1)*rhx/r2 + r1;

 Yy(m,:,:) = ym*yones;
[thy, rhy] = cart2pol(x, Yy(m,:,:));
rhyy = (r2-r1)*rhy/r2 + r1;

 for n=1:length(rhxx)
 if rhxx(n) > r2
 rhxx(n) = rhx(n);
 end
 if rhyy(n) > r2
 rhyy(n) = rhy(n);
 end
 end
 [Xx(m,:,:), Yx(m,:,:)] = pol2cart( thx, rhxx );
 [Xy(m,:,:), Yy(m,:,:)] = pol2cart( thy, rhyy );
 xm = xm + .127;
 ym = ym + .127;
 end


 figure
 hold on
 for m=1:18
plot(Xx(m,:,:), Yx(m,:,:), 'black', 'LineWidth', 2)
plot(Xy(m,:,:), Yy(m,:,:), 'black', 'LineWidth', 2);
 end

t = 0:.001:2*pi;
plot(.762*sin(t)+0,.762*cos(t)+0, 'black', 'LineWidth', 2);
 plot(.254*sin(t)+0,.254*cos(t)+0, 'black','LineWidth', 2);

 axis equal
 axis([-1.2 1.2 -1.2 1.2])
 axis off
 hold on



 % For plotting non-transformed space

 x = -.762*1.5:0.001:.762*1.5;
 y = x;

 Xx = zeros(18, length(x), 1);
 Yx = zeros(18, length(y), 1);
 Xy = Xx;
Yy = Yx;
xones = ones( length(x), 1 );
yones = ones( length(y), 1 );
 xm = -.762*1.5+.0635;
 ym = -.762*1.5+.0635;

 for m=1:18
 Xx(m,:,:) = xm*xones;
 Yy(m,:,:) = ym*yones;
 xm = xm + .127;
 ym = ym + .127;
 end

 figure
 hold on
 for m=1:18
 plot(Xx(m,:,:), y, 'black', 'LineWidth', 2)
 plot(x, Yy(m,:,:), 'black', 'LineWidth', 2);
 end

 plot(.762*sin(t)+0,.762*cos(t)+0, 'black', 'LineWidth', 2);

 axis equal
 axis([-1.2 1.2 -1.2 1.2])
 axis off
 hold on