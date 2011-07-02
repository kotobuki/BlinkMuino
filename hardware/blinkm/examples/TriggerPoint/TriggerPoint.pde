#include <LED.h>
#include <TriggerPoint.h>

#include "Pins.h"

// 閾値
int threshold = 300;

// ヒステリシス
int hysteresis = 50;

// TriggerPointオブジェクト
TriggerPoint triggerPoint = TriggerPoint(sclPin);

// LEDオブジェクト
LED led = LED(grnPin);

void setup() {
  // SetPointを初期化
  triggerPoint.init(threshold, hysteresis);

  // 2 つのイベントに対してイベントハンドラをセット
  triggerPoint.risingEdgeHandler(onBrightenUp);
  triggerPoint.fallingEdgeHandler(onDarkenUp);
}

void loop() {
  // センサの値を読み取ってその値でSetPointを更新
  triggerPoint.update();

  // LEDの状態をアップデート
  led.update();
}

// 明るくなったら
void onBrightenUp() {
  // LEDを消灯
  led.fadeOut(500);
}

// 暗くなったら
void onDarkenUp() {
  // LEDを点灯
  led.fadeIn(500);
}
