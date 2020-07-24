var dayArray = window.dayArray || [];
var monthArray = window.monthArray || [];
var selectedDates = window.selectedDates || [];
var newTopicTemplate = window.newTopicTemplate || '';
var newTeacherTemplate = window.newTeacherTemplate || '';
var newLessonTemplate = window.newLessonTemplate || '';
var calendarI18n = window.calendarI18n || {};
$(function() {


  /****************************************** TIMEZONE*******************************************/
  
  var offset = (new Date()).getTimezoneOffset()
  var date = new Date();
  date.setTime(date.getTime()+24*3600000);
  document.cookie = "utc_offset="+offset+"; expires="+date.toGMTString();+"; path=/";

  /****************************************** TIMEZONE*******************************************/
  



  /******************************************* SEARCH *******************************************/
  if (!String.prototype.trim) {
    (function() {
      var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
      String.prototype.trim = function() {
        return this.replace(rtrim, '');
      };
    })();
  }
  [].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
    if( inputEl.value.trim() !== '' ) {
      inputEl.classList.add('input--filled')
    }
    inputEl.addEventListener( 'focus', onInputFocus );
    inputEl.addEventListener( 'blur', onInputBlur );
  });

  function onInputFocus( ev ) {
    ev.target.parentNode.classList.add('input--filled')
  }
  function onInputBlur( ev ) {
    if( ev.target.value.trim() === '' ) {
      ev.target.parentNode.classList.remove('input--filled')
    }
  }
  /******************************************* SEARCH *******************************************/




  /******************************************** DATE ********************************************/

  var updateDate = (date) => {
    date.setHours(0,0,0,0)
    filterTurnos(getDashDate(date));
    if ($(".event-calendar:not(.hidden)").length){
      $('.no-events').addClass("hidden");
    } else {
      $('.no-events').removeClass("hidden");
    }
  }
 
  var getDashDate = function(currentDate) {
    return ("0"+(currentDate.getDate())).slice(-2) + "-" + ("0"+(currentDate.getMonth()+1)).slice(-2)  + "-" + currentDate.getFullYear();
  }
  var filterTurnos = (date) => {
    const events = $(".event-calendar");
    events.addClass("hidden");
    events.each((index, event) => {
      const $event = $(event);
      if ($event.data("date") === date) {
        $event.removeClass("hidden");
      }
    });
  };

  if ($("#calendar").length) {
    $.datepicker.setDefaults({
      "firstDay": 1,
      "dayNamesMin": dayArray.map(a=>a.slice(0,1)),
      "monthNames": monthArray,
      "monthNamesShort": monthArray.map(a=>a.slice(0,3)),
      "dayNamesShort": dayArray.map(a=>a.slice(0,3)),
      "showOtherMonths": true,
      "selectOtherMonths": true,
      "dayNames": dayArray,
      "isRTL": false,
      "showMonthAfterYear": false,
      "yearSuffix": "",
      "dateFormat": "dd/mm/yy",
      "closeText": "Cerrar",
      "prevText": "",
      "nextText": "",
      "currentText": "Actual"
    });

    $.datepicker.setDefaults($.datepicker.regional.es);

    $("#calendar").datepicker({
      "onSelect" () {
        const date = $("#calendar").datepicker("getDate");
        updateDate(date);
      },
      "beforeShowDay" (date) {
        if ($.inArray(date.getTime(), selectedDates) !== -1) {
          return [ true, "turn-day-highlight", "Tienes eventos este día"];
        }
        return [ true, "", ""];
      }
    });
    const date = $("#calendar").datepicker("getDate");
    updateDate(date);

  }
  /******************************************** DATE ********************************************/




  
  /**************************************** DATE-PICKER *****************************************/

  $(".ui-corner-all").mouseover(function() {
    $(".ui-corner-all").removeClass("ui-state-hover");
    $(".ui-corner-all").removeClass("ui-datepicker-next-hover");
    $(".ui-corner-all").removeClass("ui-datepicker-prev-hover");
  });

  $('#course-date, #course-enrollment-date').daterangepicker({
    "opens": "left",
    "autoUpdateInput": false,
    "locale": {
      "format": "DD/MM/YYYY",
      "separator": " - ",
      "applyLabel": calendarI18n.apply,
      "cancelLabel": calendarI18n.cancel,
      "fromLabel": calendarI18n.from,
      "toLabel": calendarI18n.to,
      "customRangeLabel": calendarI18n.custom,
      "weekLabel": "W",
      "daysOfWeek": dayArray.map(a=>a.slice(0,1)),
      "monthNames": monthArray,
      "firstDay": 1
    }
  }, function(start, end, label) {});

  $('#webinar-date, #webinar-enrollment-date').daterangepicker({
    "opens": "left",
    "autoUpdateInput": false,
    "timePicker": true,
    "timePicker24Hour": true,
    "locale": {
      "format": "DD/MM/YYYY HH:mm",
      "separator": " - ",
      "applyLabel": calendarI18n.apply,
      "cancelLabel": calendarI18n.cancel,
      "fromLabel": calendarI18n.from,
      "toLabel": calendarI18n.to,
      "customRangeLabel": calendarI18n.custom,
      "weekLabel": "W",
      "daysOfWeek": dayArray.map(a=>a.slice(0,1)),
      "monthNames": monthArray,
      "firstDay": 1
    }
  }, function(start, end, label) {});

  $('#course-date, #course-enrollment-date').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));
  });

  $('#webinar-date, #webinar-enrollment-date').on('apply.daterangepicker', function(ev, picker) {
    $(this).val(picker.startDate.format('DD/MM/YYYY HH:mm') + ' - ' + picker.endDate.format('DD/MM/YYYY HH:mm'));
  });

  $('#course-date, #course-enrollment-date, #webinar-date, #webinar-enrollment-date').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });

  /**************************************** DATE-PICKER *****************************************/

  
  /************************************* COURSE FORM INPUTS *************************************/

  $(document).on('click','.delete-teacher',function(){
    $(this).parent().parent().remove();
  });

  $(document).on('click','.delete-lesson',function(){
    $(this).parent().parent().remove();
  });

  $(document).on('click','.delete-topic',function(){
    $(this).parent().remove();
  });

  $( "#teacher-list" ).sortable({
    handle: '.move-teacher',
    forcePlaceholderSize:true,
    cancel: ''
  });
  $( "#teacher-list" ).disableSelection();

  const addNewTeacher = function(e, teacher = {}){
    e.stopPropagation();
    var index = Date.now();
    var newTeacher = $(newTeacherTemplate.replace(/\${index}/gim, index));
    if (teacher.avatar) { 
      newTeacher.find('.teacher-picture-container img').attr('src', teacher.avatar); 
    }
    if (teacher.avatar_file_name) { 
      newTeacher.find('.teacher-picture-container .custom-file-label').html(`<a href="${teacher.avatar}" download="data" onclick="event.stopPropagation()">${teacher.avatar_file_name}</a>`);
    }
    var fields = ["id", "name", "position", "facebook", "linkedin", "twitter", "instagram", "bio"];

    for (var f of fields) {
      newTeacher.find('input[name="course[teachers][]['+f+']"]').val(teacher[f] || "");
    }
    $('#teacher-list').append(newTeacher);
    newTeacher.find("input").first().focus();
  };

  $("#inputTeacher-search").autocomplete({
    "source": "/search_teachers",
    "minLength": 2,
    "select": function( event, ui ) {
      var alreadyAdded = false;
      if (ui.item.value === "default") {
        return false;
      }
      $('input[name="course[teachers][][id]"]').each((i,e)=>{
        if ($(e).val() == ui.item.id) {
          alreadyAdded = $(e).attr("id");
        }
      });
      if (alreadyAdded === false) {
        addNewTeacher(event, ui.item);
      } else {
        try {
          $('#'+alreadyAdded).parent().parent().find('img')[0].scrollIntoView({ behavior: 'instant', block: 'center' });
        } catch (e) {}
      }
      this.value = "";
      return false;

    }
  });

  $('#add-teacher').click(addNewTeacher);
  $('#add-lesson').click(function(e){
    e.stopPropagation();
    var index = Date.now();
    var newLesson = $(newLessonTemplate.replace(/\${index}/gim, index));
    $('.content-list-edit').append(newLesson);
    newLesson.find("input").first().focus();
  });

  $(document).on('click', '.add-topic', function(e){
    e.stopPropagation();
    var index = $(this).parent().data("contentId")
    var index2 = Date.now();
    var newTopic = $(newTopicTemplate.replace(/\${index}/gim, index).replace(/\${index1}/gim, index1));
    $(this).parent().find('.lesson-topics').append(newTopic);
    newTopic.find("input").first().focus();
  });

  if ($('#description').length) {
    CKEDITOR.editorConfig = function( config ) {
      config.removePlugins = 'elementspath,resize,iframe,image' ;
      config.extraPlugins = 'autogrow,html5video,youtube,html5audio,widget,widgetselection,clipboard,lineutils';
      config.extraAllowedContent = 'iframe[*]';
      config.autoGrow_onStartup = true;
      config.autoGrow_minHeight = 20;
      config.toolbarCanCollapse = true;
    };
    CKEDITOR.replace('description');
  }

  /************************************* COURSE FORM INPUTS *************************************/






  /*************************************** IMAGE CROPPER ****************************************/


  /**
  * Convert Base64 to Blob
  */
  function dataURItoBlob(dataURI) {
    var byteString;
    if (dataURI.split(',')[0].indexOf('base64') >= 0)
        byteString = atob(dataURI.split(',')[1]);
    else
        byteString = unescape(dataURI.split(',')[1]);

    // separate out the mime component
    var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];

    // write the bytes of the string to a typed array
    var ia = new Uint8Array(byteString.length);
    for (var i = 0; i < byteString.length; i++) {
        ia[i] = byteString.charCodeAt(i);
    }

    return new Blob([ia], {type:mimeString});
  }

  function initCropper(width = 200, height = 200, $image){
    if ($image.attr('src') !==  `https://via.placeholder.com/${width}x${height}.png/09f/fff?text=${width}x${height}`) {
      $image.cropper({
        viewMode: 2,
        dragMode: "move",
        autoCropArea: 1,
        center: true,
        aspectRatio: Math.round(100*width/height)/100,
        minContainerWidth: width - 1,
        maxContainerWidth: width,
        minContainerHeight: height - 1,
        maxContainerHeight: height,
        minCropBoxWidth: width - 1,
        maxCropBoxWidth: width,
        minCropBoxHeight: height - 1,
        maxCropBoxHeight: height,
        background: false,
        guides: false,
        crop: function(event) {}
      });
    }
  }

  var changeFile = function(e){
    var fileName = $(this).val().split("\\").pop();
    $(this).siblings(".custom-file-label").addClass("selected").html(fileName);

    if (e.target.files[0]) {
      var reader = new FileReader();
      var $input = $(this);
      var imgId = $input.data("imgId");
      var w = $input.data("w");
      var h = $input.data("h");
      reader.onload = function (ev) {
        var $image = $('#'+imgId);
        $image.attr('src', ev.target.result);
        $image.cropper('destroy')
        if ($image) initCropper(w,h, $image);
      };
      reader.readAsDataURL(e.target.files[0]);
    }
  };

  $(document).on("change", ".custom-file-input", changeFile);

  $('form').on("submit", function(){
    var form = this;
    $('.custom-file-input').each(function(i,e){
      var $input  = $(e);
      var imgId = $input.data("imgId");
      var w = $input.data("w");
      var h = $input.data("h");
      var name = $input.data("name");
      var $image = $('#'+imgId);
      if (imgId && $image.length) {
        var cropper = $image.data('cropper');
        if (cropper) {
          var canvas = $image.cropper('getCroppedCanvas');// cropper.getCroppedCanvas({width: Number(w || 120), height: Number( h || 120)});
          var canvasr = canvas.toDataURL();
          var photo = dataURItoBlob(canvasr);
          $image.parent().append($(`<input type="hidden" name="${name}" value="${canvasr}"/>`));
        } else {
          $image.parent().append($(`<input type="hidden" name="${name}" value=""/>`));
        }
      }
    });
    $('input[name="course[teachers][][order]"]').each(function(i,e){
       $(e).val(i);
    });
  });



  /*************************************** IMAGE CROPPER ****************************************/



  /***************************************** COUNTDOWN ******************************************/

  if ($('.countdown').length && window.countdown_date) {
    function pad(n, width, z) {
      z = z || '0';
      n = n + '';
      return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }
    var interval = setInterval(function(){
      var now = new Date();
      var scheduled = new Date(window.countdown_date);
      var remaining = (scheduled - now) / 1000 / 60 / 60 / 24 ;
      if (remaining < 0) {
        clearInterval(interval);
        $('.countdown .days').html("00");
        $('.countdown .hours').html("00");
        $('.countdown .minutes').html("00");
        $('.countdown .seconds').html("00");
        window.location.reload();
      } else {
        var days = remaining
        var hours = (days - Math.floor(remaining)) * 24;
        var minutes = (hours - Math.floor(hours)) * 60;
        var seconds = (minutes - Math.floor(minutes)) * 60;

        var days = Math.max(Math.floor(days),0);
        var hours = Math.max(Math.floor(hours),0);
        var minutes = Math.max(Math.floor(minutes),0);
        var seconds = Math.max(Math.floor(seconds),0);

        $('.countdown .days').html(pad(days,2));
        $('.countdown .hours').html(pad(hours,2));
        $('.countdown .minutes').html(pad(minutes,2));
        $('.countdown .seconds').html(pad(seconds,2));
      }
    }, 1000);
  }

  /***************************************** COUNTDOWN ******************************************/




  /******************************************* TAGS *********************************************/
  
$('input[data-role="tagsinput"]').tagsinput({
    "cancelConfirmKeysOnEmpty": false
});
  /******************************************* TAGS *********************************************/
  
});
