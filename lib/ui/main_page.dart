import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'common/scan_appbar.dart';
import 'pages/finding_scan_results_page.dart';
import 'pages/history_scan_results_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScanAppBar(),
      body: Column(
        children: [
          Expanded(child: FindScanResult()),
          Expanded(child: HistoryScanResults()),
        ],
      ),
    );
  }
}
