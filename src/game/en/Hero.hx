package en;

class Hero extends Entity{
    public var speed: Float = 0.1;

    var ca : ControllerAccess<GameAction>;


    public function new(x,y){
        super(x,y);

        playerFlag = true;
        //default rendering for the character
        var g = new h2d.Graphics(spr);
        g.beginFill(0xff0000);
        g.drawRect(0,0,16,16);

        ca = App.ME.controller.createAccess();
        ca.lockCondition = Game.isGameControllerLocked;

        initLife(100);
        damage = 10;

    }

    override function dispose() {
        super.dispose();
        ca.dispose();
    }

    override function preUpdate() {
        super.preUpdate();


        if(ca.getAnalogDist2(MoveLeft,MoveRight) > 0){
            speed = ca.getAnalogValue2(MoveLeft,MoveRight);
        }
    }

    override function fixedUpdate() {
        super.fixedUpdate();

        vBase.dx *= 0.9;

        if(speed!=0){
            vBase.dx += speed * 0.045;
        }
    }
    
}