package;

import flixel.*;

class PlayState extends FlxState
{
    private var player:Player;
    private var court:FlxSprite;

	override public function create():Void
	{
        bgColor = 0xFF40A14C;
        player = new Player(20, 20);
        court = new FlxSprite(0, 0);
        court.loadGraphic('assets/images/court.png');
        court.screenCenter();
        add(court);
        add(player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
