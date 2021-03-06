package ;

import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

/**
 * ...
 * @author 01101101
 */

class Text extends TextField {
	
	var tf:TextFormat;
	
	public function new (size:Int, bold:Bool, col:UInt = 0, w:Int = 800, center:Bool = true) {
		super();
		
		var font = (bold) ? Manager.FONT_BOLD : Manager.FONT;
		tf = new TextFormat(font.fontName, size, col);
		if (center)	tf.align = TextFormatAlign.CENTER;
		
		defaultTextFormat = tf;
		embedFonts = true;
		antiAliasType = AntiAliasType.ADVANCED;
		selectable = false;
		mouseEnabled = false;
		width = w;
	}
	
}
