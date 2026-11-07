import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/theme_provider.dart';

class ThemeMenu extends StatelessWidget{
  const ThemeMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return DropdownButtonFormField<ThemeMode>(

          value: themeProvider.themeMode,
          decoration: const InputDecoration(
            labelText: 'App Theme',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text('Light'),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text('Dark'),
            ),
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text('System Default'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              themeProvider.switchMode(value);
            }
          },
        );
      },
    );
  }

}