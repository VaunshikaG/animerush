import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/CustomAppBar.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: kIsWeb ? 1100 : MediaQuery.of(context).size.width,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomTheme.themeColor2,
          body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              CustomAppBar2(),
            ],
          ),
        ),
      ),
    );
  }
}
