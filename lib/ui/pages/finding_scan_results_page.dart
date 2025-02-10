import 'package:bluetooth_radar_demo/common/di.dart';
import 'package:flutter/widgets.dart';

import '../../managers/bluetooth_scanner_manager.dart';

class FindScanResult extends StatelessWidget {
  const FindScanResult({super.key});

  @override
  Widget build(BuildContext context) {
    var findManager = Locator.instance.findManager;
    return StreamBuilder<List<DeviceResult>>(
      stream: findManager.results.stream,
      builder: (ctx, snapshot) {
        final data = snapshot.data;
        if (data == null) return Text('Finding');

        return ListView(
          children: [
            Text('Try find: ${findManager.remotedIds}'),
            ...data.map(
              (it) => Text(it.toString()),
            ),
          ],
        );
      },
    );
  }
}
