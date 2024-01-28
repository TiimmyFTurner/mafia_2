import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';
import 'package:mafia_2/presentation/widgets/role_list_item_widget.dart';

class MyRoles extends ConsumerStatefulWidget {
  @override
  _MyRolesState createState() => _MyRolesState();
}

class _MyRolesState extends ConsumerState<MyRoles> {
  final Map<String, dynamic> _addRoleFormData = {
    'name': null,
    'job': null,
    'type': null,
    'order': null
  };
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
              // const SizedBox(width: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text("نقش های من", style: TextStyle(fontSize: 20)),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
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
                    Flexible(child: _buildRoleNameTextField()),
                    const SizedBox(width: 10),
                    Flexible(child: _buildRoleTypeDropDownField()),
                  ],
                ),
                const SizedBox(height: 10),
                _buildRoleJobTextField(),
                const SizedBox(height: 10),
                _buildAddBtnTextField()
              ],
            ),
          ),
        ),
      );
    } else {
      if (true)
      // (Provider.of<RolesNPlayers>(context).customRoles.isEmpty ||
      //     Provider.of<RolesNPlayers>(context).customRoles == null)
      {
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
        // return _roleGeidView(
        //     roles: Provider.of<RolesNPlayers>(context).customRoles);
      }
    }
  }

  Widget _roleGeidView({required List roles}) {
    return GridView.count(
      padding: const EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: (2 / 1),
      children: List.generate(
        roles.length,
        (index) => InkWell(
          borderRadius: BorderRadius.circular(20),
          child: RoleListItemWidget(roles[index]),
          onTap: () {
            showModalBottomSheet(
              context: context,
              enableDrag: true,
              isScrollControlled: true,
              builder: (builder) {
                return Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(28.0)),
                  ),
                  child: _roleDatails(context, roles[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _roleDatails(context, role) {
    String type = role.type == 'C'
        ? "شهروند"
        : role.type == 'M'
            ? "مافیا"
            : "مستقل";
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
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
        const SizedBox(height: 25),
        Text("نقش: " + role.name + "\nگروه: " + type,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl),
        const SizedBox(height: 15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    role.job,
                    style: const TextStyle(fontSize: 16),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context, Role role) {
    Widget cancelButton = TextButton(
      child: const Text(
        "بازگشت",
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
      child: const Text("حذف", style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        // Provider.of<RolesNPlayers>(context, listen: false).removeCustomRole =
        //     role;
      },
    );

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: const Text("نقش مورد نظر حذف شود ؟"),
      actions: [
        ButtonBar(
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(textDirection: TextDirection.rtl, child: alert);
      },
    );
  }

  Widget _buildRoleNameTextField() {
    return TextFormField(
      onSaved: (value) {
        // _addRoleFormData['name'] = value;
      },
      // validator: (value) => value?.isEmpty || value.length < 1
      //     ? 'نام نقش نمیتواند خالی باشد'
      //     : null,
      decoration: const InputDecoration(
          labelText: 'نام نقش', border: OutlineInputBorder()),
    );
  }

  Widget _buildRoleTypeDropDownField() {
    return DropdownButtonFormField(
      // validator: (String value) =>
      //     value == null ? 'نوع نقش را انتخاب کنید' : null,
      // dropdownColor: Theme.of(context).colorScheme.secondary,
      // value: roleType,
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
        _addRoleFormData['type'] = value;
        _addRoleFormData['order'] = value == 'M'
            ? 15
            : value == 'C'
                ? 43
                : 59;
      },
      decoration: const InputDecoration(
        labelText: 'نوع نقش',
        border: OutlineInputBorder(),

        // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(40))),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(40))),
      ),
    );
  }

  Widget _buildRoleJobTextField() {
    return TextFormField(
      maxLines: 4,
      // onSaved: (String value) {
      //   _addRoleFormData['job'] = value;
      // },
      // validator: (String value) => value.isEmpty || value.length < 1
      //     ? 'وظیفه نقش نمیتواند خالی باشد'
      //     : null,
      decoration: const InputDecoration(
          labelText: 'وظیفه',
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          border: OutlineInputBorder()),
    );
  }

  Widget _buildAddBtnTextField() {
    return SizedBox(
      height: 65,
      width: double.infinity,
      child: FilledButton(
        child: const Text(
          'اضافه کردن',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          // if (_addRoleFormKey.currentState.validate()) {
          //   _addRoleFormKey.currentState.save();
          //
          //   Provider.of<RolesNPlayers>(context, listen: false)
          //       .addCustomRole = Role.fromMap(_addRoleFormData);
          //   setState(() {
          //     status = !status;
          //   });
          // }
        },
      ),
    );
  }
}
