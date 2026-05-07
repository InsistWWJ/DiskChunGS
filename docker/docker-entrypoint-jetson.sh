#!/bin/bash
set -e

echo "Loading environment variables..."

# OpenCV
export OPENCV_PATH=/workspace/third_party/opencv
export OpenCV_DIR=/workspace/third_party/install/opencv/lib/cmake/opencv4
export LD_LIBRARY_PATH=/workspace/third_party/install/opencv/lib:$LD_LIBRARY_PATH

# libtorch (if present)
if [ -d "/workspace/third_party/libtorch" ]; then
    export LD_LIBRARY_PATH=/workspace/third_party/libtorch/lib:$LD_LIBRARY_PATH
fi

echo "Environment setup complete!"

cd /workspace/repo

# Download mono model only if it doesn't exist
MODEL_PATH="/workspace/repo/models/depth_anything_v2_vitl.onnx"
if [ ! -f "$MODEL_PATH" ]; then
    echo "Downloading mono model..."
    wget -P /workspace/repo/models https://huggingface.co/yuvraj108c/Depth-Anything-2-Onnx/resolve/main/depth_anything_v2_vitl.onnx || \
        echo "WARNING: Failed to download model. Please download it manually to $MODEL_PATH"
else
    echo "Mono model already exists, skipping download."
fi

echo "==============================================="
echo "3DGS SLAM Docker Environment (Jetson)"
echo "==============================================="
echo "- OpenCV is built and installed"
echo "- PyTorch (L4T) is ready to use"
echo "- Environment variables are set"
echo ""
echo "Code is available at /workspace/repo"
echo "Build DiskChunGS with ./scripts/build.sh"
echo "==============================================="

exec "$@"
