import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'board_tile.dart';

class GameBoard extends StatelessWidget {
  final List<List<String>> board;
  final Function(int, int) onTileTap;
  final bool isLightMode;

  const GameBoard({
    Key? key,
    required this.board,
    required this.onTileTap,
    required this.isLightMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300.h,
        width: 300.w,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 30,
              spreadRadius: 15,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (col) {
                return BoardTile(
                  value: board[row][col],
                  onTap: () => onTileTap(row, col),
                  isLightMode: isLightMode,
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
