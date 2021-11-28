
clear all
close all

matData = load('rec\tuske3.mat', 'out');
out = matData.out;

out( out == 0 ) = []; 

cred = [255, 80, 64]/255;
cgre = [4, 143, 27]/255;




f1 = figure('units','normalized','outerposition',[0.2 0 0.8 1], 'Name','Parking spot sonar');
h = animatedline('MaximumNumPoints',200, 'linewidth',5);
ylim([0 255*2.54])
grid on

f2 = figure('units','normalized','outerposition',[0 0 0.2 1], 'Name','Parking spot sonar');
%subplot(141)
hp = set(gca,'Color',cred);
%subplot(122)


%subplot(141)

ix = 1;

f_sample = 20;
duration = 60*3;


ix = 1;


wsize = 15;
di = 1;
d = ones(1,wsize);


pstate = 0;
cnt = 0;
clrcnt = 0;
length_trig = 10;
tresh = 400;

%for ix = 1:length(out)

%out = zeros(1,duration*f_sample);
for ix = 1:length(out)    
    
    
    %x = out(ix);
    x = out(ix);
    %out(ix) = x;
    
    [d, di, xf] = myfilterma(d, di, x);
    
    addpoints(h, ix, x);
    
    figure(f2);
    
     if x > tresh
        cnt = cnt + 1;  
        clrcnt = 0;
        
        plottext_(cgre)
        
        if cnt > length_trig
            plottext_free([1 1 0])
            
        end
        %
        %text(0.5,0.5, "free space",'FontSize',14)
     else
        clrcnt = clrcnt + 1;  
        %set(gca,'Color','r')
        if clrcnt > 4
            %subplot(121)
            plottext_(cred);
        
            cnt = 0;
        end
        
     end
    
    
        drawnow
        pause(0.2)
    
end

function plottext_free(c)
    text(0.1,0.7, "Free",'FontSize',40, 'Color', c)
    text(0.1,0.6, "spot",'FontSize',40, 'Color', c)
    text(0.1,0.5, "detected",'FontSize',40, 'Color', c)
end
function plottext_(c)
   set(gca,'Color',c);
   plottext_free(c);
    
    %text(0.1,0.5, "Free spot detected",'FontSize',40,'Color',[143, 46, 4]/255)
end



function [d, di, xf] = myfilterma(d, di, x)
    wsize = length(d);
    
    d(di) = x;
    
    xf = sum(d)/wsize;
    
    di = di + 1;
    if di > wsize
        di = 1;
    end
    
    

end