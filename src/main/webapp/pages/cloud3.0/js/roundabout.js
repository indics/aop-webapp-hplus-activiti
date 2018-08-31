/*publish date:2013-01-15 16:26:13*/
jQuery.extend({
	roundabout_shape: {
		def: "lazySusan",
		lazySusan: function(d, b, c) {
			return {
				x: Math.sin(d + b),
				y: (Math.sin(d + 3 * Math.PI / 2 + b) / 8) * c,
				z: (Math.cos(d + b) + 1) / 2,
				scale: (Math.sin(d + Math.PI / 2 + b) / 2) + 0.5
			}
		}
	}
});
jQuery.fn.roundabout = function() {
	var a = (typeof arguments[0] != "object") ? {} : arguments[0];
	a = {
		bearing: (typeof a.bearing == "undefined") ? 0 : parseFloat(a.bearing % 360, 4),
		tilt: (typeof a.tilt == "undefined") ? 0 : parseFloat(a.tilt, 4),
		minZ: (typeof a.minZ == "undefined") ? 100 : parseInt(a.minZ, 10),
		maxZ: (typeof a.maxZ == "undefined") ? 400 : parseInt(a.maxZ, 10),
		minOpacity: (typeof a.minOpacity == "undefined") ? 0.4 : parseFloat(a.minOpacity, 2),
		maxOpacity: (typeof a.maxOpacity == "undefined") ? 1 : parseFloat(a.maxOpacity, 2),
		minScale: (typeof a.minScale == "undefined") ? 0.4 : parseFloat(a.minScale, 2),
		maxScale: (typeof a.maxScale == "undefined") ? 1 : parseFloat(a.maxScale, 2),
		duration: (typeof a.duration == "undefined") ? 600 : parseInt(a.duration, 10),
		btnNext: a.btnNext || null,
		btnPrev: a.btnPrev || null,
		easing: a.easing || "swing",
		clickToFocus: (a.clickToFocus !== false),
		focusBearing: (typeof a.focusBearing == "undefined") ? 0 : parseFloat(a.focusBearing % 360, 4),
		shape: a.shape || "lazySusan",
		debug: a.debug || false,
		childSelector: a.childSelector || "li",
		startingChild: (typeof a.startingChild == "undefined") ? null : parseInt(a.startingChild, 10)
	};
	this.each(function(e) {
		var f = jQuery(this);
		var c = a.childSelector;
		var d = f.children(c);
		var g = 360 / d.length;
		var b = (a.startingChild === null) ? a.bearing : a.startingChild * g;
		f.addClass("roundabout-holder").css("padding", 0).css("position", "relative").css("z-index", a.minZ).attr("bearing", b).attr("tilt", a.tilt).attr("minZ", a.minZ).attr("maxZ", a.maxZ).attr("minOpacity", a.minOpacity).attr("maxOpacity", a.maxOpacity).attr("minScale", a.minScale).attr("maxScale", a.maxScale).attr("duration", a.duration).attr("easing", a.easing).attr("clickToFocus", a.clickToFocus).attr("focusBearing", a.focusBearing).attr("animating", "0").attr("childInFocus", -1).attr("shape", a.shape).attr("period", g).attr("debug", a.debug).attr("childSelector", a.childSelector);
		d.each(function(j) {
			var k = g * j;
			var h;
			jQuery(this).addClass("roundabout-moveable-item").css("position", "absolute").attr("degrees", k);
			h = [jQuery(this).width(), jQuery(this).height(), parseInt(jQuery(this).css("font-size"), 10)];
			jQuery(this).attr("startPos", h.join(","));
			if (a.clickToFocus === true) {
				jQuery(this).click(function(i) {
					if (!jQuery.roundabout_isInFocus(f, k)) {
						i.preventDefault();
						if (f.attr("animating") == "0") {
							f.roundabout_animateAngleToFocus(k)
						}
						return false
					}
				})
			}
		});
		if (a.btnNext) {
			jQuery(a.btnNext).click(function(h) {
				h.preventDefault();
				if (f.attr("animating") == "0") {
					f.roundabout_animateToNextChild()
				}
				return false
			})
		}
		if (a.btnPrev) {
			jQuery(a.btnPrev).click(function(h) {
				h.preventDefault();
				if (f.attr("animating") == "0") {
					f.roundabout_animateToPreviousChild()
				}
				return false
			})
		}
		f.roundabout_updateChildPositions()
	});
	return this
};
jQuery.fn.roundabout_setTilt = function(a) {
	this.each(function(b) {
		jQuery(this).attr("tilt", a);
		jQuery(this).roundabout_updateChildPositions()
	});
	return this
};
jQuery.fn.roundabout_setBearing = function(a) {
	this.each(function(c) {
		jQuery(this).attr("bearing", parseFloat(a % 360, 4));
		jQuery(this).roundabout_updateChildPositions()
	});
	if (typeof arguments[1] === "function") {
		var b = arguments[1];
		setTimeout(function() {
			b()
		}, 0)
	}
	return this
};
jQuery.fn.roundabout_adjustBearing = function(a) {
	a = parseFloat(a, 4);
	if (a !== 0) {
		this.each(function(b) {
			jQuery(this).attr("bearing", jQuery.roundabout_getBearing(jQuery(this)) + a);
			jQuery(this).roundabout_updateChildPositions()
		})
	}
	return this
};
jQuery.fn.roundabout_adjustTilt = function(a) {
	a = parseFloat(a, 4);
	this.each(function(b) {
		jQuery(this).attr("tilt", parseFloat(jQuery(this).attr("tilt"), 4) + a);
		jQuery(this).roundabout_updateChildPositions()
	});
	return this
};
jQuery.fn.roundabout_animateToBearing = function(b) {
	b = parseFloat(b, 4);
	var c = new Date();
	var d = (typeof arguments[3] !== "object") ? null : arguments[3];
	var e = (typeof arguments[1] == "undefined") ? null : arguments[1];
	var a = (typeof arguments[2] != "undefined") ? arguments[2] : null;
	this.each(function(j) {
		var k = jQuery(this),
			m, l, f;
		var g = (e === null) ? parseInt(k.attr("duration"), 10) : e;
		var h = (a !== null) ? a : k.attr("easing") || "swing";
		if (d === null) {
			d = {
				timerStart: c,
				start: jQuery.roundabout_getBearing(k),
				totalTime: g
			}
		}
		m = c - d.timerStart;
		if (m < g) {
			k.attr("animating", "1");
			if (typeof jQuery.easing.def == "string") {
				l = jQuery.easing[h] || jQuery.easing[jQuery.easing.def];
				f = l(null, m, d.start, b - d.start, d.totalTime)
			} else {
				f = jQuery.easing[h]((m / d.totalTime), m, d.start, b - d.start, d.totalTime)
			}
			k.roundabout_setBearing(f, function() {
				k.roundabout_animateToBearing(b, g, h, d)
			})
		} else {
			b = (b < 0) ? b + 360 : b % 360;
			k.attr("animating", "0");
			k.roundabout_setBearing(b)
		}
	});
	return this
};
jQuery.fn.roundabout_animateToDelta = function(c) {
	var a, b;
	if (typeof arguments[1] !== "undefined") {
		a = arguments[1]
	}
	if (typeof arguments[2] !== "undefined") {
		b = arguments[2]
	}
	this.each(function(d) {
		c = jQuery.roundabout_getBearing(jQuery(this)) + c;
		jQuery(this).roundabout_animateToBearing(c, a, b)
	});
	return this
};
jQuery.fn.roundabout_animateToChild = function(a) {
	var b, c;
	if (typeof arguments[1] !== "undefined") {
		b = arguments[1]
	}
	if (typeof arguments[2] !== "undefined") {
		c = arguments[2]
	}
	this.each(function(d) {
		var e = jQuery(this);
		if (parseInt(e.attr("childInFocus"), 10) !== a && e.attr("animating", "0")) {
			var f = jQuery(e.children(e.attr("childSelector"))[a]);
			e.roundabout_animateAngleToFocus(parseFloat(f.attr("degrees"), 4), b, c)
		}
	});
	return this
};
jQuery.fn.roundabout_animateToNextChild = function() {
	var a, b;
	if (typeof arguments[0] !== "undefined") {
		a = arguments[0]
	}
	if (typeof arguments[1] !== "undefined") {
		b = arguments[1]
	}
	this.each(function(f) {
		if (jQuery(this).attr("animating", "0")) {
			var e = 360 - jQuery.roundabout_getBearing(jQuery(this));
			var g = parseFloat(jQuery(this).attr("period"), 4),
				d = 0,
				c;
			while (true) {
				c = {
					lower: g * d,
					upper: g * (d + 1)
				};
				if (e <= c.upper && e > c.lower) {
					jQuery(this).roundabout_animateToDelta(e - c.lower, a, b);
					break
				}
				d++
			}
		}
	});
	return this
};
jQuery.fn.roundabout_animateToPreviousChild = function() {
	var a, b;
	if (typeof arguments[0] !== "undefined") {
		a = arguments[0]
	}
	if (typeof arguments[1] !== "undefined") {
		b = arguments[1]
	}
	this.each(function(f) {
		if (jQuery(this).attr("animating", "0")) {
			var e = 360 - jQuery.roundabout_getBearing(jQuery(this));
			var g = parseFloat(jQuery(this).attr("period"), 4),
				d = 0,
				c;
			while (true) {
				c = {
					lower: g * d,
					upper: g * (d + 1)
				};
				if (e >= c.lower && e < c.upper) {
					jQuery(this).roundabout_animateToDelta(e - c.upper, a, b);
					break
				}
				d++
			}
		}
	});
	return this
};
jQuery.fn.roundabout_animateAngleToFocus = function(b) {
	var a, c;
	if (typeof arguments[1] !== "undefined") {
		a = arguments[1]
	}
	if (typeof arguments[2] !== "undefined") {
		c = arguments[2]
	}
	this.each(function(d) {
		var e = jQuery.roundabout_getBearing(jQuery(this)) - b;
		e = (Math.abs(360 - e) < Math.abs(0 - e)) ? 360 - e : 0 - e;
		e = (e > 180) ? -(360 - e) : e;
		if (e !== 0) {
			jQuery(this).roundabout_animateToDelta(e, a, c)
		}
	});
	return this
};
jQuery.fn.roundabout_updateChildPositions = function() {
	this.each(function(a) {
		var b = jQuery(this);
		var d = -1;
		var c = {
			bearing: jQuery.roundabout_getBearing(b),
			tilt: parseFloat(b.attr("tilt"), 4),
			stage: {
				width: Math.floor(b.width() * 0.9),
				height: Math.floor(b.height() * 0.9)
			},
			animating: b.attr("animating"),
			inFocus: parseInt(b.attr("childInFocus"), 10),
			focusBearingRad: jQuery.roundabout_degToRad(parseFloat(b.attr("focusBearing"), 4)),
			shape: jQuery.roundabout_shape[b.attr("shape")] || jQuery.roundabout_shape[jQuery.roundabout_shape.def]
		};
		c.midStage = {
			width: c.stage.width / 2,
			height: c.stage.height / 2
		};
		c.nudge = {
			width: c.midStage.width + c.stage.width * 0.05,
			height: c.midStage.height + c.stage.height * 0.05
		};
		c.zValues = {
			min: parseInt(b.attr("minZ"), 10),
			max: parseInt(b.attr("maxZ"), 10)
		};
		c.zValues.diff = c.zValues.max - c.zValues.min;
		c.opacity = {
			min: parseFloat(b.attr("minOpacity"), 2),
			max: parseFloat(b.attr("maxOpacity"), 2)
		};
		c.opacity.diff = c.opacity.max - c.opacity.min;
		c.scale = {
			min: parseFloat(b.attr("minScale"), 2),
			max: parseFloat(b.attr("maxScale"), 2)
		};
		c.scale.diff = c.scale.max - c.scale.min;
		b.children(b.attr("childSelector")).each(function(e) {
			if (jQuery.roundabout_updateChildPosition(jQuery(this), b, c, e) && c.animating == "0") {
				d = e;
				jQuery(this).addClass("roundabout-in-focus")
			} else {
				jQuery(this).removeClass("roundabout-in-focus")
			}
		});
		if (d !== c.inFocus) {
			jQuery.roundabout_triggerEvent(b, c.inFocus, "blur");
			if (d !== -1) {
				jQuery.roundabout_triggerEvent(b, d, "focus")
			}
			b.attr("childInFocus", d)
		}
	});
	return this
};
jQuery.roundabout_getBearing = function(a) {
	return parseFloat(a.attr("bearing"), 4) % 360
};
jQuery.roundabout_degToRad = function(a) {
	return (a % 360) * Math.PI / 180
};
jQuery.roundabout_isInFocus = function(a, b) {
	return (jQuery.roundabout_getBearing(a) % 360 === (b % 360))
};
jQuery.roundabout_triggerEvent = function(b, c, a) {
	return (c < 0) ? this : jQuery(b.children(b.attr("childSelector"))[c]).trigger(a)
};
jQuery.roundabout_updateChildPosition = function(c, a, g, b) {
	var d = jQuery(c),
		f = [];
	var h = d.attr("startPos").split(",");
	var e = {
		startWidth: h[0],
		startHeight: h[1],
		startFontSize: h[2],
		degrees: parseFloat(d.attr("degrees"), 4)
	};
	var j = jQuery.roundabout_degToRad((360 - e.degrees) + g.bearing);
	while (j < 0) {
		j = j + Math.PI * 2
	}
	while (j > Math.PI * 2) {
		j = j - Math.PI * 2
	}
	var i = g.shape(j, g.focusBearingRad, g.tilt);
	i.scale = (i.scale > 1) ? 1 : i.scale;
	i.adjustedScale = (g.scale.min + (g.scale.diff * i.scale)).toFixed(4);
	i.width = i.adjustedScale * e.startWidth;
	i.height = i.adjustedScale * e.startHeight;
	d.css("left", ((i.x * g.midStage.width + g.nudge.width) - i.width / 2).toFixed(2) + "px").css("top", ((i.y * g.midStage.height + g.nudge.height) - i.height / 2).toFixed(2) + "px").css("width", i.width.toFixed(2) + "px").css("height", i.height.toFixed(2) + "px").css("opacity", (g.opacity.min + (g.opacity.diff * i.scale)).toFixed(2)).css("z-index", parseInt(g.zValues.min + (g.zValues.diff * i.z), 10)).css("font-size", (i.adjustedScale * e.startFontSize).toFixed(2) + "px").attr("current-scale", i.adjustedScale);
	if (a.attr("debug") == "true") {
		f.push('<div style="font-weight: normal; font-size: 10px; padding: 2px; width: ' + d.css("width") + '; background-color: #ffc;">');
		f.push('<strong style="font-size: 12px; white-space: nowrap;">Child ' + b + "</strong><br />");
		f.push("<strong>left:</strong> " + d.css("left") + "<br /><strong>top:</strong> " + d.css("top") + "<br />");
		f.push("<strong>width:</strong> " + d.css("width") + "<br /><strong>opacity:</strong> " + d.css("opacity") + "<br />");
		f.push("<strong>z-index:</strong> " + d.css("z-index") + "<br /><strong>font-size:</strong> " + d.css("font-size") + "<br />");
		f.push("<strong>scale:</strong> " + d.attr("current-scale"));
		f.push("</div>");
		d.html(f.join(""))
	}
	return jQuery.roundabout_isInFocus(a, e.degrees)
};