
NAME = '000012.jpg';
LABEL     = "Labels/label_" + NAME + ".mat";
LABEL_NUM = "Labels/label_number_" + NAME + ".mat";
PATH_IMG = "Data/" + NAME;
load(LABEL);
load(LABEL_NUM);
I_ORG = imread(PATH_IMG{1});
I = im2double(I_ORG);
testRes = getLabelGraph(labels, numlabels);
labels = labels + 1;

    



% 
% Iclone = I;
% [rC,cC, ~] = size(I);
% 
% for r=1:rC
%     for c=1:cC
%         tmp = result{labels(r,c)+1};
%         Iclone(r,c,1) = tmp(1,1) / 256;
%         Iclone(r,c,2) = tmp(1,2) / 256;
%         Iclone(r,c,3) = tmp(1,3) / 256;
%     end
% end





resultSet = mergeAll(I,labels,numlabels);






%imshow(Iclone);
%figure; plot(testRes,'NodeLabel', testRes.Nodes.Name);
 


