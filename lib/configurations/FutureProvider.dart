import 'dart:convert';
import 'package:flutter/material.dart ';

import 'package:fcx_app/configurations/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

class FutureCertX extends ChangeNotifier{

 Web3Client? _web3client;
  ContractAbi? _abiCode;
  EthereumAddress? _contractAddress;
  DeployedContract? _deployedContract;
  ContractFunction? _getMyFutureCertsURIs;
  ContractFunction? _getMyFutureCertsCount;
  ContractFunction? _getMyFutureCertsIDs;
  ContractFunction? _redeemFutureCert;
  ContractFunction? _safeMintFutureCert;
  final EthPrivateKey _creds = EthPrivateKey.fromHex(myPrivateKey);
   double get balanxe => _EthBalance;
  double _EthBalance = 0.0;
  List<dynamic> _myCertIds = [];
  List<dynamic> _myCertURIs = [];
 int myCertXCount = 0;
 String metadataURI = "cid/${tokenId}.json";
 
  static get tokenId => null;
  


 Future<void> init() async {
    _web3client = await Web3Client(RPCurl, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(webSockeUrl).cast<String>();
    });
    await getABI();
    await getDeployedContract();
  }






  Future<void> getABI() async {
    final String abiFile = await rootBundle.loadString('assets/json/abi.json');
    final jsonABI = await json.decode(abiFile);
   _abiCode = ContractAbi.fromJson(
        json.encode(jsonABI['abi']), json.encode(jsonABI['contractName']));
    _contractAddress = EthereumAddress.fromHex(contractAddress);
  }

  Future<void> getDeployedContract() async{
_deployedContract = DeployedContract(_abiCode!, _contractAddress!);
_getMyFutureCertsCount = _deployedContract!.function("getTokenCount");
_getMyFutureCertsIDs = _deployedContract!.function("getOwnedTokens");
_redeemFutureCert= _deployedContract!.function("payToMint");
_getMyFutureCertsURIs = _deployedContract!.function("tokensURIsOfOwner");
_safeMintFutureCert = _deployedContract!.function("safeMint");

}


Future<void> getEthBalance () async{
 await init();
 EtherAmount balance =  await _web3client!.getBalance(EthereumAddress.fromHex(myAddress));
 _EthBalance = balance.getValueInUnit(EtherUnit.ether);
 print(_EthBalance);
 notifyListeners();

}
Future<void> getCertCount ()async{
await init();
var response = await _web3client!.call(
sender: EthereumAddress.fromHex(myAddress),
contract:_deployedContract!,
function:_getMyFutureCertsCount!,
params:[
 EthereumAddress.fromHex(myAddress)

]);

var certCount = response[0] as BigInt;
    // Convert BigInt to int
    print(response);
     myCertXCount = certCount.toInt();
 
}


Future<void> payToMint()async{

  await init();
  await getEthBalance();
  var response = await _web3client!.sendTransaction(
    _creds,
    chainId: 11155111,
    Transaction.callContract(
     value: EtherAmount.fromBigInt(EtherUnit.wei, BigInt.from(0.0001)),      
      contract: _deployedContract!,
       function: _redeemFutureCert!, 
       from: EthereumAddress.fromHex(myAddress),
       parameters: [
          EthereumAddress.fromHex(myAddress),
          metadataURI,
  ],
 
  ));//value: EtherAmount.fromBigInt(EtherUnit.ether, )));
  notifyListeners();
}
  Future<void> getMyCertsURIs ()async{
    EthereumAddress address = EthereumAddress.fromHex(myAddress);
    await init();
    try{
List myCertsURIs = await _web3client!.call(
  contract: _deployedContract!,
  sender: EthereumAddress.fromHex(myAddress),
 function: _getMyFutureCertsURIs!,
  params: [
  address
  ]);
  print(myCertsURIs);
    }
  catch(error,trace){
    print(error.toString());
    print(trace.toString());
  }

  

//print(myCertsURIs.toString());
notifyListeners();
  }
  
}

