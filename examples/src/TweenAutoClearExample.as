package {
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	
	import com.bit101.components.*;
	
	
	[SWF(width="660", height="260", backgroundColor="0xeeeeee", frameRate="30")]
	public class TweenAutoClearExample extends Sprite {
		private const WIDTH:int = 660;
		private const HEIGHT:int = 260;
		
		private var tweenLabel:Label;
		private var tweenButton:PushButton;
		

		public function TweenAutoClearExample() {
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
			target.x = 330; target.y = 120;
			target.graphics.beginFill(0xcccccc);
			target.graphics.drawCircle(0, 0, 50);
			target.graphics.drawCircle(0, 0, 45);
			target.graphics.endFill();
			stage.addChild(target);
			
			tweenLabel = new Label(stage, 10, 10, "");
			tweenLabel.textField.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, 0x555555);

			tweenButton = new PushButton(stage, 285, 220, "Add award!", tweenButtonClicked);
			tweenButton.setSize(90, 20);
		}
		
		private function tweenButtonClicked(event:MouseEvent):void {
			var award:Sprite = new Sprite();
			award.x = 330; award.y = 120;
			
			award.graphics.beginFill(0xff0060);
			award.graphics.drawCircle(0, 0, 40);
			award.graphics.drawCircle(0, 0, 40 * 0.625);
			award.graphics.endFill();
			award.graphics.beginFill(0xc00000);
			award.graphics.drawCircle(0, 0, 40 * 0.625);
			award.graphics.endFill();
			
			award.scaleX = award.scaleY = 0.25;
			award.alpha = 0;
			stage.addChild(award);
			
			TweenEngine.addTween(award, 30, Equations.easeOutElastic, {alpha:1, scaleX:1, scaleY:1});
			TweenEngine.addTween(award, 30, Equations.easeOutBack, {alpha:0, scaleX:0.25, scaleY:0.25}, 80, false, true, enableTweenButton);
			
			disableTweenButton();
		}
		
		private function disableTweenButton():void {
			tweenLabel.text = "Award have been added to stage.";
			tweenButton.label = "reloading...";
			tweenButton.enabled = false;
		}
		
		private function enableTweenButton():void {
			tweenLabel.text = "Award have been removed from stage.";
			tweenButton.label = "Add award!";
			tweenButton.enabled = true;
		}
	}
}