%This macro will get the current axis labels and set them to time format.
%The argument is the number of ticks to use.
%To reset the axis range, use axis([xlow xup ylow yup]);
%I'm assuming the current axis used unix timestamp, and I'm not accounting
%for leap seconds.
function FormatTimeAxis(NumTicks, formatstring)
  %Set default time format.
  if nargin < 2
    formatstring = 'yy-mm-dd HH:MM:SS';
  end
  %Make formatting changes.
  L = get(gca, 'XLim');
  set(gca, 'XTick', linspace(L(1), L(2), NumTicks));
  xticks = get(gca, ['x', 'Tick']);
  dates = datestr(xticks/86400 + datenum(1903,12,31,20,0,0), formatstring);
  set(gca, ['x', 'TickLabel'], dates);
end