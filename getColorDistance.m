function colortextureDistance= getColorDistance(image, labels, gradient, label1 , label2)
    [row1,col1] = find(labels == label1);
    [row2,col2] = find(labels == label2);
    edges = 0:1/20:1;
    
   
    rc1 = cat(2, row1,col1);

    rc2 = cat(2, row2,col2);
    
    
    ir1 = zeros(size(rc1,1) ,1);
    ig1 = zeros(size(rc1,1) ,1);
    ib1 = zeros(size(rc1,1), 1);
    
    ir2 = zeros(size(rc2,1) , 1);
    ig2 = zeros(size(rc2,1) , 1);
    ib2 = zeros(size(rc2,1) , 1);
    
    
    for i = 1:size(rc1,1)
        ir1(i,1) = image(rc1(i,1),rc1(i,2) ,1);
        ig1(i,1) = image(rc1(i,1),rc1(i,2) ,2);
        ib1(i,1) = image(rc1(i,1),rc1(i,2) ,3);
    end
    
    for j = 1:size(rc2,1)
        ir2(j,1) = image(rc2(j,1),rc2(j,2) ,1);
        ig2(j,1) = image(rc2(j,1),rc2(j,2) ,2);
        ib2(j,1) = image(rc2(j,1),rc2(j,2) ,3);
    end
    
    
    
    
    r1 = histcounts(ir1,edges);
    r1= r1 / sum(r1);
    g1 = histcounts(ig1,edges);
    g1= g1 / sum(g1);
    b1 = histcounts(ib1,edges);
    b1= b1 / sum(b1);
    r2 = histcounts(ir2,edges);
    r2 = r2 / sum(r2);
    g2 = histcounts(ig2,edges);
    g2 = g2 / sum(g2);
    b2 = histcounts(ib2,edges);
    b2 = b2 / sum(b2);
    
    rgb1 = cat(1, r1 , g1 , b1);
    rgb2 = cat(1, r2 , g2 , b2);

    distanceColor = norm(rgb1 - rgb2,1);
    
    
    
    irfx = gradient{1,1};
    irfy = gradient{2,1};
    
    igfx = gradient{1,2};
    igfy = gradient{2,2};
    
    ibfx = gradient{1,3};
    ibfy = gradient{2,3};
    
    %%%%%%%%
    
    
    
    
    orientations = cell(3,8);
    i = 1;
    for angle = 0:45:315
        orientations{1,i} = cos(angle*(pi/180))*irfx+sin(angle*(pi/180))*irfy;
        orientations{2,i} = cos(angle*(pi/180))*igfx+sin(angle*(pi/180))*igfy;
        orientations{3,i} = cos(angle*(pi/180))*ibfx+sin(angle*(pi/180))*ibfy;
        i = i + 1;
    end


    edges = -25:5:25;
    
    for o = 1:8
        for color = 1:3
            oHist1{color, o} = histcounts(orientations{1,o}(labels == label1),edges);
            oHist1{color,o} = oHist1{color, o} / sum(oHist1{color, o});
            oHist2{color, o} = histcounts(orientations{1,o}(labels == label2),edges);
            oHist2{color,o} = oHist2{color, o} / sum(oHist2{color, o});
        end
    end

   
    
    hist1 = zeros(24,10);
    hist2 = zeros(24,10);
    
    
    for i = 1:8
        for j = 1:3
            for k = 1:10
                hist1((i-1) * 3 + j ,k) = oHist1{j,i}(1,k);
                hist2((i-1) * 3 + j ,k) = oHist2{j,i}(1,k);
            end
        end
    end

  
    
    distanceTexture = norm((hist1 - hist2),1);
    colortextureDistance = distanceColor + distanceTexture;
end

