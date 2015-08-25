/*
*  Example Application built with the Graffiti Library
*  ______________________________________________________________________
*  www.nocircleno.com/graffiti/
*/

/*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

package {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.display.BlendMode;
	import flash.net.navigateToURL;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLRequestHeader;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLVariables;
	import flash.text.Font;
	import flash.utils.ByteArray;

	import flash.external.ExternalInterface;

	import fl.controls.CheckBox;
	import fl.controls.ColorPicker;
	import fl.controls.Slider;
	import fl.controls.ComboBox;
	import fl.events.ColorPickerEvent;
	import fl.events.SliderEvent;
	import fl.data.DataProvider;

	import com.nocircleno.graffiti.GraffitiCanvas;
	import com.nocircleno.graffiti.display.Text;
	import com.nocircleno.graffiti.display.GraffitiObject;
	import com.nocircleno.graffiti.events.CanvasEvent;
	import com.nocircleno.graffiti.events.GraffitiObjectEvent;
	import com.nocircleno.graffiti.tools.BrushTool;
	import com.nocircleno.graffiti.tools.BrushType;
	import com.nocircleno.graffiti.tools.LineTool;
	import com.nocircleno.graffiti.tools.LineType;
	import com.nocircleno.graffiti.tools.ShapeTool;
	import com.nocircleno.graffiti.tools.ShapeType;
	import com.nocircleno.graffiti.tools.ToolMode;
	import com.nocircleno.graffiti.tools.ITool;
	import com.nocircleno.graffiti.tools.BitmapTool;
	import com.nocircleno.graffiti.tools.FillBucketTool;
	import com.nocircleno.graffiti.tools.SelectionTool;
	import com.nocircleno.graffiti.tools.TextSettings;
	import com.nocircleno.graffiti.tools.TextTool;
	import com.nocircleno.graffiti.managers.GraffitiObjectManager;

	import com.adobe.images.JPEGEncoder;

	public class Main extends MovieClip {

		public var click_message_txt:TextField;

		// ui
		public var brush_tool_mc:ItemButton;
		public var eraser_tool_mc:ItemButton;
		public var line_tool_mc:ItemButton;
		public var rectangle_tool_mc:ItemButton;
		public var fillbucket_tool_mc:ItemButton;
		public var selection_tool_mc:ItemButton;
		public var text_tool_mc:ItemButton;
		public var oval_tool_mc:ItemButton;
		public var clear_btn:SimpleButton;
		public var save_btn:SimpleButton;
		public var undo_btn:SimpleButton;
		public var redo_btn:SimpleButton;
		public var reenoo_btn:SimpleButton;
		public var slider_label_txt:TextField;
		public var slider_2_label_txt:TextField;
		public var slider_3_label_txt:TextField;
		public var combo_label_txt:TextField;
		public var stroke_color_mc:ColorPicker;
		public var fill_color_mc:ColorPicker;
		public var slider_mc:Slider;
		public var slider_2_mc:Slider;
		public var slider_3_mc:Slider;
		public var zoom_slider_mc:Slider;
		public var combo_list:ComboBox;
		public var overlay_cb:CheckBox;
		public var overlay_mc:MovieClip;
		public var canvas:GraffitiCanvas;
		public var border:Sprite;

		// tools
		private var _brush:BrushTool;
		private var _eraser:BrushTool;
		private var _line:LineTool;
		private var _shape:ShapeTool;
		private var _selectionTool:SelectionTool;
		private var _textTool:TextTool;
		private var _fillBucketTool:FillBucketTool;

		// props
		private var _brushSize:Number=2;
		private var _strokeColor:uint=0x00FF00;
		private var _fillColor:uint=0xFF0000;
		private var _strokeAlpha:Number=1;
		private var _fillAlpha:Number=1;
		private var _brushBlur:Number=0;
		private var _fontColor:uint=0x00FF00;
		private var _fontSize:uint=14;

		private var _brushShapeIndex:int;
		private var _lineStyleIndex:int;
		private var _fontIndex:uint=0;
		private var _fontList:DataProvider;
		private var _brushShapes:DataProvider;
		private var _lineStyles:DataProvider;

		private var _fileRef:FileReference;
		private var _objectManager:GraffitiObjectManager;
		private var _orginalComboBoxItemsPos = new Object();

		public function Main() {

			// hide message
			click_message_txt.alpha=0;

			// create canvas
			canvas=new GraffitiCanvas(840,470,10);
			canvas.x=0;
			canvas.y=120;
			canvas.addEventListener(MouseEvent.MOUSE_WHEEL, scrollHandler);
			canvas.addEventListener(GraffitiCanvas.HISTORY_LENGTH_CHANGE, historyLengthChangeHandler);
			canvas.addEventListener(GraffitiObjectEvent.SELECT, objectEventHandler);
			canvas.addEventListener(GraffitiObjectEvent.ENTER_EDIT, objectEventHandler);
			addChild(canvas);

			// add image over canvas
			//overlay_mc = new OverlayImage();
			//canvas.overlay=overlay_mc;

			// get instance of graffiti object manager
			_objectManager=GraffitiObjectManager.getInstance();

			// add listeners for keyboard shortcuts
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandler);

			// add event listeners for tool buttons
			selection_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			text_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			fillbucket_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			brush_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			eraser_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			line_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			rectangle_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);
			oval_tool_mc.addEventListener(MouseEvent.CLICK, toolHandler);

			// setup data providers
			_brushShapes = new DataProvider();
			_brushShapes.addItem({label:"圆形", data: BrushType.ROUND});
			_brushShapes.addItem({label:"正方形", data: BrushType.SQUARE});
			_brushShapes.addItem({label:"菱形", data: BrushType.DIAMOND});
			_brushShapes.addItem({label:"垂直", data: BrushType.VERTICAL_LINE});
			_brushShapes.addItem({label:"水平", data: BrushType.HORIZONTAL_LINE});
			_brushShapes.addItem({label:"向前", data: BrushType.FORWARD_LINE});
			_brushShapes.addItem({label:"向后", data: BrushType.BACKWARD_LINE});

			_lineStyles = new DataProvider();
			_lineStyles.addItem({label:"实线", data: LineType.SOLID});
			_lineStyles.addItem({label:"点线", data: LineType.DOTTED});
			_lineStyles.addItem( { label:"虚线", data: LineType.DASHED } );

			/////////////////////////////////////////////////
			// Setup Font List
			/////////////////////////////////////////////////
			_fontList = new DataProvider();

			var embeddedFonts:Array=Font.enumerateFonts(true);
			embeddedFonts.sortOn("fontName", Array.CASEINSENSITIVE);

			for (var i:int = 0; i < embeddedFonts.length; i++) {
				_fontList.addItem( {label: embeddedFonts[i].fontName, data: embeddedFonts[i] } );
			}

			// create tool instances
			_brush=new BrushTool(_brushSize,_fillColor,_fillAlpha,_brushBlur,BrushType.ROUND);
			_eraser=new BrushTool(_brushSize,_fillColor,1,_brushBlur,BrushType.ROUND,ToolMode.ERASE);
			_line=new LineTool(2,_strokeColor,_strokeAlpha,LineType.SOLID);
			_shape=new ShapeTool(2,_strokeColor,_fillColor,_strokeAlpha,_fillAlpha,ShapeType.RECTANGLE);
			_fillBucketTool=new FillBucketTool(_fillColor,true);
			_selectionTool = new SelectionTool();
			_textTool=new TextTool(new TextSettings(Font(_fontList.getItemAt(0).data),new TextFormat(null,_fontSize,_fontColor)));

			// setup color pickers
			stroke_color_mc.focusEnabled=false;
			stroke_color_mc.selectedColor=_strokeColor;
			stroke_color_mc.addEventListener(ColorPickerEvent.CHANGE, colorPickerHandler);
			stroke_color_mc.enabled=false;

			fill_color_mc.focusEnabled=false;
			fill_color_mc.selectedColor=_fillColor;
			fill_color_mc.addEventListener(ColorPickerEvent.CHANGE, colorPickerHandler);

			slider_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			slider_2_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			slider_3_mc.addEventListener(SliderEvent.CHANGE, sliderHandler);
			//overlay_cb.addEventListener(Event.CHANGE, overlayHandler);
			//overlay_cb.visible=false;
			//overlay_cb.focusEnabled=false;

			// config combo list
			combo_list.addEventListener(Event.CHANGE, comboEventHandler);
			combo_list.dataProvider=_brushShapes;
			combo_list.focusEnabled=false;

			// store positions
			_orginalComboBoxItemsPos.comboBox=new Point(combo_list.x,combo_list.y);
			_orginalComboBoxItemsPos.comboBoxLabel=new Point(combo_label_txt.x,combo_label_txt.y);

			// disable undo and redo buttons
			undo_btn.mouseEnabled=false;
			undo_btn.alpha=.5;
			redo_btn.mouseEnabled=false;
			redo_btn.alpha=.5;
			
			reenoo_btn.addEventListener(MouseEvent.CLICK, gourl);

			// add event listeners
			undo_btn.addEventListener(MouseEvent.CLICK, historyHandler);
			redo_btn.addEventListener(MouseEvent.CLICK, historyHandler);
			clear_btn.addEventListener(MouseEvent.CLICK, clearCanvasHandler);
			save_btn.addEventListener(MouseEvent.CLICK, saveHandler);

			zoom_slider_mc.maximum=canvas.maxZoom;
			zoom_slider_mc.addEventListener(SliderEvent.CHANGE, zoomHandler);

			// assign the brush tool as the default tool
			canvas.activeTool=_brush;

			// set brush tool
			brush_tool_mc.selected=true;
			setSelectedBrushShape(BrushType.ROUND);

		}
        private function gourl(e:MouseEvent):void {

			if (e.currentTarget==reenoo_btn) {
				//var myStr:String = "http://www.fei-d.net"; 
                //var myReq:URLRequest = new URLRequest(myStr); 
                //navigateToURL(myReq,"_blank"); 
				}

			}
		/**************************************************************************
		Method: objectEventHandler()
		
		Purpose: This method handles GraffitiObjectEvents.  We use this
		  to know when an object is selected or enters edit mode.
		
		Params: e -- GraffitiObjectEvent object.
		***************************************************************************/
		private function objectEventHandler(e:GraffitiObjectEvent):void {

			var font:Font;
			var fmt:TextFormat;
			var i:int;

			if (e.type==GraffitiObjectEvent.SELECT) {

				// get font and text format of selected object
				font=Text(e.graffitiObject).textSetting.font;
				fmt=Text(e.graffitiObject).textSetting.textFormat;

				_fontSize=Number(fmt.size);

				var fontFromList:Font;
				var numberFonts:uint=_fontList.length;

				// find select text font in font list
				for (i = 0; i < numberFonts; i++) {

					fontFromList=Font(_fontList.getItemAt(i).data);

					if (fontFromList.fontName==font.fontName&&fontFromList.fontStyle==font.fontStyle) {
						_fontIndex=i;
						break;
					}

				}

				// if text tool is active tool, then update it.
				if (canvas.activeTool is TextTool) {
					TextTool(canvas.activeTool).textSettings=new TextSettings(font,fmt);
				} else {
					_textTool.textSettings.textFormat.size=Number(fmt.size);
				}

				// update ui for objects
				combo_list.selectedIndex=_fontIndex;
				slider_mc.value=Number(fmt.size);
				fill_color_mc.selectedColor=uint(fmt.color);

			} else if (e.type == GraffitiObjectEvent.ENTER_EDIT) {

				// if we enter edit mode on an text object, make sure the tool is set to the text tool.
				if (e.graffitiObject is Text && !(canvas.activeTool is TextTool)) {
					setActiveTool(text_tool_mc);
				}

			}

		}


		/**************************************************************************
		Method: overlayHandler()
		
		Purpose: This method toggles the overlay on and off.
		
		Params: e -- Event object.
		***************************************************************************/
		private function overlayHandler(e:Event):void {
			if (e.currentTarget.selected) {
				//canvas.overlay=overlay_mc;
				canvas.overlay=null;
			} else {
				canvas.overlay=null;
			}
		}

		/**************************************************************************
		Method: historyHandler()
		
		Purpose: This method undo or redo the drawing depending on the button
		  clicked by the user.
		
		Params: e -- MouseEvent object.
		***************************************************************************/
		private function historyHandler(e:MouseEvent):void {

			if (e.currentTarget==undo_btn) {

				canvas.prevHistory();

				if (canvas.historyPosition==0) {
					undo_btn.mouseEnabled=false;
					undo_btn.alpha=.5;
				}

				redo_btn.mouseEnabled=true;
				redo_btn.alpha=1;

			} else if (e.currentTarget == redo_btn) {

				canvas.nextHistory();

				if (canvas.historyPosition == (canvas.historyLength - 1)) {
					redo_btn.mouseEnabled=false;
					redo_btn.alpha=.5;
				}

				undo_btn.mouseEnabled=true;
				undo_btn.alpha=1;

			}

		}

		/**************************************************************************
		Method: clearCanvasHandler()
		
		Purpose: This method will clear the canvas.
		
		Params: e -- MouseEvent object.
		***************************************************************************/
		private function clearCanvasHandler(e:MouseEvent):void {
			canvas.clearCanvas();
		}

		/**************************************************************************
		Method: saveHandler()
		
		Purpose: This method will save the drawing as a PNG image.
		
		Params: e -- MouseEvent object.
		***************************************************************************/
		private function saveHandler(e:MouseEvent):void {

			// get drawing as bitmapdata from the Graffiti Canvas instance.
			var canvasBmp:BitmapData=canvas.drawing();

			// create new jpg encoder object and convert bitmapdata to jpg
			//var pngEncoder:PNGEncoder = new PNGEncoder();
			//var pngStream:ByteArray=PNGEncoder.encode(canvasBmp);
			
			var jpgEncoder:JPEGEncoder = new JPEGEncoder(90);
			var jpgStream:ByteArray = jpgEncoder.encode(canvasBmp);

			// make sure you dispose of the bitmapdata object when finished.
			canvasBmp.dispose();
/*save as file
			_fileRef = new FileReference();
			_fileRef.save(jpgStream, "graffiti_example_image.jpg");
*/
/*upload to server*/
			var header:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
			var jpgURLRequest:URLRequest = new URLRequest("save.php");
			jpgURLRequest.requestHeaders.push(header);
			jpgURLRequest.method = "POST";
			jpgURLRequest.data = jpgStream;
			var loader:URLLoader = new URLLoader();           
            loader.addEventListener(Event.COMPLETE, completeHandler);  
            loader.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);  
            loader.load(jpgURLRequest); 
			function completeHandler(e:Event):void{  
            	trace("图片上传成功");  
				trace("目标文件的原始数据 (纯文本) : " + loader.data);
				ExternalInterface.call("r", loader.data);
				//navigateToURL(loader.data,"_blank"); 
        	}  
          
        	function errorHandler(e:IOErrorEvent):void{  
            	trace("图片上传失败");  
        	}  
