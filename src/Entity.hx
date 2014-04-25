package;

import Entity.Dir;
import flash.display.Sprite;


/**
 * ...
 * @author 01101101
 */

class Entity {
	
	// Global grid size
	static public var GRID_SIZE:Int = 16;
	
	// Cell coords
	public var cx:Int;
	public var cy:Int;
	// Cell ratio
	public var xr:Float;
	public var yr:Float;
	// Resulting coords
	public var xx:Float;
	public var yy:Float;
	// Movements
	public var dx:Float;
	public var dy:Float;
	// Friction
	var fx:Float;
	var fy:Float;
	
	// Entity size
	public var w:Int;
	public var h:Int;
	
	// Min/max cell ratio
	public var min:Float = 0.4;
	public var max:Float = 0.6;
	
	// Entity speed
	var hSpeed:Float;
	var vSpeed:Float;
	
	var zeroThreshold:Float;// Threshold for setting dx/dy to zero
	
	// Graphics
	public var sprite:Sprite;
	
	public function new (w:Int = 1, h:Int = 1, debugDraw:Bool = true) {
		this.w = w;
		this.h = h;
		
		hSpeed = 0.025;
		vSpeed = 0.025;
		fx = fy = 0.85;
		
		dx = dy = 0;
		
		zeroThreshold = 0.001;
		
		if (debugDraw) {
			sprite = new Sprite();
			sprite.graphics.beginFill(0x99AAFF);
			sprite.graphics.drawRect(-GRID_SIZE / 2, -GRID_SIZE / 2, GRID_SIZE * w, GRID_SIZE * h);
			sprite.graphics.endFill();
			sprite.graphics.beginFill(0x7788DD);
			sprite.graphics.drawCircle(0, 0, GRID_SIZE / 4);
			sprite.graphics.endFill();
		}
	}
	
	public function setCoords (x:Float, y:Float) {
		xx = x;
		yy = y;
		cx = Std.int(xx / GRID_SIZE);
		cy = Std.int(yy / GRID_SIZE);
		xr = (xx - cx * GRID_SIZE) / GRID_SIZE;
		yr = (yy - cy * GRID_SIZE) / GRID_SIZE;
	}
	
	public function move (dir:Dir) {
		switch (dir) {
			case Dir.RIGHT:	dx += hSpeed;
			case Dir.LEFT:	dx -= hSpeed;
			case Dir.DOWN:	dy += vSpeed;
			case Dir.UP:	dy -= vSpeed;
			default:
		}
	}
	
	public function update () {
		// Apply movement X
		xr += dx;
		updateX();
		// Apply movement Y
		yr += dy;
		updateY();
		// Update graphics
		updateFinal();
	}
	
	function updateX () {
		var collided:Bool = false;
		// Adjust positions if out of the current cell
		while (xr > 1) {
			// If target cell is not free, cancel move
			if (dx > 0 && fastColl(Dir.RIGHT)) {
				xr = max;
				dx = 0;
				collided = true;
				break;
			}
			// If free, update position
			else {
				xr -= 1;
				cx++;
			}
		}
		while (xr < 0) {
			// If target cell is not free, cancel move
			if (dx < 0 && fastColl(Dir.LEFT)) {
				xr = min;
				dx = 0;
				collided = true;
				break;
			}
			// If free, update position
			else {
				xr += 1;
				cx--;
			}
		}
		// Friction
		dx *= fx;
		if (dx < 0 && dx > -zeroThreshold)	dx = 0;
		if (dx > 0 && dx < zeroThreshold)	dx = 0;
		// Collisions
		if (!collided)	collX();
	}
	
	function updateY () {
		var collided:Bool = false;
		// Adjust positions if out of the current cell
		while (yr > 1) {
			// If target cell is not free, cancel move
			if (dy > 0 && fastColl(Dir.DOWN)) {
				yr = max;
				dy = 0;
				collided = true;
				break;
			}
			// If free, update position
			else {
				yr -= 1;
				cy++;
			}
		}
		while (yr < 0) {
			// If target cell is not free, cancel move
			if (dy < 0 && fastColl(Dir.UP)) {
				yr = min;
				dy = 0;
				collided = true;
				break;
			}
			// If free, update position
			else {
				yr += 1;
				cy--;
			}
		}
		// Friction
		dy *= fy;
		if (dy < 0 && dy > -zeroThreshold)	dy = 0;
		if (dy > 0 && dy < zeroThreshold)	dy = 0;
		// Collisions
		if (!collided)	collY();
	}
	
