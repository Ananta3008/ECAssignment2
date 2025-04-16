% Read lines from both result files
ilp_raw = readlines("gap_ilp_result.txt");
approx_raw = readlines("gap_approx_result.txt");

% Initialize arrays
ilp_vals = [];
approx_vals = [];

% Extract 5th instance values from ILP
for i = 1:length(ilp_raw)
    line = strtrim(ilp_raw(i));
    if contains(line, "-5")
        parts = split(line);
        if numel(parts) == 2 && ~any(ismissing(parts))
            ilp_vals(end+1) = str2double(parts(2));
        end
    end
end

% Extract 5th instance values from Approximation
for i = 1:length(approx_raw)
    line = strtrim(approx_raw(i));
    if contains(line, "-5")
        parts = split(line);
        if numel(parts) == 2 && ~any(ismissing(parts))
            approx_vals(end+1) = str2double(parts(2));
        end
    end
end

% Make sure both lists are aligned
min_len = min(length(ilp_vals), length(approx_vals));
ilp_vals = ilp_vals(1:min_len);
approx_vals = approx_vals(1:min_len);

% Create gap labels like gap1, gap2, ...
gap_labels = "gap" + (1:min_len);

% Plot the graph
figure('Color','w');
plot(ilp_vals, '-o', 'LineWidth', 2, 'DisplayName', 'ILP (Optimal)');
hold on;
plot(approx_vals, '-s', 'LineWidth', 2, 'DisplayName', 'Approximation');
hold off;

% Styling
legend('Location', 'northwest');
xlabel('GAP File', 'FontSize', 10);
ylabel('Objective Value', 'FontSize', 10);
title('Comparison of ILP vs Approximation', 'FontSize', 12);
xticks(1:min_len);
xticklabels(gap_labels);
xtickangle(45);
grid on;
box off;

% Save figure (optional)
saveas(gcf, 'comparison_ilp_vs_approx.png');
