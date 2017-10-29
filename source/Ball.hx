package;

import flixel.*;
import flixel.util.*;

class Ball extends FlxSprite
{
    public static inline var SPEED = 200;
    public static inline var GRAVITY = 0.6;
    public static inline var AIR_DRAG = 0.998;
    public static inline var GROUND_DRAG = 0.99;
    public static inline var BOUNCE_DRAG = 0.9;
    public static inline var MAX_UPLIFT = 10;

    public var uplift:Float;

    private var ball:FlxSprite;
    private var altitude:Float;

    public function new(x:Int, y:Int)
    {
        super(x, y);
        loadGraphic('assets/images/shadow.png');
        ball = new FlxSprite(x, y);
        ball.loadGraphic('assets/images/ball.png');
        altitude = 100;
        velocity.set(SPEED, SPEED);
        uplift = 0;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        movement();
    }

    private function movement()
    {
        // Bounce against sides
        if(x < 0) {
            x = 0;
            velocity.x = -velocity.x;
        }
        else if(x > FlxG.width - width) {
            x = FlxG.width - width;
            velocity.x = -velocity.x;
        }
        if(y < 0) {
            y = 0;
            velocity.y = -velocity.y;
        }
        else if(y > FlxG.height - height) {
            y = FlxG.height - height;
            velocity.y = -velocity.y;
        }

        // Apply gravity & drag
        uplift -= GRAVITY;
        altitude += uplift;
        if(altitude <= 0) {
            altitude = 0;
            uplift = -uplift * BOUNCE_DRAG;
            velocity.scale(GROUND_DRAG);
        }
        else {
            velocity.scale(AIR_DRAG);
        }

        if(velocity.toVector().length < 1) {
            velocity.set(0, 0);
        }

        // Set position of ball relative to shadow
        ball.x = x;
        ball.y = y - altitude;
    }

    public function getBall() {
        return ball;
    }
}
