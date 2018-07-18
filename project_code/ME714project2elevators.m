clear;clc;
lambda=1/3;mu=1/10;mu1=1/10;
for th1=1:10
for th2=1:10
for i=1:10
p=8000;q=0;elevatorstate=[0 0];current_time=0;Temp=[];Event=[];
arrive=[];leave=[];elevator1arrive=[];elevator2arrive=[];C=10;
while length(leave)<=p
interval=(-log(1-rand)/(lambda+mu+mu1));
temp=rand;
Temp=[Temp temp];
if temp<=lambda/(lambda+mu+mu1)
    event=0;
elseif temp>lambda/(lambda+mu+mu1)&&temp<=(lambda+mu)/(lambda+mu+mu1)
    event=1;
else
    event=2;
end
Event=[Event event];
if event==0
    current_time=current_time+interval/lambda;
    arrive=[arrive current_time];
    q=q+1;
    if elevatorstate(1)==1&&elevatorstate(2)==0&&q>=th1&&q<=C
        leave=[leave arrive(end)*ones(1,(q))];
        q=0;
        elevatorstate=[0 0];        
    elseif elevatorstate(1)==1&&elevatorstate(2)==0&&q>C
        leave=[leave arrive(end)*ones(1,(C))];
        q=q-C;
        elevatorstate=[0 0];
    elseif elevatorstate(1)==0&&elevatorstate(2)==1&&q>=th2&&q<=C
        leave=[leave arrive(end)*ones(1,(q))];
        q=0;
        elevatorstate=[0 0];
    elseif elevatorstate(1)==0&&elevatorstate(2)==1&&q>C
        leave=[leave arrive(end)*ones(1,(C))];
        q=q-C;
        elevatorstate=[0 0];
    elseif elevatorstate(1)==1&&elevatorstate(2)==1&&q>min(th1,th2)&&q<=C
        leave=[leave arrive(end)*ones(1,(q))];
        q=0;
        if min(th1,th2)==th1
           elevatorstate=[0 1];
        elseif min(th1,th2)==th2
            elevatorstate=[1 0];
        else
            elevatorstate=[0 1];
        end
    elseif elevatorstate(1)==1&&elevatorstate(2)==1&&q>C
        leave=[leave arrive(end)*ones(1,(C))];
        q=q-C;
        if min(th1,th2)==th1
           elevatorstate=[0 1];
        else
            elevatorstate=[1 0];
        end
    end
elseif event==1
    current_time=current_time+interval/mu;
    elevator1arrive=[elevator1arrive current_time];
    if elevatorstate(1)==0
        elevatorstate(1)=1;
    end
    if q>=th1&&q<=C
            leave=[leave elevator1arrive(end)*ones(1,(th1))];
            q=q-th1;
            elevatorstate(1)=0;
    elseif q>C
            leave=[leave elevator1arrive(end)*ones(1,(C))];
            q=q-C;
            elevatorstate(1)=0;
    end
else
    current_time=current_time+interval/mu1;
    elevator2arrive=[elevator2arrive current_time];
    if elevatorstate(2)==0
        elevatorstate(2)=1;
    end
    if q>=th2&&q<=C
            leave=[leave elevator2arrive(end)*ones(1,(th2))];
            q=q-th2;
            elevatorstate(2)=0;
    elseif q>C
            leave=[leave elevator2arrive(end)*ones(1,(C))];
            q=q-C;
            elevatorstate(2)=0;
    end
end
end
arrive=arrive(1:length(leave));
output(i)=mean(leave-arrive);
end
Output(th1,th2)=mean(output);
end
end
p = mesh(Output);
set(p,'FaceColor','white','EdgeColor','black');
hidden off;
x1=xlabel('Threshold1');x2=ylabel('Threshold2');x3=zlabel('average waiting time at mian lobbay');
hold on
[minPS,index]=min(Output);
z=min(minPS);x=find(minPS==z);y=index(x);
plot3(x,y,z,'k.','markersize',20);
hold on;