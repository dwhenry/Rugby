// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function clear_other(elem) {
  $A(elem.up('.name').children).each (function(e) {
    if(e.tagName == 'INPUT' && e != elem)
      e.value = '';
  });
}
