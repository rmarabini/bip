import xmipp
img = xmipp.Image()
img.setDataType(xmipp.DT_FLOAT)
img.resize(1024, 1024)
for i in xrange(1,1024,64):
  for j in xrange(1,1024,64):
    img.setPixel(i, j, 1)

#img.initRandom(0., 1., xmipp.XMIPP_RND_UNIFORM)
img.write("kk.tif")

