(function ($){
  $.getUrlVars = function() {
    var vars = {};
    var regex = /[?&]+([^=&]+)=([^&]*)/gi;
    var parts = window.location.href.replace(regex, function(m, key, value) {
      vars[key] = value;
    });
    return vars;
  };
})(jQuery);
