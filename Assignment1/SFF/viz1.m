% Visualisation Support

x  = nu;
y1 = power_KS(1, 1, :);
y1 = y1(:);
y2 = power_KS(1, 2, :);
y2 = y2(:);
y3 = power_KS(1, 3, :);
y3 = y3(:);
plot(x,y1,x,y2,x,y3);
title('Power of size 0.05 KD Test for tLocationScale');
xlabel('Degrees of Freedom for Student`s t');
ylabel('Power');
legend(string(sample_size));

x  = nu;
y1 = power_AD(1, 1, :);
y1 = y1(:);
y2 = power_AD(1, 2, :);
y2 = y2(:);
y3 = power_AD(1, 3, :);
y3 = y3(:);
plot(x,y1,x,y2,x,y3);
title('Power of size 0.05 AD Test for tLocationScale');
xlabel('Degrees of Freedom for Student`s t');
ylabel('Power');
legend(string(sample_size));

format shortg;

cutoffs = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

a1    = q_KS(:,1,:);
a2    = q_KS(:,2,:);
a3    = q_KS(:,3,:);
tab   = [a1(:),a2(:),a3(:)];

cutoffs_KS_05 = tab;

a1    = q_AD(:,1,:);
a2    = q_AD(:,2,:);
a3    = q_AD(:,3,:);
tab   = [a1(:),a2(:),a3(:)];

cutoffs_AD_05 = tab;

cutoffs_05 = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(q_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(q_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

save('/Users/lorenzof/Documents/MATLAB/SFF/test.mat', 'cutoffs_KS_05', 'cutoffs_AD_05')


power = table( ...
    array2table(sign_lvl', 'VariableNames', {'α\r'}), ...
    array2table(round(power_KS(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    array2table(round(power_AD(:,:,1), 3), 'VariableNames', {'30', '60', '100'}), ...
    'VariableNames', {' ','KS','AD'} ...
    );

% writeable(cutoffs, 'cutoffs.csv') % TO ADJUST
