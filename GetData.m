%This is a function that will take a file name as an argument and return a 10K point data vector of the waveform.
function [ch1, ch2, ch3, ch4] = GetData(filename)
  %Read the file 'filename' as a formatted text file.
  [month, day, year, hour, minute, second, ch1, ch2, ch3, ch4] = textread(filename, '%d/%d/%d %d:%d:%f %f %f %f %f', 'headerlines', 5);
  
end
  