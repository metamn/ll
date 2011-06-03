$(function() {

	// select #flowplanes and make it scrollable. use circular and navigator plugins
	$("#flowpanes").scrollable({ circular: true, mousewheel: true }).navigator({

		// select #flowtabs to be used as navigator
		navi: "#flowtabs",

		// select A tags inside the navigator to work as items (not direct children)
		naviItem: 'a',

		// assign "current" class name for the active A tag inside navigator
		activeClass: 'current',

		// make browser's back button work
		history: true

	});
});
