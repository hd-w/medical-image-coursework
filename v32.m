%����������ʾ­��ͼ�� region growing for skull highlighting
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
seed1=A(x1,y1);%�趨�����ӵ�Ƚ�ֵ
seed2=A(x2,y2);
B=zeros(M,N);
B(x1,y1)=1;
flag=1;%��־λ
number=1;%���ӵ����
T1=30;    %��ֵ
T2=30;
sum=seed1;%���ӵ�ֵ�ĺ�
while flag>0
    flag=0;
    for i=1:M
        for j=1:N
            if B(i,j)==1%����������
                for u=-1:1 
                     for v=-1:1
                         if (i+u)>0&&(j+v)>0&&(i+u)<M&&(j+v)<N&&B(i+u,j+v)==0&&abs(A(i+u,j+v)-seed1)<=T1%�ж��Ƿ񵽴�߽���Ƿ������ӵ�
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
    seed1=sum/number;%���¼������ӵ�ıȽ�ֵ
end
D=zeros(M,N);
D(x2,y2)=1;
flag=1;%����ָʾ����û���µ����������ʱ����������
number=1;%���ӵ����
sum=seed2;%���ӵ�ֵ�ĺ�
while flag>0
    flag=0;
    for i=1:M
        for j=1:N
            if D(i,j)==1%����������
                for u=-1:1 
                     for v=-1:1
                         if (i+u)>0&&(j+v)>0&&(i+u)<M&&(j+v)<N&&D(i+u,j+v)==0&&abs(A(i+u,j+v)-seed2)<=T2%�ж��Ƿ񵽴�߽���Ƿ������ӵ�
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
    seed1=sum/number;%���¼������ӵ�ıȽ�ֵ
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
imshow(A,[minmin,maxmax]);title('ԭʼͼ��');
subplot(122);
maxmax1=max(max(B1));
minmin1=min(min(B1));
imshow(B1,[minmin1,maxmax1]),title('���������ָ��ͼ��');