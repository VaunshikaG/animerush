import 'DetailsPodo.dart';

class ChunksModel {
  // bool hasRemainingEp;
  // int remainingEp, totalChipCount, finalChipCount, startVal, length;
  // var start, end, rangeIndex, selectedIndex;

  List<EpDetails> epDetails = [];
  List<EpDetails> epChunkList = [];

  ChunksModel({
    // required this.hasRemainingEp,
    // required this.remainingEp,
    // required this.totalChipCount,
    // required this.finalChipCount,
    // required this.startVal,
    // required this.length,
    // required this.start,
    // required this.end,
    // required this.rangeIndex,
    // required this.selectedIndex,
    required this.epDetails,
    required this.epChunkList,
  });

  /*

  List<EpDetails> epDetails = [];
  List<EpDetails> epChunkList = [];
  bool hasRemainingEp = false;
  int remainingEp = 0, totalChipCount = 0, finalChipCount = 0, startVal = 0, length = 0;
  var start = '', end = '', rangeIndex = 0.obs, selectedIndex = 9999999.obs;

  void chunks() {
    // checks if the remainder of the division of the length of the "anime" list by 50 is less than 50.
    if ((length % 50).floor() < 50) {
      log('length   ${(length % 50).toString()}');
      hasRemainingEp = true;
      remainingEp = (length % 50).floor();
      log('remainingEp  ${remainingEp.toString()}');
    }
    totalChipCount = (length / 50).floor();
    log('chunks of 50  $totalChipCount');

    //  size of the remaining chunk; otherwise, it takes 50.
    epChunkList = epDetails.sublist(0,
        (hasRemainingEp == true && length < 50) ? remainingEp : length);

    //  size of remaining chunk; otherwise, it takes 50.
    finalChipCount = totalChipCount + (hasRemainingEp ? 1 : 0);
    log('final  $finalChipCount');

  }

  String getEpisodeRange(int index) {
    start = ((index * 50) + 1).toString();
    end = ((50 * (index + 1))).toString();
    if (index == totalChipCount && hasRemainingEp) {
      end = ((50 * index) + remainingEp).toString();
    }
    startVal = int.parse(start);
    // endVal = (int.parse(end) + 1).toString();
    return ('$start - $end');
  }
*/
}
