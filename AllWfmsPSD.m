%This function will return a matrix whose columns contain the waveforms for the samples that fall within the range of (PSDmin, PSDmax) and (Qtotmin, Qtotmax). Arguments are: baseline length, integral start index, Number of samples after min for Qfast, number of samples after min for Qtotal, the PSD min, PSD max, Qtot min, and Qtot max.
function Wfms = AllWfmsPSD(BLlength, StartIdx, QfastTail, QtotTail, PSDmin, PSDmax, Qtotmin, Qtotmax)
FileInfo = dir('Data_*');
namelist = {FileInfo.name};
%wfm = zeros(10000);
MinVal = 0;
MinIdx = 0;
baseline = 0;
QfastIdx = 0;
QtotIdx = 0;
Wfms = [];
NumAvg = 0;
NumErr = 0;
for i = 1:max(size(namelist))
	wfm = ReadFile(namelist{i});
	[MinVal MinIdx] = min(wfm);
	QfastIdx = MinIdx + QfastTail;
	QtotIdx = MinIdx + QtotTail;
	if (max(size(wfm)) > 2800)&&(max(wfm(1:2800)<0))
		baseline = sum(wfm((StartIdx-BLlength):StartIdx))./(StartIdx - BLlength);
		Qfast = sum(wfm(StartIdx:QfastIdx)) - (QfastIdx - StartIdx)*baseline;
		Qtot = sum(wfm(StartIdx:QtotIdx)) - (QtotIdx - StartIdx)*baseline;
		PSD = Qfast./Qtot;
		if (PSDmin<PSD)&&(PSD<PSDmax)&&(Qtotmin<Qtot)&&(Qtot<Qtotmax)&&(!(sum(isnan(wfm))))
			if (size(zeros(10000,1))==size(wfm))
				Wfms = [Wfms wfm];
				NumAvg = NumAvg + 1;
			else
				%printf('incorrect size, i = %d', i);
				%size(wfm)
				NumErr = NumErr+1;
			end
		end
	end
end
printf('NumAvg = %d\n', NumAvg);
printf('NumErr = %d\n', NumErr);

