import 'package:erc20/erc20.dart';
import 'package:http/io_client.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

Web3Client Function() clientFactory(String httpUrl, String wsUrl) => () {
      var httpClient = IOClient();
      return Web3Client(
        httpUrl,
        httpClient,
        socketConnector: () => IOWebSocketChannel.connect(
          wsUrl,
        ).cast<String>(),
      );
    };

Web3Client Function() infuraFactory(Network network, String id) {
  final sNetwork = network.toString().split('.').last;
  return clientFactory(
    'https://$sNetwork.infura.io/v3/$id',
    'wss://$sNetwork.infura.io/ws/v3/$id',
  );
}
