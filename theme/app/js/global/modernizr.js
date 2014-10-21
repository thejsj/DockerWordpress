/*global window: false, document: false, addTest: false */

// Custom Tests
require('browsernizr/test/css/animations');
require('browsernizr/test/css/backgroundsize');
require('browsernizr/test/css/backgroundposition-xy');
require('browsernizr/test/css/fontface');
require('browsernizr/test/css/rgba');
require('browsernizr/test/css/transforms');
require('browsernizr/test/css/transforms3d');
require('browsernizr/test/css/transitions');
require('browsernizr/test/css/mediaqueries');
require('browsernizr/test/css/opacity');
require('browsernizr/test/css/gradients');
require('browsernizr/test/css/generatedcontent');

require('browsernizr/test/audio');
require('browsernizr/test/audio/webaudio');

require('browsernizr/test/es5/array');
require('browsernizr/test/es5/date');
require('browsernizr/test/es5/function');
require('browsernizr/test/es5/object');
require('browsernizr/test/es5/string');

require('browsernizr/test/event/deviceorientation-motion');

require('browsernizr/test/forms/placeholder');
require('browsernizr/test/input');
require('browsernizr/test/inputtypes');

require('browsernizr/test/svg/asimg');
require('browsernizr/test/svg');
require('browsernizr/test/url/data-uri');

require('browsernizr/test/history');
require('browsernizr/test/touchevents');
require('browsernizr/test/webanimations');
require('browsernizr/test/json');
require('browsernizr/test/video');

window.Modernizr = require('browsernizr');
module.exports = window.Modernizr;