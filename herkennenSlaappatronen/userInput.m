%file = input('Welke dataset wil je testen? ', 's');
%data = load(file);

[file,path] = uigetfile('*');
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
end

data = load(file);