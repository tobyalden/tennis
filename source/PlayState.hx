package;

import flixel.*;

class PlayState extends FlxState
{
    private var player:Player;
    private var ball:Ball;
    private var court:FlxSprite;

	override public function create():Void
	{
        bgColor = 0xFF40A14C;
        player = new Player(Std.int(FlxG.width/4), Std.int(FlxG.height/2));
        ball = new Ball(100, 100);
        court = new FlxSprite(0, 0);
        court.loadGraphic('assets/images/court.png');
        court.screenCenter();
        add(court);
        add(ball);
        add(ball.getBall());
        add(player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
