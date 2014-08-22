/**
 * TweenEngine.as
 * TweenCat - small tween engine for as3.
 * Copyright (c) 2014 Vladimir Nayata
 * version 1.0
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 
package {
	import flash.display.Shape; 
	import flash.events.Event;
	
	public class TweenEngine {
		private static var list:Array = []; 
		private static var initted:Boolean = false; 
		private static var engine:Shape = new Shape();
		
		/**
		* Constructor
		* @param target: tween target.
		* @param steps: tween time.
		* @param ease: type of transition equation (use default Robert Penner's Easing Equations).
		* @param props: tween arguments.
		* @param delay: delay time.
		* @param overwrite: if TRUE the tween will be overwrited. Use FALSE to chains.
		* @param autoclear: if TRUE the tween target will be removed from the parent container.
		* @param oncomplete: will call the user function on the tween complete.
		*/
		public static function addTween(target:Object, steps:int, ease:Function, props:Object, delay:int = 0, overwrite:Boolean = true, autoclear:Boolean = false, oncomplete:Function = null):void {
			if (!initted) { 
				engine.addEventListener(Event.ENTER_FRAME, update, false, 0, true);
				initted = true; 
			} 

			if (overwrite) { 
				var i:int = list.length;
				while (i--) {
					var t:TweenObject = list[i] as TweenObject;
					if (t.target == target) {
						list.splice(i, 1);
					}
				}
			}

			var tween:TweenObject = new TweenObject();
			tween.overwrite = !overwrite;
			tween.autoclear = autoclear;
			tween.steps = steps;
			tween.delay = delay;
			tween.target = target;
			tween.ease = ease;
			tween.loop = 0;
			
			if (oncomplete != null) { 
				tween.oncomplete = oncomplete;
			}
			
			var prop:String; 
			var p:int = 0; 

			tween.keys = [];
			
			for (prop in props) { 
				tween.keys[p] = [prop, target[prop], props[prop] - target[prop], props[prop]]; 
				p++;
			}
			
			list[list.length++] = tween;
		}
		
		private static function update(event:Event):void {
			var working:Boolean = false;
			var i:int = list.length;

			while (i--) {
				var tween:TweenObject = list[i] as TweenObject;
				
				working = true; 
				
				if (tween.delay > 0) { 
					tween.delay--;
					if (tween.delay == 0) {
						if (tween.overwrite) { recalculate(tween); }
					}
					continue;
				} 

				var key:Array; 
				var j:int = tween.keys.length;
				var factor:Number = tween.ease(tween.loop++, 0, 1, tween.steps);
				
				while (j--) {
					key = tween.keys[j];
					tween.target[key[0]] = key[1] + key[2] * factor; 
				}
				
				if (tween.loop > tween.steps) {
					if (tween.oncomplete != null) { tween.oncomplete(); }
					if (tween.autoclear && tween.target.parent != null) { 
						tween.target.parent.removeChild(tween.target); 
					}
					list.splice(i, 1);
				} 
			} 

			if (!working) { 
				engine.removeEventListener(Event.ENTER_FRAME, update); 
				initted = false; 
			} 
		}
		
		private static function recalculate(tween:TweenObject):void { 
			var j:int = tween.keys.length;
			while (j--) {
				var prop:String = tween.keys[j][0];
				tween.keys[j] = [prop, tween.target[prop], tween.keys[j][3] - tween.target[prop]];
			}
		}
		
		public static function dispose():void {
			list = [];
			engine.removeEventListener(Event.ENTER_FRAME, update); 
			initted = false; 
		}
	}
}
			
internal final class TweenObject {
	public var target:Object;
	public var oncomplete:Function;
	public var overwrite:Boolean;
	public var autoclear:Boolean;
	public var ease:Function;
	public var keys:Array;
	public var steps:int;
	public var delay:int;
	public var loop:int;
}