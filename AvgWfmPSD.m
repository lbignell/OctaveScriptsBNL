%This function will return the average waveform for a given range of Qfast and PSD ratio, given a baseline length, integral start index, Number of samples after min for Qfast, number of samples after min for Qtotal, the PSD min, PSD max, Qtot min, and Qtot max.
function AvgWfm = AvgWfmPSD(BLlength, StartIdx, QfastTail, QtotTail, PSDmin, PSDmax, Qtotmin, Qtotmax)
FileInfo = dir('Data_*');
namelist = {FileInfo.name};
%wfm = zeros(10000);
MinVal = 0;
MinIdx = 0;
baseline = 0;
QfastIdx = 0;
QtotIdx = 0;
AvgWfm = zeros(10000,1);
NumAvg = 0;
NumErr = 0;
for i = 1:max(size(namelist))
	wfm = ReadFile(namelist{i});
	[MinVal MinIdx] = min(wfm{1});
	QfastIdx = MinIdx + QfastTail;
	QtotIdx = MinIdx + QtotTail;
	if (max(size(wfm{1})) > 2800)&&(max(wfm{1}(1:2800)<0))
		baseline = sum(wfm{1}((StartIdx-BLlength):StartIdx))./BLlength;%(StartIdx - BLlength);
		Qfast = sum(wfm{1}(StartIdx:QfastIdx)) - (QfastIdx - StartIdx)*baseline;
		Qtot = sum(wfm{1}(StartIdx:QtotIdx)) - (QtotIdx - StartIdx)*baseline;
		PSD = Qfast./Qtot;
		if (PSDmin<PSD)&&(PSD<PSDmax)&&(Qtotmin<Qtot)&&(Qtot<Qtotmax)&&(!(sum(isnan(wfm{1}))))
			if (size(AvgWfm)==size(wfm{1}))
				AvgWfm = AvgWfm + wfm{1};
				NumAvg = NumAvg + 1;
			else
				%printf('incorrect size, i = %d', i);
				%size(wfm)
				NumErr = NumErr+1;
			end
		end
	end
end
AvgWfm = AvgWfm./NumAvg;
printf('NumAvg = %d\n', NumAvg);
printf('NumErr = %d\n', NumErr);

