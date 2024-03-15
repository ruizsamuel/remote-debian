FROM consol/debian-xfce-vnc:nightly

USER 0

# VS CODE
RUN apt-get clean
RUN apt-get update
RUN apt-get install dirmngr ca-certificates software-properties-common apt-transport-https curl wget -y
RUN curl -fSsL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /usr/share/keyrings/vscode.gpg >/dev/null
RUN echo deb [signed-by=/usr/share/keyrings/vscode.gpg] https://packages.microsoft.com/repos/vscode stable main | tee /etc/apt/sources.list.d/vscode.list
RUN apt-get update && apt-get install -y code

ENV DONT_PROMPT_WSL_INSTALL="YES"
RUN echo "alias code='code -no-sandbox'" >> $STARTUPDIR/generate_container_user

# IDEA
COPY scripts/install_idea.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/install_idea.sh
RUN /usr/local/bin/install_idea.sh

# GENERAL TOOLS
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y \
    git \
    python3 \
    openjdk-11-jdk \
    gcc \
    make \
    nodejs \
    npm \
    nano \
    cifs-utils

# GRADLE
RUN apt-get install -y gradle

# PYTHON VENV
RUN apt-get clean
RUN apt-get install -y python3-venv

# NVM AND NODE.JS
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN export NVM_DIR="$HOME/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
    nvm install node && \
    nvm use node


USER 1000