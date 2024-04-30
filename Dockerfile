# Use the official Google Cloud SDK image as base
FROM google/cloud-sdk:latest

# Set bash as the default shell
SHELL ["/bin/bash", "-c"]

# Set environment variables for non-interactive mode
ENV CLOUDSDK_CORE_DISABLE_PROMPTS 1

# Install required packages
RUN apt-get update \
    && apt-get install -y \
        sudo \
        wget \
        gpg  \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user 'gcptfuser'
RUN useradd -ms /bin/bash gcptfuser

# Add 'gcptfuser' to the sudoers group
RUN usermod -aG sudo gcptfuser
RUN echo "gcptfuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/gcptfuser

# Set the user to 'gcptfuser'
USER gcptfuser

# Set the working directory to the user's home directory
WORKDIR /home/gcptfuser

# Install terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
    sudo apt update && \
    sudo apt install -y terraform

# Run gcloud commands
CMD ["/bin/bash"]
