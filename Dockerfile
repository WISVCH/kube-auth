FROM wisvch/alpine-java:8_server-jre_unlimited
ADD build/libs/kube-auth.jar /srv/kube-auth.jar
WORKDIR /srv
CMD "/srv/kube-auth.jar"
