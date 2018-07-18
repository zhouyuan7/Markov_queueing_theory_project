clear;clc
mu=1/15;C=15;PS=[];
for j=2:9
lambda=(j/15);
for i=1:30
average=[];
for TH=1:15
tt=[];arrive=[];serve=[];
interval_arrive=-log(1-rand(1,TH))/lambda;
arrive=cumsum(interval_arrive);
serve=arrive(end)*ones(1,TH);
serve_time=arrive(end)+(-log(1-rand)/mu);
arrive_time=arrive(end);
p=TH;q=0;
while p<=10000
    current_time=min([arrive_time,serve_time]);
    if current_time==arrive_time
        arrive_time=arrive_time+(-log(1-rand)/lambda);
        arrive=[arrive arrive_time];
        q=q+1;
    elseif q>=TH&&q<C
           serve=[serve serve_time*ones(1,(q-1))];
           serve_time=serve_time+(-log(1-rand)/mu);
           p=p+(q-1);
           q=1;
    elseif q>=C
           q=q-C;
           serve=[serve serve_time*ones(1,C)];
           serve_time=serve_time+(-log(1-rand)/mu);
           p=p+C;
    else
        interval_arrive=-log(1-rand(1,(TH-q)))/lambda;
        arrive=[arrive arrive(end)+cumsum(interval_arrive)];
        arrive_time=arrive(end);
        serve=[serve(1:end) arrive(end)*ones(1,(TH))];
        serve_time=serve(end)+(-log(1-rand)/mu);
        q=0;
        p=p+(TH);
    end 
end 
arrive=arrive(1:length(serve));
average(TH)=sum(serve-arrive)/length(serve);
end
Average(i,:)=average;
end
A=mean(Average);
PS(:,(j-1))=A;
end
mesh(2/15:1/15:9/15,1:15,PS);
x1=xlabel('Passenger Arrive Rate');
x2=ylabel('Threshold');
x3=zlabel('average waiting time at mian lobbay');
hold on;
[minPS,index]=min(PS);
for i=1:8
th=index(i);
time=minPS(i);
plot3(2/15+(i-1)/15,th,time,'k.','markersize',20);
hold on;
plot3(2/15+(i-1)/15,1,PS(1,i),'b.','markersize',20);
hold on;
plot3(2/15+(i-1)/15,7,PS(7,i),'g.','markersize',20);
end