import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:BotPal/hive/boxes.dart';
import 'package:BotPal/hive/settings.dart';
import 'package:BotPal/provider/settings_provider.dart';
import 'package:BotPal/widgets/settings_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  // get user settings data
  void getUserSettings() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // get settings from box
      final settingsBox = Boxes.getSettings();

      // check if settings data is not empty
      if (settingsBox.isNotEmpty) {
        // Optionally handle retrieved settings here
      }
    });
  }

  @override
  void initState() {
    getUserSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),

                // Theme settings tile
                ValueListenableBuilder<Box<Settings>>(
                    valueListenable: Boxes.getSettings().listenable(),
                    builder: (context, box, child) {
                      if (box.isEmpty) {
                        return SettingsTile(
                            icon: Icons.light_mode,
                            title: 'Theme',
                            value: false,
                            onChanged: (value) {
                              final settingProvider =
                              context.read<SettingsProvider>();
                              settingProvider.toggleDarkMode(
                                value: value,
                              );
                            });
                      } else {
                        final settings = box.getAt(0)!;
                        return SettingsTile(
                            icon: settings.isDarkTheme
                                ? Icons.dark_mode
                                : Icons.light_mode,
                            title: 'Theme',
                            value: settings.isDarkTheme,
                            onChanged: (value) {
                              final settingProvider =
                              context.read<SettingsProvider>();
                              settingProvider.toggleDarkMode(
                                value: value,
                              );
                            });
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
