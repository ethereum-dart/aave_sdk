import 'package:aave_sdk/aave_sdk.dart';
import 'package:erc20/erc20.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

void main(List<String> args) async {
  final myAccount = 'your private key';
  final investor2 = EthPrivateKey.fromHex(myAccount);

  final network = Network.ropsten;
  // final ethClient = infuraFactory(network, infuraId);
  final ethClient = clientFactory(
    'http://127.0.0.1:8545',
    'ws://127.0.0.1:8546',
  );

  final aaveSdk = await AaveSdk.init(ethClient, network: network);
  final amountToDeposit = EtherAmount.fromUnitAndValue(EtherUnit.ether, 10);

  var daiBalance = await aaveSdk.lendingPool.aDai.underlyingAsset
      .balanceOf(await investor2.extractAddress());
  print(daiBalance.getInEther);

  final authorize = await aaveSdk.lendingPool.aDai.underlyingAsset.allowance(
      await investor2.extractAddress(), aaveSdk.lendingPoolCore.address);
  if (!authorize) {
    print('authorizing...');
    final approve = await aaveSdk.lendingPool.aDai.approve(
      investor2,
      aaveSdk.lendingPoolCore.address,
      amountToDeposit,
    );
    if (!approve.status) {
      print('failed to approve');
      return;
    }
  } else {
    print('authorized to use the smart contract');
  }

  final receipt = await aaveSdk.lendingPool.deposit(
    investor2,
    aaveSdk.lendingPool.aDai.underlyingAsset.address,
    amountToDeposit,
  );
  if (!receipt.status) {
    print('transaction ${bytesToHex(receipt.transactionHash)} failed');
    return;
  }

  daiBalance = await aaveSdk.lendingPool.aDai.underlyingAsset
      .balanceOf(await investor2.extractAddress());
  var aDaiBalance = await aaveSdk.lendingPool.aDai
      .balanceOf(await investor2.extractAddress());
  print('${daiBalance.getInEther} ${aDaiBalance.getInEther}');
}
