clear;clc
mu1=1/15;mu2=1/5;lambda=1/3;C=10;PS=[];
for TH1=1:10
for TH2=1:10
for i=1:10
%%
arrive1=[];serve1=[];
interval_arrive1=-log(1-rand(1,TH1))/lambda;
arrive1=cumsum(interval_arrive1);
serve1=arrive1(end)*ones(1,TH1);
serve_time1=arrive1(end)+(-log(1-rand)/mu1);
arrive_time1=arrive1(end);
p1=TH1;q1=0;
while p1<=8000
    current_time1=min([arrive_time1,serve_time1]);
    if current_time1==arrive_time1
        arrive_time1=arrive_time1+(-log(1-rand)/lambda);
        arrive1=[arrive1 arrive_time1];
        q1=q1+1;
    elseif q1>=TH1&&q1<C
           serve1=[serve1 serve_time1*ones(1,(q1-1))];
           serve_time1=serve_time1+(-log(1-rand)/mu1);
           p1=p1+(q1-1);
           q1=1;
    elseif q1>=C
           q1=q1-C;
           serve1=[serve1 serve_time1*ones(1,C)];
           serve_time1=serve_time1+(-log(1-rand)/mu1);
           p1=p1+C;
    else
        interval_arrive1=-log(1-rand(1,(TH1-q1)))/lambda;
        arrive1=[arrive1 arrive1(end)+cumsum(interval_arrive1)];
        arrive_time1=arrive1(end);
        serve1=[serve1(1:end) arrive1(end)*ones(1,(TH1))];
        serve_time1=serve1(end)+(-log(1-rand)/mu1);
        q1=0;
        p1=p1+(TH1);
    end 
end 
%%
arrive2=[];serve2=[];
interval_arrive2=-log(1-rand(1,TH2))/lambda;
arrive2=cumsum(interval_arrive2);
serve2=arrive2(end)*ones(1,TH2);
serve_time2=arrive2(end)+(-log(1-rand)/mu2);
arrive_time2=arrive2(end);
p2=TH2;q2=0;
while p2<=8000
    current_time2=min([arrive_time2,serve_time2]);
    if current_time2==arrive_time2
        arrive_time2=arrive_time2+(-log(1-rand)/lambda);
        arrive2=[arrive2 arrive_time2];
        q2=q2+1;
    elseif q2>=TH2&&q2<C
           serve2=[serve2 serve_time2*ones(1,(q2-1))];
           serve_time2=serve_time2+(-log(1-rand)/mu2);
           p2=p2+(q2-1);
           q2=1;
    elseif q2>=C
           q2=q2-C;
           serve2=[serve2 serve_time2*ones(1,C)];
           serve_time2=serve_time2+(-log(1-rand)/mu2);
           p2=p2+C;
    else
        interval_arrive2=-log(1-rand(1,(TH2-q2)))/lambda;
        arrive2=[arrive2 arrive2(end)+cumsum(interval_arrive2)];
        arrive_time2=arrive2(end);
        serve2=[serve2(1:end) arrive2(end)*ones(1,(TH2))];
        serve_time2=serve2(end)+(-log(1-rand)/mu2);
        q2=0;
        p2=p2+(TH2);
    end 
end 
%%
if length(arrive1)>=length(serve1)
    arrive1=arrive1(1:length(serve1));
else
    serve1=serve1(1:length(arrive1));
end
if length(arrive2)>=length(serve2)
    arrive2=arrive2(1:length(serve2));
else
    serve2=serve2(1:length(arrive2));
end
p1=serve1-arrive1;p2=serve2-arrive2;p=[p1 p2];
average(i)=mean(p);
end
Output(TH1,TH2)=mean(p);
end
end
o = mesh(Output);
set(o,'FaceColor','white','EdgeColor','black');
hold on;
x1=xlabel('Threshold1');x2=ylabel('Threshold2');x3=zlabel('average waiting time at mian lobbay');
plot3(5,5,40,'k.','markersize',20);
hold on;
[minPS,index]=min(Output);
z=min(minPS);x=find(minPS==z);y=index(x);
plot3(x,y,z,'k.','markersize',30);