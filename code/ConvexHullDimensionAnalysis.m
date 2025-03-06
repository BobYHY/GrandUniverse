function ConvexHullDimensionAnalysis(S, order_full, low_dimension, M)
    nSeq = length(S);
    uniqueClasses = unique({S.Class});
    numClasses = length(uniqueClasses);
    numIterations = 100;
    violation_count = 0;

    oo = low_dimension/4 - 1;
    vec = zeros(nSeq, low_dimension);
    for i = 1:nSeq
        nv_current = S(i).NV;
        vec(i,:) = [nv_current(1:oo+1), nv_current(26:26+oo), nv_current(51:51+oo), nv_current(76:76+oo)];
    end

    original_labels = zeros(nSeq, 1);
    for i = 1:nSeq
        original_labels(i) = find(strcmp(uniqueClasses, S(i).Class));
    end

    for iter = 1:numIterations
        rand_idx = randperm(nSeq);
        random_labels = original_labels(rand_idx);
        disjoint_flag = true;
        for c1 = 1:numClasses-1
            for c2 = c1+1:numClasses
                group1_raw = vec(random_labels == c1, :);
                group2_raw = vec(random_labels == c2, :);
                if isempty(group1_raw) || isempty(group2_raw)
                    continue; 
                end
                combined = [group1_raw; group2_raw];
                maxx = max(abs(combined), [], 1);
                maxx(maxx == 0) = 1;
                group1_norm = M * group1_raw ./ repmat(maxx, size(group1_raw,1), 1);
                group2_norm = M * group2_raw ./ repmat(maxx, size(group2_raw,1), 1);
                T = intersection(group1_norm, group2_norm);
                if T == 0 
                    disjoint_flag = false;
                    break;
                end
            end
            if ~disjoint_flag
                break;
            end
        end
        
        if ~disjoint_flag
            violation_count = violation_count + 1;
        end
    end

    fprintf('Out of %d random tests, convex hulls intersected %d times.\n', numIterations, violation_count);
    Ratio = violation_count / numIterations;
    fprintf('Estimated p-value: %.4f\n', Ratio);
end