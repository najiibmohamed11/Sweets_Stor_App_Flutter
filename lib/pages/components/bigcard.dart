import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SweetCard extends StatefulWidget {
  final String? imagepath;
  final String? name;
  final String? description;
  final String? id;
  final String? collection;
  final int? price;

  final void Function()? ontaped;
  final void Function()? carttap;

  const SweetCard({
    Key? key,
    this.imagepath,
    this.name,
    this.description,
    this.price,
    this.ontaped,
    this.carttap,
    this.id,
    this.collection,
  }) : super(key: key);

  @override
  State<SweetCard> createState() => _SweetCardState();
}

class _SweetCardState extends State<SweetCard> {
  Offset _tapPosition = Offset.zero;
  TapDownDetails? _tapDetails; // Store tap details here

  void _getTapPosition(TapDownDetails tapPosition) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(tapPosition.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, TapDownDetails details) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromLTRB(
      details.globalPosition.dx,
      details.globalPosition.dy,
      overlay.size.width - details.globalPosition.dx,
      overlay.size.height - details.globalPosition.dy,
    );

    final result = await showMenu(
      context: context,
      position: position, // This is critical for positioning
      items: [
        const PopupMenuItem<String>(
          value: "delete",
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
    if (result != null) {
      deleteDocument(widget.id!);
    }
  }

  Future<void> deleteDocument(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(widget.collection!) // Specify the collection name
          .doc(docId) // Specify the document ID
          .delete(); // Delete the document
      print("deleted");

      // Document deleted successfully
      // You can show a success message or perform other operations here
    } catch (e) {
      // Handling errors
      // You might want to show an error message or perform error handling logic here
      print("Error deleting document: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) =>
          setState(() => _tapDetails = details), // Capture tap details
      onLongPress: () {
        if (_tapDetails != null) {
          _showContextMenu(
              context, _tapDetails!); // Use stored details for positioning
        }
      },
      onTap: widget.ontaped,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        width: 180,
        height: 280.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100.0,
                height: 100.0,
                child: Image.network(widget.imagepath ?? ''),
              ),
            ),
            Text(
              widget.name ?? '',
              style: TextStyle(
                letterSpacing: 2.0,
                fontSize: 20,
                color: Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.description ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.grey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${widget.price}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                GestureDetector(
                  onTap: widget.carttap,
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
