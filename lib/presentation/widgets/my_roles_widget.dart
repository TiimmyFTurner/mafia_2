import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/applications/state_management/player_and_roles_provider.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';
import 'package:mafia_2/presentation/widgets/role_list_item_widget.dart';

class MyRoles extends ConsumerStatefulWidget {
  const MyRoles({super.key});

  @override
  MyRolesState createState() => MyRolesState();
}

class MyRolesState extends ConsumerState<MyRoles> {
  final _nameController = TextEditingController();
  final _jobController = TextEditingController();

  final Map<String, dynamic> _roleTypeFormData = {'type': null, 'order': null};
  final GlobalKey<FormState> _addRoleFormKey = GlobalKey<FormState>();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    List statusIcon = [
      IconButton(
          key: const ValueKey(1),
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              status = !status;
            });
          }),
      IconButton(
        key: const ValueKey(2),
        icon: const Icon(Icons.list),
        onPressed: () {
          setState(() {
            status = !status;
          });
        },
      ),
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.13,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text("نقش های من", style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: statusIcon[status ? 1 : 0],
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                ),
              ),
            ],
          ),
          _body()
        ],
      ),
    );
  }

  Widget _body() {
    if (status) {
      return Form(
        key: _addRoleFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        onSaved: (val) {
                          _nameController.clear();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'نام نقش نمیتواند خالی باشد';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'نام نقش', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: DropdownButtonFormField(
                        validator: (value) =>
                            value == null ? 'نوع نقش را انتخاب کنید' : null,
                        items: [
                          {'name': 'مافیا', 'value': 'M'},
                          {'name': 'شهروند', 'value': 'C'},
                          {'name': 'مستقل', 'value': 'I'}
                        ].map(
                          (item) {
                            return DropdownMenuItem(
                              value: item['value'],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    item['name']!,
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          _roleTypeFormData['type'] = value;
                          _roleTypeFormData['order'] = value == 'M'
                              ? 15
                              : value == 'C'
                                  ? 43
                                  : 59;
                        },
                        decoration: const InputDecoration(
                          labelText: 'نوع نقش',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _jobController,
                  onSaved: (val) {
                    _jobController.clear();
                  },
                  maxLines: 4,
                  validator: (value) => value == null || value.isEmpty
                      ? 'وظیفه نقش نمیتواند خالی باشد'
                      : null,
                  decoration: const InputDecoration(
                      labelText: 'وظیفه', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 65,
                  width: double.infinity,
                  child: FilledButton(
                    child: const Text(
                      'اضافه کردن',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () {
                      if (_addRoleFormKey.currentState!.validate()) {
                        ref.read(customRoleProvider.notifier).addCustomRole(
                              Role(
                                name: _nameController.text,
                                job: _jobController.text,
                                type: _roleTypeFormData['type'],
                                order: _roleTypeFormData['order'],
                              ),
                            );
                        _addRoleFormKey.currentState!.save();
                        setState(() {
                          status = !status;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      if (ref.watch(customRoleProvider).isEmpty) {
        return Column(
          children: [
            Image.asset("asset/theme/empty.png"),
            const Text(
              'نقشی وجود نداره',
              style: TextStyle(fontSize: 22),
            ),
            const Opacity(
              opacity: .6,
              child: Text(
                "برای اضافه کردن نقش جدید از ' + ' استفاده کنید ",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        );
      } else {
        return _roleGridView(roles: ref.watch(customRoleProvider));
      }
    }
  }

  Widget _roleGridView({required List roles}) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: (2.25 / 1),
      children: List.generate(
        roles.length,
        (index) => InkWell(
          borderRadius: BorderRadius.circular(20),
          child: RoleListItemWidget(roles[index]),
          onTap: () {
            showModalBottomSheet(
              showDragHandle: true,
              context: context,
              builder: (builder) {
                return _roleDetails(context, roles[index]);
              },
            );
          },
        ),
      ),
    );
  }

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
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(role.name, style: const TextStyle(fontSize: 24.0)),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () => showAlertDialog(context, role),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Text(
              "گروه: $type",
              style: const TextStyle(fontSize: 24.0),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  showAlertDialog(BuildContext context, Role role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("نقش مورد نظر حذف شود ؟"),
          actions: [
            TextButton(
              child: const Text("بازگشت"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("حذف", style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                ref.read(customRoleProvider.notifier).removeCustomRole(role);
              },
            )
          ],
        );
      },
    );
  }
}
