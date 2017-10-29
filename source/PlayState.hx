package;

import flixel.*;

class PlayState extends FlxState
{
    private var player1:Player;
    private var player2:Player;
    private var ball:Ball;
    private var court:FlxSprite;

	override public function create():Void
	{
        bgColor = 0xFF40A14C;
        player1 = new Player(
            Std.int(FlxG.width/4), Std.int(FlxG.height/2), false
        );
        player2 = new Player(
            Std.int(FlxG.width/4 * 3), Std.int(FlxG.height/2), true
        );
        ball = new Ball(100, 100);
        court = new FlxSprite(0, 0);
        court.loadGraphic('assets/images/court.png');
        court.screenCenter();
        add(court);
        add(ball);
        add(ball.getBall());
        add(player1.getRacket());
        add(player1);
        add(player2.getRacket());
        add(player2);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
        Controls.controller1 = FlxG.gamepads.getByID(0);
        Controls.controller2 = FlxG.gamepads.getByID(1);
		super.update(elapsed);
        FlxG.overlap(ball, player1.getRacket(), player1HitBall);
        FlxG.overlap(ball, player2.getRacket(), player2HitBall);
	}

    public function player1HitBall(_:FlxObject, _:FlxObject) {
        hitBall(false);
    }

    public function player2HitBall(_:FlxObject, _:FlxObject) {
        hitBall(true);
    }

    public function hitBall(isPlayer2:Bool) {
        var player:Player;
        if(isPlayer2) {
            player = player2;
        }
        else {
            player = player1;
        }

        if(!player.isHitting()) {
            return;
        }

        ball.velocity.x = Player.HIT_POWER;
        if(isPlayer2) {
            ball.velocity.x *= -1;
        }
        ball.velocity.y *= -1;
        ball.velocity.y += player.velocity.y/2;
        ball.uplift = Math.abs(ball.uplift) + Player.HIT_UPLIFT;
        ball.uplift = Math.min(ball.uplift, Ball.MAX_UPLIFT);
        player.stopHitting();
    }
}
