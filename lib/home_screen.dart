import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late W3MService _w3mService;
  @override
  void initState() {
    super.initState();
    initializeState();
  }

  void initializeState() async {
    _w3mService = W3MService(
      projectId: 'ed60d060cb10c9c25ef44966116464fa',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  void _signMessage() async {
    _w3mService.launchConnectedWallet();
    await _w3mService.request(
      topic: _w3mService.session?.topic ?? '',
      chainId:
          'eip155:${_w3mService.selectedChain!.chainId}', // Connected chain id
      request: SessionRequestParams(
        method: 'personal_sign',
        params: ['Sign this', _w3mService.session!.address],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              W3MConnectWalletButton(service: _w3mService),
              const SizedBox(height: 16),
              W3MNetworkSelectButton(service: _w3mService),
              const SizedBox(height: 16),
              W3MAccountButton(service: _w3mService),
              const SizedBox(height: 25),
              ElevatedButton(
                  onPressed: _signMessage, child: const Text("Sign message"))
            ],
          ),
        ),
      ),
    );
  }
}
