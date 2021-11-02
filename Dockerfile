FROM ubuntu:18.04

RUN apt-get update

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

RUN apt-get install nginx -y

# Set up new group
RUN addgroup --gid 1024 devgroup

# Set up new user
RUN useradd -ms /bin/bash developer

RUN usermod -a -G devgroup developer

WORKDIR /home/developer

ADD . .

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

RUN cd /home/developer/

# Run basic check to download Dark SDK
RUN flutter doctor
RUN flutter build web

EXPOSE 80
RUN cp -r ./build/web/*  /var/www/html/

CMD ["nginx","-g","daemon off;"]