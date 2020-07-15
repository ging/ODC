/**
 * @license Copyright (c) 2003-2019, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */


CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	config.uiColor = '#ffffff';
    config.mathJaxClass = 'math-tex';
    config.mathJaxLib = 'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_HTML';    
	config.toolbar = 'Basic';
	config.toolbar_Basic =
	[
		{ name: 'styles', items : [  'Styles', 'Format','FontSize' ] },
		{ name: 'colors', items : [ 'TextColor','BGColor' ] },
		{ name: 'snddocument', items : [ 'Source','-' ] },
		{ name: 'clipboard', items : [ 'Undo','Redo' ] },
		{ name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
		{ name: 'tools', items : [ 'Maximize' ] },
		'/',
		{ name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
		{ name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent',
		'-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' /*,'-','BidiLtr','BidiRtl' */] },
		{ name: 'links', items : [ 'Link','Unlink','-'] },
	];
	config.removePlugins = 'elementspath,resize,iframe,image' ;
	config.extraPlugins = 'autogrow,widget,widgetselection,clipboard,lineutils';
	config.extraAllowedContent = 'iframe[*]';
	config.autoGrow_onStartup = true;
	config.autoGrow_minHeight = 20;
	config.toolbarCanCollapse = true;

	// config.autoGrow_maxHeight = 600;
	// config.autoGrow_bottomSpace = 50;
	config.language = window.lang;
	config.allowedContent = true
	// config.colorButton_colors = 'primary,secondary,info,warning,danger';
	// config.colorButton_foreStyle = {
	// 	element: 'span',
	// 	attributes: { 'style': 'var(--#(color))' }
	// };
	config.toolbarCanCollapse = false;
	config.contentsCss = "/assets/application.css";

};

CKEDITOR.addCss(`#cke_bottom_detail,.cke_bottom{display:none}`);
CKEDITOR.addCss(`.cke_combo_button{border: 1px solid white !important;}`);
CKEDITOR.addCss(`.cke_editable video,.cke_editable iframe{max-width: 100%;}`);
CKEDITOR.addCss(`.cke_editable img{ max-width: 100%; height: auto !important;}`);
CKEDITOR.addCss(`.cke_editable * { outline: none !important; }`);
CKEDITOR.addCss(`body { padding: 12px; color: black; }`);
CKEDITOR.addCss(`.cke_reset_all { color: black; }`);
