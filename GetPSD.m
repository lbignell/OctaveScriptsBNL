%This function will generate a matrix of Qfast and Qtotal, given a baseline length, integral start index, Number fo samples after min for Qfast, and number of samples after min for Qtotal.
function PSD = GetPSD(BLlength, StartIdx, QfastTail, QtotTail)
FileInfo = dir('Data_*');
namelist = {FileInfo.name};
%wfm = zeros(10000);
MinVal = 0;
MinIdx = 0;
baseline = 0;
QfastIdx = 0;
QtotIdx = 0;
PSD = zeros(max(size(namelist)), 2);
for i = 1:max(size(namelist))
	wfm = ReadFile(namelist{i});
	[MinVal MinIdx] = min(wfm{1});
	QfastIdx = MinIdx + QfastTail;
	QtotIdx = MinIdx + QtotTail;
	if (max(size(wfm{1})) > 2800)&&(max(wfm{1}(1:2800)<0))
		baseline = sum(wfm{1}((StartIdx-BLlength):StartIdx))./BLlength;%(StartIdx - BLlength);
		PSD(i,1) = sum(wfm{1}(StartIdx:QfastIdx)) - (QfastIdx - StartIdx)*baseline;
		PSD(i,2) = sum(wfm{1}(StartIdx:QtotIdx)) - (QtotIdx - StartIdx)*baseline;
	end
end

