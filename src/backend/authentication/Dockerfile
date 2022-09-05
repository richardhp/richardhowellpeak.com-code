FROM dart:2.17.6-sdk as builder

# Build
RUN mkdir -p /app
WORKDIR /app
COPY ./authentication/pubspec.* ./

# Awful, awful to have to do this
COPY ./opentelemetry-dart /app
RUN ls 
RUN dart pub get
COPY . .
RUN dart compile exe ./authentication/bin/authentication.dart -o ./authentication/bin/authentication

FROM scratch as runner
COPY --from=builder /runtime/ /
COPY --from=builder /app/bin/authentication /app/authentication
ENTRYPOINT ["/app/authentication"]
