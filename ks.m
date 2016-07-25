[f,x_values] = ecdf(x0);
F = plot(x_values,f,'ko');
set(F,'LineWidth',2);
hold on;
G = plot(x_values,normcdf(x_values,0,1),'g.');
set(G,'LineWidth',2);
legend([F G],...
       'Box-Muller Method AWGN','Standard Normal CDF',...
       'Location','SE');