prefix='ISN 5.10/N11 S9 ';
postfix='.txt';

meas=zeros(5,3); %row=curve#, col=[non-contact voltage, minimum voltage, sensitivity slope nm/V]
hold off
%adh_force_all=[];

b=0;

for(i=1:3)
    for(b=0:1)
        if(b==0)
            fn=[prefix, num2str(i), postfix];
        else
            fn=[prefix, num2str(i), 'b', postfix];
        end
        data=dlmread(fn, ' ', 1, 0);
        %data(:,1)=data(:,1)*1000; %um to nm
        plot(data(:,1), data(:,2));
        hold on
        meas(i,1)=data(end,2);
        [meas(i,2), n]=min(data(:,2));
        meas(i,3)=(data(1,1)-data(n,1))/(data(1,2)-data(n,2));
    end
end

adh_force=(meas(:,1)-meas(:,2)).*meas(:,3);
ac=[mean(adh_force) std(adh_force)];
disp(ac);
adh_force_all=[adh_force_all; ac];