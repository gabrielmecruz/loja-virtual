import 'package:flutter/material.dart';
import 'package:loja_virtual/models/page_manager.dart';
import 'package:provider/provider.dart';

class DrawerTile extends StatefulWidget {
  const DrawerTile({
    required this.iconData,
    required this.title,
    required this.page,
  });

  final IconData iconData;
  final String title;
  final int page;

  @override
  _DrawerTileState createState() => _DrawerTileState();
}

class _DrawerTileState extends State<DrawerTile> {
  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<PageManager>().page;
    final Color primaryColor = Theme.of(context).primaryColor;

    return InkWell(
      onTap: () {
        debugPrint('Pagina ${widget.page}');
        context.read<PageManager>().setPage(widget.page);
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                widget.iconData,
                size: 32,
                color: currentPage == widget.page
                    ? primaryColor
                    : Colors.grey.shade700,
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                color: currentPage == widget.page
                    ? primaryColor
                    : Colors.grey.shade700,
              ),
            )
          ],
        ),
      ),
    );
  }
}
