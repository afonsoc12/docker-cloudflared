# From https://github.com/cloudflare/cloudflared/commits/master/Dockerfile
# Revision d54c8cc74544927dab45823681185615b4489363

FROM --platform=$BUILDPLATFORM golang:1.18 AS build-env
ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    TARGET_OS=${TARGETOS} \
    TARGET_ARCH=${TARGETARCH}

WORKDIR /go/src/github.com/cloudflare/cloudflared/

# copy our sources into the builder image
COPY . .

# compile cloudflared
RUN echo "Running on $BUILDPLATFORM, building for $TARGETPLATFORM: TARGET_OS=$TARGET_OS; TARGET_ARCH=$TARGET_ARCH" && \
    make cloudflared

# use a distroless base image with glibc
FROM gcr.io/distroless/base-debian10:nonroot

# copy our compiled binary
COPY --from=build-env --chown=nonroot /go/src/github.com/cloudflare/cloudflared/cloudflared /usr/local/bin/

# run as non-privileged user
USER nonroot

# command / entrypoint of container
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
