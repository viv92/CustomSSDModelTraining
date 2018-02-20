#!/bin/sh
../../caffe-ssd/build/tools/caffe train -solver="../../workspace/jobs/MobileNet/VOC2007/SSD_300x300/solver_train.prototxt" \
-weights="../../workspace/models/MobileNet/mobilenet_iter_73000.caffemodel" \
-gpu 0
