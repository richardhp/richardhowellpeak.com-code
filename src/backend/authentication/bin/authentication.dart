import 'package:authentication/config.dart' as config;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:opentelemetry/sdk.dart' as otel_sdk;

void main() async {
  final conf = config.Config();
  final exporter =
      otel_sdk.CollectorExporter(Uri.parse('http://localhost:9090'));

  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(_echoRequest);

  var server =
      await shelf_io.serve(handler, 'localhost', int.parse(conf.HTTP_PORT));

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}

shelf.Response _echoRequest(shelf.Request request) =>
    shelf.Response.ok('Request for "${request.url}"');
