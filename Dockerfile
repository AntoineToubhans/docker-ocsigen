FROM ubuntu:16.04
MAINTAINER Ocsigen Team <dev@ocsigen.org>
RUN apt-get -y update
RUN apt-get --no-install-recommends -y install adduser ca-certificates opam ocaml camlp4-extra wget curl sudo pkg-config git build-essential m4 unzip libpcre3-dev libssl-dev libsqlite3-dev
RUN adduser --disabled-password --gecos "" opam
RUN passwd -l opam
ADD opamsudo /etc/sudoers.d/opam
RUN chmod 440 /etc/sudoers.d/opam
RUN chown root:root /etc/sudoers.d/opam
USER opam
ENV HOME /home/opam
ENV OPAMVERBOSE 1
ENV OPAMYES 1
WORKDIR /home/opam
RUN sudo -u opam opam init -y -a
RUN sudo -u opam opam switch 4.02.3
RUN sudo -u opam opam install -y camlp4 eliom js_of_ocaml ocsigenserver
RUN sudo -u opam opam update
RUN sudo -u opam opam upgrade
ENV PATH $PATH:/home/opam/.opam/4.02.3/bin
