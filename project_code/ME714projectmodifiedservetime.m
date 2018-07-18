clear;clc
C=15;PS=[];lambda=4;mu=10;
for i=1:20
average=[];
for TH=1:15
tt=[];waitingstate=0;arrive=[];serve=[];
interval_arrive=exprnd(lambda,1,TH);
arrive=cumsum(interval_arrive);
serve=arrive(end)*ones(1,TH);
floor=max(unidrnd(4,1,TH));
serve_time=arrive(end)+exprnd((2.5)*floor+TH);
arrive_time=arrive(end);
p=TH;q=0;waitingstate=waitingstate+TH;
while p<=10000
    current_time=min([arrive_time,serve_time]);
    if current_time==arrive_time
        arrive_time=arrive_time+exprnd(lambda);
        arrive=[arrive arrive_time];
        q=q+1;
    elseif q>=TH&&q<C
           serve=[serve serve_time*ones(1,(q-1))];
           floor=max(unidrnd(4,1,q));
           serve_time=serve_time+exprnd((2.5)*floor+q);
           p=p+(q-1);
           q=1;
    elseif q>=C
           q=q-C;
           serve=[serve serve_time*ones(1,C)];
           floor=max(unidrnd(4,1,C));
           serve_time=serve_time+exprnd((2.5)*floor+C);
           p=p+C;
    else
        interval_arrive=exprnd(lambda,1,(TH-q));
        arrive=[arrive arrive(end)+cumsum(interval_arrive)];
        arrive_time=arrive(end);
        serve=[serve(1:end) arrive(end)*ones(1,(TH))];
        floor=max(unidrnd(4,1,TH));
        serve_time=serve(end)+exprnd((2.5)*floor+TH);
        q=0;waitingstate=waitingstate+(TH-q);
        p=p+(TH);
    end 
end 
arrive=arrive(1:length(serve));
average(TH)=sum(serve-arrive)/length(serve);
w(TH)=waitingstate;
end
W(i,:)=w;Average(i,:)=average;
end
A=mean(Average);WW=mean(W);
plot(A);
xlabel('Threshold number')
ylabel('average waiting time at mian lobbay')
title('Average waiting time of different thresholds with modified servetime');