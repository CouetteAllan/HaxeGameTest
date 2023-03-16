package props;

class Props{
    // Various getters to access all important stuff easily
    public var app(get,never) : App; inline function get_app() return App.ME;
    public var game(get, never) : Game; inline function get_game() return Game.ME;
    public var fx(get, never) : Fx; inline function get_fx() return Game.ME.fx;
    public var level(get, never) : Level; inline function get_level() return Game.ME.level;
    public var destroyed(default, null) = false;
    public var ftime(get,never) : Float; inline function get_ftime() return game.ftime;
	public var camera(get,never) : Camera; inline function get_camera() return game.camera;


	/** State machine. Value should only be changed using `startState(v)` **/
    public var state(default,null) : State;

    /** Grid X coordinate **/
    public var cx = 0;
	/** Grid Y coordinate **/
    public var cy = 0;
	/** Sub-grid X coordinate (from 0.0 to 1.0) **/
    public var xr = 0.5;
	/** Sub-grid Y coordinate (from 0.0 to 1.0) **/
    public var yr = 1.0;

    
}