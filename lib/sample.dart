import 'package:animerush/utils/theme.dart';
import 'package:animerush/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    epCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomAppBar3(
                title: "",
                backBtn: () {
                  Navigator.of(context).pop();
                },
                wishlist: () => epCall(),
              ),
            ),
            SliverToBoxAdapter(child: chips()),
            SliverToBoxAdapter(child: eps()),
          ],
        ),
      ),
    );
  }

  bool hasRemainingEp = false;
  int remainingEp = 0;
  int totalChipCount = 0;
  int finalChipCount = 0;
  var start = '';
  var end = '';
  var _rangeIndex = 0.obs;
  var selectedIndex = 9999999.obs;
  RxList<int> epChunkList = [for (var i = 1; i <= 100; i++) i].obs;
  List<int> anime = [for (var i = 1; i <= 333; i++) i];

  String getEpisodeRange(int index) {
    start = ((index * 100) + 1).toString();
    end = ((100 * (index + 1))).toString();
    if (index == totalChipCount && hasRemainingEp) {
      end = ((100 * index) + remainingEp).toString();
    }
    // startVal = start;
    // endVal = (int.parse(end) + 1).toString();
    return ('$start - $end');
  }

  void epCall() async {
    if ((anime.length % 100).floor() < 100) {
      print((anime.length % 100).toString());
      hasRemainingEp = true;
      remainingEp = (anime.length % 100).floor();
    }
    totalChipCount = (anime.length / 100).floor();
    epChunkList.value = anime.sublist(
        0, (hasRemainingEp == true && anime.length < 100) ? remainingEp : 100);
    finalChipCount = totalChipCount + (hasRemainingEp ? 1 : 0);

    print('Ep Chunk List ${epChunkList.length} + $remainingEp');
    print((anime.length % 100).floor());
    print(totalChipCount);
    print(finalChipCount);
  }

  Widget chips() {
    return Container(
      color: Colors.cyan.shade100,
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: finalChipCount,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _rangeIndex.value = index;
                  selectedIndex.value = 99999999;
                  getEpisodeRange(index);
                  if (finalChipCount == (index + 1)) {
                    epChunkList.value = anime.sublist(int.parse(start) - 1);
                  } else {
                    epChunkList.value =
                        anime.sublist(int.parse(start) - 1, int.parse(end));
                  }
                });
              },
              child: Chip(
                backgroundColor:
                    _rangeIndex.value == index ? Colors.blueGrey : Colors.grey,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                label: Text(
                  getEpisodeRange(index),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget eps() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          maxCrossAxisExtent: 45,
        ),
        itemCount: epChunkList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              setState(() {
                selectedIndex.value = index;
                print(index);
                // print(epChunkList[index].id.toString());
              });
            },
            splashColor: Colors.white,
            child: Container(
              width: 20,
              height: 20,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectedIndex.value == index
                      ? Colors.blueGrey
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                epChunkList[index].toString(),
                style: TextStyle(
                  color: (selectedIndex.value == index)
                      ? CustomTheme.white
                      : Colors.black,
                  fontSize: (selectedIndex.value == index) ? 15 : 13,
                ),
              ),
            ),
          );

          return ChoiceChip(
            // label: Text(epChunkList[index].id.toString()),
            // label: Text(),
            label: Text((index + 1).toString()),
            selected: selectedIndex.value == index,
            onSelected: (bool selected) {
              setState(() {
                selectedIndex.value = selected ? index : 0;
              });
            },
            elevation: 0,
            backgroundColor: Colors.grey.shade200,
            selectedColor: Colors.blueGrey,
            disabledColor: Colors.grey.shade100,
            // labelStyle: TextStyle(
            //   color: (selectedIndex.value == index) ? CustomTheme.white : Colors.black,
            //   fontSize: (selectedIndex.value == index) ? 15 :13,
            // ),
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            // padding: EdgeInsets.only(right: (selectedIndex.value == index) ? 20 : 5),
            // iconTheme: const IconThemeData(
            //   size: 0,
            //   weight: 4,
            //   opacity: 0,
            //   color: Colors.blueGrey,
            // ),
          );
        },
      ),
    );
  }
}


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // perform login with email and password
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
