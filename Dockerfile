FROM openjdk:8-jdk

WORKDIR /

SHELL ["/bin/bash", "-c"]

RUN apt update && apt install -y tar unzip libglu1 libpulse-dev libasound2 libc6  libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxi6  libxtst6 libnss3 wget

ARG GRADLE_VERSION=5.4.1
ARG ANDROID_API_LEVEL=28
ARG ANDROID_BUILD_TOOLS_LEVEL=28.0.3
ARG EMULATOR_NAME='test'

RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
&& unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip \
&& mkdir /opt/gradlew \
&& /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper --gradle-version ${GRADLE_VERSION} --distribution-type all -p /opt/gradlew  \
&& /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper -p /opt/gradlew

ADD start.sh /

RUN chmod +x start.sh