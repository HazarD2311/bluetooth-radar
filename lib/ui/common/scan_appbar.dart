import 'package:flutter/material.dart';

import '../../common/di.dart';

class ScanAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ScanAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _IsScanBuilder(
        scanning: Text('Scanning...'),
        nonScanning: Text('Bluetooth Scanned Demo'),
      ),
      actions: [
        _IsScanBuilder(
          scanning: CircularProgressIndicator(),
          nonScanning: SizedBox(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _IsScanBuilder extends StatelessWidget {
  final Widget scanning;
  final Widget nonScanning;

  const _IsScanBuilder({
    required this.scanning,
    required this.nonScanning,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Locator.instance.btScanner.isScanning,
      builder: (context, snapshot) => (snapshot.data ?? false) ? scanning : nonScanning,
    );
  }
}
