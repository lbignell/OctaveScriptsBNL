%This script will simply read in all .xls files in the current directory,
%saving each of them as the identical filename, but with .csv.

%This makes a struct XLSfile...
XLSfile = dir("*.xls")

numfiles = max(size(XLSfile))

for i = 1:numfiles


end