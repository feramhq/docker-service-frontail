FROM node:8.5

RUN curl -fsSL get.docker.com -o get-docker.sh
# Print contents so you can manually verify the used script after the build
RUN cat get-docker.sh
RUN sh get-docker.sh

# Install GNU parallel
RUN \
  curl http://ftp.gnu.org/gnu/parallel/parallel-20170922.tar.bz2 >parallel.tar.bz2 && \
  tar -xjf parallel.tar.bz2 && \
  cd parallel* && \
  ./configure && \
  make && \
  make install

RUN yarn global add frontail bunyan

EXPOSE 9001

CMD \
  docker service ls -q \
  | parallel --jobs 0 --linebuffer docker service logs -f 2>&1 \
  | bunyan --color \
  | frontail -
