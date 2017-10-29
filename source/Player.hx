package;

import flixel.*;
import flixel.util.*;

class Player extends FlxSprite
{
    public static inline var SPEED = 350;
    public static inline var HIT_TIME = 0.1;
    public static inline var HIT_COOLDOWN = 0.7;

    private var racket:FlxSprite;
    private var hitting:FlxTimer;
    private var hitCooldown:FlxTimer;

    public function new(x:Int, y:Int)
    {
        super(x, y);
        makeGraphic(32, 64, FlxColor.WHITE);
        racket = new FlxSprite(0, 0);
        racket.makeGraphic(
            Std.int(width * 3), Std.int(height * 3), FlxColor.RED
        );
        hitting = new FlxTimer();
        hitCooldown = new FlxTimer();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        movement();
        if(!hitCooldown.active) {
            if(Controls.checkJustPressed('shoot')) {
                hitting.start(HIT_TIME);
                hitCooldown.start(HIT_COOLDOWN);
            }
        }
        racket.visible = hitCooldown.active;
        racket.alpha = hitCooldown.timeLeft / hitCooldown.time;
    }

    private function movement()
    {
        if(Controls.checkPressed('up')) {
            velocity.y = -SPEED;
        }
        else if(Controls.checkPressed('down')) {
            velocity.y = SPEED;
        }
        else {
            velocity.y = 0;
        }

        if(Controls.checkPressed('left')) {
            velocity.x = -SPEED;
        }
        else if(Controls.checkPressed('right')) {
            velocity.x = SPEED;
        }
        else {
            velocity.x = 0;
        }

        if(velocity.x != 0 && velocity.y != 0) {
            velocity.scale(0.707106781);
        }

        racket.x = x;
        racket.y = y - height;
    }

    public function getRacket() {
        return racket;
    }

}
