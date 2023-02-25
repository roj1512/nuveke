FROM nimlang/nim

COPY . /app
WORKDIR /app

RUN nimble install -Y
RUN nimble build
