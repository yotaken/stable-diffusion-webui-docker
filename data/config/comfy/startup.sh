#!/bin/bash
BASE_DIR="/data/config/comfy/custom_nodes"

# Verifica si tenemos instaladas algunas librerías necesarias para modulos
if ! dpkg -s libgl1 libglib2.0-0 >/dev/null 2>&1; then
    echo "Instalando dependencias adicionales de CogVideoWrapper..."
    apt update && apt install -y libgl1 libglib2.0-0 && apt-get clean
    rm -R "$BASE_DIR/ComfyUI-CogVideoXWrapper"
    rm -R "$BASE_DIR/ComfyUI-Manager"
    mkdir -vp "/data/models/diffusion_models"
    mkdir -vp "/data/models/text_encoders"
    mkdir -vp "/data/models/diffusers"
    {
      echo "  diffusion_models: /data/models/diffusion_models"
      echo "  text_encoders: /data/models/text_encoders"
      echo "  diffusers: /data/models/diffusers"
    } >> /stable-diffusion/extra_model_paths.yaml

else
    echo "Las dependencias del sistema ya están instaladas. Omitiendo instalación."
fi

# Instalar CogVideoWrapper si no existe
if [ ! -d "$BASE_DIR/ComfyUI-CogVideoXWrapper" ]; then
    echo "Clonando ComfyUI-CogVideoXWrapper..."
    git clone https://github.com/kijai/ComfyUI-CogVideoXWrapper.git "$BASE_DIR/ComfyUI-CogVideoXWrapper"

    echo "Instalando dependencias de ComfyUI-CogVideoXWrapper..."
    pip install -r "$BASE_DIR/ComfyUI-CogVideoXWrapper/requirements.txt"
else
    echo "ComfyUI-CogVideoXWrapper ya está instalado. Omitiendo clonación e instalación."
fi

# Instalar ComfyUI Manager si no existe
if [ ! -d "$BASE_DIR/ComfyUI-Manager" ]; then
    echo "Clonando ComfyUI-Manager..."
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git "$BASE_DIR/ComfyUI-Manager"

    echo "Instalando dependencias de ComfyUI-Manager..."
    pip install -r "$BASE_DIR/ComfyUI-Manager/requirements.txt"
else
    echo "ComfyUI-Manager ya está instalado. Omitiendo clonación e instalación."
fi

pip install piexif deepdiff evalidate tables pynvml imageio_ffmpeg matplotlib scikit-image gguf pymunk librosa pygame mido pyhocon
