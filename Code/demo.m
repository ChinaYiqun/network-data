network = sparse(Jazz);

tic;

method = @f_degree;
rg = f_reversegreed(network,method);

t = toc;