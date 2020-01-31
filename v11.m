%exp 1.1：平滑处理 smooth
clear;
fid = fopen('Eimage-007.img','rb'); 
    C=fread(fid,65536,'float64');
fclose(fid);
for i=1:256
    for j=1:256
        A(i,j)=C((i-1)*256+j);  
    end
end
%A=A';


[n,m]=size(A);
%模板 kernel
H1=1/9*[1 1 1;1 1 1;1 1 1];
H2=1/25*[1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1;1 1 1 1 1];
H3=1/49*[1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1;1 1 1 1 1 1 1];
%卷积
for i=2:n-1
    for j=2:m-1
        a1=A(i-1:i+1,j-1:j+1).*H1;
        B1(i,j)=sum(sum(a1)); 
    end
end

for i=3:n-2
    for j=3:m-2
        a2=A(i-2:i+2,j-2:j+2).*H2;
        B2(i,j)=sum(sum(a2)); 
    end
end

for i=4:n-3
    for j=4:m-3
        a3=A(i-3:i+3,j-3:j+3).*H3;
        B3(i,j)=sum(sum(a3)); 
    end
end

figure(1);
maxmax=max(max(A));
minmin=min(min(A));
imshow(A,[minmin,maxmax]);title('原图');
figure(2);
maxmax1=max(max(B1));
minmin1=min(min(B1));
imshow(B1,[minmin1,maxmax1]);title('3*3');
figure(3);
maxmax2=max(max(B2));
minmin2=min(min(B2));
imshow(B2,[minmin2,maxmax2]);title('5*5');
figure(4);
maxmax3=max(max(B3));
minmin3=min(min(B3));
imshow(B3,[minmin3,maxmax3]);title('7*7');
