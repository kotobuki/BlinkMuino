#include <LED.h>
#include <Button.h>
#include <FiniteStateMachine.h>

#include "Pins.h"

/**
 * 状態遷移表
 * 
 * State\Input | Play    | Stop    |
 * ------------+---------+---------+
 * WAITING     | PLAYING |   ---   |
 * PLAYING     | PAUSING | WAITING |
 * PAUSING     | PLAYING | WAITING |
 * ------------+---------+---------+
 */

// それぞれの状態を定義
// 引数はその状態に入ったとき、アップデートのとき、抜けたときに実行する関数
State WAITING = State(enterWaiting, NO_UPDATE, NO_EXIT, "Waiting");
State PLAYING = State(enterPlaying, NO_UPDATE, NO_EXIT, "Playing");
State PAUSING = State(enterPausing, NO_UPDATE, NO_EXIT, "Pausing");

// Finite State Machine、初期状態はWAITING
FSM stateMachine = FSM(WAITING);

// ボタンとLEDを初期化
Button playButton = Button(sdaPin);
Button stopButton = Button(sclPin);
LED playIndicator = LED(grnPin);

void setup() {
  // シリアル出力が利用できる場合にはデバッグ出力を開始
  BEGIN_DEBUG_OUT

  // それぞれのボタンにイベントハンドラをセット
  playButton.pressHandler(playButtonPressed);
  stopButton.pressHandler(stopButtonPressed);
}

void loop() {
  // それぞれのボタンの状態をアップデート
  playButton.update();
  stopButton.update();

  // それぞれの状態に応じてアップデート
  stateMachine.update();

  // 再生インジケータの状態をアップデート
  playIndicator.update();
}

void playButtonPressed(Button& b) {
  if (stateMachine.isInState(WAITING)) {
    // 待機中であれば再生中に移行
    stateMachine.transitionTo(PLAYING);
  }
  else if (stateMachine.isInState(PLAYING)) {
    // 再生中であれば一時停止中に移行
    stateMachine.transitionTo(PAUSING);
  }
  else if (stateMachine.isInState(PAUSING)) {
    // 一時停止中であれば再生中に移行
    stateMachine.transitionTo(PLAYING);
  }
}

void stopButtonPressed(Button& b) {
  if (stateMachine.isInState(WAITING)) {
    // 待機中に停止ボタンを押しても何も起きない
  }
  else if (stateMachine.isInState(PLAYING)) {
    // 再生中であれば待機中に移行
    stateMachine.transitionTo(WAITING);
  }
  else if (stateMachine.isInState(PAUSING)) {
    // 一時停止中であれば待機中に移行
    stateMachine.transitionTo(WAITING);
  }
}

// 他の状態から待機中に移行
void enterWaiting() {
  // 待機中に移行したらLEDを消灯
  playIndicator.off();
}

// 他の状態から再生中に移行
void enterPlaying() {
  // LEDを点灯
  playIndicator.on();
}

// 他の状態から一時停止中に移行
void enterPausing() {
  // LEDを点滅
  playIndicator.blink(500);
}
