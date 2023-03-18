package en;

class Hero extends Entity{
    public var speed: Float = 0.1;

    var ca : ControllerAccess<GameAction>;
    var isDashing:Bool = false;
    var canDash:Bool = true;

    var isGrounded(get,never) : Bool;
        inline function get_isGrounded() return !destroyed && vBase.dy == 0 && yr == 1 && level.hasCollision(cx,cy+1);

    public function new(x,y){
        super(x,y);

        var start = level.data.l_Entities.all_PlayerStart[0];
         if(start != null){
                setPosCase(start.cx,start.cy);
         }

        vBase.setFricts(0.84,0.94);

        //camera tracks this
        camera.trackEntity(this,true);
        camera.clampToLevelBounds = true;

        //Init controller
        ca = App.ME.controller.createAccess();
        ca.lockCondition = Game.isGameControllerLocked;

        //graphDisplay
        var b = new h2d.Bitmap(h2d.Tile.fromColor(Blue,iwid,ihei),spr);
        b.tile.setCenterRatio(0.5,1);

        initLife(100);
        damage = 10;

    }

    override function dispose() {
        super.dispose();
        ca.dispose();
    }

    override function onPreStepX() {
        super.onPreStepX();

        //Right collision
        if(xr>0.9 && level.hasCollision(cx+1,cy))
            xr = 0.8;

        //Left collision
        if( xr < 0.2 && level.hasCollision(cx -1,cy))
            xr = 0.2;
    }

    override function onPreStepY() {
        super.onPreStepY();

        //Land on ground
        if( yr > 1 && level.hasCollision (cx,cy +1)){
            setSquashY(0.5);
            vBase.dy = 0;
            vBump.dy = 0;
            yr = 1;
            onPosManuallyChangedY();
        }

        //Ceilling collision
        if(yr < 0.1 && level.hasCollision(cx,cy -1)){
            setSquashX(0.5);
            yr = 0.2;
        }
    }

    override function preUpdate() {
        super.preUpdate();

        speed = 0;
        if(isGrounded)
            cd.setS("recentlyOnGround",0.1);

        // Jump
        if(cd.has("recentlyOnGround") && ca.isPressed(Jump)){
            vBase.dy = -0.85;
            setSquashX(0.6);
            cd.unset("recentlyOnGround");
            fx.dotsExplosionExample(centerX,centerY, 0x5cfc00);
            ca.rumble(0.05,0.06);
        }

        //Walk
        if( !isChargingAction() && ca.getAnalogDist2(MoveLeft,MoveRight)>0){
            speed = ca.getAnalogValue2(MoveLeft,MoveRight);
        }
        
        //Attack
        if(ca.isPressed(Attack)){
            attack();
        }

        //Dash
        if(ca.isPressed(Dash)){
            dash();
        }
    }

    override function fixedUpdate() {
        super.fixedUpdate();

        //Gravity
        if(!isGrounded)
            vBase.dy+=0.05;

        //Apply requested walk movement
        if(speed != 0)
            vBase.dx += speed * 0.045;
    }

    private function attack() {
        //some collision check
        //some effect
        fx.flashBangS(0x5e42f8,0.6);
        bump(speed * 0.2, -0.3);
    }

    private function dash(){
        if(!canDash || isDashing)
            return;
        canDash = false;
        isDashing = true;
        cd.setS("dash",1.0,true,onCompleteDash);

        bump(speed * 0.52,0);
        game.stopFrame();
    }

    private function onCompleteDash() : Void{
        canDash = true;
        isDashing = false;
    }
    
}


