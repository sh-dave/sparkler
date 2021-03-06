package sparkler.modules.size;

import sparkler.components.LifeProgress;
import sparkler.components.Size;
import sparkler.utils.Vector2;
import sparkler.utils.Maths;
import sparkler.ParticleModule;
import sparkler.Particle;
import sparkler.modules.size.SizeOverLifetimeModule.SizeOverLifetime;

class SizeOverLifetime {

	public var start:Vector2 = new Vector2();
	public var end:Vector2 = new Vector2();
	public var ease:(v:Float)->Float;

	public function new() {}

}

@priority(90)
@group('size')
@addModules(sparkler.modules.helpers.LifeProgressModule)
class SizeOverLifetimeModule extends ParticleModule<Particle<Size, LifeProgress>> {

	public var sizeOverLifetime:SizeOverLifetime;

	function new(options:{?sizeOverLifetime:{?ease:(v:Float)->Float, start:{x:Float, y:Float}, end:{x:Float, y:Float}}}) {
		sizeOverLifetime = new SizeOverLifetime();
		if(options.sizeOverLifetime != null) {
			sizeOverLifetime.start.x = options.sizeOverLifetime.start.x;
			sizeOverLifetime.start.y = options.sizeOverLifetime.start.y;
			sizeOverLifetime.end.x = options.sizeOverLifetime.end.x;
			sizeOverLifetime.end.y = options.sizeOverLifetime.end.y;
			sizeOverLifetime.ease = options.sizeOverLifetime.ease;
		}
	}

	override function onParticleUpdate(p:Particle<Size, LifeProgress>, elapsed:Float) {
		var t = sizeOverLifetime.ease != null ? sizeOverLifetime.ease(p.lifeProgress) : p.lifeProgress;
		p.size.x = Maths.lerp(sizeOverLifetime.start.x, sizeOverLifetime.end.x, t);
		p.size.y = Maths.lerp(sizeOverLifetime.start.y, sizeOverLifetime.end.y, t);
	}

	override function onParticleSpawn(p:Particle<Size, LifeProgress>) {
		p.size.x = sizeOverLifetime.start.x;
		p.size.y = sizeOverLifetime.start.y;
	}

}