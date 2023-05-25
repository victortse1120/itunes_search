import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/songController.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.searchController,
    required FocusNode focusNode,
    required this.songController,
  }) : _focusNode = focusNode;

  final TextEditingController searchController;
  final FocusNode _focusNode;
  final SongController songController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: TextFormField(
            controller: searchController,
            focusNode: _focusNode,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              focusColor: Colors.transparent,
              fillColor: Colors.transparent,
              hoverColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(8.0),
              counter: Container(),
              border: const OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0))),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.grey[700]!),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0))),
            ),
            style: Theme.of(context).textTheme.button,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            maxLines: 1,
            onFieldSubmitted: (value) {
              if (searchController.text.isNotEmpty) {
                songController
                    .fetchSongs(searchController.text);
              }
            },
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: ElevatedButton(
                onPressed: () {
                  _focusNode.unfocus();
                  if (searchController.text.isNotEmpty) {
                    songController
                        .fetchSongs(searchController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('search'.tr,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, height: 1.0)),
                    const Icon(Icons.search, size: 16.0,)
                  ],
                )),
          ),
        )
      ],
    );
  }
}