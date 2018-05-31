%plot framework. This line help to center the plots
limit = 7;
plotX = [-limit, -limit,  limit, limit];
plotY = [-limit,  limit, -limit, limit];
%clear plot window
clf;
plot(plotX, plotY,'*');
%From here append plots instead of replace them
hold on

%specimen sampling 4x4 grid 
[specimenX,specimenY] = meshgrid(-1.5:1.5,-1.5:1.5);
%plot * at "voxel" center
plot(specimenX, specimenY,'*','MarkerSize',30,'MarkerEdgeColor','g','MarkerFaceColor','g')
pause()
%define detector (2 prallel planes)
distanceDectOrigin  = 4;
numberDetectors     = 4;
originDetectorArray = 1.5;
originDetectorArrayEdge = originDetectorArray + .5;
horzLine = 0.2;

%detector segments
%left detectors
detectSegLY1 = linspace(-originDetectorArrayEdge,originDetectorArrayEdge,numberDetectors+1);
detectSegLX1 = linspace(-distanceDectOrigin,-distanceDectOrigin,numberDetectors+1);
%right detectors
detectSegRY1 = linspace(-originDetectorArrayEdge,originDetectorArrayEdge,numberDetectors+1);
detectSegRX1 = linspace(distanceDectOrigin,distanceDectOrigin,numberDetectors+1);

%plot red lines (detector)
for i = 1:numberDetectors
    plot([detectSegLX1(i),detectSegLX1(i+1)],[detectSegLY1(i),detectSegLY1(i+1)],'r');
    plot([detectSegRX1(i),detectSegRX1(i+1)],[detectSegRY1(i),detectSegRY1(i+1)],'r');
end
%plot detector separators (cyan)
for i = 1:numberDetectors+1
    plot([detectSegLX1(i)-horzLine,detectSegLX1(i)+horzLine], [detectSegLY1(i),detectSegLY1(i)],'c')  ;  
    plot([detectSegRX1(i)-horzLine,detectSegRX1(i)+horzLine], [detectSegRY1(i),detectSegRY1(i)],'c')  ;  
end
pause()

%matrix with LOR (lines of response)
numberOfLors = numberDetectors * numberDetectors;
lors = zeros (numberOfLors,8);%(x1,y1,x2,y2);
counter = 1;
for i1 = 1:numberDetectors
    for i2 = 1:numberDetectors
        lors(counter,:)=[detectSegLX1(i1) detectSegLY1(i1) ...
                         detectSegLX1(i1+1) detectSegLY1(i1+1) ...
                         detectSegRX1(i2) detectSegRY1(i2) ...
                         detectSegRX1(i2+1) detectSegRY1(i2+1)];
        counter = counter +1;
    end;
end
%%print lors (debuging)
for i = 1:numberOfLors
    plot([lors(i,1),lors(i,5)],[lors(i,2)+0.5,lors(i,6)+.5],'b');
end
pause()

%number of counts: positron creation
numEmissions= 1000;
%emisions at voxels with index (0,0) lower, left voxel
x = randi([0,3],numEmissions,1) ;
y = randi([0,3],numEmissions,1) ;
%direction emissions
angles = rand(numEmissions,1) * (2. * pi);
%LOR 
distance = 6;
x1p = x  + cos(angles)*distance - originDetectorArray ;
y1p = y  + sin(angles)*distance - originDetectorArray ;
x2p = x  - cos(angles)*distance - originDetectorArray ;
y2p = y  - sin(angles)*distance - originDetectorArray ;

%%plot lines
%%%for i = 1:numEmissions
for i = 1:10
    plot([x1p(i,1),x2p(i,1)],[y1p(i,1),y2p(i,1)],'y');
end
pause()
%intersection line and detector
systemMatrix = zeros (numberOfLors,16)%original specimen element in x and y?

for i1 = 1:numEmissions
    for i2 = 1:numberOfLors
        results1 = lineSegmentIntersect([x1p(i1,1),y1p(i1,1),x2p(i1,1),y2p(i1,1)],...%emision
                             [lors(i2,1),lors(i2,2),lors(i2,3),lors(i2,4),]); %detector
        results2 = lineSegmentIntersect([x1p(i1,1),y1p(i1,1),x2p(i1,1),y2p(i1,1)],...%emision
                             [lors(i2,5),lors(i2,6),lors(i2,7),lors(i2,8),]); %detector
        if results1.intAdjacencyMatrix(1) & results2.intAdjacencyMatrix(1)
          if x(i1)==0 & y(i1)==0
              plot([x1p(i1,1),x2p(i1,1)],[y1p(i1,1),y2p(i1,1)],'b')
          end
          if x(i1)==2 & y(i1)==2
              plot([x1p(i1,1),x2p(i1,1)],[y1p(i1,1),y2p(i1,1)],'r')
          end
          systemMatrix(i2,int32(1+x(i1)+y(i1)*4)) = systemMatrix(i2,int32(1+x(i1)+y(i1)*4)) + 1;
        end
    end
    if(mod(i1,100)==0 )
        i1
    end
end
%NOTE: systemMatrix is close but not exactly what is termed system matrix in the assignment 