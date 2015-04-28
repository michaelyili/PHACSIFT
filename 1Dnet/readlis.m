function [M] = readlis(str);
% read lis file, returned value is the read matrix
% plot 1-D circuit system function curve
% input file is a text file storing filtered data as a single column
%
% Author: Li Yi
% modified at Nov.2 2014

fp = fopen(str);
if (fp < 0) 
	error('fail to open file...\n');
end

array = [];

while ~feof(fp)
	line = fgetl(fp);
	if line ~= -1
		str = line(1: length(line)-1);
		num = str2num(str);
       
		if (line(length(line)) == 'u')
			num = num * 10^(-3);
		end
		if (line(length(line)) == 'n')
			num = num * 10^(-6)
		end
		if (line(length(line)) == 'p')
			num = num * 10^(-9);
		end
		array = [array, num];
	end
end

fclose(fp);
%array
figure;
axi = 1:length(array);
plot(axi, array, '-b*');
xlabel('node index');
ylabel('voltage');
%legend('voltage curve');

end
