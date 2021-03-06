tinyMCE.init({ mode : "none", theme : "advanced",
  content_css: "/css/wysiwyg.css",
	theme_advanced_blockformats : "p,h1,h2,h3,blockquote",
  theme_advanced_toolbar_location : "top",
  theme_advanced_buttons1: [
    'cut,copy,paste','undo,redo','formatselect,bold,italic,underline',
    'justifyleft,justifycenter,justifyright,justifyfull',
    'bullist,numlist','outdent,indent',
    'link,unlink,image'
    ].join(',|,'),
  theme_advanced_buttons2: '',
  theme_advanced_buttons3: '',
  relative_urls: false
}); 
$(document).ready( function() {
  var wysiwyg = function() {
    var el;
    if ( $(this).val() == 'wysiwyg' ) {
      tinyMCE.execCommand('mceAddControl',false,'wysiwyg');      
    } else if ( el = tinyMCE.getInstanceById('wysiwyg') ) {
      tinyMCE.execCommand('mceRemoveControl',false,'wysiwyg');
      $('#wysiwyg_container').hide();
    }
  };
  $('#story-format select').each( wysiwyg );
  $('#story-format select').change( wysiwyg );
});


