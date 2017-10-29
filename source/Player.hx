package;

import flixel.*;
import flixel.math.*;
import flixel.util.*;

class Player extends FlxSprite
{
    public static inline var SPEED = 450;
    public static inline var HIT_TIME = 0.1;
    public static inline var HIT_COOLDOWN = 0.7;
    public static inline var HIT_POWER = 700;
    public static inline var HIT_UPLIFT = 10;

    // Influence is how much the shot is pushed towards the opponent's court
    public static inline var SIDE_INFLUENCE = 500;
    public static inline var DISTANCE_INFLUENCE = 500;

    public static inline var ROLL_TIME = 0.24;
    public static inline var ROLL_COOLDOWN = 0.5;
    public static inline var ROLL_POWER = 2.5;

    private var racket:FlxSprite;
    private var hitting:FlxTimer;
    private var hitCooldown:FlxTimer;
    private var rolling:FlxTimer;
    private var rollCooldown:FlxTimer;
    private var isPlayer2:Bool;

    public function new(x:Int, y:Int, isPlayer2:Bool)
    {
        super(x, y);
        this.isPlayer2 = isPlayer2;
        makeGraphic(32, 64, FlxColor.WHITE);
        height = 32;
        offset.y = 32;
        racket = new FlxSprite(0, 0);
        var racketColor:FlxColor;
        if(isPlayer2) {
            racketColor = FlxColor.BLUE;
        }
        else {
            racketColor = FlxColor.RED;
        } racket.makeGraphic(
            Std.int(width * 3), Std.int(height * 3), racketColor
        );
        hitting = new FlxTimer();
        hitCooldown = new FlxTimer();
        rolling = new FlxTimer();
        rollCooldown = new FlxTimer();
    }

    public function roll() {
        rolling.start(ROLL_TIME);
        rollCooldown.start(ROLL_COOLDOWN);
        velocity.scale(ROLL_POWER);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        if(!rollCooldown.active) {
            if(Controls.checkJustPressed('jump', isPlayer2)) {
                roll();
            }
        }
        if(rolling.active) {
            var color = FlxColor.interpolate(
                FlxColor.PURPLE, FlxColor.WHITE, rollCooldown.progress
            );
            makeGraphic(32, 64, color);
            return;
        }
        else {
            makeGraphic(32, 64, FlxColor.WHITE);
        }

        movement();
        if(!hitCooldown.active) {
            if(Controls.checkJustPressed('shoot', isPlayer2)) {
                hitting.start(HIT_TIME);
                hitCooldown.start(HIT_COOLDOWN);
            }
        }
        if(isPlayer2) {
            racket.x = x - width * 2;
        }
        else {
            racket.x = x;
        }
        racket.y = y - height;
        racket.visible = hitCooldown.active;
        racket.alpha = hitCooldown.timeLeft / hitCooldown.time;
    }

    private function movement()
    {
        var controller = Controls.getController(isPlayer2);
        if(controller == null) {
            return;
        }
        var input = new FlxVector(
            controller.analog.value.LEFT_STICK_X,
            controller.analog.value.LEFT_STICK_Y
        );
        if(Math.abs(input.x) < Controls.DEAD_ZONE) {
            input.x = 0;
        }
        if(Math.abs(input.y) < Controls.DEAD_ZONE) {
            input.y = 0;
        }
        input.normalize();
        input.scale(SPEED);
        velocity.set(input.x, input.y);
    }

    public function getSideFactor() {
        var centerY = y + height/2;
        var sideAmount = FlxG.height/2 - centerY;
        return sideAmount / FlxG.height * 2;
    }

    public function getDistanceFactor() {
        var centerX = x + width/2;
        var distance = FlxG.width/2 - centerX;
        return distance / FlxG.width * 2;
    }


    public function getRacket() {
        return racket;
    }

    public function isHitting() {
        return hitting.active;
    }

    public function stopHitting() {
        hitting.cancel();
    }

}