/**/
		}
		//private function saveHandler(event:MouseEvent):void{                                
		//var bitmapData:BitmapData = new BitmapData(loader.width, loader.height);
		//var encoder:JPEGEncoder = new JPEGEncoder(90); 
		//var byteArray:ByteArray;
		//bitmapData.draw(loader);
		//byteArray = encoder.encode(bitmapData);
		//saveFileRef.save(byteArray, "test.jpg");

		/**************************************************************************
		Method: historyLengthChangeHandler()
		
		Purpose: This method will handle the change in the number of stored
		  history items.  This is used to toggle the redo and undo
		  buttons.
		
		Params: e -- Event object.
		***************************************************************************/
		private function historyLengthChangeHandler(e:Event):void {

			if (canvas.historyLength>0&&canvas.historyPosition!=0) {
				undo_btn.mouseEnabled=true;
				undo_btn.alpha=1;
			} else {
				undo_btn.mouseEnabled=false;
				undo_btn.alpha=.5;
			}

			if (canvas.historyLength>0&&canvas.historyPosition!=canvas.historyLength-1) {
				redo_btn.mouseEnabled=true;
				redo_btn.alpha=1;
			} else {
				redo_btn.mouseEnabled=false;
				redo_btn.alpha=.5;
			}

		}

		/**************************************************************************
		Method: zoomHandler()
		
		Purpose: This method will handle the zoom slider event and set the
		  canvas to the new zoom level.
		
		Params: e -- SliderEvent object.
		***************************************************************************/
		private function zoomHandler(e:SliderEvent):void {

			// set zoom of canvas
			canvas.zoom=e.value;

			// if canvas is zoomed in then display message about dragging canvas with mouse.
			if (canvas.zoom>1) {
				click_message_txt.alpha=1;
			} else {
				click_message_txt.alpha=0;
			}

		}

		/**************************************************************************
		Method: colorPickerHandler()
		
		Purpose: This method will handle the color picker event.
		
		Params: e -- ColorPickerEvent object.
		***************************************************************************/
		private function colorPickerHandler(e:ColorPickerEvent):void {

			var font:Font;
			var fmt:TextFormat;
			var ts:TextSettings;

			if (canvas.activeTool is BrushTool) {

				_fillColor=e.color;
				BrushTool(canvas.activeTool).color=_fillColor;

			} else if (canvas.activeTool is LineTool) {

				_strokeColor=e.color;
				LineTool(canvas.activeTool).color=_strokeColor;

			} else if (canvas.activeTool is ShapeTool) {

				if (e.currentTarget==stroke_color_mc) {

					_strokeColor=e.color;
					ShapeTool(canvas.activeTool).strokeColor=_strokeColor;

				} else if (e.currentTarget == fill_color_mc) {

					_fillColor=e.color;
					ShapeTool(canvas.activeTool).fillColor=_fillColor;

				}

			} else if (canvas.activeTool is TextTool) {

				// update color of textformat object
				fmt=TextTool(canvas.activeTool).textSettings.textFormat;
				fmt.color=fill_color_mc.selectedColor;

				// update text tool
				TextTool(canvas.activeTool).textSettings.textFormat=fmt;

				// update any selected text with new color
				if (_objectManager.areObjectsSelected()) {

					font=Font(combo_list.selectedItem.data);
					fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
					ts=new TextSettings(font,fmt);

					_objectManager.changeSettingsForSelectedObjects(ts);

				}

			} else if (canvas.activeTool is SelectionTool) {

				font=Font(combo_list.selectedItem.data);
				fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
				ts=new TextSettings(font,fmt);

				// update text tool
				_textTool.textSettings=ts;

				if (_objectManager.areObjectsSelected()) {

					// change settings for selected text
					_objectManager.changeSettingsForSelectedObjects(ts);

				}

			} else if (canvas.activeTool is FillBucketTool) {

				FillBucketTool(canvas.activeTool).fillColor=fill_color_mc.selectedColor;

			}


		}

		/**************************************************************************
		Method: sliderHandler()
		
		Purpose: This method will handle the slider change.
		
		Params: e -- SliderEvent object.
		***************************************************************************/
		private function sliderHandler(e:SliderEvent):void {

			var font:Font;
			var fmt:TextFormat;
			var ts:TextSettings;

			if (e.currentTarget==slider_mc) {

				if (canvas.activeTool==_brush||canvas.activeTool==_eraser) {

					_brushSize=e.value;
					BrushTool(canvas.activeTool).size=_brushSize;

				} else if (canvas.activeTool == _line) {
					LineTool(canvas.activeTool).lineWidth=e.value;
				} else if (canvas.activeTool == _shape) {
					ShapeTool(canvas.activeTool).strokeWidth=e.value;
				} else if (canvas.activeTool is TextTool) {

					_fontSize=slider_mc.value;

					fmt=TextTool(canvas.activeTool).textSettings.textFormat;
					fmt.size=slider_mc.value;

					TextTool(canvas.activeTool).textSettings.textFormat=fmt;

					if (_objectManager.areObjectsSelected()) {

						font=Font(combo_list.selectedItem.data);
						fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
						ts=new TextSettings(font,fmt);

						_objectManager.changeSettingsForSelectedObjects(ts);
					}

				} else if (canvas.activeTool == _selectionTool) {

					_fontSize=slider_mc.value;

					font=Font(combo_list.selectedItem.data);
					fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
					ts=new TextSettings(font,fmt);

					// update text tool
					_textTool.textSettings=ts;

					if (_objectManager.areObjectsSelected()) {
						_objectManager.changeSettingsForSelectedObjects(ts);
					}

				}

			} else if (e.currentTarget == slider_2_mc) {

				if (canvas.activeTool is BrushTool) {

					_fillAlpha=e.value;
					BrushTool(canvas.activeTool).alpha=e.value;

				} else if (canvas.activeTool is LineTool) {

					_strokeAlpha=e.value;
					LineTool(canvas.activeTool).alpha=e.value;

				} else if (canvas.activeTool is ShapeTool) {

					_strokeAlpha=e.value;
					ShapeTool(canvas.activeTool).strokeAlpha=e.value;

				}

			} else if (e.currentTarget == slider_3_mc) {

				if (canvas.activeTool is BrushTool) {

					_brushBlur=e.value;
					BrushTool(canvas.activeTool).blur=e.value;

				} else if (canvas.activeTool is ShapeTool) {
					_fillAlpha=e.value;
					ShapeTool(canvas.activeTool).fillAlpha=e.value;
				}

			}


		}

		/**************************************************************************
		Method: setActiveTool()
		
		Purpose: This method sets the program to use a new tool.
		
		Params: toolButton -- One of the Tool Buttons.
		***************************************************************************/
		private function setActiveTool(toolButton:ItemButton):void {

			// deselect all button to start
			brush_tool_mc.selected=false;
			eraser_tool_mc.selected=false;
			line_tool_mc.selected=false;
			rectangle_tool_mc.selected=false;
			oval_tool_mc.selected=false;
			selection_tool_mc.selected=false;
			fillbucket_tool_mc.selected=false;
			text_tool_mc.selected=false;

			// show combo box
			combo_label_txt.visible=true;
			combo_list.visible=true;
			combo_list.x=_orginalComboBoxItemsPos.comboBox.x;
			combo_list.y=_orginalComboBoxItemsPos.comboBox.y;

			combo_label_txt.x=_orginalComboBoxItemsPos.comboBoxLabel.x;
			combo_label_txt.y=_orginalComboBoxItemsPos.comboBoxLabel.y;

			// set slider
			slider_mc.minimum=2;
			slider_mc.maximum=40;

			// enable all slider ui
			slider_mc.visible=true;
			slider_label_txt.visible=true;
			slider_2_label_txt.visible=true;
			slider_2_mc.visible=true;
			slider_3_label_txt.visible=true;
			slider_3_mc.visible=true;
			slider_2_label_txt.alpha=1;

			// make sure both color pickers are enabled at this point.
			// let each tool block decide to turn them off.
			fill_color_mc.enabled=true;
			stroke_color_mc.enabled=true;

			// brush tool selected
			if (toolButton==brush_tool_mc) {

				// set selected tool state
				brush_tool_mc.selected=true;

				// config color pickers
				stroke_color_mc.enabled=false;

				// set brush shape list
				combo_label_txt.text="画笔形状";
				combo_list.dataProvider=_brushShapes;
				combo_list.selectedIndex=_brushShapeIndex;

				// config and set brush tool as active tool
				_brush.color=fill_color_mc.selectedColor;
				_brush.alpha=_fillAlpha;
				_brush.blur=_brushBlur;
				_brush.size=_brushSize;
				_brush.type=combo_list.selectedItem.data;
				canvas.activeTool=_brush;

				// update slider
				slider_label_txt.text="画笔大小";
				slider_mc.value=_brush.size;

				slider_2_label_txt.text="透明度";
				slider_2_label_txt.alpha=1;
				slider_2_mc.enabled=true;
				slider_2_mc.snapInterval=.1;
				slider_2_mc.value=_brush.alpha;

				slider_3_label_txt.text="画笔模糊";
				slider_3_label_txt.visible=true;
				slider_3_label_txt.alpha=1;
				slider_3_mc.visible=true;
				slider_3_mc.snapInterval=1;
				slider_3_mc.enabled=true;
				slider_3_mc.minimum=0;
				slider_3_mc.maximum=20;
				slider_3_mc.value=_brush.blur;

				// eraser tool selected
			} else if (toolButton == eraser_tool_mc) {

				// set selected tool state
				eraser_tool_mc.selected=true;

				// config color picker
				fill_color_mc.enabled=false;
				stroke_color_mc.enabled=false;

				// set brush shape list
				combo_label_txt.text="画笔形状";
				combo_list.dataProvider=_brushShapes;
				combo_list.selectedIndex=_brushShapeIndex;

				// config and set eraser tool as active tool
				_eraser.color=fill_color_mc.selectedColor;
				_brush.alpha=1;
				_brush.blur=_brushBlur;
				_eraser.size=_brushSize;
				_eraser.type=combo_list.selectedItem.data;
				canvas.activeTool=_eraser;

				// update slider
				slider_label_txt.text="画笔大小";
				slider_mc.value=_eraser.size;

				slider_2_label_txt.text="透明度";
				slider_2_label_txt.alpha=.5;
				slider_2_mc.enabled=false;
				slider_2_mc.snapInterval=.1;
				slider_2_mc.value=_eraser.alpha;

				slider_3_label_txt.text="画笔模糊";
				slider_3_label_txt.visible=true;

				slider_3_label_txt.alpha=.5;
				slider_3_mc.visible=true;
				slider_3_mc.minimum=0;
				slider_3_mc.maximum=20;
				slider_3_mc.enabled=false;
				slider_3_mc.value=_eraser.blur;

				// line tool
			} else if (toolButton == line_tool_mc) {

				// set selected tool state
				line_tool_mc.selected=true;

				// config color picker
				fill_color_mc.enabled=false;

				// set line style list
				combo_label_txt.text="线条形状";
				combo_list.dataProvider=_lineStyles;
				combo_list.selectedIndex=_lineStyleIndex;

				combo_label_txt.x=slider_3_label_txt.x+8;
				combo_list.x=slider_3_mc.x;

				// config and set line tool as active tool
				_line.color=stroke_color_mc.selectedColor;
				_line.alpha=_strokeAlpha;
				_line.type=combo_list.selectedItem.data;
				canvas.activeTool=_line;

				// update slider
				slider_label_txt.text="笔触大小";
				slider_mc.value=_line.lineWidth;

				slider_2_label_txt.text="透明度";
				slider_2_mc.enabled=true;
				slider_2_mc.snapInterval=.1;
				slider_2_mc.value=_line.alpha;

				slider_3_label_txt.visible=false;
				slider_3_mc.visible=false;

				// rectangle tool
			} else if (toolButton == rectangle_tool_mc) {

				// set selected tool state
				rectangle_tool_mc.selected=true;

				// config and set shape tool as active tool
				_shape.strokeColor=stroke_color_mc.selectedColor;
				_shape.fillColor=fill_color_mc.selectedColor;
				_shape.strokeAlpha=_strokeAlpha;
				_shape.fillAlpha=_fillAlpha;
				_shape.type=ShapeType.RECTANGLE;
				canvas.activeTool=_shape;

				// set slide value
				slider_label_txt.text="笔触大小";
				slider_mc.value=_shape.strokeWidth;

				slider_2_label_txt.text="笔触透明度";
				slider_2_label_txt.alpha=1;
				slider_2_mc.enabled=true;
				slider_2_mc.snapInterval=.1;
				slider_2_mc.value=_shape.strokeAlpha;

				slider_3_label_txt.text="填充透明度";
				slider_3_label_txt.visible=true;
				slider_3_label_txt.alpha=1;
				slider_3_mc.visible=true;
				slider_3_mc.enabled=true;
				slider_3_mc.minimum=0;
				slider_3_mc.maximum=1;
				slider_3_mc.snapInterval=.1;
				slider_3_mc.value=_shape.fillAlpha;

				// hide combo box
				combo_label_txt.visible=false;
				combo_list.visible=false;

				// oval tool
			} else if (toolButton == oval_tool_mc) {

				// set selected tool state
				oval_tool_mc.selected=true;

				// config and set shape tool as active tool
				_shape.strokeColor=stroke_color_mc.selectedColor;
				_shape.fillColor=fill_color_mc.selectedColor;
				_shape.strokeAlpha=_strokeAlpha;
				_shape.fillAlpha=_fillAlpha;
				_shape.type=ShapeType.OVAL;
				canvas.activeTool=_shape;

				// update slider
				slider_label_txt.text="笔触大小";
				slider_mc.value=_shape.strokeWidth;

				slider_2_label_txt.text="笔触透明度";
				slider_2_label_txt.alpha=1;
				slider_2_mc.enabled=true;
				slider_2_mc.snapInterval=.1;
				slider_2_mc.value=_shape.strokeAlpha;

				slider_3_label_txt.text="填充透明度";
				slider_3_label_txt.visible=true;
				slider_3_label_txt.alpha=1;
				slider_3_mc.visible=true;
				slider_3_mc.enabled=true;
				slider_3_mc.minimum=0;
				slider_3_mc.maximum=1;
				slider_3_mc.snapInterval=.1;
				slider_3_mc.value=_shape.fillAlpha;

				// hide combo box
				combo_label_txt.visible=false;
				combo_list.visible=false;

				// text tool selected
			} else if (toolButton == text_tool_mc || toolButton == selection_tool_mc) {

				// disable stroke color picker
				stroke_color_mc.enabled=false;

				// ui for text
				slider_label_txt.text="文字大小";

				// set font style list
				combo_label_txt.text="字体";
				combo_list.dataProvider=_fontList;
				combo_list.selectedIndex=_fontIndex;

				// turn off ui not needed for text tool
				slider_2_label_txt.visible=false;
				slider_2_mc.visible=false;
				slider_3_label_txt.visible=false;
				slider_3_mc.visible=false;

				combo_label_txt.x=slider_2_label_txt.x+8;
				combo_list.x=slider_2_mc.x;

				slider_mc.minimum=10;
				slider_mc.maximum=44;
				slider_mc.value=Number(_textTool.textSettings.textFormat.size);

				if (toolButton==selection_tool_mc) {

					selection_tool_mc.selected=true;

					// set active tool
					canvas.activeTool=_selectionTool;

				} else {

					text_tool_mc.selected=true;

					var font:Font=Font(combo_list.selectedItem.data);

					var fmt:TextFormat = new TextFormat();
					fmt.size=slider_mc.value;
					fmt.color=fill_color_mc.selectedColor;

					_textTool.textSettings=new TextSettings(font,fmt);

					// set active tool
					canvas.activeTool=_textTool;

				}

				// fill bucket tool selected
			} else if (toolButton == fillbucket_tool_mc) {

				// turn off ui not needed for fill bucket tool
				slider_mc.visible=false;
				slider_label_txt.visible=false;
				slider_2_label_txt.visible=false;
				slider_2_mc.visible=false;
				slider_3_label_txt.visible=false;
				slider_3_mc.visible=false;
				combo_label_txt.visible=false;
				combo_list.visible=false;

				// turn off stroke color picker
				this.stroke_color_mc.enabled=false;

				this._fillBucketTool.fillColor=fill_color_mc.selectedColor;
				fillbucket_tool_mc.selected=true;

				// set active tool
				canvas.activeTool=_fillBucketTool;

			}

		}

		/**************************************************************************
		Method: toolHandler()
		
		Purpose: This method will handle switching between brush and eraser
		  tools.  The two tool buttons call this method on click.
		
		Params: e -- Mouse Event object.
		***************************************************************************/
		private function toolHandler(e:MouseEvent):void {

			setActiveTool(ItemButton(e.currentTarget));

		}

		/**************************************************************************
		Method: comboEventHandler()
		
		Purpose: This method will handle the button events for the different
		  Combo box in the UI.
		
		Params: e -- Mouse Event object.
		***************************************************************************/
		private function comboEventHandler(e:Event):void {

			var font:Font;
			var fmt:TextFormat;
			var ts:TextSettings;

			if (canvas.activeTool is BrushTool) {

				// store brush shape index
				_brushShapeIndex=ComboBox(e.currentTarget).selectedIndex;
				setSelectedBrushShape(ComboBox(e.currentTarget).selectedItem.data);

			} else if (canvas.activeTool is LineTool) {

				// store line style index
				_lineStyleIndex=ComboBox(e.currentTarget).selectedIndex;
				setSelectedLineStyle(ComboBox(e.currentTarget).selectedItem.data);

			} else if (canvas.activeTool is TextTool) {

				// update font for text tool
				font=Font(combo_list.selectedItem.data);
				TextTool(canvas.activeTool).textSettings.font=font;

				// update font index
				_fontIndex=combo_list.selectedIndex;

				// update font for any selected text
				if (_objectManager.areObjectsSelected()) {

					fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
					ts=new TextSettings(font,fmt);

					_objectManager.changeSettingsForSelectedObjects(ts);
				}

			} else if (canvas.activeTool is SelectionTool) {

				font=Font(combo_list.selectedItem.data);
				fmt=new TextFormat(null,slider_mc.value,fill_color_mc.selectedColor);
				ts=new TextSettings(font,fmt);

				// update font index
				_fontIndex=combo_list.selectedIndex;

				// update text tool
				_textTool.textSettings=ts;

				// update font for any selected text
				if (_objectManager.areObjectsSelected()) {
					_objectManager.changeSettingsForSelectedObjects(ts);
				}

			}

		}

		/**************************************************************************
		Method: setSelectedLineStyle()
		
		Purpose: This method will update the active line with a new line
		  type.
		
		Params: localType -- Type of Line.
		***************************************************************************/
		private function setSelectedLineStyle(localType:String):void {

			// update the Brush object if different type
			if (BitmapTool(canvas.activeTool).type!=localType) {
				BitmapTool(canvas.activeTool).type=localType;
			}

		}


		/**************************************************************************
		Method: setSelectedBrushShape()
		
		Purpose: This method will update the active brush with a new brush
		  type.
		
		Params: localType -- Type of Brush.
		***************************************************************************/
		private function setSelectedBrushShape(localType:String):void {

			// update the Brush object if different type
			if (BitmapTool(canvas.activeTool).type!=localType) {
				BitmapTool(canvas.activeTool).type=localType;
			}

		}

		/**************************************************************************
		Method: scrollHandler()
		
		Purpose: This method handles the event from the mouse scroll wheel.
		
		Params: e -- MouseEvent object
		***************************************************************************/
		public function scrollHandler(e:MouseEvent):void {

			// calculate and set zoom of canvas
			canvas.zoom += (e.delta/3) * 1;

			// sync slider to new zoom value.
			zoom_slider_mc.value=canvas.zoom;

			// if canvas is zoomed in then display message about dragging canvas around.
			if (canvas.zoom>1) {
				click_message_txt.alpha=1;
			} else {
				click_message_txt.alpha=0;
			}

		}

		/**************************************************************************
		Method: keyHandler()
		
		Purpose: This method handle the keyboard shortcut to drag allow
		  the user to drag the canvas with their mouse.
		
		Params: e -- KeyboardEvent object
		***************************************************************************/
		public function keyHandler(e:KeyboardEvent):void {

			if (e.keyCode==Keyboard.SPACE) {

				if (e.type==KeyboardEvent.KEY_UP) {
					canvas.mouseDrag=false;
				} else if (e.type == KeyboardEvent.KEY_DOWN) {
					canvas.mouseDrag=true;
				}

			}

		}


	}

}