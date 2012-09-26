package;

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
    });
  }

  private function init(event:js.Event) {
    stage = new Stage(cast js.Lib.document.getElementById("canvas"));

    untyped Lib.window.addEventListener("dragover", function(e) { event.preventDefault(); }, false);
    untyped Lib.window.addEventListener("drop", filedrop, false);
  }

  private function filedrop(event:js.Event) {
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
        var bitmap= new Bitmap(image);
        image.onload = function() {
          stage.addChild(bitmap);
          stage.update();
        };
      };
      reader.readAsDataURL(file);
    }
  }

  private var stage:Stage;
}
