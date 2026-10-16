FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends gcc make jq bash diffutils libc6-dev && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN make check

CMD ["./build/wordcount"]
