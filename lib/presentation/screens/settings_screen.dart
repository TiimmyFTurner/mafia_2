import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    bool limitLock = ref.watch(limitLockProvider);
    bool starRole = ref.watch(starRoleProvider);
    // bool platformDarkMode =
    //     MediaQuery.of(context).platformBrightness == Brightness.dark;
    // Widget themeNote() => platformDarkMode
    //     ? Padding(
    //         padding: EdgeInsets.only(right: 15, left: 12, bottom: 15),
    //         child: Text(
    //             "در صورت فعال بودن تم تاریک دستکاه نمیتوانید تم را تغییر دهید"))
    //     : Container();
    Widget starRoleNote() => limitLock
        ? const Padding(
            padding: EdgeInsets.only(right: 15, left: 12, bottom: 15),
            child: Text(
                "در صورت فعال بودن محدودیت نسبت نمیتوانید از نقش های ستاره دار استفاده کنید"))
        : Container();
    return Scaffold(
      appBar: AppBar(title: const Text("تنظیمات")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // const SizedBox(height: 12),
          // Card(
          //   child: SwitchListTile(
          //     title: Text("تم تاریک"),
          //     activeColor: Theme.of(context).colorScheme.secondary,
          //     value: platformDarkMode
          //         ? true
          //         : Provider.of<Settings>(context).darkMode,
          //     onChanged: platformDarkMode
          //         ? null
          //         : (value) => Provider.of<Settings>(context, listen: false)
          //             .switchDarkMode = value,
          //   ),
          // ),
          // themeNote(),
          SwitchListTile(
            title: const Text("محدودیت نسبت "),
            subtitle: const Text(
              "به طور معمول نسبت تعداد مافیا به شهروند یک به دو میباشد در صورت نیاز برای سناریو های مختلف میتوانید این محدودیت را غیر فعال کنید",
            ),
            value: limitLock,
            onChanged: (value) => ref.read(limitLockProvider.notifier).toggle(),
          ),
          SwitchListTile(
            title: const Text("نقش ستاره دار"),
            subtitle: const Text(
              'در صورت نیاز استفاده از یک نقش بیش از یک بار برای سناریو های مختلف میتوانید این ویژگی را فعال کنید',
            ),
            // activeColor: Theme.of(context).colorScheme.secondary,
            value: starRole,
            onChanged: limitLock
                ? null
                : (value) =>
                ref.read(starRoleProvider.notifier).toggle(),
          ),
          starRoleNote(),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 36),
                const Text("Mafia 2 0.0.0",
                    style: TextStyle(color: Colors.grey)),
                const Text("Copyright © 2024 Timothy F. Turner",
                    style: TextStyle(color: Colors.grey)),
                InkWell(
                  onTap: _sendMail,
                  child: const Text("TiimmyFTurner@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                ),
                InkWell(
                  onTap: _openTelegram,
                  child: const Text("T.me/TiimmyFTurner",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMail() async {
    final Uri url =
        Uri.parse('mailto:TiimmyFTurner@gmail.com?subject=MafiaApp');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _openTelegram() async {
    final Uri url = Uri.parse('https://T.me/TiimmyFTurner');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
