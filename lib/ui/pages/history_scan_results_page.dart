import 'package:bluetooth_radar_demo/common/di.dart';
import 'package:flutter/widgets.dart';

import '../../managers/bluetooth_scanner_manager.dart';
import '../common/pulse_text.dart';

class HistoryScanResults extends StatelessWidget {
  const HistoryScanResults({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<Id, DeviceResult>>(
      stream: Locator.instance.historyManager.results.stream,
      builder: (ctx, snapshot) {
        final data = snapshot.data;
        if (data == null) return Text('Finding');

        return ListView(
          children: [
            ...data.values.map(
                  (it) => PulsatingTextWidget(
                it.toString(),
                key: ValueKey(it.remoteId),
              ),
            ),
          ],
        );
      },
    );
  }
}
