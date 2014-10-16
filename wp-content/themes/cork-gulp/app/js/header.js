/*global window: false */
window.Modernizr   = window.Modernizr || require('./global/modernizr');

window.Log = function(color){
    return function (message) {
        console.log('%c' + message, 'color: ' + color + ';');
    };
};