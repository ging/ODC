console.log(2)

$(document).on('turbolinks:load', function() {
function delay(ms){
      var ctr, rej, p = new Promise(function (resolve, reject) {
          ctr = setTimeout(resolve, ms);
          rej = reject;
      });
      p.cancel = function(){ clearTimeout(ctr); rej(Error("Cancelled"))};
      return p; 
  }
  function scrollIntoViewIfNeeded(target) {
      var rect = target.getBoundingClientRect();
      if (rect.bottom > window.innerHeight) {
          target.scrollIntoView(false);
      }
      if (rect.top < 0) {
          target.scrollIntoView();
      } 
  }

  function getCourseInfo (current) {

    return `
    <div class="flexbox">
      <div class="flexbox-col">
        <h2>${current.find('.card-title').text()}</h2>
        <h3>01/02/2020 - 15/08/2020</h3>
      </div>
      <div class="flexbox-col course-author text-primary">
        Powered by Cisco
      </div>
    </div>
    <div class="badges">
      <span class="badge badge-primary">medio ambiente</span>
      <span class="badge badge-info">inclusión digital y social</span>
      <span class="badge badge-success">digitalización PYMES y autónomos</span>
      <span class="badge badge-danger">uso seguro TIC</span>
      <span class="badge badge-warning">otros</span>
    </div>
    <br/>
    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
    <p>

    <p class="align-right">
      <a href="./show.html">
        <button type="button" class="btn btn-outline-primary">Más información</button>
      </a>
      <a href="#">
        <button type="button" class="btn btn-outline-secondary">Acceder al curso</button>
      </a>
    </p><hr>`;

  }
  async function clickCard(current, resize) {
    let currentTop = current.offset().top;
    const currentId = $('.course-selected').attr("id");
    const same = currentId === current.attr("id") && !resize;
    const differentHeight = resize || !$('.course-selected').length || (currentTop !== $('.course-selected').offset().top);
    if(differentHeight || same) {
      $('.course-extended-info').
        animate({maxHeight: "0px"}, 200)
      await delay(200)
      $('.course-extended-info').parent().
        remove();
    }
    $('.course-selected').removeClass('course-selected');
    if (same) {
        return;
    }

    let lastInRow = null;
    currentTop = current.offset().top;

    $('.card').each((i,e)=> {
      if ($(e).offset().top <= currentTop) {
        lastInRow = $(e);
      } else if (lastInRow) {
        return;
      }
    });

    let parent = (lastInRow || current).parent()

    current.addClass('course-selected');

    if (differentHeight) {
      $('<div class="col-12" ><div class="course-extended-info">'+getCourseInfo(current)+'</div></div>').
        insertAfter(parent);
         $('.course-extended-info'). animate({maxHeight: "3000px"}, 600)
    } else {
      $('.course-extended-info').html(getCourseInfo(current));
    }
    await delay(300)
    scrollIntoViewIfNeeded($('.course-extended-info')[0]);
  }

  $(".card").click((ev)=>clickCard($(ev.currentTarget)));
  var resizeTimer;
  const id = window.location.hash;
  if (id.match("course-")) {
    clickCard($(id), true);
  }

  $(window).on('resize', function(e) {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(function() {
      if ($('.course-selected').length) {
        clickCard($('.course-selected'), true);
      }            
    }, 500);
  });
}