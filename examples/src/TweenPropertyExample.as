package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	
	
	[SWF(width="660", height="260", backgroundColor="0xeeeeee", frameRate="30")]
	public class TweenPropertyExample extends Sprite {
		private const WIDTH:int = 660;
		private const HEIGHT:int = 260;
		
		private var defaultObject:DefaultObject;
		private var tweenButton:PushButton;
		private var tweenLabel:Label;
		

		public function TweenPropertyExample() {
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
			
			defaultObject = new DefaultObject();
			defaultObject.x = 330; defaultObject.y = 120;
			stage.addChild(defaultObject);

			tweenButton = new PushButton(stage, 285, 220, "tween");
			tweenButton.addEventListener(MouseEvent.MOUSE_OVER, tweenButtonOver);
			tweenButton.addEventListener(MouseEvent.MOUSE_OUT, tweenButtonOut);
			tweenButton.setSize(90, 20);
			
			tweenLabel = new Label(stage, 10, 10, "");
			tweenLabel.textField.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, 0x555555);
		}
		
		private function tweenButtonOver(event:MouseEvent):void {
			TweenEngine.addTween(defaultObject, 10, Equations.easeNone, {angle:-90});
			tweenLabel.text = "TweenEngine.addTween(defaultObject, 10, Equations.easeNone, {angle:-90});";
		}
		
		private function tweenButtonOut(event:MouseEvent):void {
			TweenEngine.addTween(defaultObject, 10, Equations.easeNone, {angle:0});
			tweenLabel.text = "TweenEngine.addTween(defaultObject, 10, Equations.easeNone, {angle:0});";
		}
	}
}

import flash.display.*;
import flash.geom.*;
	
internal class DefaultObject extends Sprite {
	private var _angle:Number = 0;
		
	public function DefaultObject() {
		graphics.beginFill(0xff0060);
		graphics.drawCircle(0, 0, 40);
		graphics.drawCircle(0, 0, 40 * 0.625);
		graphics.endFill();
		graphics.beginFill(0xc00000);
		graphics.drawCircle(0, 0, 40 * 0.625);
		graphics.endFill();
		graphics.beginFill(0x222222);
		graphics.drawRect(-20/2, -8/2, 20, 8);
		graphics.endFill();
		graphics.beginFill(0x222222);
		graphics.drawRect(-8/2, -20/2, 8, 20);
		graphics.endFill();
			
		var overlay:Sprite = new Sprite();
		overlay.graphics.beginGradientFill(GradientType.LINEAR, [0x000000, 0x000000], [0, 0.3], [0, 255]);
		overlay.graphics.drawCircle(0, 0, 40);
		overlay.graphics.endFill();
		overlay.blendMode = BlendMode.MULTIPLY;
		overlay.rotation = 90;
		addChild(overlay);
	}
		
	public function get angle():Number {
		return _angle;
	}
		
	public function set angle(value:Number):void {
		_angle = value;
		rotation = _angle;
	}
}