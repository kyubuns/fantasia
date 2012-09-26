package;

import Std;
import js.Lib;
import js.JQuery;
import js.Dom;
import createjs.easeljs.Stage;
import createjs.easeljs.Bitmap;
import createjs.easeljs.Shape;
import createjs.preloadjs.PreLoadJS;

extern class FileReader {
  function new():Void;
  dynamic function onload(event:js.Event):Void;
  function readAsDataURL(event:js.Event):Void;
}

class Fantasia {
  public static function main():Void { new Fantasia(); }
  public function new() {
    new JQuery(Lib.document).ready(function(e) {
      Lib.window.onload = init;
      new JQuery("#shuffle").click(shuffle);
    });
  }

  private function init(event:js.Event) {
    stage = new Stage(cast js.Lib.document.getElementById("canvas"));

    untyped Lib.window.addEventListener("dragover", function(e) { event.preventDefault(); }, false);
    untyped Lib.window.addEventListener("drop", fileDrop, false);
  }

  private function fileDrop(event:js.Event) {
    untyped event.preventDefault();
    var files:Array<js.Event> = untyped event.dataTransfer.files;
    for(file in files) {
      //ToDo:
      //if (!fileType.match(/image.*/)) {
      //  alert('画像ファイル以外は利用できません');
      //  continue;
      //}
      var reader = new FileReader();
      reader.onload = function(event:js.Event) {
        var image = untyped __js__("new Image()");
        untyped image.src = event.target.result;
        image.onload = function(_) { drawImage(image); };
      };
      reader.readAsDataURL(file);
    }
  }

  private function drawImage(image:Image) {
    //ToDo:Imageに枠を付ける
    var baseX = Std.random(stageWidth);
    var baseY = Std.random(stageHeight);
    var angle = Std.random(60)-30; //-30 ~ +30度ぐらいで回転させる
    var scale = 0.3;//ToDo: ちゃんとscale調整する
    //ずらして9回描画
    for(x in -1...2) for(y in -1...2) {
      //ToDo:先に影を描画
      var bitmap = new Bitmap(image);
      bitmap.x = baseX + stageWidth * x;
      bitmap.y = baseY + stageHeight * y;
      bitmap.rotation = angle;
      bitmap.scaleX = bitmap.scaleY = scale;
      stage.addChild(bitmap);
    }
    stage.update();
  }

  private function shuffle() {
    //ToDo:
    //fileDrop時に画像をリストにつっこんで保存しておいて、
    //ここでcanvas一度真っ白にして(stageのchild消すだけ)、再描画(call drawImage)
    trace("shuffle");
  }

  //ToDo:保存処理

  //ToDo: constにする方法調べる
  private var stageWidth = 800;
  private var stageHeight = 600;
  private var stage:Stage;
}
