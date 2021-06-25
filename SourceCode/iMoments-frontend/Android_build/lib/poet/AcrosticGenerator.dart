import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';


/*
usage:
AcrosticGenerator AG = AcrosticGenerator();
AG.generate(Sting: 藏头词, String: 风格词(如_StyledPoems中的诗句), bool:是否为藏头诗, int: lineNumber);
returns String

Example:
AcrosticGenerator AG = AcrosticGenerator();
print(AG.generate("我的朋友圈真精彩"));

Out:
我亭夭桃熟，宫柳簇簇芳。
的环规翰翰，金簟出星芒。
朋友因才遂，天津位益彰。
友朋通象外，造化在中堂。
圈似金堦错，跻攀瑞气长。
真珠明玉案，绛柳拂金张。
精鉴言难重，馨香祕易彰。
彩霞初吐镜，舒黛似成心。

*/
class AcrosticGenerator {
  final _word2idxFile = 'word2idx.map';
  final _idx2wordFile = 'idx2word.map';
  final _modelFile = 'AcrosticPoet.tflite';

  Map<String, int> _word2idx;
  Map<int, String> _idx2word;

  // Maximum length of sentence
  final int _HIDDEN_SIZE = 1024;
  final int _MAX_CHAR_COUNT = 200;
  final int _MAX_ACROSTIC_COUNT = 50;

  final String start = '<START>';
  final String eop = '<EOP>';
  final String unk = '</s>';

  /// Instance of Interpreter
  Interpreter _interpreter;

  var _input;
  var _inputState;
  var _inputTensor;

  var _output;
  var _outputState;
  Map<int, Object> _outputTensor;

  var _lastOutputState;

