package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	
	
	[SWF(width="660", height="260", backgroundColor="0xeeeeee", frameRate="30")]
	public class TweenEquationsExample extends Sprite {
		private const WIDTH:int = 660;
		private const HEIGHT:int = 260;
		
		private var sprite:Sprite;
		
		private var list:Array = [];
		private var equations:Array = [];
		
		private var tweenTime:PushButton;
		private var tweenEquation:ComboBox;
		private var tweenButton:PushButton;


		public function TweenEquationsExample() {
			registerTransition("easeNone",			Equations.easeNone);
			registerTransition("linear",			Equations.easeNone);
			
			registerTransition("easeInQuad",		Equations.easeInQuad);
			registerTransition("easeOutQuad",		Equations.easeOutQuad);
			registerTransition("easeInOutQuad",		Equations.easeInOutQuad);
			registerTransition("easeOutInQuad",		Equations.easeOutInQuad);
			
			registerTransition("easeInCubic",		Equations.easeInCubic);
			registerTransition("easeOutCubic",		Equations.easeOutCubic);
			registerTransition("easeInOutCubic",	Equations.easeInOutCubic);
			registerTransition("easeOutInCubic",	Equations.easeOutInCubic);
			
			registerTransition("easeInQuart",		Equations.easeInQuart);
			registerTransition("easeOutQuart",		Equations.easeOutQuart);
			registerTransition("easeInOutQuart",	Equations.easeInOutQuart);
			registerTransition("easeOutInQuart",	Equations.easeOutInQuart);
			
			registerTransition("easeInQuint",		Equations.easeInQuint);
			registerTransition("easeOutQuint",		Equations.easeOutQuint);
			registerTransition("easeInOutQuint",	Equations.easeInOutQuint);
			registerTransition("easeOutInQuint",	Equations.easeOutInQuint);
			
			registerTransition("easeInSine",		Equations.easeInSine);
			registerTransition("easeOutSine",		Equations.easeOutSine);
			registerTransition("easeInOutSine",		Equations.easeInOutSine);
			registerTransition("easeOutInSine",		Equations.easeOutInSine);
			
			registerTransition("easeInCirc",		Equations.easeInCirc);
			registerTransition("easeOutCirc",		Equations.easeOutCirc);
			registerTransition("easeInOutCirc",		Equations.easeInOutCirc);
			registerTransition("easeOutInCirc",		Equations.easeOutInCirc);
			
			registerTransition("easeInExpo",		Equations.easeInExpo);
			registerTransition("easeOutExpo", 		Equations.easeOutExpo);
			registerTransition("easeInOutExpo", 	Equations.easeInOutExpo);
			registerTransition("easeOutInExpo", 	Equations.easeOutInExpo);
			
			registerTransition("easeInElastic", 	Equations.easeInElastic);
			registerTransition("easeOutElastic", 	Equations.easeOutElastic);
			registerTransition("easeInOutElastic", 	Equations.easeInOutElastic);
			registerTransition("easeOutInElastic", 	Equations.easeOutInElastic);
			
			registerTransition("easeInBack", 		Equations.easeInBack);
			registerTransition("easeOutBack", 		Equations.easeOutBack);
			registerTransition("easeInOutBack", 	Equations.easeInOutBack);
			registerTransition("easeOutInBack", 	Equations.easeOutInBack);
			
			registerTransition("easeInBounce", 		Equations.easeInBounce);
			registerTransition("easeOutBounce", 	Equations.easeOutBounce);
			registerTransition("easeInOutBounce", 	Equations.easeInOutBounce);
			registerTransition("easeOutInBounce", 	Equations.easeOutInBounce);
			
			Style.setStyle(Style.DARK);
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
			
			var target:Sprite = new Sprite();
			target.x = 100; target.y = 120;
			target.graphics.beginFill(0x444444);
			target.graphics.drawCircle(0, 0, 50);
			target.graphics.drawCircle(0, 0, 45);
			target.graphics.endFill();
			target.graphics.beginFill(0x444444);
			target.graphics.drawRect(-20/2, -8/2, 20, 8);
			target.graphics.endFill();
			target.graphics.beginFill(0x444444);
			target.graphics.drawRect(-8/2, -20/2, 8, 20);
			target.graphics.endFill();
			stage.addChild(target);
			
			target = new Sprite();
			target.x = 330; target.y = 120;
			target.graphics.beginFill(0x444444);
			target.graphics.drawCircle(0, 0, 50);
			target.graphics.drawCircle(0, 0, 45);
			target.graphics.endFill();
			target.graphics.beginFill(0x444444);
			target.graphics.drawRect(-20/2, -8/2, 20, 8);
			target.graphics.endFill();
			target.graphics.beginFill(0x444444);
			target.graphics.drawRect(-8/2, -20/2, 8, 20);
			target.graphics.endFill();
			stage.addChild(target);
			
			sprite = new Sprite();
			sprite.x = 330; sprite.y = 120;
			sprite.graphics.beginFill(0xff0060);
			sprite.graphics.drawCircle(0, 0, 36);
			sprite.graphics.drawCircle(0, 0, 36 * 0.625);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(0xc00000);
			sprite.graphics.drawCircle(0, 0, 36 * 0.625);
			sprite.graphics.endFill();
			stage.addChild(sprite);
			
			tweenEquation = new ComboBox(stage, 500, 85, "easeNone", list);
			tweenEquation.selectedIndex = 0;
			tweenEquation.setSize(110, 20);
			
			tweenTime = new PushButton(stage, 500, 105, "Tween time: 5", changeTweenTime);
			tweenTime.setSize(110, 20);
			tweenTime.tag = 5;
			
			tweenButton = new PushButton(stage, 500, 135, "Tween");
			tweenButton.addEventListener(MouseEvent.MOUSE_OVER, tweenButtonOver);
			tweenButton.addEventListener(MouseEvent.MOUSE_OUT, tweenButtonOut);
			tweenButton.setSize(110, 20);
			tweenButton.tag = 1;
		}
		
		private function registerTransition(equationName:String, equationFunction:Function):void {
			list[list.length++] = equationName;
			equations[equations.length++] = equationFunction;
		}
		
		private function changeTweenTime(event:MouseEvent):void {
			if (tweenTime.tag == 5) {
				tweenTime.label = "Tween time: 10";
				tweenTime.tag = 10;
			}
			else if (tweenTime.tag == 10) {
				tweenTime.label = "Tween time: 20";
				tweenTime.tag = 20;
			}
			else if (tweenTime.tag == 20) {
				tweenTime.label = "Tween time: 50";
				tweenTime.tag = 50;
			}
			else if (tweenTime.tag == 50) {
				tweenTime.label = "Tween time: 5";
				tweenTime.tag = 5;
			}
		}
		
		private function tweenButtonOver(event:MouseEvent):void {
			TweenEngine.addTween(sprite, tweenTime.tag, equations[tweenEquation.selectedIndex], {x:100});
		}
		
		private function tweenButtonOut(event:MouseEvent):void {
			TweenEngine.addTween(sprite, tweenTime.tag, equations[tweenEquation.selectedIndex], {x:330});
		}
	}
}