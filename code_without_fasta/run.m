clear; clc;
order_full = 24; %We generate high-dimensional natural vectors and then truncate them. Generally, 100 dimensions are sufficient. However, if we increase the dimensions, the subsequent code needs to be adjusted.      
fasta_folder = 'fasta_files';  
excel_file = 'Accession.xlsx'; 
M = 10000;                     

dimension = 4 * (order_full + 1);
nv_filename = sprintf('nv_%d.mat', dimension);

% Read accession numbers and classes from the Excel file
[~, txt, ~] = xlsread(excel_file);
accessions = txt(2:end, 1);
classes = txt(2:end, 2);
nSeq = length(accessions);
fprintf('Number of sequences: %d\n', nSeq);

% Generate the NV dataset
SS = struct('Accession', {}, 'Class', {}, 'NV', {});
for i = 1:nSeq
    acc_full = accessions{i};
    dot_idx = strfind(acc_full, '.');
    if ~isempty(dot_idx)
        acc = acc_full(1:dot_idx(1)-1);
    else
        acc = acc_full;
    end
    fasta_filename = fullfile(fasta_folder, [acc, '.fasta']);
    if exist(fasta_filename, 'file') == 2
        A = fastaread(fasta_filename);
        SS(i).Accession = acc;
        SS(i).Class = classes{i};
        SS(i).NV = nv(A.Sequence, order_full);
        fprintf('Processed sequence: %s\n', acc);
    else
        fprintf('File %s does not exist.\n', fasta_filename);
    end
end
save(nv_filename, 'SS');
fprintf('%s saved successfully.\n', nv_filename);

% Extract unique classes
uniqueClasses = unique({SS.Class});
numClasses = length(uniqueClasses);
min_dimension_found = 0;
n = nSeq; 

% Check for the minimum dimension where convex hulls remain disjoint
for oo = 2:order_full   
    dimension = 4 * (oo + 1);
    vec = zeros(n, dimension);
    classLabels = zeros(n, 1);
    for i = 1:n
        nv_current = SS(i).NV;
        vec(i,:) = [nv_current(1:oo+1), nv_current(26:26+oo), nv_current(51:51+oo), nv_current(76:76+oo)];
        classLabels(i) = find(strcmp(uniqueClasses, SS(i).Class));
    end
    
    % Check convex hull intersections with pairwise normalization
    total_intersections = 0;
    for c1 = 1:numClasses-1
        for c2 = c1+1:numClasses
            % Extract raw data for the pair
            group1_raw = vec(classLabels == c1, :);
            group2_raw = vec(classLabels == c2, :);
            
            % Skip if any group is empty
            if isempty(group1_raw) || isempty(group2_raw)
                continue;
            end
            
            % Calculate combined max for normalization
            combined = [group1_raw; group2_raw];
            maxx = max(abs(combined), [], 1);
            maxx(maxx == 0) = 1;
            
            % Normalize each group separately
            group1_norm = M * group1_raw ./ repmat(maxx, size(group1_raw,1), 1);
            group2_norm = M * group2_raw ./ repmat(maxx, size(group2_raw,1), 1);
            
            % Check intersection
            T = intersection(group1_norm, group2_norm);
            total_intersections = total_intersections + 1 - T;
        end
    end
    
    fprintf('Dimension: %d, Number of intersections: %d\n', dimension, total_intersections);
    
    if total_intersections == 0
        min_dimension_found = dimension;
        fprintf('The convex hull principle holds in %d dimensions.\n', min_dimension_found);
        break;
    end
end

% Final evaluation
if min_dimension_found==0
    fprintf('The convex hulls are not fully disjoint for tested dimensions. Higher order is needed.\n');
end