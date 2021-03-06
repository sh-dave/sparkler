package sparkler.modules.scale;

import sparkler.utils.Maths;
import sparkler.components.Scale;
import sparkler.components.LifeProgress;
import sparkler.ParticleModule;
import sparkler.Particle;
import sparkler.modules.scale.ScaleOverLifetimeModule.ScaleOverLifetime;

class ScaleOverLifetime {

	public var start:Float = 1;
	public var end:Float = 1;
	public var ease:(v:Float)->Float;

	public function new() {}

}

@priority(100)
@group('scale')
@addModules(sparkler.modules.helpers.LifeProgressModule)
class ScaleOverLifetimeModule extends ParticleModule<Particle<Scale, LifeProgress>> {

	public var scaleOverLifetime:ScaleOverLifetime;

	function new(options:{?scaleOverLifetime:{?ease:(v:Float)->Float, start:Float, end:Float}}) {
		scaleOverLifetime = new ScaleOverLifetime();

		if(options.scaleOverLifetime != null) {
			scaleOverLifetime.start = options.scaleOverLifetime.start;
			scaleOverLifetime.end = options.scaleOverLifetime.end;
			scaleOverLifetime.ease = options.scaleOverLifetime.ease;
		}
	}

	override function onParticleUpdate(p:Particle<Scale, LifeProgress>, elapsed:Float) {
		p.scale = Maths.lerp(scaleOverLifetime.start, scaleOverLifetime.end, scaleOverLifetime.ease != null ? scaleOverLifetime.ease(p.lifeProgress) : p.lifeProgress);
	}

	override function onParticleSpawn(p:Particle<Scale, LifeProgress>) {
		p.scale = scaleOverLifetime.start;
	}
	
}