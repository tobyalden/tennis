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
        add(player.getRacket());
        add(player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
        FlxG.overlap(ball, player.getRacket(), hitBall);
	}

    public function hitBall(_:FlxObject, _:FlxObject) {
        if(!player.isHitting()) {
            return;
        }
        if(!FlxG.overlap(ball.getBall(), player.getRacket())) {
            return;
        }
        ball.velocity.x = 500;
        ball.velocity.y += player.velocity.y;
        ball.uplift = Math.abs(ball.uplift) + Player.HIT_POWER;
        player.stopHitting();
    }
}
