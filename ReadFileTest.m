%This will read in the data using textscan.
tic;
fid = fopen('Data_0_3519322988');
Wfm = textscan(fid, '%*u/%*u/%*u %*u:%*u:%*f %f', 10000, 'headerlines', 5);
fclose(fid);
toc;

%This example preassigns the size:
tic;
Wfm = zeros(10000,1);
Wfm = textread('Data_0_3519322988','%*u/%*u/%*u %*u:%*u:%*f %f','headerlines', 5);
toc;

%This is another approach:
tic;
fid = fopen('Data_0_3519322988');
for i = 1:5
	fgetl(fid);
end
Wfm = zeros(10000,1);
for i = 1:10000
%	printf('i = %d', i);
	theline = fgetl(fid);
	Wfm(i) = sscanf(tline, '%*u/%*u/%*u %*u:%*u:%*f %f');
end
fclose(fid);
toc;

%Yet another approach:
tic;
fid = fopen('Data_0_3519322988');
Wfm = zeros(10000,1);
Wfm = fread(fid, 10000, 'double');
fclose(fid);
toc;

%What I need to do:
%- Open the file. The file pointer is at the start of the file.
%- Use fgetl to skip the header.
%- Use fread to skip the preamble that I don't want. (26 chars)
%- Use fread to: read in the part that I want (the n*char number) and skip the parts I don't (the EOL + preamble -> 28 chars). Do this above 10000 times.
%- Close the file.
tic;
fid = fopen('Data_0_3519322988');
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);
fread(fid, 26, 'char=>char');
thevals = fread(fid, 10000*(12+2), '14*char=>char', 26);
Wfm = zeros(10000,1);
Wfm = sscanf(thevals, '%f');
fclose(fid);
toc;

%Apparently, this will vectorise the data read, though I don't understand the code.
%tic;
%fid = fopen('Data_0_3519322988');
%bufferSize = 10000;
%eol = sprintf('\n');

%dataBatch = fread(fid,bufferSize,'uint8=>char')';
%dataIncrement = fread(fid,1,'uint8=>char');
%while ~isempty(dataIncrement) && (dataIncrement(end) ~= eol) && ~feof(fid)
%    dataIncrement(end+1) = fread(fid,1,'uint8=>char');  %This can be slightly optimized
%end
%data = [dataBatch dataIncrement];

%while ~isempty(data)
%    scannedData = reshape(sscanf(data,'%d, %d'),2,[])';
%    CHECK = round((CHECK + mean(scannedData(:)) ) /2);

%    dataBatch = fread(fid,bufferSize,'uint8=>char')';
%    dataIncrement = fread(fid,1,'uint8=>char');
%    while ~isempty(dataIncrement) && (dataIncrement(end) ~= eol) && ~feof(fid)
%        dataIncrement(end+1) = fread(fid,1,'uint8=>char');%This can be slightly optimized
%    end
%    data = [dataBatch dataIncrement];
%end
%fclose(fid);
%t = toc;
%fprintf(1,'Fully batched operations.  %3.2f sec.  %d check \n', t, CHECK);
