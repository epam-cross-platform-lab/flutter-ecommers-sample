import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/widgets.dart';


@immutable
class RightMenuItemsList extends StatelessWidget {
  final List<RightMenuItemModel> itemList;

  const RightMenuItemsList({
    this.itemList
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final itemModel = itemList[index];
        return RightMenuItem(
          itemModel: itemModel,
        );
      },
    );
  }
}
