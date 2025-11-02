import 'package:endless_tic_tac_toe/constant/board_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../constant/symbol_xo.dart';
import '../logic/game_controller.dart';
import '../widgets/score_board.dart';
import '../widgets/game_board/game_board.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = GameController();
  BannerAd? _bannerAd;

  Color _getSymbolColor(int index) {
    final moves = [...controller.xMoves, ...controller.oMoves];
    final move = moves.where((m) => m.index == index).firstOrNull;

    if (move == null) return Colors.transparent;
    if (move.age == 5) return Colors.grey;

    return controller.board[index] == SymbolXO.X
        ? BoardConstants.xColor
        : BoardConstants.oColor;
  }

  void _onCellTap(int index) {
    final moved = controller.makeMove(index);
    if (moved) {
      controller.checkWinner();
      setState(() {});
    }
  }

  void _loadBanner() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',//'ca-app-pub-6881197226483425/5516543106', ca-app-pub-3940256099942544/6300978111
      request: const AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (ad) {
            debugPrint('Баннер успешно загружен');
            setState(() {});
          },
          onAdFailedToLoad: (ad, err){
            debugPrint('Ошибка загрузки баннера: $err');
            ad.dispose();
            Future.delayed(const Duration(seconds: 3), _loadBanner);
          }
      ),
    )..load();
  }


  @override
  void initState() {
    super.initState();
    _loadBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: ScoreBoard(
          teamBlue: controller.teamBlueScore,
          teamRed: controller.teamRedScore,
          currentTurn: controller.currentTurn,
        ),
      ),
      body: GameBoard(
        board: controller.board,
        getSymbolColor: _getSymbolColor,
        onCellTap: _onCellTap,
      ),
      bottomNavigationBar: (_bannerAd != null && _bannerAd!.responseInfo != null)
          ? SizedBox(
        height: _bannerAd!.size.height.toDouble(),
        width: _bannerAd!.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      )
          : SizedBox.shrink(),
    );
  }
}
