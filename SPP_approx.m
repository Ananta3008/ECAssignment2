function run_heuristic()
    numFiles = 12;
    aggregatedResults = cell(numFiles, 1);

    % Open result file
    resultFile = fopen('gap_approx_result.txt', 'w');
    if resultFile == -1
        error('Cannot open gap_approx_result.txt for writing.');
    end

    % Process each file
    for fileIdx = 1:numFiles
        fileName = sprintf('gap%d.txt', fileIdx);
        fileID = fopen(fileName, 'r');
        if fileID == -1
            error('Error opening file %s.', fileName);
        end

        numInstances = fscanf(fileID, '%d', 1);
        caseResults = cell(numInstances, 1);

        fprintf(resultFile, 'gap%d\n', fileIdx);  % Header in file

        for instanceIdx = 1:numInstances
            m = fscanf(fileID, '%d', 1); 
            n = fscanf(fileID, '%d', 1); 
            c = fscanf(fileID, '%d', [n, m])';
            r = fscanf(fileID, '%d', [n, m])';
            b = fscanf(fileID, '%d', [m, 1]);

            x_matrix = solve_heuristic(m, n, c, r, b);
            totalCost = sum(sum(c .* x_matrix));

            line = sprintf('c%d-%d\t%d', m*100 + n, instanceIdx, round(totalCost));
            caseResults{instanceIdx} = line;
            fprintf(resultFile, '%s\n', line);
        end

        fclose(fileID);
        aggregatedResults{fileIdx} = caseResults;
    end

    fclose(resultFile);

    % Display results in formatted columns
    columnsPerRow = 4;
    for rowStart = 1:columnsPerRow:numFiles
        rowEnd = min(rowStart + columnsPerRow - 1, numFiles);

        % Print headers
        for fileIndex = rowStart:rowEnd
            fprintf('gap%d\t\t', fileIndex);
        end
        fprintf('\n');

        % Determine max number of cases in this row
        maxCases = max(cellfun(@length, aggregatedResults(rowStart:rowEnd)));

        % Print each row of results
        for caseIndex = 1:maxCases
            for fileIndex = rowStart:rowEnd
                if caseIndex <= length(aggregatedResults{fileIndex})
                    fprintf('%s\t', aggregatedResults{fileIndex}{caseIndex});
                else
                    fprintf('\t\t');
                end
            end
            fprintf('\n');
        end
        fprintf('\n');
    end
end

function xMatrix = solve_heuristic(m, n, c, r, b)
    xMatrix = zeros(m, n); 
    efficiency = -c ./ (r + 1e-6);
    [~, sortedIdx] = sort(efficiency(:), 'descend');
    remaining_b = b;

    for idx = sortedIdx'
        [i, j] = ind2sub([m, n], idx);
        if remaining_b(i) >= r(i, j)
            xMatrix(i, j) = 1;
            remaining_b(i) = remaining_b(i) - r(i, j);
        end
    end
end
