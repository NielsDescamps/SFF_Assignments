function sample = mvtLocationScale_random(sample_size,Mu, Sigma,df)

% generate location zero bivariate student-t samples
sample = mvtrnd(Sigma,df,sample_size);

% correct for the location
sample(:,1) = sample(:,1) + Mu(1);
sample(:,2) = sample(:,2) + Mu(2);
end