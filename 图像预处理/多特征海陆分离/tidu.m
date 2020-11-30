function tiduzhi = tidu(I)

BW=edge(I,'canny',[0.1,0.2],3);

se=strel('disk',5);
I=imdilate(BW,se);
I2=imfill(I,'holes');
tiduzhi=imerode(I2,se);

end