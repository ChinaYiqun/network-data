function nodequeue = f_reversegreed(network,method)

n1 = size(network,1);

cost_all = sparse(n1,n1+1);
nodequeue = zeros(1,n1);
taillocation = 1;

tz = method(network);
[~,r_s] = sort(tz);

network(:,:) = network(r_s,r_s);
nbofallnodes = cell(1,n1);
for k1 = 1:n1
    nbofallnodes{k1} = find(network(:,k1))';
end

haseffect = zeros(1,n1);
for k1 = 1:n1
    if ~haseffect(k1)
        nodequeue(taillocation) = k1;
        taillocation = taillocation+1;
        haseffect(nbofallnodes{k1}) = haseffect(nbofallnodes{k1})+1;
        cost_all(nbofallnodes{k1},k1) = 1;
        cost_all(k1,n1+1) = Inf;
    end
end
for taillocation = taillocation:n1
    costofnode = sum(cost_all,2);
    [kk1,kk2] = min(costofnode);
    nodequeue(taillocation) = kk2;
    nodead = find(cost_all(kk2,:));
    all_lj = find(sum([network(:,kk2) cost_all(:,nodead)],2));
    cost_all(all_lj,kk2) = kk1+1;
    cost_all(:,nodead) = 0;
	cost_all(kk2,n1+1) = Inf;
end

nodequeue = nodequeue(n1:-1:1);
nodequeue = r_s(nodequeue);
if length(unique(nodequeue)) ~= size(network,1)
    input('Error!');
end

end