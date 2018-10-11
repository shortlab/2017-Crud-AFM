prefix='ISN 5.10/N11 CLFC1 ';
postfix='.txt';
strs={'soft', 'hard'};

kref=0.196;%calibrated constant, N/m
Lm=136/146; %tested position on reference cantilever as fraction of its length

slope=[0 0];
hold off

for(i=1:2)
    fn=[prefix, strs{i}, postfix];
    data=dlmread(fn, ' ', 1, 0);
    %data(:,1)=data(:,1)*1000; %um to nm
%     if(i==1)
%         data(1:344,:)=[]; %drop over-extended data
%         data(:,2)=data(:,2)/1000; %mV to V
%     end
    plot(data(:,1), data(:,2));
    hold on
    [~, n]=min(data(:,2));
    slope(i)=(data(1,1)-data(n,1))/(data(1,2)-data(n,2)); %sensitivity in nm/V
end

k=kref*(slope(1)/slope(2)-1)*((1/Lm)^3);

disp([k slope]);