%exp 1.3：Robert算子作边缘检测
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
%模板
H1=[1 0;0 -1];
H2=[0 1;-1 0];
%卷积
for i=1:n-1
    for j=1:m-1
        B(i,j)=abs(A(i,j)-A(i+1,j+1))+abs(A(i,j)-A(i,j+1));
    end
end

%显示图像
maxmax=max(max(A));
minmin=min(min(A));

imshow(A,[minmin,maxmax]);title('原图');
figure;
imshow(uint8(B));

