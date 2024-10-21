[data, txt] = xlsread('Accession_new.xlsx'); % The file that contains accession numbers

firstColumn = txt(:,1); 
secondColumn = txt(:,2); 

for i = 2:length(firstColumn)
    idx = strfind(firstColumn{i}, '.');
    if ~isempty(idx)
        acc = firstColumn{i}(1:idx(1)-1); 
    else
        acc = firstColumn{i}; 
    end
    fastaFilename = [acc, '.fasta'];
    %if exist(fastaFilename, 'file') ~= 2 
    %    fprintf('Missing file: %s\n', fastaFilename);  
    %    continue;  
    %end
    i
    A = fastaread(fastaFilename);
    S(i-1).Accession=acc;
    S(i-1).Organism = secondColumn{i};
    S(i-1).NV = nv(A.Sequence,20);
end

save('S','S')