import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';

class PlayAIScreen extends StatefulWidget {
  const PlayAIScreen({super.key, required this.title});

  final String title;

  @override
  _PlayAIScreenState createState() => _PlayAIScreenState();
}

class _PlayAIScreenState extends State<PlayAIScreen> {
  List<List<String>> board = List.generate(3, (_) => List.generate(3, (_) => ''));
  String currentPlayer = 'O';
  bool isGameOver = false;

  void resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.generate(3, (_) => ''));
      currentPlayer = 'O';
      isGameOver = false;
    });
  }

  void makeMove(int row, int col) {
    if (board[row][col].isEmpty && !isGameOver) {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(currentPlayer)) {
          showWinDialog(currentPlayer);
          isGameOver = true;
        } else if (isBoardFull()) {
          showDrawDialog();
          isGameOver = true;
        } else {
          currentPlayer = currentPlayer == 'O' ? 'X' : 'O';
          if (currentPlayer == 'X') {
            Future.delayed(const Duration(milliseconds: 300), aiMove);
          }
        }
      });
    }
  }

  bool checkWin(String player) {
    // Check rows
    for (var row in board) {
      if (row.every((cell) => cell == player)) return true;
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (board.every((row) => row[col] == player)) return true;
    }

    // Check diagonals
    if (board[0][0] == player && board[1][1] == player && board[2][2] == player) return true;
    if (board[0][2] == player && board[1][1] == player && board[2][0] == player) return true;

    return false;
  }

  bool isBoardFull() {
    for (var row in board) {
      for (var cell in row) {
        if (cell.isEmpty) return false;
      }
    }
    return true;
  }

  void aiMove() {
    // Simple AI move: just pick the first available spot
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          makeMove(i, j);
          return;
        }
      }
    }
  }

  void showWinDialog(String player) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('$player Wins!'),
        content: const Text('Congratulations!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetBoard();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void showDrawDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Draw!'),
        content: const Text('The game ended in a draw.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetBoard();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),    leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
        actions: [
        IconButton(
        icon: const Icon(
          Icons.info_outline,
        ),
        onPressed: () {
          showAboutDialog(
            context: context,
            applicationName: 'Tic Tac Toe',
            applicationVersion: '1.0.0',
            children: [const Text('This is a Tic Tac Toe game app.')],
          );
        },
      ),
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              final themeMode = Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;
              MyApp.of(context)?.setThemeMode(themeMode);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: Container(
              height: 300.h,
              width: 300.w,
              decoration: BoxDecoration(
                color: Colors.transparent,
                boxShadow: [
                  BoxShadow(
                    color:     Theme.of(context).brightness == Brightness.dark ? Colors.green.withOpacity(0.1) :Colors.green.withOpacity(0.3) ,
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
                      return GestureDetector(
                        onTap: () => makeMove(row, col),
                        child: Container(
                          width: 70.w,
                          height: 70.h,
                          decoration: BoxDecoration(
                            color:Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.07) : Colors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: board[row][col] == 'O'
                                  ? Colors.red
                                  : board[row][col] == 'X'
                                  ? Colors.green
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: board[row][col] == 'O'
                                ? SvgPicture.asset(
                              "assets/players/o.svg",
                              width: 40.w,
                              height: 40.h,
                              color: Colors.red,
                            )
                                : board[row][col] == 'X'
                                ? SvgPicture.asset(
                              "assets/players/x.svg",
                              width: 40.w,
                              height: 40.h,
                              color: Colors.green,
                            )
                                : null,
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/players/o.svg",
                      width: 40.w,
                      height: 40.h,
                      color: Colors.red,
                    ),
                    SizedBox(height: 5.h),
                     Text(
                      "YOU",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      "assets/players/x.svg",
                      width: 40.w,
                      height: 40.h,
                      color: Colors.green,
                    ),
                    SizedBox(height: 5.h),
                     Text(
                      "AI",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(

            width: 200.w,
            child: ElevatedButton(
              onPressed: resetBoard,
              child: const Text('Reset'),
            ),
          ),
        ],
      ),
    );
  }
}
