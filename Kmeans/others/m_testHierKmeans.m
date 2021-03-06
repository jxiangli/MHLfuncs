function m_testHierKmeans()
    test2();

% more clusters
function test2()
    Data1 = genGaussCluster([0;0], 3, 70);
    Data2 = genGaussCluster([10;10], 2, 100);
    Data3 = genGaussCluster([-10;-10], 5, 100);
    Data4 = genGaussCluster([+10;-7], 3, 200);
    Data5 = genGaussCluster([10;-3], 6, 100);
    
    X = [Data1, Data2, Data3, Data4, Data5]';
    idxs = randperm(size(X,1)); 
    X = X(idxs, :);
    
    k = floor(size(X,1)/2);
    TestX = X(k+1:end,:);
    X = X(1:k,:);

    
    factor = 2;
    depth = 3;
    [IDXs, clustModel] = ml_hierKmeans(X, factor, depth, 5);
    TestIDXs = ml_hierKmeans_assign(TestX, clustModel);

    for j=1:depth
        figure(j); clf; 
        for i=1:factor^j
            class_i = X(IDXs(:,depth-j+1) == i,:);
            Test_class_i = TestX(TestIDXs(:,depth -j +1) == i,:);
            scatter([class_i(:,1); Test_class_i(:,1)], ...
                [class_i(:,2); Test_class_i(:,2)]);
            hold on;
        end;                
        axis image ij;
    end;
    keyboard;
    
%     TData1 = genGaussCluster([0;0], 4, 70);
%     TData2 = genGaussCluster([10;10], 3, 100);
%     TData3 = genGaussCluster([-7;-10], 5, 100);
%     TData4 = genGaussCluster([+20;-7], 3, 200);
%     TData5 = genGaussCluster([5;-3], 6, 100);
%     
%     TX = [TData1, TData2, TData3, TData4, TData5]';
%     IDXs = ml_hierKmeans_assign(TX, clustModel);
% 
%     for j=1:depth
%         figure(depth+j); clf; 
%         for i=1:factor^j
%             class_i = TX(IDXs(:,depth-j+1) == i,:);
%             scatter(class_i(:,1), class_i(:,2));
%             hold on;
%         end;                
%         axis image ij;
%     end;
%     keyboard;
    
    
% two distinct clusters
function test1()
    mu1 = [0;0];
    mu2 = [10; 10];
    Data1 = genGaussCluster(mu1, 3, 70);
    Data2 = genGaussCluster(mu2, 2, 100);
    
    X = [Data1, Data2]';
    idxs = randperm(size(X,1)); 
    X = X(idxs, :);
    
    [IDXs, clustModel] = ml_hierKmeans(X, 2, 1, 5);
    
    clf;
    i = 1;
    class_i = X(IDXs(:,1) == i,:);
    scatter(class_i(:,1), class_i(:,2), '+r');
    i = 2;
    class_i = X(IDXs(:,1) == i,:);
    hold on; scatter(class_i(:,1), class_i(:,2), 'ob');
    axis image ij;

    keyboard;


% Generate a random Gaussian cluster
% mu: mean
% sigma: variance
% n: number of instances.
function Data = genGaussCluster(mu, sigma, n)

d = size(mu,1); % number of dimension

Data = randn(d, n);
Data = sigma*Data + repmat(mu,1, n);


