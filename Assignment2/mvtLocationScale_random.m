function sample = mvtLocationScale_random(sample_size,Mu, Sigma,df)

% generate location zero bivariate student t samples
R = mvtrnd(Sigma,df,sample_size);

% correct for the location
R(:,1) = R(:,1) + Mu(1);
R(:,2) = R(:,2) + Mu(2);

sample = R;
end