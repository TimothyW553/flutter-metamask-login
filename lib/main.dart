import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:metamaskxflutter/metamask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskModel()..init(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF181818),
          body: Center(
            child: Consumer<MetaMaskModel>(
              builder: (context, provider, child) {
                late final String text;

                if (provider.isConnected && provider.isInOperatingChain) {
                  text = 'Connected';
                } else if (provider.isConnected &&
                    !provider.isInOperatingChain) {
                  text =
                      'Wrong chian. Please connected to ${MetaMaskModel.operatingChain}';
                } else if (provider.isEnabled) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Click the button...',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      MaterialButton(
                        onPressed: () =>
                            context.read<MetaMaskModel>().connect(),
                        color: Colors.white,
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(
                              'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                              width: 300,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  text = 'Please use a Web3 supported browser.';
                }

                return Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