  var _StyledPoems = [
      "紫阁连终南，青冥天倪色。",
      "凭崖望咸阳，宫阙罗北极。",
      "万井惊画出，九衢如弦直。",
      "渭水银河清，横天流不息。",
      "朝野盛文物，衣冠何翕赩。",
      "厩马散连山，军容威绝域。",
      "伊臯运元化，卫霍输筋力。",
      "歌钟乐未休，荣去老还逼。",
      "圆光过满缺，太阳移中昃。",
      "不散东海金，何争西飞匿。",
      "无作牛山悲，恻怆泪沾臆。",
      "梁山感杞妻，恸哭为之倾。",
      "金石忽蹔开，都由激深情。",
      "东海有勇妇，何惭苏子卿。",
      "学劒越处子，超然若流星。",
      "损躯报夫雠，万死不顾生。",
      "白刃耀素雪，苍天感精诚。",
      "十步两躩跃，三呼一交兵。",
      "斩首掉国门，蹴踏五藏行。",
      "豁此伉俪愤，粲然大义明。",
      "北海李使君，飞章奏天庭。",
      "舍罪警风俗，流芳播沧瀛。",
      "名在列女籍，竹帛已光荣。",
      "淳于免诏狱，汉主为缇萦。",
      "津妾一櫂歌，脱父於严刑。",
      "十子若不肖，不如一女英。",
      "豫让斩空衣，有心竟无成。",
      "要离杀庆忌，壮夫所素轻。",
      "妻子亦何辜，焚之买虚声。",
      "岂如东海妇，事立独扬名。",
      "安石在东山，无心济天下。",
      "一起振横流，功成复潇洒。",
      "大贤有卷舒，季叶轻风雅。",
      "匡复属何人，君为知音者。",
      "传闻武安将，气振长平瓦。",
      "燕赵期洗清，周秦保宗社。",
      "登朝若有言，为访南迁贾。",
      "大道何曾讨，无端入荒草。",
      "卷来复卷去，不觉虚生老。",
      "松楸连塔古，窗槛任闲开。",
      "水遶清阴里，人从热处来。",
      "噪风蝉带鹤，欹树石兼苔。",
      "向晓东林下，迟迟舍此廻。",
      "仙闱井初凿，灵液沁成泉。",
      "色湛青苔里，寒凝紫绠边。",
      "铜瓶向影落，玉甃抱虚圆。",
      "永愿调神鼎，尧时泰万年。",
      "帝子鸣金瑟，余声自抑扬。",
      "悲风丝上断，流水曲中长。",
      "出没游鱼听，逶迤彩凤翔。",
      "微音时扣征，雅韵乍含商。",
      "神理诚难测，幽情讵可量。",
      "至今闻古调，应恨滞三湘。",
      "天山一丈雪，杂雨夜霏霏。",
      "溼马胡歌乱，经烽汉火微。",
      "丁零苏武別，疎勒范羌归。",
      "若著关头过，长榆叶定稀。",
      "暮宿南洲草，晨行北岸林。",
      "日悬沧海阔，水隔洞庭深。",
      "烟景无留意，风波有异浔。",
      "岁游难极目，春戏易为心。",
      "朝夕无荣遇，芳菲已满襟。",
      "为爱江南雪，涉江聊采苹。",
      "水深烟浩浩，空对双车轮。",
      "车轮明月团，车盖浮云盘。",
      "云月徒自好，水中行路难。",
      "遥遥洛阳道，夹岸生春草。",
      "寄语櫂船郎，莫夸风浪好。",
      "皎然青琐客，何事动行轩。",
      "何当招我宿，乘月上方行。",
      "婆娑园中树，根株大合围。",
      "楚怀放灵均，国政亦荒淫。",
      "汉日大江军，少为乞食子。",
      "秦时故列侯，老作锄瓜士。",
      "春华何暐晔，园中发桃李。",
      "秋风忽萧条，堂上生荆杞。",
      "峡猨亦何意，陇水复何情。",
      "为入愁人耳，皆为肠断声。",
      "请看元侍御，亦宿此邮亭。",
      "天子闻此章，教化如法施。",
      "直谏从如流，佞臣恶如疵。",
      "宰相闻此章，政柄端正持。",
      "尚可以斧斤，伐之为栋梁。",
      "杀身获其所，为君构明堂。",
      "不然终天年，老死在南冈。",
      "不愿亚枝叶，低随槐树行。",
      "有木名弱柳，结根近清池。",
      "风烟借颜色，雨露助华滋。",
      "峨峨白雪花，嫋嫋青丝枝。",
      "渐密阴自庇，转高梢四垂。",
      "截枝扶为杖，輭弱不自持。",
      "有木名丹桂，四时香馥馥。",
      "花团夜雪明，叶翦春云绿。",
      "风影清似水，霜枝冷如玉。",
      "孤岛如江上，诗家犹闭门。",
      "一池分倒影，空舸系荒根。",
      "天道不可问，问天天杳冥。",
      "如何正月霜，百卉皆凋零。",
      "几岁松花下，今来草色平。",
      "衣冠游佛剎，鼓角望军城。",
      "乱竹边溪暗，孤云向岭明。",
      "紫蕚扶千蘂，黄须照万花。",
      "忽疑行暮雨，何事入朝霞。",
      "文章亦不尽，窦子才纵横。",
      "非尔更苦节，何人符大名。",
      "读书云阁观，问绢锦官城。",
      "高斋常见野，愁坐更临门。",
      "十月山寒重，孤城月水昏。",
      "五载客蜀郡，一年居梓州。",
      "如何关塞阻，转作潇湘游。",
      "道消诗兴废，心息酒为徒。",
      "许与才虽薄，追谁迹未拘。",
      "阑干上处远，结构坐来重。",
      "骑马行春径，衣冠起晚钟。",
      "寒食少天气，东风多柳花。",
      "小桃知客意，春尽始开花。",
      "谪居潇湘渚，再见洞庭秋。",
      "极目连江汉，西南浸斗牛。",
      "胡角引北风，蓟门白于水。",
      "天含青海道，城头月千里。",
      "露下旗濛濛，寒金鸣夜刻。"];

  AcrosticGenerator() {
    _loadDictionary();
    _loadModel();

    _input = new List<int>(1).reshape([1,1]);
    _inputState = new List<double>(_HIDDEN_SIZE).reshape([1,_HIDDEN_SIZE]);
    _inputTensor = new List(2);
    _inputTensor[0] = _input;
    _inputTensor[1] = _inputState;

    _output = new List<int>(1).reshape([1]);
    _outputState = new List<double>(_HIDDEN_SIZE).reshape([1,_HIDDEN_SIZE]);
    _outputTensor = {
      0: _output,
      1: _outputState,
    };

    _lastOutputState = new List<double>(_HIDDEN_SIZE).reshape([1,_HIDDEN_SIZE]);

    _reset();
  }

