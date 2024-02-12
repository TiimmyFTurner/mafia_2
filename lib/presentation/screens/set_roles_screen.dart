import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/presentation/widgets/my_roles_widget.dart';
import 'package:mafia_2/presentation/widgets/role_list_item_widget.dart';
import 'package:mafia_2/presentation/widgets/selected_roles_bottom_sheet.dart';

class SetRolesScreen extends ConsumerWidget {
  const SetRolesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List mafia = ref.watch(mafiasProvider);
    List citizen = ref.watch(citizensProvider);
    List independent = ref.watch(independentsProvider);

    Widget roleGridView(
        {required int flex, required List roles, required String setter}) {
      return Expanded(
        flex: flex,
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: (2.6 / 1),
          children: List.generate(
            roles.length,
            (index) => index < roles.length
                ? InkWell(
                    borderRadius: BorderRadius.circular(15),
                    radius: 200,
                    child: RoleListItemWidget(roles[index]),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      ref
                          .read(selectedRolesProvider.notifier)
                          .addRole(roles[index]);
                    },
                    onLongPress: () => showRoleJob(context, roles[index]),
                  )
                : Container(),
          ),
        ),
      );
    }

    Widget buildBody() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            const Text('مافیا',
                style: TextStyle(color: Colors.red, fontSize: 18)),
            roleGridView(flex: 4, roles: mafia, setter: "add"),
            const Text('شهروند',
                style: TextStyle(color: Colors.green, fontSize: 18)),
            roleGridView(flex: 5, roles: citizen, setter: "add"),
            const Text('مستقل',
                style: TextStyle(color: Colors.orange, fontSize: 18)),
            roleGridView(flex: 3, roles: independent, setter: "add"),
            const SizedBox(height: 95)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(context, ref),
      body: Stack(
        children: <Widget>[
          SafeArea(child: buildBody()),
          const SelectedRolesBottomSheet(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(context, ref) => AppBar(
        title: Text("انتخاب نقش ها (${ref.watch(playerNamesProvider).length})"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("راهنما"),
                    content: const Text(
                      "برای مشاهده وظیفه هر نقش آن را نگه دارید، برای دیدن یا حذف نقش های انتخاب شده قسمت 'نقش های انتخاب شده' را به سمت بالا بکشید \n\nبرای بازگردانی نقش های بازی قبل از منوی بالا سمت راست گذینه بازگردانی را انتخاب کنید\n\nبرای اضافه کردن نقش های شخصی سازی شده از منوی بالا سمت راست گذینه نقش های من را انتخاب کرده نقش های خود را اضافه و مدیریت کنید\n\nاستفاده از نقش های ستاره دار یا غیر فعال کردن محدودیت نسبت را میتوانید از قسمت تنظیمات مدیریت کنید",
                    ),
                    actions: [
                      TextButton(
                        child: const Text("بازگشت"),
                        onPressed: () => context.pop(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          _popupMenuButton(context,ref),
        ],
      );

  showRoleJob(_, role) {
    return showDialog(
      context: _,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            role.name,
          ),
          content: SingleChildScrollView(
            child: Text(
              role.job,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("فهمیدم"),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }

  _popupMenuButton(context,ref) {
    return PopupMenuButton<int>(
      onSelected: (value) => _menuOnSelected(value, context,ref),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              Icon(Icons.replay),
              SizedBox(width: 8),
              Text("باز گردانی نقش ها"),
            ],
          ),
        ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.list_alt),
              SizedBox(width: 8),
              Text("نقش های من"),
            ],
          ),
        ),
      ],
    );
  }

_menuOnSelected(int value, BuildContext context,ref) {
  switch (value) {
    case 1:
      ref.read(selectedRolesProvider.notifier).recoverLastRoles();
      break;
    case 2:
      showModalBottomSheet(
        useSafeArea: true,
          showDragHandle: true,
          context: context,
          isScrollControlled: true,
          builder: (builder) => const MyRoles());
      break;
  }
}
}
