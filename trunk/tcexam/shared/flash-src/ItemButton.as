/*
*  	Example Application built with the Graffiti Library
*  	______________________________________________________________________
*  	www.nocircleno.com/graffiti/
*/

/*
* 	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* 	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* 	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* 	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* 	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* 	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* 	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* 	OTHER DEALINGS IN THE SOFTWARE.
*/

package {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class ItemButton extends MovieClip {
		
		public var button_states_mc:MovieClip;
		
		private var _selected:Boolean = false;
		
		public function ItemButton() {
			
			button_states_mc.stop();
			
			this.addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
			
		}
		
		/**************************************************************************
			Method	: selected()
			
			Purpose	: This method sets the selected value of the button.
			
			Params	: v -- Boolen value
		***************************************************************************/
		public function set selected(v:Boolean):void {
			
			_selected = v;
			
			if(_selected) {
				button_states_mc.gotoAndStop("selected");
			} else {
				button_states_mc.gotoAndStop("up");
			}
			
		}
		
		/**************************************************************************
			Method	: selected()
			
			Purpose	: This methods returns the selected value.
		***************************************************************************/
		public function get selected():Boolean {
			return _selected;
		}
		
		/**************************************************************************
			Method	: mouseHandler()
			
			Purpose	: This methods handles the rollover and rollout events.
			
			Params	: e -- MouseEvent object.
		***************************************************************************/
		private function mouseHandler(e:MouseEvent):void {
			
			if(!_selected && !e.buttonDown) {
				
				if(e.type == MouseEvent.ROLL_OVER) {
					button_states_mc.gotoAndStop("over");
				} else if(e.type == MouseEvent.ROLL_OUT) {
					button_states_mc.gotoAndStop("up");
				}
				
			}
			
		}
		
	}
	
}