  void _reset() {
    _input[0][0] = 0;
    _output[0] = 0;
    for(int i = 0; i < _HIDDEN_SIZE; ++i){
      _inputState[0][i] = 0.0;
      _outputState[0][i] = 0.0;
      _lastOutputState[0][i] = 0.0;
    }
  }

  void _loadDictionary() async
  {
    // load word to index map
    final word2idxVocab = await rootBundle.loadString('assets/$_word2idxFile');
    var word2idxDict = <String, int>{};
    final word2idxVocabList = word2idxVocab.split('\n');
    for (var i = 0; i < word2idxVocabList.length; i++) {
      var entry = word2idxVocabList[i].trim().split(' ');
      word2idxDict[entry[0]] = int.parse(entry[1]);
    }
    _word2idx = word2idxDict;

    // load index to word map
    final idx2wordVocab = await rootBundle.loadString('assets/$_idx2wordFile');
    var idx2wordDict = <int, String>{};
    final idx2wordVocabList = idx2wordVocab.split('\n');
    for (var i = 0; i < idx2wordVocabList.length; i++) {
      var entry = idx2wordVocabList[i].trim().split(' ');
      idx2wordDict[int.parse(entry[0])] = entry[1];
    }
    _idx2word = idx2wordDict;

    print('Dictionary loaded successfully');
    // print(fetchNext("好"));
    // print(generate("我的朋友圈真精彩"));
  }

  void _loadModel() async
  {
    // Creating the interpreter using Interpreter.fromAsset
    _interpreter = await Interpreter.fromAsset(_modelFile);
    print('Interpreter loaded successfully');
  }

  String fetchNext(String word) {
    var wordIndex = _word2idx[word];
    if(wordIndex == null) {
      return "";
    }
    _input[0][0] = wordIndex;
    for(int i = 0; i < _HIDDEN_SIZE; ++i){
      _inputState[0][i] = _lastOutputState[0][i];
    }
    _interpreter.runForMultipleInputs(_inputTensor, _outputTensor);
    for(int i = 0; i < _HIDDEN_SIZE; ++i){
      _lastOutputState[0][i] = _outputState[0][i];
    }
    var out = _idx2word[_output[0]];
    if (out == null) {
      return "";
    }
    return out;
  }

  String replacePunctuation(String words) {
  return words.replaceAll(",", "，")
      .replaceAll(".", "。")
      .replaceAll("?","？")
      .replaceAll("!", "！");
  }

  Future<String> generate(String startWords, {String prefixWords = "", bool acrostic = true, int line = 5}) async {
    if(prefixWords == "") {
      var random = new Random();
      prefixWords = _StyledPoems[random.nextInt(119)];
    }
    var startWordsLocal = replacePunctuation(startWords);
    var prefixWordsLocal = replacePunctuation(prefixWords);
    _reset();
    var preWord = "<START>";
    String poem = "";
    int prefixWordsLocalLength = prefixWordsLocal.length;
    for(int i = 0; i < _MAX_ACROSTIC_COUNT; ++i) {
      if (i >= prefixWordsLocalLength && ["。", "！", "？"].contains(preWord)) {
        break;
      }
      var next = fetchNext(preWord);
      if (next == "") {
        return "包含无法序列化的字符，换句话试试吧~";
      }
      preWord = (i < prefixWordsLocalLength)
          ? prefixWordsLocal[i].toString()
          : next;
    }
    var lineSize = acrostic ? startWordsLocal.length : line;
    var lineIndex = -1;
    int startWordsLocalLength = startWordsLocal.length;
    for(int i = 0; i < _MAX_CHAR_COUNT; ++i) {
      var isNewLine = ["。", "！", "<START>", "？"].contains(preWord);
      if (isNewLine) {
        lineIndex++;
      }
      if (lineIndex>=lineSize) {
        break;
      }
      var newWord = fetchNext(preWord);
      if (newWord == "") {
        return "包含无法序列化的字符，换句话试试吧~";
      }
      if (newWord == "<EOP>") {
        break;
      }
      if (acrostic) {
        if (isNewLine) {
          newWord = startWordsLocal[lineIndex].toString();
        }
      } else if (i < startWordsLocalLength) {
        newWord = startWordsLocal[i].toString();
      }
      poem += newWord;
      preWord = newWord;
      if (["。", "！", "？"].contains(newWord)) {
        poem += "\n";
      }
    }
    return poem;
  }

}