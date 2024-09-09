import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _nfcData = 'No NFC data yet';

  @override
  void initState() {
    super.initState();
    checkNfcAvailability();
  }

  Future<void> startNfcSession() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (!isAvailable) {
      setState(() {
        _nfcData = 'NFC not available on this device';
      });
      return;
    }

    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final tagData = tag.data;

      String formattedData = 'Unknown tag format';
      if (tagData.containsKey('nfca')) {
        final nfca = tagData['nfca'] as Map?;
        if (nfca != null) {
          final id = nfca['id'] as List?;
          if (id != null) {
            formattedData = 'NFC ID: ${id.map((e) => e.toString()).join(', ')}';
          }
        }
      }

      setState(() {
        _nfcData = formattedData;
      });

      NfcManager.instance.stopSession();
    });
  }

  Future<void> checkNfcAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    setState(() {
      _nfcData = isAvailable
          ? 'NFC is available. Tap button to scan.'
          : 'NFC not available on this device';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _nfcData,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startNfcSession,
              style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
              child: const Text('Start NFC Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
