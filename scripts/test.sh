#!/bin/sh
#latest=snapshot/mobilenet_iter_73000.caffemodel
latest=$(ls -t ../../workspace/jobs/MobileNet/VOC2007/SSD_300x300/snapshot/*.caffemodel | head -n 1)
if test -z $latest; then
	exit 1
fi
../../caffe-ssd/build/tools/caffe train -solver="../../workspace/jobs/MobileNet/VOC2007/SSD_300x300/solver_test.prototxt" \
--weights=$latest \
-gpu 0
