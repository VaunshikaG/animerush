// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/watchListController.dart';
import '../screens/details.dart';
import 'noData.dart';

class SimilarList extends StatefulWidget {
  final similarData;
  final String pg;
  // final void Function() onRemove;
  SimilarList({super.key, required this.similarData, required this.pg});

  @override
  State<SimilarList> createState() => _SimilarListState();
}

class _SimilarListState extends State<SimilarList> {
  WatchListController watchListController = Get.put(WatchListController());

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAlias,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 160,
            ),
            itemCount: widget.similarData.length,
            itemBuilder: (BuildContext ctx, index) {
              final similarList = widget.similarData[index];
              final lang, type, status;

              if (similarList.type == 'S') {
                lang = "SUB";
              } else if (similarList.type == 'D') {
                lang = "DUB";
              } else {
                lang = "-";
              }

              if (similarList.animeWatchType == 'ON') {
                type = "Onas";
              } else if (similarList.animeWatchType == 'OV') {
                type = "Ovas";
              } else if (similarList.animeWatchType == 'M') {
                type = "Movie";
              } else if (similarList.animeWatchType == 'SP') {
                type = "Special";
              } else if (similarList.animeWatchType == 'S') {
                type = "Series";
              } else {
                type = "-";
              }

              if (similarList.status == 'C') {
                status = "Completed";
              } else if (similarList.status == 'O') {
                status = "Ongoing";
              } else {
                status = "-";
              }

              return GestureDetector(
                onTap: () {
                  Get.offAll(() => Details(id: similarList.id.toString()));
                },
                onHorizontalDragEnd: (DragEndDetails) {
                  setState(() {
                    if (widget.pg == 'detail') {
                      watchListController.addToListApi(
                        animeId: similarList.id.toString(),
                        type: 'False00',
                      );
                    }
                  });
                },
                child: Container(
                  height: 250,
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Wrap(
                    children: [
                      FadeInImage.assetNetwork(
                        alignment: Alignment.center,
                        placeholder: "assets/img/blank.png",
                        image:
                            similarList.aniImage ?? similarList.imageHighQuality!,
                        fit: BoxFit.fill,
                        height: 230,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/img/blank.png",
                            fit: BoxFit.contain,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0, top: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (lang == "SUB")
                                  ? appTheme.indicatorColor
                                  : appTheme.colorScheme.error,
                            ),
                            child: Text(
                              lang,
                              style: appTheme.textTheme.labelSmall,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: appTheme.colorScheme.background,
                            ),
                            child: Text(
                              "EP ${similarList.episodes}",
                              style: appTheme.textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        title: Text(
                          similarList.name ?? "",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: appTheme.textTheme.titleMedium,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            "$type  •  $status  •  ${similarList.airedYear ?? "-"}",
                            // maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: appTheme.textTheme.titleSmall,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.2),
      ],
    );
  }
}
