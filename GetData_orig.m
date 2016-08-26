%This function will grab data from a single file, and plot it.

  function [theTime, ch1, ch2] = GetData(fname)

    ID = fopen(fname);
    
    %Scan the file and populate the Contents cell array.
    Contents = textscan(ID, '%f/%f/%f %f:%f:%f %f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', 1, 'HeaderLines', 5);
    
    %Grab the year, month, and day data and parse into a datenum.
    theDay = datenum(Contents(1,3){1}(:), Contents(1,1){1}(:), Contents(1,2){1}(:));
    
    %Define number of days since Lindsey was born.
    %theDay = Contents(1,3){1}(:).*365.25 + Contents(1,1){1}(:
    
    %Convert the hour, minute, and seconds data into fractions of days, for adding to datenum
    theHour = Contents(1,4){1}(:)./24.0;
    theMinute = Contents(1,5){1}(:)./(24.0*60.0);
    theSecond = Contents(1,6){1}(:)./(24.0*60.0*60.0);
    
    %Returns
    theTime = theDay + theHour + theMinute + theSecond;
    ch1 = Contents(1,7){1}(:);
    ch2 = Contents(1,8){1}(:);
  end
