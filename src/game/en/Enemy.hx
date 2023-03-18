package en;

class Enemy extends Entity{
    public var walkSpeed:Float;
    

    public function new(x : Int,y : Int) {
        super(x,y);


    }

    override function onDamage(dmg:Int, from:Entity) {
        super.onDamage(dmg, from);
        //Do some graph effects and feedback
        setSquashY(0.5);
    }
}