	function updateFinal () {
		// Update final coords
		xx = Std.int((cx + xr) * GRID_SIZE);
		yy = Std.int((cy + yr) * GRID_SIZE);
		// Update graphics
		if (sprite != null) {
			sprite.x = xx;
			sprite.y = yy;
		}
	}
	
	function fastColl (dir:Dir) :Bool {
		switch (dir) {
			case Dir.UP:
				for (i in 0...w) {
					if (hasCollision(cx + i, cy - 1, this))	return true;
				}
				if (xr < min && hasCollision(cx - 1, cy - 1, this))	return true;
				if (xr > max && hasCollision(cx + w, cy - 1, this))	return true;
			case Dir.DOWN:
				for (i in 0...w) {
					if (hasCollision(cx + i, cy + h, this))	return true;
				}
				if (xr < min && hasCollision(cx - 1, cy + h, this))	return true;
				if (xr > max && hasCollision(cx + w, cy + h, this))	return true;
			case Dir.LEFT:
				for (i in 0...h) {
					if (hasCollision(cx - 1, cy + i, this))	return true;
				}
				if (yr < min && hasCollision(cx - 1, cy - 1, this))	return true;
				if (yr > max && hasCollision(cx - 1, cy + h, this))	return true;
			case Dir.RIGHT:
				for (i in 0...h) {
					if (hasCollision(cx + w, cy + i, this))	return true;
				}
				if (yr < min && hasCollision(cx + w, cy - 1, this))	return true;
				if (yr > max && hasCollision(cx + w, cy + h, this))	return true;
			default:
		}
		return false;
	}
	
	function collX () :Bool {
		// Basic collisions
		for (i in 0...h) {
			if (xr > max && hasCollision(cx + w, cy + i, this)) {
				xr = max;
				dx = 0;
				return true;
			}
			if (xr < min && hasCollision(cx - 1, cy + i, this)) {
				xr = min;
				dx = 0;
				return true;
			}
		}
		// Additional collisions
		if (yr > max && xr > max && hasCollision(cx + w, cy + h, this)) {
			xr = max;
			dx = 0;
			return true;
		} else if (yr < min && xr > max && hasCollision(cx + w, cy - 1, this)) {
			xr = max;
			dx = 0;
			return true;
		}
		if (yr > max && xr < min && hasCollision(cx - 1, cy + h, this)) {
			xr = min;
			dx = 0;
			return true;
		} else if (yr < min && xr < min && hasCollision(cx - 1, cy - 1, this)) {
			xr = min;
			dx = 0;
			return true;
		}
		return false;
	}
	
	function collY () :Bool {
		// Basic collisions
		for (i in 0...w) {
			if (yr > max && hasCollision(cx + i, cy + h, this)) {
				yr = max;
				dy = 0;
				return true;
			}
			if (yr < min && hasCollision(cx + i, cy - 1, this)) {
				yr = min;
				dy = 0;
				return true;
			}
		}
		// Additional collisions
		if (xr > max && yr > max && hasCollision(cx + w, cy + h, this)) {
			yr = max;
			dy = 0;
			return true;
		} else if (xr < min && yr > max && hasCollision(cx - 1, cy + h, this)) {
			yr = max;
			dy = 0;
			return true;
		}
		if (xr > max && yr < min && hasCollision(cx + w, cy - 1, this)) {
			yr = min;
			dy = 0;
			return true;
		} else if (xr < min && yr < min && hasCollision(cx - 1, cy - 1, this)) {
			yr = min;
			dy = 0;
			return true;
		}
		return false;
	}
	
	function hasCollision (x:Int, y:Int, e:Entity = null) {
		return true;
	}
	
}

enum Dir {
	NONE;
	UP;
	LEFT;
	DOWN;
	RIGHT;
}
