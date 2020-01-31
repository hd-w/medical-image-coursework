%���������ָ���ͼ�� Segmentation by region growing
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
%������ʼ��
x=70;
y=80;
seed=A(x,y);%�趨�����ӵ�Ƚϵ�ֵ
B=zeros(M,N);
B(x,y)=1;
flag=1;%��־λ
number=1;%���ӵ����
T=36;    %��ֵ
sum=seed;%���ӵ�ֵ�ĺ�
while flag>0
    flag=0;
    for i=1:M
        for j=1:N
            if B(i,j)==1%����������
                for u=-1:1 
                     for v=-1:1
                         if (i+u)>0&&(j+v)>0&&(i+u)<M&&(j+v)<N&&B(i+u,j+v)==0&&abs(A(i+u,j+v)-seed)<=T%�ж��Ƿ񵽴�߽���Ƿ������ӵ�
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
    seed=sum/number;%���¼������ӵ�ıȽ�ֵ
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