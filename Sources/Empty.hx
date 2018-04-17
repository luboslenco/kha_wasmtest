package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Assets;

class Empty {

	var exports:Dynamic;	

	public function new() {
		Assets.loadEverything(done);
	}

	function done(): Void {
		var data = Assets.blobs.main_wasm.toBytes().getData();
		untyped __js__('var module = new WebAssembly.Module({0});', data);
		untyped __js__('{0} = new WebAssembly.Instance(module).exports;', exports);

		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
	}

	function update(): Void {
		
	}

	var x = 0.0;

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin();
		g2.color = 0xffff0000;
		g2.fillRect(x, 0, 100, 100);
		g2.end();

		x += exports.test() * 10;
	}
}
