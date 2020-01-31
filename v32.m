%区域生长显示颅骨图像 region growing for skull highlighting
clear all;
fid = fopen('Eimage-007.img','rb'); 
    C=fread(fid,65536,'float64');
fclose(fid);
for i=1:256
    for j=1:256
        A(i,j)=C((i-1)*256+j);  
    end
end
[M,N]=size(A);
x1=24;
y1=204;
x2=27;
y2=70;
seed1=A(x1,y1);%设定与种子点比较值
seed2=A(x2,y2);
B=zeros(M,N);
B(x1,y1)=1;
flag=1;%标志位
number=1;%种子点个数
T1=30;    %阈值
T2=30;
sum=seed1;%种子点值的和
while flag>0
    flag=0;
    for i=1:M
        for j=1:N
            if B(i,j)==1%生长扩增点
                for u=-1:1 
                     for v=-1:1
                         if (i+u)>0&&(j+v)>0&&(i+u)<M&&(j+v)<N&&B(i+u,j+v)==0&&abs(A(i+u,j+v)-seed1)<=T1%判断是否到达边界和是否是种子点
                            flag=1;
                            number=number+1;
                            sum=sum+A(i+u,j+v);
                            B(i+u,j+v)=1;
                         end
                     end
                end
            end
        end 
    end
    seed1=sum/number;%重新计算种子点的比较值
end
D=zeros(M,N);
D(x2,y2)=1;
flag=1;%遍历指示：当没有新的生长点出现时，生长结束
number=1;%种子点个数
sum=seed2;%种子点值的和
while flag>0
    flag=0;
    for i=1:M
        for j=1:N
            if D(i,j)==1%生长扩增点
                for u=-1:1 
                     for v=-1:1
                         if (i+u)>0&&(j+v)>0&&(i+u)<M&&(j+v)<N&&D(i+u,j+v)==0&&abs(A(i+u,j+v)-seed2)<=T2%判断是否到达边界和是否是种子点
                            flag=1;
                            number=number+1;
                            sum=sum+A(i+u,j+v);
                            D(i+u,j+v)=1;
                         end
                     end
                end
            end
        end 
    end
    seed1=sum/number;%重新计算种子点的比较值
end
for i=1:M
    for j=1:N
        if B(i,j)<D(i,j)
            B(i,j)=1;
        end
    end
end            
B1=A.*B;
figure;
subplot(121);
maxmax=max(max(A));
minmin=min(min(A));
imshow(A,[minmin,maxmax]);title('原始图像');
subplot(122);
maxmax1=max(max(B1));
minmin1=min(min(B1));
imshow(B1,[minmin1,maxmax1]),title('区域生长分割后图像');