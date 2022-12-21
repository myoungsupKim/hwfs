if (! window.TOBEHTML) {
	window.TOBEHTML = {};
}

window.TOBEHTML.FireUserNotify = function(userdata) {
	var parent = window.TOBEWEBBROWSER;
	if (parent) {
		parent.$fire_onusernotify(parent, userdata);
	} else {
		window.document.title = userdata;
	}
}
