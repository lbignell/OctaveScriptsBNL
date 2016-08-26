%This is a macro to run the GetData on all files in a given folder, then print the output.
%First, grab the data file names
theFiles = dir('Data_*');
theFNames = {theFiles.name}
%Run the first time to initialise
printf("Processing file: %s \n", theFNames{1});
[tstamp, Ch1, Ch2] = GetData(theFNames{1})
for i = 1:max(size(theFNames))
	printf("Processing file: %s \n", theFNames{i});
	%iterate though...
	[tstamp_tmp, Ch1_tmp, Ch2_tmp] = GetData(theFNames{i});
	tstamp = [tstamp; tstamp_tmp];
	Ch1 = [Ch1; Ch1_tmp];
	Ch2 = [Ch2; Ch2_tmp];
end
%do outputs
printf("Start time = %f \n", tstamp(1));
toffset = tstamp(:) - tstamp(1);
figure;
hold on;
plot(toffset, Ch1, 'b');
plot(toffset, Ch2, 'r');
