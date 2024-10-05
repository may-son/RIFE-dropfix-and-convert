FROM python:3.10-slim

# Install extra requeriments (I had to install this on my Practical-RIFE Docker)
RUN apt update -y && apt install -y git bash ffmpeg libsm6 libxext6 libxrender-dev

# Create workdir & Create input/output folder
RUN mkdir -p /fixdropframes && mkdir -p /input

# Set workdir
WORKDIR /fixdropframes

# Copy files
COPY . /fixdropframes

# Install requeriments
RUN pip install torch==2.3.0 torchvision==0.18.0 --index-url https://download.pytorch.org/whl/cu121
RUN pip install numpy==1.23.5 tqdm==4.66.5 opencv-python==4.10.0.84 colorama==0.4.6 rawpy==0.21.0

# Clean up all cached files
RUN pip cache purge && apt clean autoclean -y && apt autoremove -y && rm -rf /var/lib/{apt,dpkg,cache,log}/

# Set entry point
ENTRYPOINT ["python"]
