import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/presentation/widgets/role_list_item_widget.dart';

class HelpRolesScreen extends ConsumerWidget {
  const HelpRolesScreen({super.key});

  Widget _roleDetails(context, role) {
    String type = role.type == 'C'
        ? "شهروند"
        : role.type == 'M'
            ? "مافیا"
            : "مستقل";
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("نقش: ${role.name}\nگروه: $type",
              style: const TextStyle(fontSize: 24.0),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceVariant,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  role.job,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    // final rNPProviderListener = ref.read(rolesNPlayersProvider.notifier);
    List mafia = [];//rNPProviderListener.mafia;
    List citizen = [];//rNPProviderListener.citizen;
    List independent = [];//rNPProviderListener.independent;

    Widget roleGridView({required List roles}) {
      return GridView.count(
        padding: const EdgeInsets.all(8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: (2.5 / 1),
        children: List.generate(
          roles.length,
          (index) => GestureDetector(
            child: RoleListItemWidget(roles[index]),
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                // enableDrag: true,
                // isScrollControlled: true,
                builder: (builder) {
                  return _roleDetails(context, roles[index]);
                },
              );
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("نقش ها"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(24),
            //   child: SizedBox(
            //     width: double.infinity,
            //     height: 55,
            //     child: FilledButton.tonal(
            //       child: const Text(
            //         "نقش های من",
            //         style: TextStyle(
            //           fontSize: 16,
            //         ),
            //       ),
            //       onPressed: () =>{}
            //           showModalBottomSheet(
            //           context: context,
            //           enableDrag: true,
            //           isScrollControlled: true,
            //           builder: (builder) => MyRoles())
            //           .then((value) => Provider.of<RolesNPlayers>(context, listen: false)
            //           .saveCustomRoles()),
            //     ),
            //   ),
            // ),
            const Text('مافیا',
                style: TextStyle(color: Colors.red, fontSize: 18)),
            roleGridView(roles: mafia),
            const Text('شهروند',
                style: TextStyle(color: Colors.green, fontSize: 18)),
            roleGridView(roles: citizen),
            const Text('مستقل',
                style: TextStyle(color: Colors.orange, fontSize: 18)),
            roleGridView(roles: independent),
          ],
        ),
      ),
    );
  }
}
