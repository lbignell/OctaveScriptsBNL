%What I need to do:
%- Open the file. The file pointer is at the start of the file.
%- Use fgetl to skip the header.
%- Use fread to skip the preamble that I don't want. (26 chars)
%- Use fread to: read in the part that I want (the 12*char number + 2*char EOL) and skip the parts I don't (the preamble -> 26 chars). Do this above 10000 times.
%- Close the file.
function Wfm = ReadFile(filename)
%tic;
fid = fopen(filename);
fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);fgetl(fid);
%fread(fid, 26, 'char=>char');
%thevals = fread(fid, 10000*(12+2), '14*char=>char', 26);
%Wfm = sscanf(thevals, '%f');
Wfm = textscan(fid, '%*s %*s %f');
fclose(fid);
%toc;
