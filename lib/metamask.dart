import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskModel extends ChangeNotifier {
  static const operatingChain = 4; // which chain (rinkeby test network)
  String currentAddress = '';
  int currentChain = -1;

  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  Future<void> connect() async {
    // connecting to wallet
    if (isEnabled) {
      final account = await ethereum!.requestAccount();
      if (account.isNotEmpty) currentAddress = account.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
  }

  init() {
    // initialize the listeners
    if (isEnabled) {
      // when account changes
      ethereum!.onAccountsChanged((accounts) {
        clear(); // make them sign in again (clear)
      });
      // same when chain changes
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
