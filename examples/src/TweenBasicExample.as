package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	
	
	[SWF(width="660", height="260", backgroundColor="0xeeeeee", frameRate="30")]
	public class TweenBasicExample extends Sprite {
		private const WIDTH:int = 660;
		private const HEIGHT:int = 260;
		
		private var sprite:Sprite;
		private var tweenLabel:Label;
		private var tweenButton:PushButton;
		private var list:Array = ["alpha", "scale", "move", "delay", "chain", "oncomplete"];
		private var page:int = 0;
		

		public function TweenBasicExample() {
			Style.LABEL_TEXT = 0xBBBBBB;
			Style.BUTTON_FACE = 0x393939;
			Style.BUTTON_DOWN = 0x333333;
			Style.BACKGROUND = 0x1d1d1d;
			Style.DROPSHADOW = 0x1d1d1d;
			Style.PANEL = 0x505050;
			
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(660, 660, 0, 0, -200);
			
			var bg:Sprite = new Sprite();
			bg.graphics.beginGradientFill(GradientType.RADIAL, [0xe0e0e0, 0xd0d0d0], [1, 1], [0, 255], matrix);
			bg.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			stage.addChild(bg);
			
			sprite = new Sprite();
			sprite.x = 330; sprite.y = 120;
			sprite.graphics.beginFill(0xff0060);
			sprite.graphics.drawCircle(0, 0, 40);
			sprite.graphics.drawCircle(0, 0, 40 * 0.625);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(0xc00000);
			sprite.graphics.drawCircle(0, 0, 40 * 0.625);
			sprite.graphics.endFill();
			stage.addChild(sprite);
			
			tweenLabel = new Label(stage, 10, 10, "");
			tweenLabel.textField.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, 0x555555);

			tweenButton = new PushButton(stage, 285, 220, "alpha");
			tweenButton.addEventListener(MouseEvent.MOUSE_OVER, tweenButtonOver);
			tweenButton.addEventListener(MouseEvent.MOUSE_OUT, tweenButtonOut);
			tweenButton.setSize(90, 20);
			tweenButton.tag = 1;
			
			var prevButton:PushButton = new PushButton(stage, 265, 220, "<", changeTween);
			prevButton.setSize(20, 20);
			prevButton.tag = 1;
			
			var nextButton:PushButton = new PushButton(stage, 375, 220, ">", changeTween);
			nextButton.setSize(20, 20);
			nextButton.tag = 2;
		}
		
		private function changeTween(event:MouseEvent):void {
			var action:int = event.target.tag; 
			
			if (action == 1 && page > 0) page--;
			if (action == 2 && page < list.length-1) page++;
			
			tweenButton.label = list[page];
		}
		
		private function tweenButtonOver(event:MouseEvent):void {
			var action:String = list[page];

			switch (action) {
				case "alpha":
				TweenEngine.addTween(sprite, 5, Equations.easeNone, {alpha:0.1});
				tweenLabel.text = "TweenEngine.addTween(sprite, 5, Equations.easeNone, {alpha:0.1});";
				break;
				case "scale":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {scaleX:1.2, scaleY:1.2});
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {scaleX:1.2, scaleY:1.2});";
				break;
				case "move":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:180});
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:180});";
				break;
				case "delay":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:480}, 10);
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:480}, 10);";
				break;
				case "chain":
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:180});
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:330, y:60}, 20, false);
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:480, y:120}, 40, false);
				tweenLabel.text = "TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:180});";
				tweenLabel.text += "\nTweenEngine.addTween(sprite, 10, Equations.easeNone, {x:330, y:60}, 20, false);";
				tweenLabel.text += "\nTweenEngine.addTween(sprite, 10, Equations.easeNone, {x:480, y:120}, 40, false);";
				break;
				case "oncomplete":
				var sayHello:Function = function():void { trace("Hello!"); }
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {alpha:0.5}, 0, true, false, sayHello);
				tweenLabel.text = "var sayHello:Function = function():void { trace(\"Hello!\"); }";
				tweenLabel.text += "\nTweenEngine.addTween(sprite, 10, Equations.easeNone, {alpha:0.5}, 0, true, false, sayHello);";
				break;
			}
		}
		
		private function tweenButtonOut(event:MouseEvent):void {
			var action:String = list[page];
			
			switch (action) {
				case "alpha":
				TweenEngine.addTween(sprite, 5, Equations.easeNone, {alpha:1.0});
				tweenLabel.text = "TweenEngine.addTween(sprite, 5, Equations.easeNone, {alpha:1.0});";
				break;
				case "scale":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {scaleX:1.0, scaleY:1.0});
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {scaleX:1.0, scaleY:1.0});";
				break;
				case "move":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:330});
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:330});";
				break;
				case "delay":
				TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:330}, 10);
				tweenLabel.text = "TweenEngine.addTween(sprite, 30, Equations.easeOutElastic, {x:330}, 10);";
				break;
				case "chain":
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:330, y:120});
				tweenLabel.text = "TweenEngine.addTween(sprite, 10, Equations.easeNone, {x:330, y:120});";
				break;
				case "oncomplete":
				var sayGoodbay:Function = function():void { trace("Goodbay!"); }
				TweenEngine.addTween(sprite, 10, Equations.easeNone, {alpha:1.0}, 0, true, false, sayGoodbay);
				tweenLabel.text = "var sayGoodbay:Function = function():void { trace(\"Goodbay!\"); }";
				tweenLabel.text += "\nTweenEngine.addTween(sprite, 10, Equations.easeNone, {alpha:1.0}, 0, true, false, sayGoodbay);";
				break;
			}
		}
	}
}