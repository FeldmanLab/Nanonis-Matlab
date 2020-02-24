function [Time1, SORB1, K1, HE1, STM1] = importtemplog(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  [TIME1, SORB1, K1, HE1, STM1] = IMPORTFILE(FILE) reads data from the
%  first worksheet in the Microsoft Excel spreadsheet file named FILE.
%  Returns the data as column vectors.
%
%  [TIME1, SORB1, K1, HE1, STM1] = IMPORTFILE(FILE, SHEET) reads from
%  the specified worksheet.
%
%  [TIME1, SORB1, K1, HE1, STM1] = IMPORTFILE(FILE, SHEET, DATALINES)
%  reads from the specified worksheet for the specified row interval(s).
%  Specify DATALINES as a positive scalar integer or a N-by-2 array of
%  positive scalar integers for dis-contiguous row intervals.
%
%  Example:
%  [Time1, SORB1, K1, HE1, STM1] = importfile("C:\Users\STM\log07262019.xls", "Sheet0", [5, 65004]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 23-Oct-2019 13:27:49

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [5, 65004];
end

%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 5);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":E" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Time1", "SORB1", "K1", "HE1", "STM1"];
opts.SelectedVariableNames = ["Time1", "SORB1", "K1", "HE1", "STM1"];
opts.VariableTypes = ["double", "double", "double", "double", "double"];

% Import the data
tbl = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":E" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    tbl = [tbl; tb]; %#ok<AGROW>
end

%% Convert to output type
Time1 = tbl.Time1;
SORB1 = tbl.SORB1;
K1 = tbl.K1;
HE1 = tbl.HE1;
STM1 = tbl.STM1;
end