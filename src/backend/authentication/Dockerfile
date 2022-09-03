FROM dart:2.17.6-sdk as builder

# Build
RUN mkdir -p /app
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get
COPY . .
RUN dart compile exe ./bin/authentication.dart -o ./bin/authentication

FROM scratch as runner
COPY --from=builder /runtime/ /
COPY --from=builder /app/bin/authentication /app/authentication
ENTRYPOINT ["/app/authentication"]
