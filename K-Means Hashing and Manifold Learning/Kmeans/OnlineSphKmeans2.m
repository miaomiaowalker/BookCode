function [centroids,s,s2,error] = OnlineSphKmeans2(X,k,max_iter,eps)
	if ~exist('eps','var'), eps=0.005; end
	if ~exist('max_iter','var'), max_iter=20; end
	error = 99999999999999;
	iter = 0;
	fprintf('Running Spherical Kmeans for %d iterations\n', max_iter );
	%s = zeros(size(X,1),k);
	s=sparse(size(X,1),k);
	% Random Initialize Centroids
	fprintf('Initializing Centroids\n');
	centroids = rand(k,size(X,2));
	% Normalize Centroids to have norm=1
	fprintf('Normalizing Centroids\n');
	centroids = RowNormalize(centroids);
	
	fprintf('Entering First Iteration\n');

	while (iter < max_iter) && (error>eps)
		D = X * centroids';
        % 'Now create matrix s with assignments of points to centroids;
        s = repmat(max(d, [], 2), 1, size(d, 2)) .* (d == repmat(max(d, [], 2), 1, size(d, 2)))
        old_centroids = centroids;
        iter = iter + 1;
        centroids = (s'*X) + centroids;
        centroids = RowNormalize(centroids);
		error = (sum(sum(centroids-old_centroids)));
    	error = abs(error);
	end
	s2=s;
	fprintf('Finished in %d iterations\n',iter)
	%s = sparse(1,size(X,1));
	s= (s~=0) * (1:size(s,2))';
end