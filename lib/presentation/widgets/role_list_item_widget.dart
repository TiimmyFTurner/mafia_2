import 'package:flutter/material.dart';
import 'package:mafia_2/domain/data_models/role_model.dart';

class RoleListItemWidget extends StatefulWidget {
  final Role _role;

  const RoleListItemWidget(this._role, {super.key});

  @override
  State createState() => _RoleListItemWidgetState();
}

class _RoleListItemWidgetState extends State<RoleListItemWidget> {
  bool _lock = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration d) {
      setState(() {
        _lock = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final role = widget._role;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: _lock ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
        padding: _lock
            ? EdgeInsets.zero
            : EdgeInsets.only(top: MediaQuery.of(context).size.height),
        child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    role.name,
                    maxLines: 2,
                    style: const TextStyle(height: 1.2),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.person,
                  color: role.type == 'C'
                      ? Colors.green
                      : role.type == 'M'
                          ? Colors.red
                          : Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
