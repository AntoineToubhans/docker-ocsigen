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
ENV PATH $PATH:/home/opam/.opam/4.02.3/bin
ENV OCAML_TOPLEVEL_PATH /home/opam/.opam/4.02.3/lib/toplevel
ENV PERL5LIB /home/opam/.opam/4.02.3/lib/perl5:$PERL5LIB
ENV MANPATH $MANPATH:/home/opam/.opam/4.02.3/man
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.02.3/lib/stublibs
RUN sudo -u opam opam depext dbm.1.0
RUN sudo -u opam opam install -y camlp4 dbm eliom js_of_ocaml ocsigenserver
RUN sudo -u opam opam update
RUN sudo -u opam opam upgrade
